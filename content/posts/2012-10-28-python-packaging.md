Title: Python Packaging
Date: 2012-10-28 20:08
tags: Python, Packaging
Category: Code
slug: python-packaging


There are two major hurdles to Python disrupting the entire HPC work stack:
packaging and [dynamic loading](http://pyvideo.org/video/1201/solving-the-import-problem-scalable-dynamic-load). Today I want to discuss the packaging issue.
While there are many people working on these hurdles, it is my opinion that the
community needs to seek out methods to solve these hurdles together in a
satisfactory way. I see this problem taking shape in many different
communities, but the HPC version of the problem is probably the most difficult,
thus by solving it, we can provide solutions for many other communities as well.

To this end, I helped host a conference call among the young, enthusiastic
[NumFOCUS](http://numfocus.org/) community.  This call seemed much more of a
get to know the problem rather than a listing of solutions.  We are working on
editting the call and hope to have it published as a
[InSCIght](http://www.inscight.org) podcast soon.  The call included several
companies that produces packaged Python solutions, university folks from around
the globe, and industrial users of Python.  The interest in the call was so
great that we had to switch mediums at the last moment and lost out on some
interactions with other great folks.  I hope to have another call in the future
and a discussion at the upcoming [SuperComputing 2012 conference](http://sc12.supercomputing.org/schedule/event_detail.php?evid=bof154).

## What is wrong with Python Packaging

Perhaps the place to start is defining the problem.  When you have a piece of
code in a pure Python setting, one easily adds the top source directory to
`PYTHONPATH` and happily imports away.  This model works quite well
usually. For the first years of Google App engine, code could only be installed
in this manner.

The issue is that in HPC one must depend upon libraries that are highly tuned
for specifics of the architecture where the code is run.  These highly tuned
libraries often include assembly and usually only include compiled static or
shared libraries.  Since, HPC often uses specific compilers dedicated to their
hardware, these libraries depend on the formats compatible with those
compilers.  To further enhance the problem, if these libraries are distributed
via MPI, then the libraries depend on the MPI implementation (which depends
upon the compiler).  At TACC we have a hierarchical module system to keep this
all straight.  You load the compiler, then the MPI implementation, and finally
any libraries.  If you switch to a different compiler, the entire stack is
reloaded.  Actually a big part of my job is to make sure these stacks are all
compiled in a way that they can be switched out, something that is a feat with
biology codes. In a nutshell, we have a huge dependency chain that is binary
and machine dependent.

Python isn't supporting this long list of dependencies very well.  For HPCers
this is not new as we are use to having to hack build and package systems.  In
fact in the eight years I've been around the FEniCS community, I've seen four
package systems come and go.  It took me three weeks to get the Trilinos code
installed on my system back in 2006, at the time folks opined that picking that
the right Trilinos configure was NP-Hard. It is much better today. In both cases
though, CMake has turned out to be the tool that has stabilized everything.

Why can't Python support this jumble of dependencies?  The reasons are many,
but as [David Cournapeau](https://twitter.com/cournape) has pointed out, Python
fundamentally mixes both build and packaging together in a way that makes it
impossibly hard.  I don't know David's history, but he seems pretty critical of
the community about not understanding the issue.  Rather than rehash all the
arguments, I'm going to outline my view of the solution, separating build and
packaging.

## The build process

The difficult part of the build process is not calling the compiler, rather
configuring the environment and compiler flags to produce the desired binary.

To give a simple example, if you are compiling a threaded library, say using
OpenMP, you need to know that gcc uses -fopenmp, icc uses -openmp, pgi
-mp, something else on xl, and clang doesn't even support it.  Thank you
Apple for making my job that much harder by using a default compiler that
doesn't support OpenMP.  

Okay that's actually not hard to code, but it gets better.  Because multicore
threading is still an infant technology, if you compose several threaded
libraries you can see a real performance degradation (despite
[@dbeaz](https://twitter.com/dabeaz) thinking threading is easy). Thus most
vendors provide a threaded version of BLAS and a sequential version, the idea
being if you have a big matrix to work with make BLAS be the multithreaded
portion of the code, but if you have lots of smaller matrices let the
application be multithreaded.  This means that each application could be built
with 4 compilers X 2 BLAS threading modes, we also need to throw in debugging
and optimized modes as yes -O3 versus -g -O0 really do matter.

In this trivial example, we already need to test 16 different builds of a
library, not to mention figuring out how many threads to run (which is often a
runtime decision with OpenMP). If you want to drive your graduate students to
madness get them to install Scalapack on your cluster.

At this point, you might say "16 versions of the library, quit your crying,
baby!". It should be easy to script except Python distribution tools really
don't give a way to manage these different compiler flags.  In many cases the
tools just slaps your code in some place on the path and runs all sorts of
bootstrapping patching hacks to install at all.  Virtualenv give a bit of sanity as
one can isolate different Python builds, but it doesn't handle any of the
system libraries at all.  It is my understanding that when EPD was built, they
initially tried to fix this problem but quickly switched to a single binary
only distribution model.

To tackle all these burdens, we need to start using real configure and build
tools.  They need to work on all platforms, yes Windows matters in HPC. They
need to be free and open source. And they actually already exist, the community
just needs to start adopting them and that will take some effort.  The two
tools I've seen used well are [Bento](http://cournape.github.com/Bento/)
produced by David and [CMake](http://www.cmake.org/) produced by Kitware.  I'm
not going to have a bake-off on the pros and cons of each, I have far more
experience with CMake but people I trust tell me Bento is far easier to use. If
NumFOCUS and the PSF really wants to help the community today, it would start
helping people augment distutils to use one of these tools.

## The package selection process

Now that we've discussed the build process, we need to package up those builds
and allow developers to use them.  I was really glad the Yaroslav, one of the
Debian developers, and Samuel, homebrew's Python guy, was able to join us on
the call.  Open source platforms have created great packaging tools, but it
only gets us code monkeys about halfway.  I can install the basic libraries
that aren't cutting edge and don't need fine grain configuration system
wide. Then I just keep the jumbled mess in my developer space.  But what if a
developer needs to fix a bug with one of those system installed libraries that
isn't the version installed? I've spend more time futzing with the packaging
system installer than fixing the bug.

The truth of the matter is we really want the jumbled mess to be managed better
too.  Just like on my supercomputer, I can issue a single command and have a
whole new compiler stack working, why can't I do that with my current
development tree.  Here enters
[HashDist](https://github.com/hashdist/hashdist/wiki).  HashDist is
[Dag](http://folk.uio.no/dagss/) and [Ondrej's](http://ondrejcertik.com/) plan
for fixing this problem.  The idea is to build libraries and stash them some
place, recording the necessary details in a small distribution file that is
hashed and put in a database store.  Now when you need to build different
versions of a library, one can simply refer to the different hashes of the
other built libraries. At this point, HashDist is vaporware that has some
funding.  I have been working with these guys trying to fund this project for
about a year and a half.

Let me be frank.  If this tool existed, reporting bugs could come with a
hashdist number that would set your machine up in the bug state immediately,
i.e., no more futzing with installers just working.  For HPC systems this would
be huge. Hell it is even a good idea for a SAAS startup company.

This is very similar to the module system that we use at TACC, lmod, but it
should build into the development cycle not just running a supercomputer.  For
what its worth, supercomputers use module systems because when you have 5000
users on a machine, you have to keep the kids from stepping on each others
toes.

## Why this affects developers outside of HPC

Hopefully, I've explained the problem well enough and pointed to a few
promising fixes.  While these problems are accentuated in HPC systems, they
exist everywhere.  Every single company, I have consulted with has this
problem.  They solve it different ways, but they all manage their own build and
packaging system.  Every single open source scientific Python team, has this
problems.  They usually solve it the old fashioned way, indentured servants, err
graduate students.  But perhaps more importantly, as PyPy and other python
distributions threaten CPython for popularity, even Python core is having these
problems. The wheel proposals are a good first step, but its gonna take more
than changing package names to fix it.

NumFOCUS was founded to help encourage businesses and institutions to put
funding together to solve science software problems. This is a big problem and
one that prevents a large number of people from effectively using our
ecosystem.  I would like to see more funds and community resources put forward
to create working solutions. Finally a homework for everyone who has read this
far. I invite you to send me your versions of how you fix Python
packaging for your work so I can collect the best ideas.

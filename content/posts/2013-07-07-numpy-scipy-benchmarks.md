Title: NumPy SciPy Benchmarks
Date: 2013-07-07 21:08
tags: Python, NumPy, SciPy
Categories: Code
slug: numpy-scipy-benchmarks

At PyCon2013, a group of about 30 developers got together to discuss
NumPy and SciPy.  The room mostly included folks that use NumPy and
SciPy extensively, such as myself, a few who were just learning, and
several core contributors (if not currently in the past), such as Eric
Jones, Travis Oliphant, Anthony Scopatz, and Jake Vanderplas.  It was
an impromptu meeting, as most birds of a feather sessions are, so I
don't think we even got the full number of interested participants at
PyCon2013.  The scientific large support at PyCon was surprising,
since most of us scientists think the wider Python ecosystem leaves us
behind in many of their activities.

There were three topics we discussed: briefly about the development and
maintenance of the libraries, about the use of newer technologies, e.g. Cython,
PyPy, Copperhead, Numba, and finally about having a benchmark for new
implementations of NumPy to see how complete they are.  Since there were not
very many core developers in the room, it was hard to really push a topic on
the development side but the other two topics were the most discussed.

To briefly summarize the maintenance and future plans section, I asked about
how the community was doing since I've been organizing this whole conference
thing and haven't been on the mailing lists in a while. Travis mentioned that
NumFOCUS was trying to raise money for the projects, especially around the
topic of paying a maintainer.  

Miniature Applications
---------------------

Next we turn to the topic of benchmarks.  At the end we decided that there are
at least two types of benchmarks that are really needed by the community.
First, is a set of miniature applications that show off the tools well.  Since
there is such a wide variety of tools available right now, it is difficult to
know what to invest in as a developer.  Ian Osvald mentioned his book that
includes one of the only major comparisons I've seen in the tools.  I suggested
we look at how the Mantevo project implemented its mini-apps for the US DOE.
Another suggestion was to organize the applications in the seven dwarfs
of scientific computing suggested by Phil Collela. I believe these have been
renamed to motifs and extended to eleven by the Berkeley crowd.

The idea moving forward will be to collect a number of applications, give a
reference implementation, and accept contributions showing how to implement
them in a Python runnable way.  The idea is not to make everyone use Python for
everything but to show off the capabilities of Python as an integration (and
implementation) platform.  One participant brought up that we could have a site
like the Computer Language Benchmarks, while we agreed in spirit enough of us
do not like that benchmark because of its purist ideas that applications should
stick to a single language.  To be friendly to vendor solutions, I'm willing to
accept closed runtimes but since the point is to highlight the code, all code
must be free and open, preferably BSD.  I am sure we will refine the rules as
we go.

NumPy Benchmarks
----------------

Matti, a contributor to NumPyPy, brought up the idea of creating a suite of
benchmarks to compare different implementations of NumPy.  The idea here is
once again not to compete ruthlessly for fame and glory, but rather provide a
baseline for developer to hit when implementing alternatives and users to know
how complete and single implementation is. Right now I know of several NumPy
implementations (or close to implementations), e.g., NumPyPy, Numba,
Copperhead, and a benchmark will be a welcome addition to the tools.

The plan to start off will be to grab out some tests from the NumPy regression
tests and grab a benchmark runner.  Matti suggested trying to port the PyPy
runners for our needs. Once we get something up and going we can try to put it
up somewhere for people to make contributions.

There were many concerns about the benchmarks not being productive and bringing
out too much competition.  My view is that we should try to be as open and
welcoming as the rest of the Python ecosystem.  That is let the numbers speak
for themselves and make these benchmarks something anyone can contribute to.

A final aspect of the benchmark would be to show off that NumPy is useful for
more then numeric algorithms.  Many people see "Num" and assume there is no use
for their specific needs, but in actuality, NumPy should be thought of as more
a typed array.  This allows fast access to contiguous blocks (although the
element access is often slower than lists).  

Going Forward
-------------
This post is intended to start a wider discussion among the community.  I'm
posting here because there are enough places in the community and I wanted a
single place rather than four or five mailing lists.  The hope is we can start
a repository and get some tests rolling.


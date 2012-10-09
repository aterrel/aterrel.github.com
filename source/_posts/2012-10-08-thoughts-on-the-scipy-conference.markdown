---
layout: post
title: "Thoughts on the SciPy Conference"
date: 2012-10-08 01:24
comments: true
publish: true
categories: 
---

For SciPy2012 I was given the privilege of serving as the co-chair of the
program committee.  The experience was exciting and rewarding as I was able to
affect what I view as one of the most important conferences for the scientific
world. Now, that's a pretty bold statement and I'm not going to dwell on it
long here, but essentially many conferences people go to show off;
SciPy is a conference where people come to learn best practices.  And when young
scientists are able to see science rock stars like Joshua Bloom lift up the
covers and show off how his scientific process works, it changes their entire
workflow creating more efficient, better scientists. With that said, I would
like to focus more on my opinions about the state of the conference, its
successes and failures, and how I believe the conference should be transformed.

## The state of the SciPy Community

It was a bit strange being the co-chair of the program committee at SciPy2012,
because prior to 2012 I had only attended one SciPy conference.  Of course, I
have known about the conference for years and have tried to go many times but
life has always gotten in the way.  Additionally, I came to the scientific
Python community after most everything had evolved to a pretty high level of
quality.  Sure there are bits and pieces that could use some polish, but
largely I feel that my contributions have all been cosmetic (although the GSOC
students I have mentored have done phenomenal work). This puts me at a bit of a
disadvantage to extol any long history of the SciPy community, but I'm sure
someone will let me know where I get things right and wrong.

There are some interesting divides in the community.  For example, SciPy can
refer to many different things:

1. The US SciPy conference,
2. The international SciPy conference series,
3. The Python package named scipy,
4. The basic scientific computing stack used by most pythonistas, and/or
5. Any piece of code slightly related to science and Python

For this article, when I say SciPy I am talking about the US SciPy conference
(since if I usually can't afford to make it to SciPy in Austin, TX, I sure
can't afford to go to Brussels or India) and a mix of the other topics.  SciPy
was originally a set of friends who got together in a room at Caltech to chat
and hack about the scipy package.  They use to have these talks from the core
devs where each gave a summary of the package and largely discuss technical
issues around these packages.  As of late, the conference has turned into much
more of a place where any scientist or technical computing professional can go
and hear about a very wide variety of topics on science and Python.

This change in community is both a good and a bad thing.  It means that at
coffee, there are a lot of strange faces and let's be honest if we were the
most social crowd we wouldn't have spent a non-trivial amount of our lives
pouring over code and mathematics.  Second we seem to have lost some of the
core devs attention.  For example, in the months preceding the conference the
numpy mailing list had turned into a pretty nasty flamewar.  At the conference,
I only saw one of the major contributors to the numpy code base.  I find the
fact that SciPy isn't the most important event on the calendar for these devs
kind of surprising.  After all this is where you core devs are the gurus
everyone has come to be inspired by.

The good news is that we are able to see a more accurate view of the
penetration of Python in science.  But not only science, pretty much all
technical computing areas of industry, academia, and government were
represented.  The conference had a record number of attendees and submissions,
in fact this was the first SciPy that we knew of where people received
rejections.  

## Successes and Failures of SciPy 2012


In many ways SciPy is a great conference, but in other ways it is lacking.  I
want to explore a few of these ideas, get feedback from the community, and put
the consensus into action.  

### Success

> If it ain't broke don't fix it ~ Anonymous

#### Topics

The past two years, there has been two special topics.  Last year was Big Data
and Core Issues; this year we did High Performance Computing and Visualization.
The truth was that we picked these topics because a few motivated folks were
excited about them.  This is true about the domain session this year as well.
Lauren and I chatted, I gave names and she went calling people down to get the
right set of talks.  Largely I think this works, but I don't like it.

I don't like it because the community wasn't really involved and when you have
a couple of people picking the overall direction of a community, it largely
becomes a clique.  If we want to keep a vibrant community, I think these topics
are really important as they are aimed at bringing in people from outside our
community.

With that said, my proposal this year would be:
* Machine Learning, and
* Geographic Information Systems
Both topics that came out during the surveys and are a broad cutting
technologies.  Machine Learning should be a no-brainer as the Big Data world
needs it more than ever, but GIS is a bit harder for me to predict being a
break out success.  Of course last year I thought HPC would be the small topic
and Vis a bigger draw, but I was dead wrong.  We could of had the whole
conference on PyHPC (if you want sort of thing, check out the SuperComputing
Conference pyHPC workshop).  

#### Fabulous plenaries

This year I believe the plenaries were really off the chart.  I was actually
recruited to help out after the plenaries had already been chosen, so this was
really Stephan and Warren's doing.  I really like the format as well. A talk
about a well-known package, a science talk about the things people are able to
accomplish with the tools, and a look into industry and how our community
relates.

I have quite a few ideas about how to replicate this formula, but I believe we
should probably have some discussion from the community.  

#### Poster session

The poster session was great.  There was a lot of interaction between people at
the session.  I'm somewhat beside myself on the session though.  I thought it
would be better during the reception, but we couldn't get the posters in the
reception room and be visible during the entire conference.  I really liked
the poster session and hope to see it in the future.  One fact of science
conferences is that usually it is harder to get funding if you don't have
something to present.  Posters are a great way to increase participation,
although I do wonder if we need to go to three parallel tracks in the future.

#### Domain science symposiums

The symposiums at the end of the day were much sparser than the day.  This was
expected, but they play an important role.  As the main session includes a
large number of folks that have quite different domains, these sessions allowed
for topic specifics to be discussed.  More and more domain conferences are
including sessions on Python, but SciPy allows for sessions to grab the
attention of Python experts who are often able to give fresh advice.

### Failures

> Develop success from failures. Discouragement and failure are two of the
> surest stepping stones to success.  ~ Dale Carnegie

Failure is probably too harsh a word for what I discuss in this section.  It's
more adequately, "Things that disappointed Andy."  And as most people who know
me know, I'm not afraid to tell you why I'm disappointed (only I usually use
harsher words).  At any rate, I believe in [admitting
failure](http://www.admittingfailure.com/) and want to discuss a few things I
would like to rectify.

#### Community involvement

For the most part, the conference is put on by about four people.  Sure there is
a longer list on the website, but the brunt of the work falls on a few.  I
would like to see this change.  For example, look at how PyCon is run.  There
are more volunteers than you can count. While Enthought is an amazing
institutional sponsor of the event, they only have a small number of resources
to put into the event.  My impression is that these resources are over
exhausted.

It is time we as a community come together to setup structures for more
community participation.  For example, the websites need work, the process of
reviewing papers needs work, there needs to be more logistical help at the
meeting, and so on.  My guess is that most people don't even know that they
could be helping. To even start though we need to build a volunteer network and
appropriate web presence to give volunteers things to do.

#### Diversity

Matt Davis brought this up on Twitter, but I want to echo it louder.  There was
a discouraging lack of diversity at SciPy.  I believe there were 100 males to
every female and very few minorities.  When talking to a few people about this,
the general view was that there just aren't woman coders around.  I think this is
really wrong, I think that women coders either don't know about SciPy or don't
care.

Which brings up how do you attract female coders?  One metric given to me is
that conferences with women plenary speakers and/or women on the executive
staff have 50% more women participants.  I look at the places we advertised and
we didn't focus on any female or minority organizations.  Closing this gap will
only make our community more vibrant.

#### Industry/Academia interactions

SciPy is a place where there are a few industrial partners but there could be
many more. The problem I saw on the program committee was that anyone who
submitted work on closed source software were negatively impacted.  We are an
open source community but hundreds (thousands?) of companies use our tools.
Industrial partners that come back to the community and talk about how to
interact more can only be a good thing.  For one it will give us a since of the
impact that SciPy has beyond the halls of academia.  It will heighten our
profile among young developers as they are able to come to SciPy to meet
potential employers.  

My suggestion here would be to have vendor booths and a recruitment event.  I
would even go as far to suggest hosting a few sponsor speaking sessions.  Open
source is often supported by industry, just as the scipy stack has been
supported by Enthought for years.  Inviting industry to our meeting will make it
more visible.

#### Social Media

The lack of social media at the conference is quite surprising.  Are we all old
fuddies who don't know how to use social media to discuss?  It is quite
exciting to go to a conference where the social media around the conference is
working well.  It allows for more dialog among the participants and thus a
greater shared experience.  

With that said, I would like to see a greater use of Twitter, G+ and Facebook
throughout the event, including planning. Connecting our community may even
heal all those fights we have on mailing lists.

#### Lack of Core Developers 

I've already touched on this, but one last failure is the lack of core project
developers at the conference.  Sure people have lots competing with their time,
but this is the conference dedicated to the code we spend so much free time
on.  Conversations at SciPy are still having an effect on the directions of
codes (in fact today scipy.users had a long conversation about the scipy domain which
was hotly discussed at the sprints).

The few ideas I have on bringing the coders back include:
1. More sprinting (space every night *all night*)
2. Sessions dedicated to core projects
3. More organization around BoFs
4. Conference sponsorship for devs to attend conference 


## Vision

Okay 2000 words in and I'm sure you are getting bored.  But I've said this
before and I'll say it again.  There is no reason SciPy shouldn't be as large
as PyCon.  While there are certainly more users of the Python language, our
community is always one of the featured groups when Python users are
discussed.  The suggestions I outlined above are only a small set of comments I
really have, but they are the ones I feel probably need a broader discussion.

For me the vision of SciPy should be simple.  SciPy is the fuel of the
scientific Python movement.  It is where producers and consumers of
science and technical code come to learn from each other and make each other
better scientists and coders.  SciPy as a conference should be inclusive of all
technical disciplines and help mentor novice programmers. Finally, it should be
the place where we inject new life into our projects, hack the wild ideas we
only dream about, and submit pull requests that change the face of science.

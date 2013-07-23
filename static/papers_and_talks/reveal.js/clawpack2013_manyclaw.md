### ManyClaw and Code Generation

> [Andy R. Terrel, PhD](http://andy.terrel.us)  
>  
> [ClawDev 2013 Workshop](http://clawpack.github.io/clawdev2013/)  
> slides at: [http://bit.ly/ClawDev2013_ManyClaw](http://bit.ly/ClawDev2013_ManyClaw)  

<sub>[slides by Reveal.js](http://lab.hakim.se/reveal-js/)</sub>

<aside class="notes">
Welcome to my talk.  Randy asked that we make this a discussion, so please feel
free to interrupt me at any point.  
</aside>



### Background
<aside class="notes">
Let's first start by talking about how this project got started, it's relation
to clawpack, and how I became involved.
</aside>


Science needs code.

<aside class="notes">
Everyone here probably recognizes the innovations brought to science through
scientific computing.  As science relys on code more heavily, it behooves us to
think about our relationship to it and the future of code.  Let's explore some
qualities that scientific code needs.
</aside>


Most Scientists see code as a tax.

<aside class="notes">
Whether their advisors didn't code or they aren't very good at it, scientists
in general would rather avoid code.  I personally avoid writing, but it doesn't
mean it isn't part of science.  So anything to make a code less frustrating to
write, install, or run will help the success of a code and hence more
citations.
</aside>


Scientific codes need to be fast.

<aside class="notes">
While performance is not the only criteria, I put it on my list because
it is a often missed as a feature.  Performance can dictate everything about a
code and override all other features.  Another aspect to scientific code is
that it must scale up as there is always a bigger science problem to solve. As
most tech companies are dealing with web scale, and that changes the patterns
they use, scientists do well to think about science scale applications and use
patterns to grow their code.
</aside>


Scientific code needs to be robust, but not as robust as other software
products.

<aside class="notes">
We need our codes to be stable to inputs and work on a variety of computers.
But we errors are okay (i.e. they don't cost us millions of dollars) and we
typically can restart from known states.  
</aside>


My work research is two pronged:

- making scientific code fast but readable and
- creating robust tools and patterns for scientists,

<aside class="notes">
From this starting point, I have two basic goals.  To make science a better
place to code with fast, robust tools and patterns.  I typically like to work
embedded in a scientific group, currently I'm working with the Computational
Hydrology group at ICES.
</aside>



### High performance computing
New trends in HPC include:


<aside class="notes">
HPC is hard, but it often predicts the technology of the future.  My concern is
usually the software features, not the performance, but if we want to push what
scientific codes can do, we have to 
- using hardware to it's full capability,
- running on problems much larger than is capable on a single laptop,
</aside>

## 

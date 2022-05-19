
<!-- README.md is generated from README.Rmd. Please edit that file -->

# How to build a package with “Rmd First” method

> Build reproducible and shareable data analyses using R packages

<!-- badges: start -->
<!-- badges: end -->

This repository contains the course material of our [useR! 2021
tutorial](https://user2021.r-project.org/), then [AFH
2022](https://www.association-francaise-halieutique.fr).

Instructors: [Sébastien Rochette](https://statnmap.com), Florence
Mounier

## Tutorial purpose

The tutorial is designed for R users from a variety of fields who are
interested in organizing their analyses or development, usually written
in RMarkdown files, into R packages.

## Modifications

Please use a branch to add modifications and open a merge request to ask
to add them in the *master*. You can assign me to this.

## Content of this repository

-   `courses/`: Rmd for different courses
-   `data/`: shapefiles and data used in the slides and in exercises
-   `exercises/` : Rmd of the exercises with complete answers
-   `submission.Rmd` : Tutorial submission

## What we proposed

### Abstract

“Rmd First” method can reduce mental load when building packages by
keeping users in a natural environment, using a tool they know: a
RMarkdown document.

The step between writing your own R code to analyze some data and
refactoring it into a well-documented, ready-to-share R package seems
unreachable to many R users. The package structure is sometimes
perceived as useful only for building general-purpose tools for data
analysis to be shared on official platforms. However, packages can be
used for a broader range of purposes, from internal use to open-source
sharing. Because packages are designed for robustness and enforce
helpful standards for documentation and testing, the package structure
provides a useful framework for refactoring analyses and preparing them
to go into production. The following approach to write a development or
an analysis inside a Rmd, will significantly reduce the work to
transform a Rmd into a package :

-   *Design* : define the goal of your next steps and the tools needed
    to reach them
-   *Prototype* : use some small examples to prototype your script in
    Rmd
-   *Build* : Build your script as functions and document your work to
    be able to use them, in the future, on real-life datasets
-   *Strengthen* : Create tests to assure stability of your code and
    follow modifications through time
-   *Deploy* : Transform as a well-structured package to deploy and
    share with your community

During this tutorial, we will work through the steps of Rmd Driven
Development to persuade attendees that their experience writing R code
means that they already know how to build a package. They only need to
be in a safe environment to find it out, which will be what we propose.
We will take advantage of all existing tools such as {devtools},
{testthat}, {attachment} and {usethis} that ease package development
from Rmd to building a package. The recent package
[{fusen}](https://thinkr-open.github.io/fusen), which “inflates a
package from a simple flat Rmd”, will be presented to further reduce the
step between well-designed Rmd and package deployment. Attendees will
leave this workshop having built their first package with the “Rmd
First” method and with the skills and tools to build more packages on
their own.

### The learning goals

By the end of the tutorial participants should:

-   understand the methodology proposed by Rmd Driven Development
-   be able to refactor their code into correctly formatted functions
-   understand the structure of a package
-   be able to build a documented and tested R package
-   know how to share their work with the community on GitHub

## What can you do after this tutorial?

-   Practice again, following complementary ‘Rmd-first’ / ‘RMDD’
    presentations
    -   <https://rtask.thinkr.fr/when-development-starts-with-documentation/>
    -   <https://emilyriederer.netlify.com/post/rmarkdown-driven-development/>
    -   <https://malco.io/talk/you-re-already-ready-zen-and-the-art-of-r-package-development-rsg/>
-   Try [“{fusen}: inflate a package from a simple flat
    Rmd”](https://rtask.thinkr.fr/fusen-create-a-package-from-a-single-rmarkdown-file/)

# For instructors

The content will be built using an internal ThinkR package called
{formation}. This ensures that the HTML output, datasets, and extra
files are stored in the correct place to be added to the ThinkR
e-learning platform.  
Each instructor is still able to locally knit each chapter using
{xaringan}.  
The content of the course is:

-   courses/C00-package-objectives.en.Rmd: What we will present during
    this tutorial, and how it will be held
-   courses/00-cruz.Rmd: How the e-learning platform works
-   courses/C00-package_preambule.en.Rmd: What means package first ?
-   courses/C01a-package_fusen_discover.en.Rmd: Discover the structure
    of a package with {fusen}
-   courses/C01b-package_express_fusen.en.Rmd: Build a package using
    {fusen}
    <!-- - courses/C06-pkg_avance_test.Rmd: Go further with unit tests -->
-   courses/C09-pkg_avance_data.en.Rmd: Include datasets in your package
-   courses/C13-git_fusen.en.Rmd: Use git with {fusen} projects
-   courses/C14-data-analyses-packages.en.Rmd: What about data analyses
    in a package?

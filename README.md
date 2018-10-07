
<!-- README.md is generated from README.Rmd. Please edit that file -->

# viewtweets <img src="man/figures/logo.png" width="160px" align="right" />

<!--[![Build status](https://travis-ci.org/mkearney/viewtweets.svg?branch=master)](https://travis-ci.org/mkearney/viewtweets)
[![CRAN status](https://www.r-pkg.org/badges/version/viewtweets)](https://cran.r-project.org/package=viewtweets)
[![Coverage Status](https://codecov.io/gh/mkearney/viewtweets/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/viewtweets?branch=master)

#![Downloads](https://cranlogs.r-pkg.org/badges/viewtweets)
#![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/viewtweets)-->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

View Twitter timelines in Rstudio.

## Installation

Install the development version from Github with:

``` r
## install remotes pkg if not already
if (!requireNamespace("remotes")) {
  install.packages("remotes")
}

## install from github
remotes::install_github("mkearney/viewtweets")
```

## View home timeline

View home (authenticating user’s) timeline:

<p style="align:center">

<img src="inst/tools/readme/home.gif" />

</p>

## View user timeline

View tweets posted by a given user:

<p style="align:center">

<img src="inst/tools/readme/user.gif" />

</p>

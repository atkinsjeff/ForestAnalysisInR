
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ForestAnalysisInR

<!-- badges: start -->
<!-- badges: end -->

ForestAnalysisInR is a “metapackage,” an R package that is meant to help
users find the right tools in R to produce the analysis they need.

![](inst/extdata/hex.png)

## Installation

You can install the development version of ForestAnalysisIn from
[GitHub](https://github.com/) with:

``` r
devtools::install_github("atkinsjeff/ForestAnalysisInR")

library("ForestAnalysisInR")
```

## Example

At the core of ForestAnalysisIn is a `Shiny` app which gives produces a
sortable and querable data table of all the availble R packages for
forestry and forest ecology research:

``` r
library(ForestAnalysisInR)
## basic example code
launchRFA()
```

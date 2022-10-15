
<!-- README.md is generated from README.Rmd. Please edit that file -->

# twenty

<!-- badges: start -->
<!-- badges: end -->

The goal of twenty is to provide functions for working with *scores*.
These include some simple

## Installation

You can install the development version of twenty like so:

``` r
remotes::install_github("jmbarbone/twenty")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(twenty)

x <- c(
  1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, 9L, 6L,
  6L, 3L, 1L, 2L, 7L, 7L, 35L, 6L, 6L, 9L
)

range <- c(0, 40)
bounds <- c(0, 100)
anchors <- c(0, 4, 16, 32, 40)

normalize(x)
#>  [1] 0.00000000 0.02941176 0.05882353 0.08823529 0.11764706 0.14705882
#>  [7] 0.17647059 0.20588235 0.23529412 0.14705882 0.14705882 0.05882353
#> [13] 0.00000000 0.02941176 0.17647059 0.17647059 1.00000000 0.14705882
#> [19] 0.14705882 0.23529412
normalize(x, range)
#>  [1] 0.025 0.050 0.075 0.100 0.125 0.150 0.175 0.200 0.225 0.150 0.150 0.075
#> [13] 0.025 0.050 0.175 0.175 0.875 0.150 0.150 0.225
normalize(x, range, bounds)
#>  [1]  2.5  5.0  7.5 10.0 12.5 15.0 17.5 20.0 22.5 15.0 15.0  7.5  2.5  5.0 17.5
#> [16] 17.5 87.5 15.0 15.0 22.5

score_reverse(x)
#>  [1] 33 32 31 30 29 28 27 26 25 28 28 31 33 32 27 27 -1 28 28 25
score_reverse(x, range)
#>  [1] 39 38 37 36 35 34 33 32 31 34 34 37 39 38 33 33  5 34 34 31

anchorize(x, anchors)
#>  [1]  0  0  4  4  4  4  4  4  4  4  4  4  0  0  4  4 32  4  4  4
anchorize(x, anchors, reverse = TRUE)
#>  [1] 40 40 40 32 32 32 32 32 32 32 32 40 40 40 32 32  4 32 32 32

percentile_rank(x)
#>     1     2     3     4     5     6     7     8     9     6     6     3     1 
#> 0.050 0.150 0.250 0.325 0.375 0.525 0.725 0.825 0.900 0.525 0.525 0.250 0.050 
#>     2     7     7    35     6     6     9 
#> 0.150 0.725 0.725 0.975 0.525 0.525 0.900
percentile_rank(1:5, weights = c(10, 5, 0, 2, 3))
#>     1     2     3     4     5 
#> 0.250 0.625 0.750 0.800 0.925
```

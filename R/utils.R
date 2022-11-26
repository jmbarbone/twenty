`%||%` <- function(x, y) { if (is.null(x)) y else x }

get_range <- function(x) {
  x <- as.double(x)
  x <- x[!is.na(x)]

  if (!length(x)) {
    stop("No non-missing arguments in range", call. = FALSE)
  }

  x <- x[is.finite(x)]
  if (!length(x)) {
    stop("Not enough finite values in range", call. = FALSE)
  }

  fuj::struct(c(min(x), max(x)), class = "twenty_range")
}

diff.twenty_range <- function(x, lag = 1, differences = 1, ...) {
  if (!missing(lag) | !missing(differences)) {
    warning("`diff.twenty_range(lage, differences)` is ignored", call. = FALSE)
  }

  x[2L] - x[1L]
}

check_lengths <- function(x, y) {
  dx <- deparse1(substitute(x))
  dy <- deparse1(substitute(y))
  nx <- length(x)
  ny <- length(y)

  ok <- (nx > 0 & ny > 0) & (nx == ny | nx == 1L | ny == 1L)

  if (!ok) {
    msg <- sprintf(
      "%s [n = %i] and %s [n = %i] are not compaitable lengths",
      dx,
      nx,
      dy,
      ny
    )

    stop(msg, call. = FALSE)
  }

  invisible()
}

any_duplicated <- function(x) {
  # safe for vctrs where anyDuplicated.vctrs returns logical:
  #
  # ``` r
  # anyDuplicated(vctrs::new_vctr(1))
  # #> [1] FALSE
  # ```
  #
  # https://github.com/r-lib/vctrs/issues/1452
  isTRUE(as.logical(anyDuplicated(unclass(x))))
}

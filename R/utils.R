`%||%` <- function(x, y) { if (is.null(x)) y else x }

get_range <- function(x) {
  x <- as.integer(x)
  x <- x[!is.na(x)]

  if (!length(x)) {
    stop("No non-missing arguments in range", call. = FALSE)
  }

  x <- x[is.finite(x)]
  if (!length(x)) {
    stop("Not enough finite values in range", call. = FALSE)
  }

  mark::struct(c(min(x), max(x)), class = "twenty_range")
}

diff.twenty_range <- function(x, lag = 1, differences = 1, ...) {
  if (!missing(lag) | !missing(differences)) {
    warning("`diff.twenty_range(lage, differences)` is ignored", call. = FALSE)
  }

  x[2L] - x[1L]
}

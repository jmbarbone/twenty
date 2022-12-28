#' Percentile rank
#'
#' Computes a percentile rank for each score in a set.
#'
#' @description
#' The bounds of the percentile rank are > 0 and < 1 (see Boundaries)
#'
#' A percentile rank here is the proportion of scores that are less than the
#'   current score.
#'
#' \deqn{PR = (c_L + 0.5 f_i) / N}
#'
#' Where
#'
#'   \eqn{c_L} is the frequency of scores less than the score of interest
#'
#'   \eqn{f_i} is the frequency of the score of interest
#'
#' @section Boundaries:
#'
#' While the percentile rank of a score in a set must be exclusively within the
#' boundaries of `0` and `1`, this function may produce a percentile rank that
#' is exactly `0` or `1`.  This may occur when the number of values are so large
#' that the value within the boundaries is too small to be differentiated.
#'
#' Additionally, when using the `weights` parameter, if the lowest or highest
#' number has a value of `0`, the number will then have a theoretical `0` or
#' `1`, as these values are not actually within the set.
#'
#' @param x A vector of values to rank
#' @param ... Additional parameters sent to methods
#'
#' @return The percentile rank of `x` between 0 and 1 (see Boundaries)
#'
#' @examples
#' percentile_rank(0:9)
#' x <- c(1, 2, 1, 7, 5, NA_integer_, 7, 10)
#' percentile_rank(x)
#'
#' # with weights
#' percentile_rank(7:1, c(1, 0, 2, 2, 3, 1, 1))
#' @export
percentile_rank <- function(x, ...) {
  UseMethod("percentile_rank")
}

#' @export
#' @rdname percentile_rank
#' @param weights A vector of the number of times to repeat `x`
percentile_rank.default <- function(x, weights = NULL, ...) {
  if (!is.null(weights)) {
    return(do_percentile_rank(x, weights))
  }

  id <- facts::pseudo_id(x)
  tab <- tabulate(id)
  res <- do_percentile_rank(attr(id, "values"), tab)
  fuj::struct(
    res[id],
    class = class(res),
    names = names(res)[id],
    values = attr(res, "values")[id]
  )
}

#' @export
#' @rdname percentile_rank
percentile_rank.table <- function(x, ...) {
  w <- as.integer(x)
  x <- as.numeric(names(x))
  # TODO include fills for 0
  percentile_rank(x, w)
}

# helpers -----------------------------------------------------------------

do_percentile_rank <- function(u, w) {
  if (any_duplicated(u)) {
    stop(cond_percentile_rank_dupe(u))
  }

  w <- as.integer(w)
  if (length(w) == 1L) {
    if (is.na(w)) {
      # If weight is NA return NA?  Maybe through an warning?
      return(rep.int(NA_real_, length(n)))
    }

    # no ordering necessary
    ok <- !is.na(u)
    n <- sum(ok)
    p <- rep(1L, n)
    res <- (cumsum(p) - 0.5) / n
  } else {
    if (length(w) != length(u)) {
      stop(cond_percentile_rank_length())
    }

    ok <- stats::complete.cases(u, w)
    o <- order(u[ok])
    p <- w[ok][o]
    res <- (cumsum(p) - p * 0.5)[match(u[ok], u[ok][o])] / sum(w[ok])
  }

  out <- rep(NA_real_, length(ok))
  out[ok] <- res
  fuj::struct(
    x = out,
    class = c("percentile_rank", "numeric"),
    names = as.character(u),
    values = u
  )
}

new_percentile_rank <- function(x, values) {
  fuj::struct(
    x,
    class = c("percentile_rank", "numeric"),
    names = as.character(values),
    values = values
  )
}

#' @export
print.percentile_rank <- function(x, ...) {
  out <- x
  out <- as.double(x)
  names(out) <- names(x)
  print(out)
  invisible(x)
}

cond_percentile_rank_dupe <- function(x) {
  w <- which(duplicated(x))
  fuj::new_condition(
    msg = sprintf("`x` has duplicate values at: [%s]", toString(w)),
    class = "percentile_rank_duplicated"
  )
}

cond_percentile_rank_length <- function(x) {
  fuj::new_condition(
    msg = "length(weights) must be 1L or equal to length(x)",
    class = "percentile_rank_lengths"
  )
}

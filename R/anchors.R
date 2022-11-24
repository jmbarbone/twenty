#' Anchors
#'
#' @param x A vector of values
#' @param anchors A vector of anchors
#' @param reverse If `TRUE` reverses the scores in `x` [score_reverse()]
#'
#' @examples
#' x <- c(0.826, 0.674, 0.543, 0.105, 0.592)
#' anchors <- seq(-1, 1, .1)
#' anchorize(x, anchors)
#'
#' @export
anchorize <- function(x, anchors = NULL, reverse = FALSE) {
  x <- as.double(x)
  anchors <- as.double(unique(anchors %||% x))

  if (reverse) {
    x <- score_reverse(x, anchors)
  }

  mat <- do.call(rbind, lapply(x, function(i) i - anchors))
  mat[] <- abs(mat)

  structure(
    anchors[apply(mat, 1, which.min)],
    class = c("twenty_anchorized", "numeric"),
    anchors = anchors
  )
}

# S3 methods --------------------------------------------------------------

#' @export
#' @rdname anchorize
print.twenty_anchorized <- function(x, ...) {
  print(as.factor(x), ...)
  invisible(x)
}

#' @export
#' @rdname anchorize
as.factor.twenty_anchorized <- function(x) {
  factor(x, levels = attr(x, "anchors", exact = TRUE))
}

#' @rdname anchorize
fact.twenty_anchorized <- function(x) {
  a <- attr(x, "anchors", exact = TRUE)
  facts:::new_fact(match(x, a), a)
}

#' @rdname anchorize
counts.twenty_anchorized <- function(x) {
  anchors <- attr(x, "anchors", exact = TRUE)
  n <- length(anchors)
  x <- match(x, anchors)
  x[is.na(x)] <- n
  fuj::set_names(tabulate(x, n), anchors)
}

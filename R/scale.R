#' Scaling
#'
#' Scale scores with centrality and scale
#'
#' @param x A vector of values
#' @param center A center
#' @param scale A scale
#' @return A vector of scales scores
#' @examples
#' score_scale(1:10)
#' score_scale(1:10, center = 3, scale = 1)
#'
#' x <- matrix(1:15, ncol = 3)
#' score_scale(x)
#' score_scale(as.data.frame(x))
#' @export
score_scale <- function(x, center = mean, scale = stats::sd) {
  UseMethod("score_scale")
}

#' @rdname score_scale
#' @export
score_scale.data.frame <- function(x, center = mean, scale = stats::sd) {
  x[] <- lapply(x, score_scale)
  x
}

#' @rdname score_scale
#' @export
score_scale.default <- function(x, center = mean, scale = stats::sd) {
  if (is.function(center)) {
    center <- match.fun(center)
    center <- do.call(center, list(x))
  }

  if (is.function(scale)) {
    scale <- match.fun(scale)
    scale <- do.call(scale, list(x))
  }

  check_lengths(center, scale)
  x[] <- (x - center) / scale
  x
}

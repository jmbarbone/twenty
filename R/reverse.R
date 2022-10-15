#' Reverse a score
#'
#' @param x A vector of `numeric` values
#' @param range A range of potential values
#' @examples
#' x <- (2L, 4L, 5L, 2L, 4L, 3L, 5L, 5L, 2L, 5L)
#' score_reverse(x)
#' score_reverse(x, 0:5)
#'
#' df <- data.frame(x = x, y = score_reverse(x))
#' df
#'
#' score_reverse(df)
#' score_reverse(df, range = 1:5)
#' score_reverse(df, range = list(0:10, 1:5))
#' score_reverse(df, range = list(y = 0:10, x = 1:5))
#'
#' @export
score_reverse <- function(x, range = NULL, ...) {
  UseMethod("score_reverse")
}

#' @rdname score_reverse
#' @export
score_reverse.default <- function(x, range = NULL, ...) {
  sum(get_range(range %||% x)) - x
}

#' @rdname score_reverse
#' @export
#' @param cols An optional selection for columns
score_reverse.data.frame <- function(x, range = NULL, cols = NULL, ...) {
  if (is.list(range) & !is.null(names(range))) {
    cols <- match(names(range), colnames(x))
  } else  {
    if (is.null(cols)) {
      cols <- seq_along(x)
    } else if (is.logical(cols)) {
      cols <- which(cols)
    } else if (is.character(cols)) {
      cols <- match(cols, colnames(x))
      cols <- cols[!is.na(cols)]
    }
  }

  if (!is.list(range)) {
    range <- list(range)
  }

  if (!(length(range) == 1L) || length(range) == length(cols)) {
    stop("x and range are not compatable lengths", call. = FALSE)
  }

  x[cols] <- Map(score_reverse, x = x, range = range)
  x
}

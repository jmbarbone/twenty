test_that("score_scale() works", {
  x <- c(0.8, 0.68, 0.29, 0.67, 0.79)
  exp <- (x - mean(x)) / stats::sd(x)
  res <- score_scale(x)
  expect_identical(res, exp)

  foo_m <- function(i) sum(i) / (length(i) - 1)
  foo_s <- function(i) sqrt(sum((i - stats::median(i))^2))

  exp <- (x - foo_m(x)) / foo_s(x)
  res <- score_scale(x, foo_m, foo_s)
  expect_identical(res, exp)
})

test_that("score_scale() methods work", {
  x <- c(0.8, 0.68, 0.29, 0.67, 0.79)
  y <- x^2
  df <- data.frame(x = x, y = y)
  exp <- data.frame(x = score_scale(x), y = score_scale(y))
  res <- score_scale(df)
  expect_identical(exp, res)

  mat <- as.matrix(df)
  exp <- matrix((mat - mean(mat)) / sd(mat), ncol = 2)
  dimnames(exp) <- list(NULL, c("x", "y"))
  res <- score_scale(mat)
  expect_identical(exp, res)
})

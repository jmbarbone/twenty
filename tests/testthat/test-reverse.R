test_that("score_reverse()", {
  x <- c(2L, 4L, 5L, 2L, 4L, 3L, 5L, 5L, 2L, 5L)

  obj <- score_reverse(x)
  exp <- c(5, 3, 2, 5, 3, 4, 2, 2, 5, 2)
  expect_identical(obj, exp)

  obj <- score_reverse(x, 0:5)
  exp <- c(3, 1, 0, 3, 1, 2, 0, 0, 3, 0)
  expect_identical(obj, exp)

  df <- data.frame(x = x, y = score_reverse(x))

  obj <- score_reverse(df)
  exp <- structure(
    list(
      x = c(5, 3, 2, 5, 3, 4, 2, 2, 5, 2),
      y = c(2, 4, 5, 2, 4, 3, 5, 5, 2, 5)
    ),
    row.names = c(NA, -10L),
    class = "data.frame"
  )
  expect_identical(obj, exp)

  obj <- score_reverse(df, range = 1:5)
  exp <- structure(
    list(x = c(4, 2, 1, 4, 2, 3, 1, 1, 4, 1),
         y = c(1, 3, 4, 1, 3, 2, 4, 4, 1, 4)
    ),
    row.names = c(NA, -10L),
    class = "data.frame"
  )
  expect_identical(obj, exp)

  obj <- score_reverse(df, range = list(0:10, 1:5))
  exp <- structure(
    list(
      x = c(8, 6, 5, 8, 6, 7, 5, 5, 8, 5),
      y = c(1,3, 4, 1, 3, 2, 4, 4, 1, 4)
    ),
    row.names = c(NA, -10L),
    class = "data.frame"
  )
  expect_identical(obj, exp)

  obj <- score_reverse(df, range = list(y = 0:10, x = 1:5))
  exp <- structure(
    list(
      x = c(1, 3, 4, 1, 3, 2, 4, 4, 1, 4),
      y = c(8, 6, 5, 8, 6, 7, 5, 5, 8, 5)
    ),
    row.names = c(NA, -10L),
    class = "data.frame"
  )
  expect_identical(obj, exp)
})

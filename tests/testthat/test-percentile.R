test_that("percentile_rank()", {
  obj <- percentile_rank(0:9)
  exp <- new_percentile_rank(
    c(0.05, 0.15, 0.25, 0.35, 0.45, 0.55, 0.65, 0.75, 0.85, 0.95),
    0:9
  )
  expect_equal(obj, exp)

  x <- c(1, 2, 1, 7, 5, NA_real_, 7, 10)
  obj <- percentile_rank(x)
  exp <- new_percentile_rank(
    c(0.142857142857143, 0.357142857142857, 0.142857142857143, 0.714285714285714, 0.5, NA, 0.714285714285714, 0.928571428571429),
    x
  )
  expect_equal(obj, exp)
})

test_that("percentile_rank(weights)", {
  obj <- percentile_rank(7:1, c(1, 0, 2, 2, 3, 1, 1))
  exp <- new_percentile_rank(c(0.95, 0.9, 0.8, 0.6, 0.35, 0.15, 0.05), 7:1)
  expect_equal(obj, exp)
})

test_that("percentile_rank() conditions", {
  expect_error(
    percentile_rank(c(1, 1, 2), 1),
    class = "twenty:percentileRankDuplicatedError"
  )

  expect_error(
    percentile_rank(1:3, 1:2),
    class = "twenty:percentileRankLengthsError"
  )
})

test_that("percentile_rank()", {
  obj <- percentile_rank(0:9)
  exp <- c(`0` = 0.05, `1` = 0.15, `2` = 0.25, `3` = 0.35, `4` = 0.45,
           `5` = 0.55, `6` = 0.65, `7` = 0.75, `8` = 0.85, `9` = 0.95)
  expect_equal(obj, exp)

  x <- c(1, 2, 1, 7, 5, NA_integer_, 7, 10)
  obj <- percentile_rank(x)
  exp <- structure(
    c(0.142857142857143, 0.357142857142857, 0.142857142857143, 0.714285714285714, 0.5, NA, 0.714285714285714, 0.928571428571429),
    names = c("1", "2", "1", "7", "5", NA, "7", "10")
  )
  expect_equal(obj, exp)
})

test_that("percentile_rank(weights)", {
  obj <- percentile_rank(7:1, c(1, 0, 2, 2, 3, 1, 1))
  exp <- c(`7` = 0.95, `6` = 0.9, `5` = 0.8, `4` = 0.6, `3` = 0.35, `2` = 0.15,
           `1` = 0.05)
  expect_equal(obj, exp)
})

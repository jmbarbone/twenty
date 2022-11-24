test_that("anchorize()", {
  x <- c(0.826, 0.674, 0.543, 0.105, 0.592)
  anchors <- seq(-1, 1, .1)
  obj <- anchorize(x, anchors)
  exp <- structure(
    c(0.8, 0.7, 0.5, 0.1, 0.6),
    class = c("twenty_anchorized", "numeric"),
    anchors = anchors
  )
  expect_equal(obj, exp)
})


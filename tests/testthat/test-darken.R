context("Test darken")

test_that("expected values", {
  expect_equal(ramp("green", "blue", 0), "#00FF00")
  expect_equal(ramp("green", "blue", 100), "#0000FF")
  expect_equal(ramp("green", "blue", 50), "#007F7F")
  expect_true(all(ramp("green", "blue", 50, TRUE)[,1L] == c(0, 127, 127)))
  expect_equal(darken("green", 50), "#007F00")
  expect_equal(lighten("green", 50), "#7FFF7F")
})

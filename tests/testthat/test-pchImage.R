library(graphicsutils)
context("Test pchImage")


test_that("checking errors", {
  expect_error(pchImage(2,2))
  expect_error(pchImage(2,2,"cool.bmp"))
})

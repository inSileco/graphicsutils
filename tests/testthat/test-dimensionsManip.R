context("Dimensions manipulations at large")

test_that("howManyRC", {
  expect_error(howManyRC(-10), "n > 0 is not TRUE", fixed = TRUE)
  expect_true(identical(howManyRC(10), c(4,3)))
  expect_true(identical(howManyRC(16), c(4,4)))
})


test_that("prettyRange", {
  expect_error(prettyRange(1), "min(rgx) != max(rgx) is not TRUE", fixed = TRUE)
  expect_error(prettyRange(rep(1, 4)), "min(rgx) != max(rgx) is not TRUE", fixed = TRUE)
  expect_true(identical( prettyRange(c(3.849,3.88245)), c(3.84 + 0.005, 3.84 + 0.045)))
})

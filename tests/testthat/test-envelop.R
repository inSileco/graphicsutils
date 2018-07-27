context("Test envelop")

x <- c(1,2)
lower <- x-1
upper <- x+1

res1 <- envelop(x, upper, lower, add = F)
res2 <- envelop(x, upper, add = F)

test_that("checking areas", {
  expect_error(envelop(x, upper[-1L], lower, add=F))
  expect_error(envelop(x, upper, lower[-1L], add=F))
  #
  expect_true(identical(res1$x, c(1,2,2,1)))
  expect_true(identical(res1$y, c(2,3,1,0)))
  expect_true(identical(res2$y, c(2,3,0,0)))
})
#

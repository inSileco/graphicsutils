context("Test geometries")

plot0()
res1 <- circles(x=.5, y = .5, incr = pi/5, radi=0.45, from=0.5*pi, to=0.25*pi)
res1b <- circles(x=.5, y = .5, incr = pi/5, radi=0.45, from=0.5*pi, to=0.25*pi, clockwise = TRUE)
res2 <- circles(x=.5, y = .5, incr = pi/5, radi=0.45, from=0.5*pi, to=0.25*pi, pie=TRUE)
res3 <- circles(x=c(.5, -.5), y = .5, incr = pi/5, radi=0.45, from=0.5*pi, to=0.25*pi)


test_that("checking dimension of outputs", {
  expect_equal(length(res1), 1)
  expect_equal(length(res2), 1)
  expect_equal(length(res3), 2)
  expect_true(nrow(res2[[1]]) == nrow(res1[[1]]) + 2)
})

test_that("checking outputs", {
  expect_true(identical(res3[[1]]$y, res3[[2]]$y))
  expect_true(identical(round(res1[[1]]$y, 10), round(res1b[[1]]$y, 10)))
  expect_true(res1[[1]]$x[1] == res1b[[1]]$x[1])
})

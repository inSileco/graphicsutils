context("Circles and polar plots")

plot0()
res1 <- circles(x = 0)
res2 <- circles(x = 0, pie = T)
res3 <- circles(x = c(0, 1))
dev.off()


test_that("expected dimension", {
  expect_true(all(dim(res1[[1]]) == c(629, 2)))
  expect_true(all(dim(res2[[1]]) == c(631, 2)))
  expect_equal(length(res3), 2)
  expect_true(all(names(res1[[1]]) == c("x", "y")))
  expect_true(all(res1[[1]][1,] == c(1, 0)))
  expect_true(all(res2[[1]][1,] == c(0, 0)))
  expect_true(all(res2[[1]][631,] == c(0, 0)))
})


#' # Example 2:
#' plot0()
#' circles(x=-.5, radi=0.5, from=0.5*pi, to=0.25*pi)
#' circles(x=.5, radi=0.5, from=0.5*pi, to=0.25*pi, pie=TRUE)
#'
#' # Example 3:
#' plot0()
#' circles(matrix(-.5+.5*stats::runif(18), ncol=3))
#'
#' # Example 4:
#' plot0(x=c(-2,2),y=c(-2,2), asp=1)
#' circles(x=c(-1,1),c(1,1,-1,-1),from=pi*seq(0.25,1,by=0.25),to=1.25*pi, col=2, border=4, lwd=3)
polarPlot(1:40, stats::runif(40), to=1.9*pi, col='grey30', border='grey80')

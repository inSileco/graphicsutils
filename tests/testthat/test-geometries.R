context("Test geometries")

## get the area of rhombi drawn
res1 <- rhombi(x=0, rot=seq(0,180,60), ldg=0.5, col=7, border=NA, add=FALSE)
#
x <- c(1,3,5)
y <- c(1,2,3)
res2 <- rotation(x, y, rot=180)
res3 <- rotation(x, y, rot=360)
res4 <- homothety(x, y, 1, xcen=mean(x), ycen=mean(y))
res5 <- translation(x, y, 1, 1)
#

test_that("checking areas", {
  expect_true(all(res1==0.125))
  expect_true(all(res2$x==rev(c(1,3,5))))
  expect_true(all(round(res3$x,12)==c(1,3,5)))
  expect_true(all(round(res3$y,12)==c(1,2,3)))
  #
  expect_true(identical(res4$x, x))
  expect_true(identical(res4$y, y))
  #
  expect_true(identical(res5$x, x+1))
  expect_true(identical(res5$y, y+1))
})

#

context("Test geometry")

## get the area of rhombi drawn
res1 <- rhombi(x=0, rot=seq(0,180,60), ldg=0.5, col=7, border=NA, area=T)
##
res2 <- rotation(c(1,3,5), c(1,2,3), rot=180)
res3 <- rotation(c(1,3,5), c(1,2,3), rot=360)

test_that("checking areas", {
  expect_true(all(res1==0.125))
  expect_true(all(res2$x==rev(c(1,3,5))))
  expect_true(all(round(res3$x,12)==c(1,3,5)))
  expect_true(all(round(res3$y,12)==c(1,2,3)))
})

context("testing showPalette")

##
showPalette()
res1 <- showPalette()
dev.off()

##
showPalette()
##-- the computation of the computation of the number of rows and columns
## should be integrated in a separate function...
res2 <- showPalette(palette()[1:2], inline=T, add_number = T, add_codecolor = T)
dev.off()


test_that("checking areas", {
  expect_true(all(res1 == c("#000000", "#FF0000", "#00CD00", "#0000FF", "#00FFFF", "#FF00FF", "#FFFF00", "#BEBEBE")))
  expect_true(all(res2 == c("#000000", "#FF0000")))
})
#

test_that("number of rows and number of columns", {
  expect_true(all(howManyRC(9)==c(3,3)))
  expect_true(all(howManyRC(17)==c(5,4)))
})

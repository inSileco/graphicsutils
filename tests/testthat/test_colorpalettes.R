context("gpu color palette")

pal_atom <- c("#dedcd5", "#991f16", "#3b9b6d", "#584b4f", "#72acab", "#ca8c81")
pal_cisl <- c("#c7cbce", "#96a3a3", "#687677", "#222d3d", "#25364a", "#c77f20",
"#e69831", "#e3af16", "#e4be29", "#f2ea8b")

test_that("test gpuPalettes", {
  expect_true(all(gpuPalette("atom") == pal_atom))
  expect_true(all(gpuPalette(c("atom", "cisl")) == c(pal_atom, pal_cisl)))
  expect_equal(length(gpuPalette("atom", 100)), 100)
  expect_error(gpuPalette("insil"), "all(names %in% names(gpuPalettes)) is not TRUE", fixed = T)
})

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

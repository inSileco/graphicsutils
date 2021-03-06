context("gpu color palettes")

pal_atom <- c("#dedcd5", "#991f16", "#3b9b6d", "#584b4f", "#72acab", "#ca8c81")
pal_cisl <- c("#c7cbce", "#96a3a3", "#687677", "#222d3d", "#25364a", "#c77f20",
"#e69831", "#e3af16", "#e4be29", "#f2ea8b")

test_that("test gpuPalettes", {
  expect_true(all(gpuPalette("atom") == pal_atom))
  expect_true(all(gpuPalette(1) == pal_atom))
  expect_true(all(gpuPalette(1, 20) == colorRampPalette(pal_atom)(20)))
  expect_true(all(gpuPalette(c("atom", "cisl")) == c(pal_atom, pal_cisl)))
  expect_true(all(gpuPalette(1:2) == c(pal_atom, pal_cisl)))
  expect_equal(length(gpuPalette("atom", 100)), 100)
  expect_error(gpuPalette("insil"), "all(id %in% names(gpuPalettes)) is not TRUE", fixed = TRUE)
})

context("testing showPalette")

##
showPalette()
res1 <- showPalette()
dev.off()

##-- the computation of the computation of the number of rows and columns
## should be integrated in a separate function...
palette("default")
res2 <- showPalette(palette()[1:2], inline = TRUE, add_number = TRUE,
  add_codecolor = TRUE)
dev.off()


test_that("checking areas", {
  expect_equal(tolower(res1), col2Hex(palette()))
  expect_equal(tolower(res2), col2Hex(palette())[1:2])
})
#

test_that("number of rows and number of columns", {
  expect_equal(howManyRC(9), c(3,3))
  expect_equal(howManyRC(17), c(5,4))
})

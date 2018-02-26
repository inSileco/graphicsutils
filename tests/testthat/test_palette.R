context("Test gpu color palette")

pal_atom <- c("#dedcd5", "#991f16", "#3b9b6d", "#584b4f", "#72acab", "#ca8c81")
pal_cisl <- c("#c7cbce", "#96a3a3", "#687677", "#222d3d", "#25364a", "#c77f20",
"#e69831", "#e3af16", "#e4be29", "#f2ea8b")

test_that("test gpuPalettes", {
  expect_true(all(gpuPalette("atom") == pal_atom))
  expect_true(all(gpuPalette(c("atom", "cisl")) == c(pal_atom, pal_cisl)))
  expect_error(gpuPalette("insil"), "all(names %in% names(gpuPalettes)) is not TRUE", fixed = T)
})

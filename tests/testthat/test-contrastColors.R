context("Contrast colors")

test_that("expected values", {
  expect_equal(contrastColors("blue"), "#ffffff")
  expect_equal(contrastColors("#ffffff44", alpha = T), "#00000044")
  expect_equal(contrastColors("#ffffff", how = "how_cent"), "#808080")
  expect_equal(contrastColors("#ffffff", how = "how_prop"), "#808080")
  expect_equal(contrastColors("#ffffff", how = "how_oppo"), "#000000")
  expect_equal(contrastColors("#ffff00", how = "how_cent"), "#80807f")
  expect_equal(contrastColors("#ffff00", how = "how_prop"), "#404000")
  expect_equal(col2Hex("#ffff00"), "#ffff00")
  expect_equal(col2Hex("turquoise3"), "#00c5cd")
})

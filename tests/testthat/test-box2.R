context("test box2")


test_that("box2", {
  plot0()
  expect_error(box2(which = "dd"))
  expect_warning(box2(side = 5))
  res <- box2(c(1, 2, "h", "t"))
  expect_equal(res, 1:3)
  dev.off()

})

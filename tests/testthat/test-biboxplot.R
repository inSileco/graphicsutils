context("Create a biboxplot")

dis1 <- rnorm(1000, sd = 0.25)
dis2 <- rnorm(1000, sd = 0.5)

res1 <- biBoxplot(list(dis1), list(dis2), width = .1)
pu1 <- par()$usr
dev.off()

biBoxplot(rep(list(dis1), 10))
pu2 <- par()$usr
dev.off()

plot0(c(0.5,10.5), c(-2, 2))
biBoxplot(rep(list(stats::rnorm(1000, sd = 0.25)), 2),  add = TRUE, at = c(3, 6))
pu3 <- par()$usr
dev.off()

test_that("expected errors", {
  expect_error(biBoxplot(dis1), "class(df1) == \"list\" is not TRUE", fixed = TRUE)
  expect_error(biBoxplot(list(dis1), probs = c(.1, .2)), "length(probs) == 5 is not TRUE", fixed = TRUE)
})

test_that("expected output", {
  expect_true(all(names(res1) == c("distributions_left", "distributions_right")))
  expect_true(all(pu2[1L:2L] == pu3[1L:2L]))
  expect_true(pu1[3L] < pu2[3L])
  expect_true(pu1[4L] > pu2[4L])
})

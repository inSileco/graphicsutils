context("test boxplot2")


df_ex <- replicate(4, runif(100))
df_ex2 <- data.frame(nam = rep(LETTERS[1:2], each = 50), val = df_ex[, 1L])
xy <- boxplot2(df_ex)
xy2 <- boxplot2(df_ex, probs = c(.01, 0.25, .5, .75, .99), at = 2:5)
xy3 <- boxplot2(val ~ nam, data = df_ex2)
grDevices::graphics.off()

test_that("expected errors", {
  expect_error(boxplot2(df_ex, add = TRUE))
  expect_error(boxplot2(df_ex, probs = c(.01)))
  expect_error(boxplot2(df_ex, probs = c(.01, 0.25, .5, .75, 2)))
  expect_error(boxplot2(df_ex, probs = c(.01, 0.25, .5, .75, -2)))
})


test_that("expected output", {
  expect_identical(xy$x, 1:4)
  expect_identical(xy2$x, 2:5)
  expect_identical(xy3$x, 1:2)
  expect_identical(row.names(xy2$y), c("1%", "25%", "50%", "75%", "99%"))
  expect_identical(row.names(xy2$y), c("1%", "25%", "50%", "75%", "99%"))
  expect_true(
    all(
      xy2$y[,1] == quantile(df_ex[,1], probs = c(.01, 0.25, .5, .75, .99))
    )
  )
})


# dfa <- data.frame(name = rep(LETTERS[1:4], 25), val = runif(100))
# boxplot2(val ~ name, data = dfa, add = TRUE, vc_cex = c(4, 40, 2))

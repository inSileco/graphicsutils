context("Test plot0")

##
plot0()
pus1 <- par()$usr
dev.off()

##
plot0(x=c(0,1), y=c(0,2), xlim=c(0,10), fill=2)
pus2 <- par()$usr
dev.off()

##
plot0(x=cbind(c(0,1), c(0,2)), text="test")
pus3 <- par()$usr
dev.off()

##
plot0(c(-10,10),  grid.col = 2)

test_that("test par()$usr dimensions", {
  expect_true(all(pus1 == c(-1.08, 1.08, -1.08, 1.08)))
  expect_true(all(pus2 == c(-0.40, 10.40, -0.08, 2.08)))
  expect_true(all(pus3 == c(-0.04, 1.04, -0.08, 2.08)))
})

test_that("expected errors", {
  expect_error(plot0(1, c(1,1)), "length(x) == length(y) is not TRUE", fixed = T)
})

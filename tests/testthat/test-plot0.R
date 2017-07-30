context("Test plot0")

##
plot0()
pus1 <- par()$usr
dev.off()

##
plot0(x=c(0,1), y=c(0,2), xlim=c(0,10), fill=2)
pus2 <- par()$usr
dev.off()

test_that("test par()$usr dimensions", {
  expect_true(all(pus1 == c(-1.08, 1.08, -1.08, 1.08)))
  expect_true(all(pus2 == c(-0.40, 10.40, -0.08, 2.08)))
})

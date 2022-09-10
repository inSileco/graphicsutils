context("Test points in polygon")

tria <- matrix(c(0,2,1,0,0,2), ncol = 2)
pts <- matrix(c(1, 1, 2, 1, -1, 1), ncol = 2)
res <- pointsInPolygon(pts, tria)


test_that("does it work properly", {
  expect_true(all(res == c(TRUE, FALSE, FALSE)))
})

test_that("expected warnings", {
  expect_warning(pointsInPolygon(cbind(tria,0), pts), "ncol(points) > 2 - only the first two columns are used.", fixed = TRUE)
  expect_warning(pointsInPolygon(tria, cbind(pts, 0)), "ncol(polygon) > 2 - only the first two columns are used.", fixed = TRUE)
})

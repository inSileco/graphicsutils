
colorScale <- function(x, y, col, val = NULL, at = NULL, horizontal = TRUE) {
# plot(c(0,10), c(0, 10))
  nc <- length(col)
  sq <- seq_along(col)
  pu <- par()$usr

  if (horizontal) {
    # create x ranges
    x <- sq * .5
    ymn = .5
    ymx = 1
    image(x, y = c(ymn, ymx), z = matrix(sq), col = col, add = TRUE)
    segments(x0 = min(x), x1 = max(x), y0 = ymn)
    text(sq/diff(range(x)) + min(x), ymn, labels = sq)
  } else {
    # replicates what's above but x => y
  }

  # coords
  invisible(NULL)
}


# plot(c(0,10), c(0, 10))
# col = gpuPalette("cisl", 10)

colorScale <- function(x, y, col, val = NULL, at = NULL, horizontal = TRUE, percx = NULL, percy = NULL) {

  nc <- length(col)
  sq <- seq_along(col)
  pu <- par()$usr

  if (horizontal) {
    if (is.null(percy)) percy = .04
    if (is.null(percx)) percx = .25
    #
    pury <- diff(pu[3:4])*percy
    purx <- diff(pu[3:4])*percx
    # create x ranges
    x <- sq * .5
    sqx <- seq(x, x + purx, length.out = nc)
    image(sqx, c(y, y + pury), z = matrix(sq), col = col, add = TRUE)
    segments(x0 = x, x1 = max(x), y0 = ymn)
    text(sq/diff(range(x)) + min(x), ymn, labels = sq)
  } else {
    # replicates what's above but x => y
    if (is.null(percx)) percx = .04
    if (is.null(percy)) percy = .25
    pur <- diff(pu[1:2])*percx
  }

  # coords
  invisible(NULL)
}

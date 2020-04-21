#' Create a color scale
#'
#' Simple and flexible color scale.
#'
#' @param x x-coordinates of the
#' @param y y-coordinates of the
#' @param col vector of color
#' @param at color id
#' @param labels labels
#' @param horiz should the be horizontal
#' @param percx percentage of the plot region
#' @param percy percentage of the plot region
#' @param labels.cex coefficient of expo for labels.
#' @param title legend title.
#' @param title.cex legend title.

# x=5; y=5
# col = gpuPalette("cisl", 10)
# plot(c(0,10), c(0,10))
# colorScale(5,5,gpuPalette("cisl", 10))

colorScale <- function(x, y, col, at = NULL, labels = NULL, horiz = TRUE,
  percx = NULL, percy = NULL, labels.cex = 1, title = "legend", title.cex = 1.2) {

  stopifnot(length(col) > 1)
  nc <- length(col)
  sq <- seq_along(col)
  pu <- par()$usr

  if (horiz) {
    if (is.null(percy)) percy <- .04
    if (is.null(percx)) percx <- .25
    #
    pury <- diff(pu[1:2])*percy
    purx <- diff(pu[3:4])*percx
    # create sequence of x values
    sqx <- seq(x, x + purx, length.out = nc)
    # create sequence of labels
    if (is.null(labels)) {
      at <- sqx
    } else at <- sqx[at]
    if (is.null(labels)) {
      labels <- as.character(sq)
    } else labels <- as.character(labels)
    stopifnot(length(at) == length(labels))

    d <- diff(sqx[1:2])/2

    image(sqx, c(y, y + pury), z = matrix(sq), col = col, add = TRUE)
    segments(x0 = x - d, x1 = x + purx + d, y0 = y)
    segments(x0 = at, y0 = y, y1 = y - .01*diff(pu[1:2]))
    text(at, y, labels = labels, pos = 1, cex = labels.cex)
    text(.5*(2*x + purx), y + pury, labels = title, pos = 3, cex = title.cex)
  } else {
    # replicates what's above but x => y
    if (is.null(percx)) percx <- .04
    if (is.null(percy)) percy <- .25
    pur <- diff(pu[1:2])*percx
  }

  # coords
  invisible(NULL)
}

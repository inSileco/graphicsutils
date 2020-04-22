#' Create a color scale
#'
#' Simple and flexible color scale.
#'
#' @param x x-coordinates of the bottom-left corner of the legend.
#' @param y y-coordinates of the bottom-left corner of the legend.
#' @param col vector of colors.
#' @param at vector of integers indicating colors to be labeled.
#' @param labels labels.
#' @param horiz a logical. Should the color scale be horizontal?
#' @param percx size of the color scale along x axis.
#' @param percy size of the color scale along y axis.
#' @param adj adjust the position labels position. If `adj = 0` then labels are
#' at the bottom if `horiz = TRUE` and on the the left if `horiz = FALSE`. If
#' `adj = 1`, labels are at the top if `horiz = TRUE` and on the the right if
#' `horiz = FALSE`. So far if `horiz = TRUE`, `title` and `labels` are on
#' opposite sides.
#' @param labels.cex magnification to be used for labels.
#' @param title legend title.
#' @param title.cex magnification to be used for the title.
#'
#' @export
#' @examples
#' plot(c(0,10), c(0,10))
#' colorScale(5, 5, gpuPalette("cisl", 10), at = c(2, 4))

colorScale <- function(x, y, col, at = NULL, labels = NULL, horiz = TRUE,
  percx = NULL, percy = NULL, adj = 0, labels.cex = 1, title = "legend", title.cex = 1.2) {

  stopifnot(length(col) > 1)
  nc <- length(col)
  sq <- seq_along(col)
  pu <- par()$usr

  if (horiz) {
    if (is.null(percy)) percy <- .04
    if (is.null(percx)) percx <- .25
    pury <- diff(pu[1:2])*percy
    purx <- diff(pu[3:4])*percx
    # create sequence of x values
    sqx <- seq(x, x + purx, length.out = nc)
    # create sequence of labels
    #
    if (is.null(at)) {
      at <- sqx
      if (is.null(labels)) labels <- as.character(sq)
    } else {
      if (is.null(labels)) labels <- as.character(at)
      at <- sqx[at]
    }
    stopifnot(length(at) == length(labels))

    d <- diff(sqx[1:2])/2
    image(sqx, c(y, y + pury), z = matrix(sq), col = col, add = TRUE)
    # segments(x0 = x - d, x1 = x + purx + d, y0 = y)

    if (adj) {
      text(.5*(2*x + purx), y, labels = title, pos = 1, cex = title.cex)
      segments(x0 = at, y0 = y + pury, y1 = y + pury + .006*diff(pu[3:4]))
      text(at, y + pury, labels = labels, pos = 3, cex = labels.cex)
    } else {
      text(.5*(2*x + purx), y + pury, labels = title, pos = 3, cex = title.cex)
      segments(x0 = at, y0 = y, y1 = y - .006*diff(pu[3:4]))
      text(at, y, labels = labels, pos = 1, cex = labels.cex)
    }


  } else {
    # replicates what's above but x => y
    if (is.null(percx)) percx <- .04
    if (is.null(percy)) percy <- .25
    purx <- diff(pu[1:2])*percx
    pury <- diff(pu[3:4])*percy
    # create sequence of x values
    sqy <- seq(y, y + pury, length.out = nc)
    # create sequence of labels
    if (is.null(at)) {
      at <- sqy
      if (is.null(labels)) labels <- as.character(sq)
    } else {
      if (is.null(labels)) labels <- as.character(sq[at])
      at <- sqy[at]
    }
    stopifnot(length(at) == length(labels))

    d <- diff(sqy[3:4])/2
    image(c(x, x + purx), sqy, z = matrix(sq, nrow = 1), col = col, add = TRUE)
    # segments(x0 = x, y0 = y - d, y1 = y + pury + d)
    if (adj) {
      segments(x0 = x + purx, y0 = at, x1 = x + purx + .006*diff(pu[3:4]))
      text(x + purx, at, labels = labels, pos = 4, cex = labels.cex)
    } else {
      segments(x0 = x, y0 = at, x1 = x - .006*diff(pu[3:4]))
      text(x, at, labels = labels, pos = 2, cex = labels.cex)
    }
    text(.5*(2*x + purx), max(sqy) + 2*d, labels = title, pos = 3, cex = title.cex, srt = 0)
  }

  # coords
  invisible(NULL)
}

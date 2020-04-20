#' Draw circles
#'
#' Draw circles in a flexible way.
#'
#' @param x the x coordinates of the centers of the circles.
#' @param y the y coordinates of the centers of the circles.
#' @param radi the radii of the circles.
#' @param from the angles, expressed in radians, from which circles are drawn.
#' @param to the angles, expressed in radians, to which circles are drawn.
#' @param incr increments between two points to be linked (expressed in radians).
#' @param pie a logical. If `TRUE`, end points are linked with the center of the circle (default is set to `FALSE`).
#' @param clockwise a logical. Shall circles and arcs be drawn clockwise? Defaut is `FALSE`.
#' @param add a logical. Should the circles be added on the current plot?
#' @param ... additional arguments to be passed to [graphics::polygon()] function.
#'
#' @keywords circle geometries
#'
#' @export
#'
#' @details
#' The number of circles drawn is given by the maximum argument length amng
#' `x`, `y`, `radi`, `from` and `to` arguments.
#' Sizes are adjusted (i.e. repeated over) with \code{\link{rep_len}} function.
#'
#' @return
#' An invisible list of `data.frame` of two columns including the
#' coordinates of all circles.
#'
#' @seealso [graphics::symbols()], \code{\link[plotrix]{draw.circle}}, \code{\link[plotrix]{draw.arc}}.
#'
#' @examples
#' # Example 1:
#' plot0()
#' circles(x = 0)
#'
#' # Example 2:
#' plot0()
#' circles(x=-.5, radi=0.45, from=0.5*pi, to=0.25*pi)
#' circles(x=.5, radi=0.45, from=0.5*pi, to=0.25*pi, pie=TRUE)
#' circles(x=.5, y = -.5, radi=0.45, from=0.5*pi, to=0.25*pi, pie=TRUE, clockwise = TRUE)
#'
#' # Example 3:
#' plot0()
#' circles(matrix(-.5+.5*stats::runif(18), ncol=3))
#'
#' # Example 4:
#' plot0(x=c(-2,2),y=c(-2,2), asp=1)
#' circles(x=c(-1,1),c(1,1,-1,-1),from=pi*seq(0.25,1,by=0.25),to=1.25*pi, col=2, border=4, lwd=3)

circles <- function(x, y = x, radi = 1, from = 0, to = 2 * pi, incr = 0.01, pie = FALSE,
    clockwise = FALSE, add = TRUE, ...) {
    #
    pipi <- 2 * pi
    #
    if (!isTRUE(add))
        plot0()
    # format checking / adjusting vectors sizes
    matx <- as.matrix(x)
    argn <- c("x", "y", "radi", "from", "to")
    nbarg <- length(argn)
    nbcol <- min(nbarg, ncol(matx))
    for (i in seq_len(nbcol)) assign(argn[i], matx[, i])
    argo <- list(x, y, radi, from, to)
    ##
    sz <- max(lengths(argo))
    for (i in seq_len(nbarg)) assign(argn[i], rep_len(argo[[i]], sz))
    # drawing circles
    out <- list()
    for (i in seq_len(sz)) {
        ## distance (in rardian)
        dagl <- abs(to[i] - from[i])
        ## --- angles sequence
        if (dagl >= pipi) {
            # no point of drawing a circle multiple times
            to[i] <- pipi + 0.5 * pi
            from[i] <- 0.5 * pi
        }
        ##
        if (!clockwise) {
            sqc <- seq(from[i], from[i] + dagl, by = incr)
        } else {
            sqc <- seq(from[i], from[i] - dagl, by = -incr)
        }
        ##
        if (!pie) {
            xout <- x[i] + radi[i] * cos(sqc)
            yout <- y[i] + radi[i] * sin(sqc)
        } else {
            xout <- x[i] + c(0, radi[i] * cos(sqc), 0)
            yout <- y[i] + c(0, radi[i] * sin(sqc), 0)
        }

        polygon(xout, yout, ...)
        out[[i]] <- data.frame(x = xout, y = yout)
    }

    invisible(out)
}

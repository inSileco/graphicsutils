#' Draw ellipses
#'
#' Draw ellipses in a flexible way.
#'
#' @param x the x coordinates of the centers of the ellipses.
#' @param y same as `x` for the y-axis.
#' @param mjradi the major radii of the ellipses.
#' @param mnradi the minor radii of the ellipses.
#' @param from the angles, expressed in radians, from which ellipses are drawn.
#' @param to the angles, expressed in radians, to which ellipses are drawn.
#' @param rot the rotation angles (in degree) of the ellipses.
#' @param incr increments between two points to be linked (expressed in
#' radians).
#' @param pie a logical. If `TRUE` end points are linked with the center of
#' the ellipse (default is set to `FALSE`).
#' @param ... additional arguments to be passed to [graphics::polygon()].
#'
#' @keywords ellipse
#'
#' @export
#'
#' @details
#' For a rotation angle of 0, major radii refer to the one along the x axis.
#' The number of circles drawn is given by the maximum argument length among
#' `x`, `y`, `radi`, `from` and `to` arguments. Note vector length are adjusted
#' using [rep_len()].
#'
#' @note
#' There is a similar function, called `draw.ellipse`, in the package `plotrix`.
#'
#' @examples
#' # Example 1:
#' plot0(asp = 1)
#' ellipse()
#'
#' # Example 2:
#' plot0()
#' for (i in seq(0, 360, 30)) ellipse(rot = i)
#'
#' # Example 3:
#' plot0()
#' ellipse(matrix(-.5 + .5 * stats::runif(18), ncol = 3))
#'
#' # Example 4:
#' plot0(x = c(-2, 2), y = c(-2, 2), asp = 1)
#' ellipse(
#'     x = c(-1, 1), c(1, 1, -1, -1), from = pi * seq(0.25, 1, by = 0.25),
#'     to = 1.25 * pi, col = 2, border = 4, lwd = 3
#' )
#'
ellipse <- function(x = 0, y = x, mjradi = 1, mnradi = 0.5, from = 0, to = 2 * pi,
                    rot = 0, incr = 0.01, pie = FALSE, ...) {

    ## --- format checking / adjusting vectors sizes
    matx <- as.matrix(x)
    argn <- c("x", "y", "mjradi", "mnradi", "from", "to")
    nbarg <- length(argn)
    nbcol <- min(nbarg, ncol(matx))
    for (i in seq_len(nbcol)) assign(argn[i], matx[, i])
    argo <- list(x, y, mjradi, mnradi, from, to)
    sz <- max(lengths(argo))
    for (i in seq_len(nbarg)) assign(argn[i], rep_len(argo[[i]], sz))

    ## --- draw ellipses
    for (i in seq_len(sz)) {
        ## --- sequence to draw the ellipse
        if (abs(to[i] - from[i]) >= (2 * pi)) {
            to[i] <- 2 * pi
            from[i] <- 0
        } else {
            if ((to[i] > from[i]) & (to[i] %% (2 * pi) == 0)) {
                to[i] <- 2 * pi
            }
            to[i] <- to[i] %% (2 * pi)
            from[i] <- from[i] %% (2 * pi)
            if (to[i] < from[i]) {
                to[i] <- to[i] + 2 * pi
            }
        }
        ##
        sqc <- seq(from[i], to[i], by = incr)
        seqx <- x[i] + mjradi[i] * cos(sqc)
        seqy <- y[i] + mnradi[i] * sin(sqc)
        if (pie) {
            seqx <- c(x[i], seqx, x[i])
            seqy <- c(y[i], seqy, y[i])
        }
        rotpt <- graphicsutils::rotation(seqx, seqy,
            xrot = x[i], yrot = y[i],
            rot = rot
        )
        polygon(rotpt$x, rotpt$y, ...)
    }
    ##
    invisible(NULL)
}

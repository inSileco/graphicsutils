#' An interactive version of `layout`
#'
#' `layout2()` provides an interactive version of [graphics::layout()]. Once
#' called, an interactive grid is displayed and can be used to create a layout.
#'
#' @param n Number of plot regions, default is set to 1.
#' @param grain.x Number of vertical lines drawn to select the size of the
#' subplots regions.
#' @param grain.y Number of horizontal lines drawn to select the size of the
#' subplots regions.
#' @param show logical. If `TRUE` [graphics::layout.show()] is used to get a
#' preview of the subplots regions.
#' @param now logical. If `TRUE` [graphics::layout()] is called on exit.
#'
#' @keywords interactive layout
#'
#' @return the matrix use to draw the layout is returned as an invisible output.
#'
#' @details
#' Arguments `grain.x` and `grain.y` control the aspect of the support
#' grid generated to locate the different panels. Once the grid pops up, the
#' user must click 2*n times to select the size of the n subplots. A panel is
#' delimited by two consecutive clicks, the tow cells selected by click 2*p
#' and clicks 2*p+1  will be used to compute the area allocated to panel p.
#' Note that the user is allowed to use the same area for several plots
#' but only this area will actually be used only by the last one.
#'
#' As [graphics::layout()] is ultimately called, `layout2()` has the same
#' limits, i.e. currently 200 for the numbers of rows and columns and 10007
#' for the total number of cells.
#' @export

interactiveLayout <- function(n = 1, grain.x = 20, grain.y = grain.x,
        show = TRUE, now = TRUE) {
    stopifnot(grain.x < 201)
    stopifnot(grain.y < 201)
    stopifnot(grain.y * grain.x < 10007)
    old.par <- graphics::par(no.readonly = TRUE)
    ## --- matrix to be returned
    mat <- matrix(0, ncol = grain.x, nrow = grain.y)
    ## --- plot and lines
    par(mfrow = c(1, 1), mar = rep(0, 4), xaxs = "i", yaxs = "i", ann = TRUE)
    plot.default(0, xlim = c(0, 1), ylim = c(0, 1), type = "n", axes = FALSE)
    seqx <- seq(0, 1, length.out = grain.x + 1)
    seqy <- seq(0, 1, length.out = grain.y + 1)
    abline(v = seqx, h = seqy, lty = 3, lwd = 0.8)
    ## --- Reperes
    if ((grain.x %% 2) == 0 && (grain.y %% 2) == 0) {
        points(x = seqx[1 + grain.x / 2], y = seqy[1 + grain.y / 2], pch = 43)
    }
    if ((grain.x %% 2) == 0 && (grain.y %% 2) == 1) {
        points(
            x = rep(seqx[1 + grain.x / 2], 2),
            y = seqy[c(1 + grain.y / 3, 1 + 2 * grain.y / 3)], pch = 43
        )
    }
    if ((grain.x %% 2) == 1 && (grain.y %% 2) == 0) {
        points(
            x = seqx[c(1 + grain.x / 3, 1 + 2 * grain.x / 3)],
            y = rep(seqy[1 + grain.y / 2], 2), pch = 43
        )
    }
    if ((grain.x %% 2) == 1 && (grain.y %% 2) == 1) {
        points(
            x = seqx[c(1 + grain.x / 3, 1 + 2 * grain.x / 3)],
            y = seqy[c(1 + grain.y / 3, 1 + 2 * grain.y / 3)], pch = 43
        )
        points(
            x = seqx[c(1 + 2 * grain.x / 3, 1 + grain.x / 3)],
            y = seqy[c(1 + grain.y / 3, 1 + 2 * grain.y / 3)], pch = 43
        )
    }
    rx <- max(which((grain.x %% 1:5) == 0))
    ry <- max(which((grain.y %% 1:5) == 0))
    if (rx > 1) {
        abline(v = seqx[1 + seq(grain.y / rx, (rx - 1) * grain.x / rx,
            length.out = rx - 1
        )])
    }
    if (ry > 1) {
        abline(h = seqy[1 + seq(grain.y / ry, (ry - 1) * grain.y / ry,
            length.out = ry - 1
        )])
    }
    ## ---- center sequences
    seqcx <- seq(1 / (2 * grain.x), 1 - 1 / (2 * grain.x), length.out = grain.x)
    seqcy <- seq(1 / (2 * grain.y), 1 - 1 / (2 * grain.y), length.out = grain.y)
    for (i in seq_len(n)) {
        xy <- locator(1)
        pt1x <- which.min((seqcx - xy$x) * (seqcx - xy$x))
        pt1y <- which.min((seqcy - xy$y) * (seqcy - xy$y))
        xy <- locator(1)
        pt2x <- which.min((seqcx - xy$x) * (seqcx - xy$x))
        pt2y <- which.min((seqcy - xy$y) * (seqcy - xy$y))
        #--
        xlf <- min(pt1x, pt2x)
        xrg <- max(pt1x, pt2x)
        ybt <- min(pt1y, pt2y)
        ytp <- max(pt1y, pt2y)
        #--
        for (j in ybt:ytp) {
            for (k in xlf:xrg) {
                mat[grain.y - j + 1, k] <- i
            }
        }
        rect(seqx[xlf], seqy[ybt], seqx[xrg + 1], seqy[ytp + 1],
            col = "#00000088", border = "#00000088"
        )
    }
    dev.off()
    par(old.par)
    if (show) {
        layout(mat)
        layout.show(n)
    }
    if (now) on.exit(graphics::layout(mat))
    #
    invisible(mat)
}

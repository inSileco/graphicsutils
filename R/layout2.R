#' An interactive version of \code{layout}
#'
#' This function provides an interactive version of the \code{layout} function. Once \code{layout2} is called, the users get a grid he can click on (thanks to \code{locator} function).
#' Once the clicks have been achieved, the users can get the matrix created and/or use directly layout and then call the function.
#'
#' @param n Number of plot regions desired.
#' @param grain.x Number of vertical lines drawn to select the size of the subplots regions.
#' @param grain.y Number of horizontal lines drawn to select the size of the subplots regions.
#' @param getmatrix logical. If TRUE the matrix used to draw the subplot region is returned.
#' @param show logical. If TRUE \code{layout.show} is used to get a preview of the subplots regions.
#' @param now logical. If TRUE \code{layout} is called at \code{layout2} exit.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @details Arguments \code{grain.x} and \code{grain.y} control the aspect of the grid generated. Then,  users must click 2*n times to select the size of their n subplot (2 click by subplot).
#'
#' As \code{layout} is ultimately called, \code{layout2} has the same limits: currently 200 for the numbers of rows and columns and 10007 for the total number of cells.


layout2 <- function(n = 4, grain.x = 20, grain.y = grain.x, getmatrix = TRUE, show = TRUE, 
    now = TRUE) {
    stopifnot(grain.x < 201)
    stopifnot(grain.y < 201)
    stopifnot(grain.y * grain.x < 10007)
    old.par <- graphics::par(no.readonly = TRUE)
    ## --- matrix to be returned
    mat <- matrix(0, ncol = grain.x, nrow = grain.y)
    ## --- plot and lines
    graphics::par(mfrpw = c(1, 1), mar = rep(0, 4), xaxs = "i", yaxs = "i", ann = T)
    graphics::plot.default(0, xlim = c(0, 1), ylim = c(0, 1), type = "n", axes = F)
    seqx <- seq(0, 1, length.out = grain.x + 1)
    seqy <- seq(0, 1, length.out = grain.y + 1)
    graphics::abline(v = seqx, h = seqy, lty = 3, lwd = 0.8)
    ## --- Reperes
    if ((grain.x%%2) == 0 && (grain.y%%2) == 0) {
        graphics::points(x = seqx[1 + grain.x/2], y = seqy[1 + grain.y/2], pch = 43)
    }
    if ((grain.x%%2) == 0 && (grain.y%%2) == 1) {
        graphics::points(x = rep(seqx[1 + grain.x/2], 2), y = seqy[c(1 + grain.y/3, 
            1 + 2 * grain.y/3)], pch = 43)
    }
    if ((grain.x%%2) == 1 && (grain.y%%2) == 0) {
        graphics::points(x = seqx[c(1 + grain.x/3, 1 + 2 * grain.x/3)], y = rep(seqy[1 + 
            grain.y/2], 2), pch = 43)
    }
    if ((grain.x%%2) == 1 && (grain.y%%2) == 1) {
        graphics::points(x = seqx[c(1 + grain.x/3, 1 + 2 * grain.x/3)], y = seqy[c(1 + 
            grain.y/3, 1 + 2 * grain.y/3)], pch = 43)
        graphics::points(x = seqx[c(1 + 2 * grain.x/3, 1 + grain.x/3)], y = seqy[c(1 + 
            grain.y/3, 1 + 2 * grain.y/3)], pch = 43)
    }
    rx <- max(which((grain.x%%1:5) == 0))
    ry <- max(which((grain.y%%1:5) == 0))
    if (rx > 1) 
        graphics::abline(v = seqx[1 + seq(grain.y/rx, (rx - 1) * grain.x/rx, length.out = rx - 
            1)])
    if (ry > 1) 
        graphics::abline(h = seqy[1 + seq(grain.y/ry, (ry - 1) * grain.y/ry, length.out = ry - 
            1)])
    ## ---- center sequences
    seqcx <- seq(1/(2 * grain.x), 1 - 1/(2 * grain.x), length.out = grain.x)
    seqcy <- seq(1/(2 * grain.y), 1 - 1/(2 * grain.y), length.out = grain.y)
    for (i in 1:n) {
        xy <- graphics::locator(1)
        pt1x <- which.min((seqcx - xy$x)^2)
        pt1y <- which.min((seqcy - xy$y)^2)
        xy <- graphics::locator(1)
        pt2x <- which.min((seqcx - xy$x)^2)
        pt2y <- which.min((seqcy - xy$y)^2)
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
        graphics::rect(seqx[xlf], seqy[ybt], seqx[xrg + 1], seqy[ytp + 1], col = "#00000088", 
            border = "#00000088")
    }
    grDevices::dev.off()
    graphics::par(old.par)
    if (show) {
        graphics::layout(mat)
        graphics::layout.show(n)
    }
    if (now) {
        on.exit(graphics::layout(mat))
    }
    if (getmatrix) 
        return(mat)
    
}

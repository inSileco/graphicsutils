#' Encircle points
#'
#' Draw a polygons around a certains set of points.
#'
#' @param x the x coordinates of a set of points. Alternatively, a
#'       single argument `x` can be provided.
#' @param y the y coordinates of a set of points.
#' @param nb.pt the number of points to be generated around each coordinates.
#' @param off.set the y coordinates of a set of points.
#' @param ... further arguments to be passed to `[graphics::polygon()]` function.
#'
#' @details
#' The technique employed is fairly simple: for a set of coordinates x, y handled
#' using `xy.coords` a set of `nb.pt` number is generetaed at a
#' `off.set` distance of each coordinates, then a convex is drawn around
#' the coordinates using [grDevices::chull()].
#'
#' @export
#'
#' @examples
#' coords <- cbind(runif(10), runif(10))
#' plot0(coords)
#' points(coords, bg='grey25', pch=21)
#' encircle(coords, border='#7b11a1', lwd=2)

encircle <- function(x, y = NULL, nb.pt = 20, off.set = 1, ...) {
    tmp <- grDevices::xy.coords(x, y)
    coords <- data.frame(x = tmp$x, y = tmp$y)
    cfig <- toFig(coords)
    ## off.set as a percentage of the maximum figure region dimensions
    ofs <- off.set * 0.02 * max(diff(graphics::par()$fig)[c(1, 3)])
    seqa <- seq(0, 2 * pi, length.out = nb.pt + 1)[-1L]
    seqx <- ofs * cos(seqa)
    seqy <- ofs * sin(seqa)
    ##
    pts <- data.frame(x = rep(cfig$x, each = nb.pt) + rep(seqx, nrow(cfig)), y = rep(cfig$y,
        each = nb.pt) + rep(seqy, nrow(cfig)))
    ## compute the convex hull and plot it using user system
    graphics::polygon(toUser(pts[grDevices::chull(pts), ]), ...)
    ##
    invisible(NULL)
}

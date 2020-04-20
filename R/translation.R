#' Translation
#'
#' Compute a translation for a set of points. The transformed set of points is
#' optionally add to the current plot.
#'
#' @param x,y x and y coordinates of points to be translated (can also be a matrix, see details).
#' @param xtrans the x coordinate of the translation vector.
#' @param ytrans the y coordinate of the translation vector.
#' @param add logical. If `TRUE` the set of transformed points is drawn as a polygon.
#' @param ... Additional arguments to be passed to `polygon` function (used only if `add` is TRUE).
#'
#' @keywords translation, geometry
#'
#' @export
#'
#' @details
#' For details about what is a translation, see
#' <https://en.wikipedia.org/wiki/Translation_(geometry)>. Note that if `x` is a
#' matrix with more than 2 columns, then x is the first column and y the second
#' one.
#'
#'
#' @examples
#' # Example 1:
#' plot0(c(0,10),c(0,10))
#' x <- c(4,6,5)
#' y <- c(2,2,4)
#' polygon(x,y)
#' trans1 <- translation(x,y,xtrans=2,ytrans=5, add=TRUE, border=4, lwd=2)
#'
#' # Example 2:
#' x <- c(2,4,3,1)
#' y <- c(1,1,3,3)
#' plot0(c(0,10),c(0,10))
#' polygon(x,y)
#' for (i in seq_len(6)) translation(x,y,xtrans=i,ytrans=i, add=TRUE, border=i+1, lwd=2)


translation <- function(x, y, xtrans = 0, ytrans = 0, add = FALSE, ...) {
    ##-- Format checking
    x <- as.matrix(x)
    stopifnot(ncol(x) <= 2)
    x <- matrix(as.numeric(x), ncol = ncol(x))
    if (ncol(x) > 1) {
        y <- x[, 2]
        x <- x[, 1]
    } else {
        sz <- max(length(x), length(y))
        x <- rep_len(x, sz)
        y <- rep_len(y, sz)
    }
    ##--
    trasla <- list(x = x + xtrans, y = y + ytrans)
    if (add)
        polygon(trasla$x, trasla$y, ...)
    ##--
    trasla
}

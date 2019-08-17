#' Homothety
#'
#' Compute a homothetic transformation for a set of points.
#' The transformed set of points is optionally drawn as a polygon.
#'
#' @param x the x coordinates of points. It can also be a matrix (see details).
#' @param y the y coordinates of points.
#' @param lambda the factor to be used for the homothetetic transformations.
#' @param xcen the x coordinate for the center of rotation.
#' @param ycen the y coordinate for the center of rotation.
#' @param add logical. If `TRUE` the set of transformed points are drawn as a polygon.
#' @param ... additional arguments to be passed to [graphics::polygon()] function (used only if `add` is TRUE).
#'
#' @keywords homothety, geometry
#'
#' @export
#'
#' @details
#' Details about what is a homothetic transformation, see <https://en.wikipedia.org/wiki/Homothetic_transformation>.
#'
#' If `x` is a matrix with more than 2 columns, then `x` is the first column and y the second one.
#'
#' Note that `lambda`, `xcen` and `ycen` are unique, meaning that `homothety` computes only one homothetic transformation.
#' Drawing the points computed is relevant only if there are more than 2 points.
#'
#' @examples
#' # Example:
#' plot0(c(0,10),c(0,10))
#' x <- c(4,6,5)
#' y <- c(2,2,4)
#' polygon(x,y)
#' poly2 <- homothety(x,y,2)
#' polygon(poly2$x,poly2$y)
#' poly3 <- homothety(x, y, -2.5, xcen=5, ycen=4, border=4, add=TRUE)


homothety <- function(x, y, lambda, xcen = NULL, ycen = NULL, add = FALSE, ...) {

    # Format checking
    x <- as.matrix(x)
    stopifnot(ncol(x) <= 2)
    x <- matrix(as.numeric(x), ncol = ncol(x))
    if (ncol(x) > 1) {
        y <- x[, 2L]
        x <- x[, 1L]
    } else {
        sz <- max(length(x), length(y))
        x <- rep_len(x, sz)
        y <- rep_len(y, sz)
    }
    # if null, xrot/yrot are the mean of x/y coordinates
    if (is.null(xcen))
        xcen <- mean(x)
    if (is.null(ycen))
        ycen <- mean(y)
    #
    homot <- list(x = lambda * (x - xcen) + xcen, y = lambda * (y - ycen) + ycen)
    if (add)
        polygon(homot$x, homot$y, ...)
    #
    invisible(homot)
}

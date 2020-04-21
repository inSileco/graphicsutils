#' Rotation
#'
#' Rotates a set of points.
#'
#' @param x,y x and y coordinates of points.
#' @param rot angle of the rotation expressed in degree.
#' @param xrot optional, x coordinate for the center of rotation.
#' @param yrot optional, y coordinate for the center of rotation.
#' @param rad logical. Should radian be used rather than degrees?
#'
#' @keywords rotation
#'
#' @export
#'
#' @details Returns the coordinates of the points after rotation.
#' If the coordinates of the rotation center are not specified, then the
#' rotation center is the centroid of the points to be rotated.
#'
#' @examples
#' plot0(c(0,10),c(0,10))
#' y <- c(6,6,9)
#' x <- c(2,5,3.5)
#' polygon(x, y, lwd=2)
#' myrot <- rotation(x, y, rot=90)
#' polygon(myrot$x, myrot$y, lwd=2, border=4)
#' myrot2 <- rotation(x, y, rot=-40, 0, 0)
#' polygon(myrot2$x,myrot2$y, lwd=2, border=3)

rotation <- function(x, y, rot = 90, xrot = mean(x), yrot = mean(y), rad = FALSE) {
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
    #
    matxy <- matrix(c(x - xrot, y - yrot), nrow = 2, byrow = TRUE)
    if (!isTRUE(rad))
        rot <- pi * rot/180
    mat.rot <- matrix(c(cos(rot), sin(rot), -sin(rot), cos(rot)), 2)
    matxy2 <- mat.rot %*% matxy
    #
    list(x = matxy2[1L, ] + xrot, y = matxy2[2L, ] + yrot)
}

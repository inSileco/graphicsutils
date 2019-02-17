#' Are points inside a polygon?
#'
#' For a given matrix of points coordinates, `pointsInPolygon` returns a
#' logical vector stating whether or not these points are inside a specific
#' polygon whose coordinate as passed as an argument.
#'
#' @param points a matrix of coordinates of points to be tested.
#' @param polygon a two-columns matrix including the coordinate of the polygon.
#'
#' @keywords points, polygons, over
#'
#' @details
#' Implements the Ray-casting algorithm.
#'
#' @references
#' \url{https://rosettacode.org/wiki/Ray-casting_algorithm#C}
#'
#' @export
#'
#' @examples
#' mat <- matrix(10*runif(100), 50)
#' res <- pointsInPolygon(mat, cbind(c(4,8,8,4),c(4,4,8,8)))
#' # Visual assessment
#' plot0(c(0,10), c(0,10))
#' graphics::polygon(c(4,8,8,4),c(4,4,8,8))
#' graphics::points(mat[,1], mat[,2], col=res+1)


pointsInPolygon <- function(points, polygon) {
    ##
    points <- as.matrix(points)
    polygon <- as.matrix(polygon)
    stopifnot(nrow(polygon) > 2)
    ##
    if (ncol(points) > 2) {
        warning("ncol(points)>2 - only the first two columns are used.")
        points <- points[, 1L:2L]
    }
    if (ncol(polygon) > 2) {
        warning("ncol(polygon)>2 - only the first two columns are used.")
        polygon <- polygon[, 1L:2L]
    }
    pointsInPolygon_core(points, polygon)
}

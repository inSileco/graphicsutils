#' Are points inside a polygon?
#'
#' Return a logical vector stating whether or not points are inside a static polygon.
#'
#' @param x the x coordinates of points to be tested.
#' @param y the y coordinates of points to be tested.
#' @param poly_x the x coordinates of the static polygons.
#' @param poly_y the y coordinates of the static polygons.
#'
#' @keywords points, polygons, over
#'
#' @details
#' It implements the Ray-casting algorithm.
#'
#' @export
#'
#' @examples
#' # Example
#' plot0(c(0,10), c(0,10))
#' valx <- 10*runif(40)
#' valy <- 10*runif(40)
#' res <- pointsInPolygon(valx,valy,c(4,8,8,4),c(4,4,8,8))
#' # Visual assessment
#' graphics::polygon(c(4,8,8,4),c(4,4,8,8))
#' graphics::points(valx, valy, col=res+1)


pointsInPolygon <- function(x, y, poly_x, poly_y) {
    ## 
    stopifnot(length(x) == length(y))
    stopifnot(length(poly_x) == length(poly_y))
    stopifnot(length(x) > 3)
    ## 
    szpt <- length(x)
    szpo <- length(poly_x)
    ## 
    next_x <- c(poly_x[-1], poly_x[1])
    next_y <- c(poly_y[-1], poly_y[1])
    ## 
    constant <- (next_x - poly_x)/(next_y - poly_y)
    ## 
    out <- rep(FALSE, szpt)
    ## 
    rgx <- range(poly_x)
    rgy <- range(poly_y)
    ## 
    for (k in 1:szpt) {
        if (x[k] >= rgx[1L] & x[k] <= rgx[2L] & y[k] >= rgy[1L] & y[k] <= rgy[2L]) {
            for (j in 1:szpo) {
                if ((poly_y[j] >= y[k] & next_y[j] < y[k]) | (next_y[j] >= y[k] & 
                  poly_y[j] < y[k]) & (poly_x[j] <= x[k] | next_x[j] <= y[k])) {
                  if (poly_x[j] + (y[k] - poly_y[j]) * constant[j] < x[k]) {
                    out[k] <- !out[k]
                  }
                }
            }
        }
    }
    return(out)
}

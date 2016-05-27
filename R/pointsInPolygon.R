#' Are points inside a polygon ?
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
#' I repoduced the algorithm described in \url{http://alienryderflex.com/polygon/}.
#'
#' @export
#'
#' @examples
#' # Example
#' plot0(c(0,10), c(0,10))
#' valx <- 10*runif(20)
#' valy <- 10*runif(20)
#' polygon(c(4,8,8,4),c(4,4,8,8))
#' points(valx, valy, col=pointsInPolygon(valx,valy,c(4,8,8,4),c(4,4,8,8))+1)


pointsInPolygon <- function(x, y, poly_x, poly_y) {
    ## 
    szpt <- length(x)
    szpo <- length(poly_x)
    ## 
    stopifnot(szpt == length(y))
    stopifnot(szpo > 3)
    stopifnot(szpo == length(poly_y))
    ## 
    next_x <- c(poly_x[-1], poly_x[1])
    next_y <- c(poly_y[-1], poly_y[1])
    ## 
    constant <- (next_x - poly_x)/(next_y - poly_y)
    ## 
    out <- rep(FALSE, szpt)
    ## 
    for (k in 1:szpt) {
        for (j in 1:szpo) {
            if ((poly_y[j] >= y[k] & next_y[j] < y[k]) | (next_y[j] >= y[k] & poly_y[j] < 
                y[k]) & (poly_x[j] <= x[k] | next_x[j] <= y[k])) {
                if (poly_x[j] + (y[k] - poly_y[j]) * constant[j] < x[k]) {
                  out[k] <- !out[k]
                }
            }
        }
    }
    return(out)
}

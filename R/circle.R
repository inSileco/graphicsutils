#' Draw circles
#'
#' \code{circle} Draw circles in a flexible way.
#'
#' @param x The x coordinates of the centers of the circles.
#' @param y The y coordinates of the centers of the circles.
#' @param radi The radii of the circles.
#' @param from Start points expressed in radians.
#' @param to End points expressed in radians.
#' @param incr Increments expressed in radians.
#' @param col Vector of colors of the circles.
#' @param ... Additional arguments to be passed to either \code{\link{polygon}} function (if \code{boder} is defined) either \code{\link{lines}} function (otherwise).
#'
#' @keywords circle, plot
#'
#' @export
#'
#' @details The number of cicrles drawn is given by the maximum argument length among \code{x}, \code{y} and \code{radi} arguments. Sizes are adjusted using \code{\link{rep_len}} function. The plot used \code{\link{lines}} function, however if \code{border} is defined, then \code{\link{polygon}} function is used.
#'
#' @examples
#' #Example 1:
#' plot0()
#' circle()
#'
#' #Example 2:
#' plot0(x=c(-2,2),y=c(-2,2))
#' circle(c(-1,1), col=2, lwd=4)
#'
#' #Example 3:
#' plot0(x=c(-2,2),y=c(-2,2), asp=1)
#' circle(x=c(-1,1),c(1,1,-1,-1),from=pi*seq(0.25,1,by=0.25),to=1.25*pi, col=2, border=4, lwd=3)

circle <-
function(x=0, y=x, radi=1, from=0, to=2*pi, incr=0.01, closing=1, col=1, ...){

    ## --- format checking
    x <- as.matrix(x)
    stopifnot(ncol(x)<=3)
    x <- matrix(as.numeric(x),ncol=ncol(x))
    if (ncol(x)>1){
        y <- x[,2L]
        if (ncol(x)>2) radi <- x[,3L]
        x <- x[,1L]
    }

    ## --- adjust vectors sizes
    sz <- max(length(x),length(y),length(radi), length(from), length(to))
    x <- rep_len(x,sz)
    y <- rep_len(y,sz)
    from <- rep_len(from,sz)
    to <- rep_len(to,sz)
    radi <- rep_len(radi,sz)
    mycol <- rep_len(col,sz)
    bd <- which("border"%in%names(list(...)))

    ## --- draw the circle
    for (i in 1L:sz){
        ## --- sequence to draw the circle
        sqc <- seq(from[i], to[i], by=incr)
        if (length(bd)>0) polygon(x[i]+radi[i]*cos(sqc),y[i]+radi[i]*sin(sqc), col=mycol[i],...)
        else lines(x[i]+radi[i]*cos(sqc),y[i]+radi[i]*sin(sqc),col=mycol[i],...)
    }
}

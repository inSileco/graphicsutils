#' Translation
#'
#' Compute a translation for a set of points. The transformed set of points is optionnaly add to the current plot.
#'
#' @param x The x coordinates of points. It can also be a matrix (see details).
#' @param y The y coordinates of points.
#' @param xtrans The x vector of the translation.
#' @param ytrans The y vector of the translation..
#' @param add logical. If TRUE the set of transforned points is drawn as a polygon.
#' @param ... Additionnal arguments to be passed to \code{polygon} function (used only if \code{add} is TRUE).
#'
#' @keywords translation
#'
#' @export
#'
#' @details
#' For details about what is a translation, see \url{https://en.wikipedia.org/wiki/Translation_(geometry)}.
#'
#' If x is a matrix with more than 2 columns, then x is the first column and y the second one.
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
#' for (i in 1:6) translation(x,y,xtrans=i,ytrans=i, add=TRUE, border=i+1, lwd=2)


translation <- function(x, y, xtrans=0, ytrans=0, add=FALSE, ...){
    ## ---- Format checking
    x <- as.matrix(x)
    stopifnot(ncol(x)<=2)
    x <- matrix(as.numeric(x),ncol=ncol(x))
    if (ncol(x)>1){
        y <- x[,2]
        x <- x[,1]
    }
    else {
        sz <- max(length(x),length(y))
        x <- rep_len(x,sz)
        y <- rep_len(y,sz)
    }
    ## ----
    trasla <- list(x=x+xtrans,y=y+ytrans)
    if (add) polygon(trasla$x, trasla$y, ...)
    ## ----
    return(trasla)
}

#' Angles between vectors.
#'
#' Calcul the angle of two set of vectors.
#'
#' @param x0 The x coordinates of the first set of vector.
#' @param y0 The y coordinates of the first set of vector.
#' @param x1 The x coordinates of the second set of vector.
#' @param y1 The y coordinates of the second set of vector.
#' @param rad logical. If TRUE, angles are returned in radians.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @examples
#' #Example:
#' plot0(c(-10,10),c(-10,10))
#' arrows(c(0,3),c(0,0),c(3,0),c(3,-3))
#' cool <- getAngle2d(c(0,3),c(0,0),c(3,0),c(3,-3))

getAngle2d<-function(x0, y0, x1, y1, rad=FALSE){
    sz <- max(sapply(list(x0,y0,x1,y1),length))
    x0 <- rep_len(x0, sz)
    x1 <- rep_len(x1, sz)
    y0 <- rep_len(y0, sz)
    y1 <- rep_len(y1, sz)
    ## ----
    dstc <- sqrt((x1-x0)*(x1-x0)+(y1-y0)*(y1-y0))
    stopifnot(sum(dstc==0)==0)
    cx <- acos((x1-x0)/dstc)
    ## ----
    ang <- cx*(-1+2*((y1-y0)>0))
    if (!rad) ang <- ang*180/pi+(ang<0)*360
    return(ang)
}

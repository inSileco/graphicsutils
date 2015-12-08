#' Add arrows to a plot.
#'
#' Draw arrows between pairs of points. Arrows drawn are fully customizable by using parameters of \code{polygon} function.
#'
#' @param x0 The x coordinates of points from which to draw arrows.
#' @param y0 The y coordinates of points from which to draw arrows.
#' @param x1 The x coordinates of points to which to draw arrows.
#' @param y1 The y coordinates of points to which to draw arrows.
#' @param off0 Offset of points from which to draw arrows.
#' @param off1 Offset of points to which to draw arrows.
#' @param cex.arr The magnification coefficient to be used for the heights of the arrows.
#' @param cex.shr The magnification coefficient to be used to change the height of arrows towards their heads.
#' @param cex.hl The magnification coefficient to be used for the lengths of arrows' head.
#' @param cex.hh The magnification coefficient to be used for the heights of arrows' head.
#' @param prophead logical. If TRUE arrows are drawn with head proportionnal to the length of the arrows.
#' @param twoheaded logical. If TRUE two-headed arrows are drawn, default is FALSE.
#' @param ... Additional arguments to be passed to \code{polygon} function.

#' @keywords arrows
#'
#' @export
#'
#'
#' @examples
#' # Example 1:
#' plot0(c(0,10),c(0,10))
#' arrows2(1,9,8)
#' arrows2(1,8,8,1,cex.hh=1.2, cex.hl=1.2, col="grey30", lwd=1.2, prophead=TRUE, twoheaded=TRUE)
#'
#' # Example 2:
#' plot0(c(0,1),c(0,1))
#' arrows2(runif(2), runif(2), x1=runif(2), y1=runif(2))
#' arrows2(runif(2), runif(2), x1=runif(2), y1=runif(2), prophead=FALSE, lty=3)


arrows2 <- function(x0, y0, x1=x0, y1=y0, off0=0, off1=off0, cex.arr=1, cex.shr=1, cex.hh=1, cex.hl=1, prophead=TRUE, twoheaded=FALSE, ...){
    stopifnot(all(c(off0,off1)^2<1))
    ## ---- Format checkings / adjusting vectors sizes
    argn <- c("x0", "y0", "x1", "y1")
    argo <- list(x0, y0, x1, y1)
    sz <- max(sapply(list(x0,y0,x1,y1),length))
    for (i in 1L:length(argn)) assign(argn[i], rep_len(argo[[i]], sz))
    argo <- list(x0, y0, x1, y1)
    ## ----
    rx <- (x1-x0)
    ry <- (y1-y0)
    distpt <- sqrt(rx*rx+ry*ry)
    # ----- Checkings
    pb <- which(distpt==0)
    if (length(pb)>0) {
        warning("Zero-length arrows are skipped.")
        for (i in 1L:length(argn)) assign(argn[i], argo[[i]][-pb])
    }
    ## ----
    anglept <- .5*pi
    idx1 <- which(rx!=0)
    anglept[idx1] <- atan(ry[idx1]/rx[idx1])
    idx2 <- which(rx<0)
    anglept[idx2] <- anglept[idx2]+pi
    ## ----
    x0 <- x0+distpt*off0*cos(anglept)
    y0 <- y0+distpt*off0*sin(anglept)
    distpt <- distpt*(1-off0-off1)
    ## ----
    myusr <- par()$usr
    hg1 <- 0.015*(myusr[4L]-myusr[3L])*cex.arr
    hg2 <- hg1*cex.shr
    hg3 <- hg2+cex.hh*hg1
    ## ----
    for (i in 1L:sz){
      print(i)
      lg1 <- distpt[i]
      if (!prophead) {
        lg3 <- cex.hl*0.06*(myusr[2L]-myusr[1L])
        lg2 <- lg1-lg3
      }
      else {
        lg2 <- lg1*(1-cex.hl*0.2)
        lg3 <- lg1*cex.hl*0.2
      }
      ## ----
      if (!twoheaded){
        sqptx <- rep(x0[i],7)+c(0, lg2, lg2, lg1, lg2, lg2, 0)
        sqpty <- rep(y0[i],7)+c(hg1, hg2, hg3, 0, -hg3, -hg2, -hg1)
      }
      else {
        sqptx <- rep(x0[i],12)+c(0, lg3, lg3, 0.5*lg1, lg2, lg2, lg1, lg2, lg2, 0.5*lg1, lg3, lg3)
        sqpty <- rep(y0[i],12)+c(0, hg3, hg2, hg1, hg2, hg3, 0, -hg3, -hg2, -hg1, -hg2, -hg3)
      }
      ## ----
      ptcoord <- rotation(sqptx, sqpty, rot=anglept[i], xrot=x0[i], yrot=y0[i], radian=TRUE)
      polygon(ptcoord$x, ptcoord$y, ...)
    }
}

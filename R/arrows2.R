#' Add arrows to a plot.
#'
#' Draw arrows between pairs of points.
#'
#' @param x0 The x coordinates of points from which to draw.
#' @param y0 The y coordinates of points from which to draw.
#' @param x1 The x coordinates of points to which to draw.
#' @param y1 The y coordinates of points to which to draw.
#' @param cex.hg The magnification coefficient to be used for the heights of the arrows.
#' @param pct.hg The height of the arrows expressed as a percentage of the total length (see details).
#' @param cex.hh The magnification coefficient to be used for the height of the heads of the arrows.
#' @param pct.hw The length of the heads of the arrows expressed as a percentage of the total length.
#' @param cex.sk The magnification coefficient to be used to chance the height of the arrows towards the heads.
#' @param pct.spc The proportion of the distance between the points to leave as space before and after the arrow.
#' @param twoheaded logical. If TRUE two headed arrows are drawn, default is FALSE.
#' @param relativ logical. If TRUE, the heights of arrows are proportional to the lengths, default is TRUE.
#' @param ... Additional arguments to be passed to \code{polygon} function.

#' @keywords arrows
#'
#' @export
#'
#' @details
#' If \code{relativ} is FALSE (as it is by default), then when \code{cex.hh} is set to 1, heights represent 10\% of the length of arrows.
#' If \code{relativ} is FALSE then a reference length is computed according to bith the y axis and the x/y ratio of the current plot.
#' In both case the height can be ajusted using \code{cex.hh}.
#'
#' @note
#' When arrows are not parallel to one axis, right angles within arrows are not right unless the x/y ration is set to 1.
#'
#' @examples
#' # Example 1:
#' par(mfrow=c(1,2))
#' plot0(c(0,10),c(0,10))
#' arrows2(2,c(4,6,8),x1=c(4,6,8),y1=c(4,6,8), col=8, pct.spc=0.025)
#' plot0(c(0,10),c(0,10))
#' arrows2(2,c(4,6,8),x1=c(4,6,8),y1=c(4,6,8), col=8, pct.spc=0.025, relativ=FALSE)
#'
#' # Example 2:
#' plot0(c(0,10),c(0,10), asp=1)
#' arrows2(1, 9, x1=9,y1=6, lwd=2, col=4, border=2, lty=2)
#' arrows2(1, 7, x1=9,y1=4, lwd=2, cex.hg=0.8, cex.hh=2, cex.sk=0.5, col=4, border=2, lwd=2)
#' arrows2(1, 5, x1=9,y1=2, lwd=2, cex.hg=0.6, cex.hh=2, cex.sk=1, pct.hw=0.18, twoheaded=TRUE,
#' col=4, border=2, lwd=2)


arrows2 <- function(x0, y0, x1=x0, y1=y0, cex.hg=1, pct.hg=0.1, cex.hh=1, pct.hw=0.1, cex.sk=1, pct.spc=0, twoheaded=FALSE, relativ=TRUE, ...){
    stopifnot(pct.hw^2<1, pct.hg^2<1, pct.spc^2<1)
    ## ---- Format checkings / adjusting vectors sizes
    argn <- c("x0", "y0", "x1", "y1")
    argo <- list(x0, y0, x1, y1)
    sz <- max(sapply(list(x0,y0,x1,y1),length))
    for (i in 1L:length(argn)) assign(argn[i], rep_len(argo[[i]], sz))
    argo <- list(x0, y0, x1, y1)
    # ----- Checkings
    pb <- which((x0==x1)&(y0==y1)==1)
    if (length(pb)>0) {
        warning("Zero-length arrow is of indeterminate angle and so skipped.")
        for (i in 1L:length(argn)) assign(argn[i], argo[[i]][-pb])
    }
    ## ----
    distpt <- sqrt((x0-x1)^2+(y0-y1)^2)
    anglpt <- getAngle2d(x0,y0,x1,y1)
    ## ---- Using height reference, hgref integrates the range of y axis and the y/x aspect ration
    mypin <- par()$pin
    myusr <- par()$usr
    hgref <- 0.001*(myusr[4L]-myusr[3L])*(mypin[1L]+mypin[2L])/(2*mypin[2L])
    # ## ----
    for (i in 1L:sz){
        myspace <- pct.spc*distpt[i]
        totdist <- distpt[i]*(1-2*pct.spc)
        ## ----
        ax1 <- myspace
        ax2 <- totdist*(1-pct.hw)
        ax3 <- distpt[i]-myspace
        ## ----
        if (relativ) {
            ay1 <- 0.04*totdist*cex.hg
            ay2 <- 0.04*totdist*cex.hg*(cex.sk*cex.hg+cex.hh)
        }
        else {
            ay1 <- hgref*cex.hg
            ay2 <- hgref*(cex.sk*cex.hg+cex.hh)
        }
        ## ----
        if (!twoheaded){
            sqptx<-rep(x0[i],7)+c(ax1, ax2, ax2, ax3, ax2, ax2, ax1)
            sqpty<-rep(y0[i],7)+c(ay1, cex.sk*ay1, ay2, 0, -ay2, -cex.sk*ay1, -ay1)
        }
        else {
            ax4 <- totdist*pct.hw
            sqptx <- rep(x0[i],12)+c(ax1, ax4, ax4, 0.5*totdist, ax2, ax2, ax3, ax2, ax2, 0.5*totdist, ax4, ax4)
            sqpty <- rep(y0[i],12)+c(0, ay2, cex.sk*ay1, ay1, cex.sk*ay1, ay2, 0, -ay2, -cex.sk*ay1, -ay1, -cex.sk*ay1, -ay2)
        }
        ptcoord <- rotation(sqptx, sqpty, rot=anglpt[i], xrot=x0[i], yrot=y0[i])
        polygon(ptcoord$x, ptcoord$y, ...)
    }
}

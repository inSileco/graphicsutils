#' Add arrows to a plot
#'
#' Draw arrows between pairs of points.
#'
#' @usage
#' function(x0, y0, x1=x0, y1=y0, cex.hg=1, cex.hh=1, pct.hw=0.1, 
#' cex.sk=1, space=1, twoheaded=FALSE, ...)
#'
#' @param x0 The x coordinates of points from which to draw.
#' @param y0 The y coordinates of points from which to draw.
#' @param x1 The x coordinates of points to which to draw.
#' @param y1 The y coordinates of points to which to draw.
#' @param cex.hg The magnification coefficient to be used for the height of the arrows.
#' @param cex.hh The magnification coefficient to be used for the height of the heads of the arrows.
#' @param pct.hw The length of the heads of the arrows expressed as a percentage of the total length.
#' @param cex.sk The magnification coefficient to be used to chance the height of the arrows towards the heads.
#' @param space The magnification coefficient to be used for the space between points between which arrows are drawn and the arrows them-selves.  
#' @param twoheaded logical. If TRUE two headed arrows are drawn.
#' @param ... Additional arguments to be passed to \code{polygon} function. 

#' @keywords arrows
#'
#' @export
#'
#' @details Arrows as a polygons
#'
#' @examples
#' # Example 1:
#' plot0(c(0,10),c(0,10))
#' points(c(2,6),c(8,8), col=8, pch=19)
#' arrows2(2,2,x1=2,y1=4)
#' arrows2(2,c(4,6,8),x1=6,y1=c(4,6,8), col=8, space=1.2)
#'
#' # Example 2:
#' plot0(c(0,10),c(0,10))
#' arrows2(1,8,x1=9,y1=6, lwd=2, col=4, border=2, lty=2)
#' arrows2(1,6,x1=9,y1=4, lwd=2, cex.hg=2, cex.hh=2, cex.sk=0.5, col=4, border=2, lwd=2)
#' arrows2(1,4,x1=9,y1=2, lwd=2, cex.hg=2, cex.hh=2, cex.sk=0.5, pct.hw=0.18, twoheaded=TRUE, 
#' twocol=4, border=2, lwd=2)


arrows2 <- function(x0, y0, x1=x0, y1=y0, cex.hg=1, cex.hh=1, pct.hw=0.1, cex.sk=1, space=1, twoheaded=FALSE, ...){

    stopifnot()
    ## ----
    sz<-max(sapply(list(x0,y0,x1,y1),length))
    x0<-rep_len(x0, sz)
    y0<-rep_len(y0, sz)
    x1<-rep_len(x1, sz)
    y1<-rep_len(y1, sz)
    ## ---
    ## checkings
    pb<-which((x0==x1)*(y0==y1)==1)
    if (length(pb)) stop("Points between which arrows are drawn must have different coordinates.") 

    ## ----
    distpt<-sqrt((x0-x1)^2+(y0-y1)^2)
    anglpt<-getangle2d(x0,y0,x1,y1)
    usrx<-0.008*(par()$usr[2L]-par()$usr[1L])
    usry<-0.008*(par()$usr[4L]-par()$usr[3L])
    ## ----
    for (i in 1:sz){
        ## Using length reference in both dimension, weightening by the sin and cos of the angle  
        ## 
        asphg<-sin(anglpt[i]+90)^2*usry+cos(anglpt[i]+90)^2*usrx
        aspwd<-sin(anglpt[i])^2*usry+cos(anglpt[i])^2*usrx
        ##
        myspace<-space*aspwd
        ##
        totdist<-distpt[i]-2*myspace
        ax1<-myspace
        ax2<-totdist*(1-pct.hw) 
        ax3<-distpt[i]-myspace
        ##
        ay1<-asphg*cex.hg
        ay2<-asphg*(cex.sk*cex.hg+cex.hh)
        ay3<-0
        ##
        if (!twoheaded){
            sqptx<-rep(x0[i],7)+c(ax1, ax2, ax2, ax3, ax2, ax2, ax1)
            sqpty<-rep(y0[i],7)+c(ay1, cex.sk*ay1, ay2, ay3, -ay2, -cex.sk*ay1, -ay1)
        }
        else {  
            ax4<-totdist*pct.hw 
            sqptx<-rep(x0[i],12)+c(ax1, ax4, ax4, 0.5*totdist, ax2, ax2, ax3, ax2, ax2, 0.5*totdist, ax4, ax4)
            sqpty<-rep(y0[i],12)+c(ay3, ay2, cex.sk*ay1, ay1, cex.sk*ay1, ay2, ay3, -ay2, -cex.sk*ay1, -ay1, -cex.sk*ay1, -ay2)
        }
        ptcoord<-rotation(sqptx,sqpty,rot=anglpt[i], xrot=x0[i], yrot=y0[i])
        polygon(ptcoord$x,ptcoord$y,...)
    }
}

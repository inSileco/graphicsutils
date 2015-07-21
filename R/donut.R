#' Donut chart.
#'
#' Draw a donut chart.
#'
#' @param vec Vector of data.
#' @param eaten The eaten part of the donut.
#' @param labels One or more expressions or character strings giving names for the slices.
#' @param rot The rotation angle (in degree) of the donut.
#' @param cx Controls the total horizontal width of the donut.
#' @param cy Controls the total vertical width of the donut.
#' @param cex The magnification of the size of the donut.
#' @param tck The magnification of the length of the tick marks.
#' @param width The width of the donut (set between 0 and 1).
#' @param mycol Vector of colors to be used.
#' @param density the density of shading lines, in lines per inch.  The default value of ‘NULL’ means that no shading lines are drawn.
#' @param angle the slope of shading lines, given as an angle in degrees (counter-clockwise).
#' @param dt Point density of the drawn circles.
#' @param add Should images be added on the current graph ? If FALSE a new plot is created.
#' @param border border color of the donut. The default value of ‘NA’ means that no border lines are drawn.
#' @param clockwise logical. Shall slices be drawn clockwise?
#' @param ... additionnal arguments to be passed to lines methods.
#'
#' @keywords donut
#'
#' @export
#'
#' @details
#' The aspect of the donut is fully customizable. If \code{width} is set to 1 and \code{eaten} to 0, the donut chart is then a pie chart.
#'
#' @note
#' Substantial part of the code have been inspired by the \code{pie} function.
#'
#' The 'col' argument determines the succession of colors to be applied to each axis.
#'
#' @examples
#' #Example 1:
#' par(mfrow=c(2,2), mar=rep(2,4))
#' donut(c(10,20,15), 0.2, rot=180, lwd=2, labels=paste("group",1:3))
#' donut(c(10,20,15), 0, lwd=3, col=4)
#' donut(c(10,20,15), 0.5, col=4, mycol=c(3,7,2), density=30, angle=c(20,55,110))
#' donut(c(10,20,40), 0.2, col=NA, mycol=c(3,7,2), width=0.2, clockwise=TRUE)
#'
#' #Example 2:
#' plot0(c(0,10),c(0,40), type="n")
#' vec <- runif(7)
#' donut(vec, 0.15, cx=5, cy=20, add=TRUE, col=2)

donut <-
function(vec, eaten=0, labels=NULL, rot=0, cx=0, cy=0, cex=0.8, tck=0.05, width=0.6, mycol=1+1:length(vec), density=NULL, angle=45, dt=0.001, add=FALSE, border=NA, clockwise=TRUE, ...){
    if (!is.numeric(vec) || any(is.na(vec) | vec < 0))
        stop("'vec' values must be positive.")
    stopifnot(width<=1 & width>0)
    # makes "width" intuitive
    width <- 1-width
    ## sequence to draw circles
    x <- (2*pi*rot/360)+seq(-.5*pi,-2.5*pi,-dt)
    if (!clockwise) x<-rev(x)
    sz<-length(x)
    d<-floor(.5*eaten*sz)
    ## remove the eaten part
    xb<-x[d:(sz-d)]
    szb<-length(xb)
    ## vector
    nb <- length(vec)
    vecb <- floor(vec/sum(vec)*szb)
    ## color
    mycol <- rep(mycol, length.out=nb)
    ## labels
    if (is.null(labels)) labels<-as.character(1:nb)
    else labels<-as.graphicsAnnot(labels)
    ## Dimension
    wid<-(par()$usr[2]-par()$usr[1])
    heg<-(par()$usr[4]-par()$usr[3])

    if (!add) {
        plot.new()
        plot.window(c(-1,1), c(-1,1), asp=1)
        cx<-cy<-0
        cex.x<-cex.y<-cex
    }
    else {
        cex.x <- cex*.4*wid
        aspin<-par()$pin[1]/par()$pin[2]
        print(aspin)
        cex.y <- aspin*cex*.4*heg
    }
    if (!is.null(density)) {
        density<-rep(density,length.out=nb)
        angle<-rep(angle,length.out=nb)
    }
    sx <- 1
    for (i in 1L:nb){
        vx <- c(cos(xb[sx]),width*cos(xb[sx]),width*cos(xb[sx:(sx+vecb[i])]),cos(xb[(sx+vecb[i]):sx]))
        vy<-c(sin(xb[sx]),width*sin(xb[sx]),width*sin(xb[sx:(sx+vecb[i])]),sin(xb[(sx+vecb[i]):sx]))
        if (!is.null(density)) polygon(cx+cex.x*vx,cy+cex.y*vy, col=mycol[i], border=border, density=density[i], angle=angle[i])
        else polygon(cx+cex.x*vx,cy+cex.y*vy, col=mycol[i], border=border)
        lab<-as.character(labels[i])
        if (!is.na(lab) && nzchar(lab)) {
            mid <- sx+floor(.5*vecb[i])
            pos <- 1+(sin(xb[mid])>-.5*sqrt(3))
            if (pos>1) pos <- pos+(cos(xb[mid])>-.5)+(cos(xb[mid])>.5)
            lines(cx+cex.x*c(1, 1+tck)*cos(xb[mid]),cy+cex.y*c(1, 1+tck)*sin(xb[mid]), ...)
            text(cx+(1+tck)*cex.x*cos(xb[mid]),cy+cex.y*(1+tck)*sin(xb[mid]), labels[i], pos=pos, xpd=TRUE)
        }
        sx<-sx+vecb[i]
    }
    lines(cx+cex.x*cos(xb),cy+cex.y*sin(xb), ...)
    lines(cx+cex.x*width*cos(xb),cy+cex.y*width*sin(xb), ...)
    if (eaten){
        lines(cx+cex.x*c(cos(xb[1]),width*cos(xb[1])), cy+cex.y*c(sin(xb[1]),width*sin(xb[1])), ...)
        lines(cx+cex.x*c(cos(xb[szb]),width*cos(xb[szb])), cy+cex.y*c(sin(xb[szb]),width*sin(xb[szb])),...)
    }
}

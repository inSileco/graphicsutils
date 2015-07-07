#' Draw stacked areas
#'
#' \code{circle} Draw circles in a flexible way.
#'
#' val: a dataframe or a matrix containing a series of positive value, rows stand for popultaions.
#' index: values to be used for the x axis. Defaults set is
#' ext: extent values multiplying the defaults range set to c(0,1).
#' cumul: if true, data are considered as cumulative.
#' transp: compute the transpose of the data if needed.
#' colors: vector of colors, repeated if too small.
#' add:
#' ...: arguments to be passed to polygon function
#'
#' @keywords circle, plot
#'
#' @export
#'
#' @details The number of cicrles drawn is given by the maximum argument length among \code{x}, \code{y} and \code{radi} arguments. Sizes are adjusted using \code{\link{rep_len}} function. The plot used \code{\link{lines}} function, however if \code{border} is defined, then \code{\link{polygon}} function is used.
#'
#' @examples
#' ## data for 8 populations at 25 different periods.
#' x <- data.frame(matrix(runif(200,2,10),8,25))
#'
#' ## plot 1: default plot
#' stackedarea(x)
#' ##------
#' ## plot 2:
#' stackedarea(x, index=2001:2025,ext=100, border="white")
#' ##------
#' ## plot 3: personalized plot
#' par(xaxs="i", yaxs="i", font=2, cex.axis=1.2, cex.lab=1.4, bty="l")
#' ## Few colors palette avaialable on the internet
#' ## browseURL("http:www.color-hex.com/color-palettes/")
#' d1dark <- c("#05695e","#710c25","#82480c","#69820c","#0b7687")
#' d1light <- c("#38bfaf","#e23d4f","#e2913d","#bfe23d","#3dcce2")
#' bigfail <- c("#e1b54d","#bd5f2c","#722121","#0c505a","#101029")
#' cbacwine <- c("#c7a34b","#966426","#7a4a0f","#541726","#420518")
#' plot(c(1999,2027), c(-10,110), type="n", xlab="Years",ylab="Percentage", main="Myplot")
#' rect(par()$usr[1],par()$usr[3],par()$usr[2],par()$usr[4], col="#f2c4c4", border="transparent")
#' stackedarea(x, index=2001:2025, ext=100, colors=c(bigfail,d1light), lwd=2, add=TRUE, border="transparent")

stackedarea <-
function(val, index=NULL, ext=1, legend=NULL, cumul=FALSE, transp=FALSE, add=FALSE, colors=NULL, ...){

    ## --- Format checking / converting
    x <- as.matrix(val)
    stopifnot(ncol(x)>1)
    if (sum(x<0)>0) stop("x must be positive")
    ##
    if (transp==TRUE) x <- t(x)
    ##
    if (is.null(index)) index <- 1:ncol(x)
    ##
    vecol <- colSums(x)
    if (sum(vecol!=rep(1,ncol(x)))>0) x <- t(t(x)/vecol)
    ##
    if (nrow(x)>1){
        if (!cumul) for (i in 2:nrow(x)) x[i,] <- x[i-1,]+x[i,]
    }

    ## --- Plot
    ## -- Colors
    if (is.null(colors)) {
        colors=rep(1:8,length.out=nrow(x))
    }
    else colors <- rep(colors,length.out=nrow(x))
    ## -- Defaults plotting set
    if (!add) {
        oldpar <- par(no.readonly=TRUE)
        layout(matrix(1:2,1), widths=c(1,0.3))
        par(mar=c(5,4,4,1),xaxs="i", yaxs="i", ann=FALSE)
        plot(range(index), ext*c(0,1), type="n")
    }
    ## -- Stacked area
    cx <- c(index,rev(index))
    polygon(cx,ext*c(rep(1,ncol(x)),1-rev(x[1,])),col=colors[1],...)
    if (nrow(x)>1) polygon(cx,ext*c(1-x[nrow(x)-1,],rep(0,ncol(x))),col=colors[nrow(x)],...)
    if (nrow(x)>2){
        for (i in 2:(nrow(x)-1)){
            cy <- c(1-x[i-1,],rev(1-x[i,]))
            polygon(cx,ext*cy,col=colors[i],...)
        }
    }
    ## -- Defaults legend
    if (!add) {
        box(lwd=1.1)
        par(mar=c(4,1,4,1), xaxt="n", yaxt="n", bty="n", xaxs="i", yaxs="i")
        if (is.null(legend)) legend <- paste0("population ",1:nrow(x))
        plot(c(0,1),c(0,1),type="n")
        legend("center", legend, fill=colors, bty="n")
        par(oldpar)
    }
}

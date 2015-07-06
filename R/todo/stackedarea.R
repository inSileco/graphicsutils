stackedarea <-
function(x, index=NULL, ext=1, legend=NULL, cumul=FALSE, transp=FALSE, add=FALSE, colors=NULL, ...){

    ## --- Format checking / converting
    x <- as.matrix(x)
    stopifnot(ncol(x)>1)
    ##
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

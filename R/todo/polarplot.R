polarplot <-
function(seqtime, seqval=NULL, rad=1, from=0, to=2*pi, incr=0.01, labelc=NULL, atc=NULL, labelr=NULL, atr=NULL, clockwise=TRUE, empty=TRUE, add=FALSE, ...){
    
    ## --- format checking 
    seqtime <- as.matrix(seqtime)
    if (ncol(seqtime)>1L) {
        seqval <- seqtime[,-1L]
        seqtime <- seqtime[,1L]
    }
    else seqval <- as.matrix(seqval)
    stopifnot(length(seqtime)==length(seqval[]))
    if (from>to) stop("Error : from>to, to use counter-clockwise direction, use 'clockwise' argument !" )
    if (to>2*pi) warning("to>2*pi, it can generate unexpected outputs !", call=FALSE)
    
    ## --- to polar coordinates 
    rgtime <- range(seqtime)
    rgval <- prettyRange(seqval)
    lgv <- floor(log(rgval[2]-rgval[1]))
    ## 
    seqtp<--.5*pi+from + (to-from)*(seqtime-rgtime[1L])/(rgtime[2L]-rgtime[1L])
    if (clockwise) seqtp <- 2*from - seqtp 
    seqvp<-rad*(seqval-rgval[1L])/(rgval[2L]-rgval[1L]) 

    ## --- plot
    if (!add) {
        par(mar=c(1,1,1,1))
        plot.new()
        plot.window(1.2*c(-1,1),1.2*c(-1,1),asp=1)
    }

    ## --- circles 
    for (i in rad/5*seq_len(5-1)) circle(0,0,rad*i, empty=TRUE, col="grey45", lwd=0.5+0.5*i, lty=2)
    circle(0,0,rad,empty=TRUE,col=1,lwd=1)#, from=0.54*pi, to=2.46*pi)
    points(0,0, pch=20, col="grey45")
    # segments(c(0,-rad),c(-rad,0),c(0,rad),c(rad,0))

    ## --- Lines
    if (empty) lines(seqvp*cos(seqtp), seqvp*sin(seqtp),...)
    else polygon(seqvp*cos(seqtp), seqvp*sin(seqtp),...)

    ## --- Points at start and end
    points(seqvp[1L]*cos(seqtp[1L]), seqvp[1L]*sin(seqtp[1L]), pch=19, col=2, cex=1.2)
    lv <- length(seqval)
    points(seqvp[lv]*cos(seqtp[lv]), seqvp[lv]*sin(seqtp[lv]), pch=20, col=4)

    ## --- Values labels 
    if (is.null(labelr)) labelr<- round(seq(rgval[1],rgval[2],length.out=6),digits=-lgv+2)
    if (!is.na(labelr) && nzchar(labelr)){
        text(rep(0,6), -.2*0:5, as.graphicsAnnot(labelr), cex=1.15, pos=3)
    }
    
    ## --- Circular ticks 
    mangle <- -.5*pi+from+(0:6)/6*(to-from)
    if (clockwise) mangle <- 2*from-mangle
    print(mangle)
    segments(cos(mangle),sin(mangle),1.05*cos(mangle),1.05*sin(mangle))

    ## --- Circular values
    if (is.null(labelc)) labelc<-as.graphicsAnnot(seq(rgtime[1],rgtime[2],length.out=7))
    else labelc<-as.graphicsAnnot(labelc)
    if (!is.na(labelc) && nzchar(labelc)) {
        if (mangle[1]%%(2*pi)==mangle[length(mangle)]%%(2*pi)) {
            mg1<-mangle[1] 
            mgl <- mangle[length(mangle)]
            text(1.15*cos(mg1),1.15*sin(mg1), labelc[1], pos=4, cex=1.15, col=4)
            text(1.15*cos(mgl),1.15*sin(mgl), labelc[length(labelc)], pos=2, cex=1.15, col=4)
            mangle <- mangle[-c(1L,length(mangle))]
            labelc <- labelc[-c(1L,length(labelc))]
        }
        text(1.15*cos(mangle),1.15*sin(mangle), labelc, cex=1.15, col=4)
    }
    
}

setgraph<-
function(mat, n, xlim=c(0,1), ylim=c(0,1), ...){

    stopifnot(n%in%unique(mat))
    stopifnot(n>0)

    nr<- nrow(mat)
    nc<-ncol(mat)
    rc<-range(which(mat==n))-1L
    xlf<-floor(rc[1L]/nr)+1L
    xrg<-floor(rc[2L]/nr)+1L
    ybt<-(rc[1L]%%nr)+1L
    ytp<-(rc[2L]%%nr)+1L

    seqx<- seq(0,1,length.out=nc+1)
    seqy<- seq(0,1,length.out=nr+1)
    par(new=TRUE, fig=c(seqx[xlf],seqx[xrg+1L],seqx[(nr-ytp)+1L],seqx[(nr-ybt)+2L]),...)
    plot.new() 
    plot.window(xlim,ylim)
}

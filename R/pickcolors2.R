#' Pick your colors up version 2
#'
#' Generate an interactive interface to pick up colors and returns colors selected.
#'
#' @param colors The number of colors to be selected.
#' @param ramp A vector of colors.
#'
#' @keywords color, selection
#'
#' @export
#'
#' @details
#' This colors selection open a grapical interface you navigate within following a red frame. 
#' It allows you to confirm at each step wether or not you want to use the tone selected. 
#' It does the same for the shades.
#'
#' @note Beyond 20 colors, the interest of such function is questionnable.
#'
#' @examples
#' #Example 1:
#' mypal1<-pickcolors2()
#' #Example 2:
#' mypal2<-pickcolors(colors=7, ramp=colorRampPalette(c('grey','blue','red'))(100))
#' plot(runif(8),runif(8), col=mypal2, pch=19, cex=3)


pickcolors2 <- function(colors=6, ramp=rainbow(1024)){
    ## checkings
    if (colors>20) stop("More than 20 colors, really?")
    ##
    msg1 <- function() cat('Your click is outside the red frame! \n')
    ##
    szrp<-length(ramp)
    slccolor<-rep("white",colors)
    slc<-0
    tonecoor<-double(colors)
    ##
    extra<-0+((colors%%2)==1)*1
    ##
    dev.new()
    old.par<-par(no.readonly=TRUE)
    ## 
    layout(matrix(c(1,2,4,5,1,3,3,3),ncol=2), height=c(0.8,0.8,0.8,2), width=c(1,2))
    ## Record par for all the subplot region
    mypar<-list()
    for (i in 1:5) {
        plot0()
        mypar[[i]]<-par(no.readonly=TRUE)
    }
    ## while + locator + check the relevance of locator's result.
    while (slc<colors){
        tone<-0
        while (tone==0){
            ## ----
            par(new=TRUE, fig=mypar[[1L]]$fig, mar=c(0.5, 1, 1, 1), xaxs="i", yaxs="i")
            image(matrix(1:szrp, ncol=1L), col=ramp, axes = FALSE, ann=FALSE)
            if (slc>0) for (i in 1:slc) {
                points(rep(tonecoor[i],2),rep(0,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
                text(rep(tonecoor[i],2),rep(0,2),rep(as.character(1+colors-i),2), col=c("white",1), pos=c(1,3))
            }
            box(col=2,lwd=2.5)
            if (slc==0) text(0.5,0,"First, chose a tone, then select a shades below. Follow the red frame !", cex=1.5)
            xy<-locator(1L)
            ## ---
            if (abs(xy$y)>1 | xy$x>1 | xy$x<0) msg1()
            else {
                box(lwd=2.8)
                points(rep(xy$x,2),rep(xy$y,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
                text(rep(xy$x,2),rep(xy$y,2),rep(as.character(colors-slc),2), col=c("white",1), pos=c(1,3))
                slcton<-ramp[1L+floor(szrp*xy$x)]
                mypal<-colorRampPalette(c("white",slcton,"black"))(128)
                ## ----
                seqx<-1:16
                seqy<-1:8
                slc2<-0
                ## ----
                par(new=TRUE, fig=mypar[[3]]$fig, mar=c(1, 0.5, 0.5, 1))
                mypal<-colorRampPalette(c("white",slcton,"black"))(128)
                image(x=seqx, y=seqy, matrix(1:128,16,8), col=mypal, axes=FALSE, ann=FALSE)
                box(lwd=2.8)
                ## ----
                par(new=TRUE, fig=mypar[[2]]$fig, mar=c(0.5, 1, 0.5, 0.5))
                plot0(c(0,1),c(-1,1))
                bgcol(col="white")
                text(0.5,0.5,"Keep it !", cex=2)
                rect(0,-1,1,0, col="black")
                text(0.5,-0.5,"Change it !", cex=2, col="white")
                box(col=2,lwd=2.5)
                xy0 <- locator(1L)
                while (xy0$x>1|xy0$x<0|(xy0$y)^2>1) {
                    msg1()
                    xy0<-locator(1L)
                }
                if (xy0$y>0) {
                    box(lwd=2.8)
                    tone<-1
                    tonecoor[slc+1]<-xy$x
                }
                else box(lwd=2.8)
                ## ----
            }
        }
        while (!slc2) {
            ## ----
            par(new=TRUE, fig=mypar[[3]]$fig, mar=c(1, 0.5, 0.5, 1))
            image(x=seqx, y=seqy, matrix(1:128,16,8), col=mypal,  axes = FALSE, ann=FALSE)
            box(col=2,lwd=2.5)
            ## ----
            xy2<-locator(1L)
            points(rep(xy2$x,2),rep(xy2$y,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
            ## ----
            if (xy2$y> 8.5 | xy2$y< -0.5) msg1()
            else {
                box(lwd=2.8)
                ##
                diffx <- ((1:16)-xy2$x)^2
                diffy <- ((1:8)-xy2$y)^2
                sclcol <- which.min(diffx)+(which.min(diffy)-1)*16
                points(rep(xy2$x,2),rep(xy2$y,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
                ## ----
                par(new=TRUE, fig=mypar[[4]]$fig, mar=c(1, 1, 0.5, 0.5))
                image(matrix(1,1),col=mypal[sclcol], axes = FALSE, ann=FALSE)
                box(col=1, lwd=2)
                text(0,0.35,mypal[sclcol], cex=2.5)
                text(0,-0.35,mypal[sclcol], cex=2.5, col="white")
                ## -----
                par(new=TRUE, fig=mypar[[2]]$fig, mar=c(0.5, 1, 0.5, 0.5))
                plot0(c(0,1),c(-1,1))
                bgcol(col="white")
                text(0.5,0.5,"Keep it !", cex=2)
                rect(0,-1,1,0, col="black")
                text(0.5,-0.5,"Change it !", cex=2, col="white")
                box(col=2,lwd=2.5)
                xy3<- locator(1L)
                while ((xy3$x)^2>1 | (xy3$y)^2>1) {
                    msg1()
                    xy3<-locator(1L)
                }
                if (xy3$y>0) {
                    box(lwd=2.8)
                    slc<-slc+1
                    slc2<-1
                    slccolor[slc]<-mypal[sclcol]
                    ## ----
                    par(new=TRUE, fig=mypar[[5]]$fig, mar=c(1, 1, 0.5, 0.5))
                    image(matrix(1:(colors+extra), nrow=2L), col="white", axes = FALSE, ann=FALSE)
                    par(new=TRUE, fig=mypar[[5]]$fig, mar=c(1, 0.5, 0.5, 1))
                    image(matrix(1:(colors+extra), nrow=2L), col=rev(slccolor), axes = FALSE, ann=FALSE)
                }
                else box(lwd=2.8)
            }
        }
    }

    Sys.sleep(0.8)
    par(old.par)
    dev.off()
    return(slccolor)
}
#' Pick your colors up
#'
#' Generate a simple interactive interface to pick up colors and returns colors selected.
#'
#' @param ramp A first set of colors.
#' @param colors The number of colors to be selected.
#' @param tones A number of tones.
#' @param shades A number of shades to be plotted for each tones.
#'
#' @keywords color, selection
#'
#' @export
#'
#' @details
#' This functions is a two steps color selection. First, color decribed by \code{color} are displayed and users are invited to pick up \code{tones} number of color tones. In the second step, for each selected tones, \code{shades} shades and tints are presented. Users are then allowed to select the final set of \code{colors} colors they require.
#'
#' @note Beyond 20 colors, the interest of such function is questionnable.
#'
#' @examples
#' #Example 1:
#' mypal1 <- pickcolors()
#' #Example 2:
#' mypal2 <- pickcolors(colorRampPalette(c('grey','blue','red'))(100), colors=6, tones=4, shades=30)
#' plot(runif(10),runif(10), col=mypal2, pch=19, cex=3)

pickcolors <- function(ramp=rainbow(1024), colors=8, tones=colors, shades=32){
    ## checkings
    if (colors>20) warning("More than 20 colors, really?")
    colors <- min(colors,100)
    tones <- min(tones,100)
    shades <- min(shades,100)
    ## First : tones selection
    szrp <- length(ramp)
    dev.new(height=3, width=8)
    old.par <- par(no.readonly=TRUE)
    par(mar=c(0,0,4,0))
    image(matrix(1:szrp, ncol=1L), col=ramp, axes = TRUE, xlab="", ylab="", main=paste0("Pick up your ", tones, " tones (",tones," clicks are required)"))
    slcton <- double(tones)
    slc <- 0
    ## while + locator + check the relevance of locator's result.
    while (slc<tones){
      xy <- locator(1L)
      if (xy$y>1) cat('Your click is outside the relevant region! \n')
      else {
        slc <- slc+1
        points(rep(xy$x,2),rep(xy$y,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
        text(rep(xy$x,2),rep(xy$y,2),rep(as.character(slc),2), col=c("white",1), pos=c(1,3))
        slcton[slc] <- ramp[1L+floor(szrp*xy$x)]
      }
    }
    ##
    matrp <- matrix("",nrow=shades, ncol=tones)
    for (i in rev(1:tones)) matrp[,i] <- colorRampPalette(c("white",slcton[i],"black"))(shades+2)[2:(shades+1)]
    dev.off()
    ## Second: color selection
    dev.new()
    layout(matrix(1:2,2,1), height=c(3,1))
    par(mar=c(0, 0, 0, 0))
    par1 <- par(no.readonly=TRUE)
    image(matrix(1:(shades*tones),nrow=shades, ncol=tones), col=as.vector(matrp), axes=FALSE, ann=FALSE)
    ##
    par(mar=c(4, 4, 4, 4))
    par2 <- par(no.readonly=TRUE)
    yourcol <- rep("transparent", colors)
    image(matrix(1:colors,ncol=1), axes=FALSE, xlab="", ylab="", main=paste0("Click above, get your ",colors," colors below"), col=yourcol)
    ##
    slccol <- rep("",colors)
    slc <- 0
    while (slc<colors) {
      par(new=TRUE, fig=par2$fig, mar=c(0, 0, 0, 0), xaxs="i", yaxs="i")
      frame()
      plot.window(c(0,1),c(0,1))
      xy <- locator(1)
      if (xy$x<0 | xy$y<0) cat('Your click is outside the relevant region! \n')
      else {
        slc <- slc+1
        slccol[slc] <- yourcol[slc] <- matrp[1+floor(shades*xy$x),1+floor(tones*xy$y)]
        points(rep(xy$x,2),rep(xy$y,2), cex=c(1.2,0.8), col=c("white",1), pch=19)
        text(rep(xy$x,2),rep(xy$y,2),rep(as.character(slc),2), col=c("white",1), pos=c(1,3))
        ##
        par(mar=c(2, 2, 4, 2),new=TRUE, fig=par1$fig, xaxs="i", yaxs="i")
        image(matrix(1:colors,ncol=1), axes=FALSE, ann=FALSE, col=yourcol)
        if (colors<11){
          text(seq(0,1,length.out=colors)[1:slc],rep(0.3,slc),yourcol[1:slc], cex=0.7)
          text(seq(0,1,length.out=colors)[1:slc],rep(-0.3,slc),yourcol[1:slc], cex=0.7, col="white")
        }
      }
    }
    Sys.sleep(0.8)
    par(old.par)
    dev.off()
    return(slccol)
}

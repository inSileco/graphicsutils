#' Pick colors up
#'
#' Generate an interactive interface to pick up colors and returns colors selected.
#'
#' @param ramp A vector of colors used as tone palette.
#' @param nb_shades Number of shades to be displayed once a tone is selected.
#' @param rgb logical. If TRUE, colors are returned as a rgb matrix. Default is set to FALSE.
#' @param preview logical. If TRUE, colors are displayed once the selection is done. Default is set to FALSE.
#'
#' @keywords color, selection
#'
#' @export
#'
#' @return
#' A vector
#'
#' @details
#' This function generates a graphical window splitted into 6 panels. The top panel serves to select one tone.
#' The panel right below present \code{nb_shades} of the selected tones.
#' The bottom rigth panel presents the selected color that can be stored by clicking on the bottom left panel.
#' The bottom center panel shows the characteristic of the selcted color.
#' Finally, to abort, the user can simply clik on the left \code{Stop} panel.

pickColors <- function(ramp=rainbow(1024), nb_shades=1024, rgb=FALSE, preview=FALSE){

    old.par <- par(no.readonly=TRUE)
    ##
    nb_ramp <- length(ramp)
    slccolor <- 0
    col_ini <- ramp[floor(nb_ramp*0.5)+1]
    shades <- colorRampPalette(c("white",col_ini,"black"))(nb_shades)
    col_foc <- shades[floor(nb_shades*0.5)+1]

    drawSelector <- function(col_ini, col_foc, shades){
        par(mar=c(0,0,0,0), xaxs="i", yaxs="i")
        plot0()
        ##
        par(fig=c(0,1,0.8,1), new=TRUE)
        image(matrix(1L:nb_ramp), col=ramp, axes=FALSE, ann=FALSE)
        points(rep(which(ramp==col_ini)[1L]/nb_shades,2),c(0,0),col=c("white",1), pch=c(19,20))
        box(lwd=3, col="white")
        ##
        par(fig=c(0,1,0.6,0.8), new=TRUE)
        image(matrix(1:nb_shades), col=shades, axes=FALSE, ann=FALSE)
        points(rep(which(shades==col_foc)[1L]/nb_shades,2),c(0,0),col=c("white",1), pch=c(19,20))
        box(lwd=3, col="white")
        ##
        par(fig=c(0,0.2,0.3,0.6), new=TRUE)
        plot0()
        plotAreaColor()
        text(0,0,label="Keep it", cex=2)
        box(lwd=3, col="white")
        ##
        par(fig=c(0,0.2,0,0.3), new=TRUE)
        plot0()
        plotAreaColor()#col="grey80")
        text(0,0,label="Stop", cex=2)
        box(lwd=3, col="white")
        ##
        par(fig=c(0.2,0.5,0,0.6), new=TRUE)
        plot0()
        plotAreaColor(col="grey90")
        text(0,0.6,label=colorRampPalette(col_foc)(1), cex=2)
        code_rgb <- col2rgb(col_foc)
        text(0,0.1,label=paste0("Red: ",code_rgb[1]), cex=2)
        text(0,-0.3,label=paste0("Green: ",code_rgb[2]), cex=2)
        text(0,-0.7,label=paste0("Blue: ",code_rgb[3]), cex=2)
        box(lwd=3, col="white")
        ##
        par(fig=c(0.5,1,0,0.6), new=TRUE)
        plot0()
        plotAreaColor(col=col_foc)
        box(lwd=3, col="white")
        ##
        par(fig=c(0,1,0,1), usr=c(0,1,0,1),new=TRUE)
    }

    i <- 0
    while(i==0){
      shades <- colorRampPalette(c("white",col_ini,"black"))(nb_shades)
      drawSelector(col_ini, col_foc, shades)
      loc <- locator(1L)
      ##
      if (loc$y>0.6){
        if (loc$y>0.8) {
          col_ini <- ramp[floor(nb_ramp*loc$x)+1]
          shades <- colorRampPalette(c("white",col_ini,"black"))(nb_shades)
          col_foc <- shades[floor(nb_shades*0.5)+1]
        }
        else col_foc <- shades[floor(nb_shades*loc$x)+1]
      }
      else{
        if (loc$x<0.2){
          if(loc$y>0.3) {
            slccolor <- c(slccolor,col_foc)
            cat("Stored !\n")
          }
          else i <- 1
        }
        else {cat("Nothing to do !\n")}
      }
    }

    par(old.par)
    dev.off()

    slccolor <- slccolor[-1L]
    if (preview) showPalette(slccolor, add_number=TRUE)

    if (rgb) return(col2rgb(slccolor))
    else return(slccolor)
}

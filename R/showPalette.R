#' Show a color Palette
#'
#' Generate an interactive interface to pick up colors and returns colors selected.
#'
#' @param ramp A vector of colors.
#' @param inline logical. If TRUE, the colors are displayed on a single row.
#' @param add_number logical. If TRUE, color vector's indices are added.
#'
#' @keywords color, selection
#'
#' @export
#'
#' @details
#' This function generates a graphical window splitted into 6 panels. The top panel serves to select one tone.
#'
#' @examples
#' showPalette(floor(runif(30,1,9)), add_number=TRUE)

showPalette <- function(ramp, inline=FALSE, add_number=FALSE, cex_number=1.2){

    old.par <- par(no.readonly=TRUE)
    nb_ramp <- length(ramp)

    if (!inline) {
      sqr <- sqrt(nb_ramp)
      fsq <-  floor(sqr)
      nb_row <- nb_col <- fsq
      if (sqr-fsq!=0) nb_row <- fsq+1
      if (nb_ramp-nb_row*nb_col>0) nb_col <- fsq+1
      par(mfrow=c(nb_row,nb_col))
    }
    else par(mfrow=c(1L,nb_ramp))

    par(mar=rep(0,4L))

    for (i in 1:nb_ramp){
      plot0()
      plotAreaColor(col=ramp[i])
      if (add_number) {
        text(0,0,i, cex=cex_number, pos=3L)
        text(0,0,i, cex=cex_number, pos=1L, col="white")
      }
      box(col="white")
    }

    par(old.par)
}

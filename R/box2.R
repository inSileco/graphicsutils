#' Box version 2
#'
#' Draw a Box around a Plot
#'
#' @param side A numerical or character vector or a character string specifying which side(s) of the plot the box is to be drawn (see details).
#' @param which A character, one of \code{plot}, \code{figure}, \code{inner} and \code{outer}.
#' @param fill The color to be used to fill the box.
#' @param ... Further graphical parameters (see \code{\link[graphics]{par}}) may also be supplied as arguments, particularly, line type, \code{lty}, line width, \code{lwd}, color, \code{col} and for \code{type = "b"}, \code{pch}.  Also the line characteristics \code{lend}, \code{ljoin} and \code{lmitre}.
#'
#' @keywords box
#'
#' @export
#'
#' @details This function intends to give more flexibility to the \code{\link[graphics]{box}} function.
#' As \code{which} parameter, users provides an object first coerced by \code{as.character} to a character string that is secondly split into single characters. For all of these characters, matches are sought with all elements of \code{1, 2, 3, 4, b, l, t, r} where \code{1=below, 2=left, 3=above, 4=right, b=below, l=left, t=above and r=right}.
#'
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:
#' plot0()
#' box2()
#' ##
#' plot0()
#' box2("14", fill="grey80", lwd=2)
#' plot0()
#' box2(c(1,4), fill="grey80", lwd=2)
#' plot0()
#' box2(c(1,4), fill="grey80", lwd=2)
#' # Example 2:
#' par(mfrow=c(2,2),oma=c(2,2,2,2))
#' plot(0,0)
#' box("outer",lwd=2)
#' box("inner",lwd=2)
#' plot(0,0)
#' plot(0,0)
#' plot(c(0,1),c(0,2))
#' box2(which="figure",lwd=2, fill=2)
#' box2(side=12, lwd=2, fill=8)
#' points(c(0,1),c(0,2))
#' axis(2)
#' axis(1)
#' title(xlab="coolx", ylab="cooly")


box2 <- function(side=1:4, which="plot", fill=NULL, ...){
    ##
    stopifnot(which%in%c("plot", "figure", "outer", "inner"))
    ##
    vec <- unlist(strsplit(tolower(as.character(side)),""))
    ax1 <- match(vec, c("1","2","3","4"))%%5
    ax2 <- match(vec, c("b","l","t","r"))%%5
    ax <- unique(c(ax1,ax2), na.rm=TRUE)
    ax <- ax[!is.na(ax)]
    ##
    if (length(ax)){
      coord <- par()$usr
      if (which!="plot"){
        ## figure margins in user units
        cvx <- (par()$usr[2]-par()$usr[1])/par()$pin[1]
        cvy <- (par()$usr[4]-par()$usr[3])/par()$pin[2]
        mau <- par()$mai*rep(c(cvy,cvx),2)
        coord <- coord+c(-mau[2],mau[4],-mau[1],mau[3])
        ## inner margins in user units (get the lenght and adjust!)
        if (which!="figure"){
          diffx <- coord[2]-coord[1]
          diffy <- coord[4]-coord[3]
          lenx <- diffx*1/(diff(par()$fig[1:2]))
          leny <- diffy*1/(diff(par()$fig[1:2]))
          coord[1] <- coord[1]-par()$fig[1]*lenx
          coord[2] <- coord[1]+lenx
          coord[3] <- coord[3]-par()$fig[3]*leny
          coord[4] <- coord[3]+leny
          ## outer margins in user units
          if (which!="inner"){
            omu <- par()$omi*rep(c(cvy,cvx),2)
            coord <- coord+c(-omu[2],omu[4],-omu[1],omu[3])
          }
        }
      }
      op <- par("xpd")
      par(xpd=NA)
      mat <- matrix(c(4,2,3,1,3,1,4,2), ncol=2)
      if (!is.null(fill)) rect(coord[1],coord[3],coord[2],coord[4], col=fill, border=NA)
      for (i in ax) {
        coordb <- coord
        coordb[mat[i,1]] <- coordb[mat[i,2]]
        lines(c(coordb[1],coordb[2]),c(coordb[3],coordb[4]), ...)
      }
      par(xpd=op)
    }
    else warning("'bty' does not match any of '1', '2', '3', '4', 'b', 'l', 't', 'r'")
}

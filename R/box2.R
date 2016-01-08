#' Box version 2
#'
#' Draw a Box around a Plot
#'
#' @param bty A numerical/character vector or a character string decribing on which side the box is drawn (see details).
#' @param ... Further graphical parameters (see ‘par’) may also be supplied as arguments, particularly, line type, ‘lty’, line width, ‘lwd’, color, ‘col’ and for ‘type = "b"’, ‘pch’.  Also the line characteristics ‘lend’, ‘ljoin’ and ‘lmitre’.
#'
#' @keywords box
#'
#' @export
#'
#' @details This function is made to give more flexibility to the \code{\link[grpahics]{box}} function.
#' Users provides an object first coerced by ‘as.character’ to a character string that is secondly split
#' into single characters. For all of these characters, matches are sought with element among \code{c('1', '2', '3', '4', 'b', 'l', 't', 'r'}. All of these are matched with the
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:
#' plot0()
#' box2()
#' ##
#' plot0()
#' box2("14", col2fill="grey80", lwd=2)
#' plot0()
#' box2(c(1,4), col2fill="grey80", lwd=2)
#' plot0()
#' box2(c(1,4), col2fill="grey80", lwd=2)
#' # Example 2:
#' plot0(c(-10,10), asp=1)


box2 <- function(bty=1:4, col2fill=NULL, ...){

    vec <- unlist(strsplit(tolower(as.character(bty)),""))

    if (!is.null(col2fill)) {
      plotAreaColor(col=col2fill, border=NA)
    }

    ax1 <- match(vec, c("1","2","3","4"))%%5
    ax2 <- match(vec, c("b","l","t","r"))%%5
    ax <- unique(c(ax1,ax2), na.rm=TRUE)
    ax <- ax[!is.na(ax)]

    if (length(ax)){
      old_par <- par(no.readonly = TRUE)
      par(xpd=TRUE)
      on.exit(par(old_par))
      coord <- par()$usr
      mat <- matrix(c(4,2,3,1,3,1,4,2), ncol=2)
      for (i in ax) {
        coordb <- coord
        coordb[mat[i,1]] <- coordb[mat[i,2]]
        lines(c(coordb[1],coordb[2]),c(coordb[3],coordb[4]), ...)
      }
    }
    else warning("'bty' does not match any of '1', '2', '3', '4', 'b', 'l', 't', 'r'")
}

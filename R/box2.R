#' Alternative box function
#'
#' Draw a Box around a Plot.
#'
#' @param side a numerical or character vector or a character string specifying which side(s) of the plot the box is to be drawn (see details).
#' @param which a character, one of \code{plot}, \code{figure}, \code{inner} and \code{outer}.
#' @param fill the color to be used to fill the box.
#' @param ... further graphical parameters (see \code{\link[graphics]{par}}) may also be supplied as arguments, particularly, line type, \code{lty}, line width, \code{lwd}, color, \code{col} and for \code{type = 'b'}, \code{pch}.  Also the line characteristics \code{lend}, \code{ljoin} and \code{lmitre}.
#'
#' @keywords box
#'
#' @export
#'
#' @details This function intends to give more flexibility to the \code{\link[graphics]{box}} function.
#' As \code{which} parameter, the user provides an object first coerced by \code{as.character} to a character string that is secondly split into single characters. For all of these characters, matches are sought with all elements of \code{1, 2, 3, 4, b, l, t, r} where \code{1=below, 2=left, 3=above, 4=right, b=below, l=left, t=above and r=right}.
#'
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:
#' plot0()
#' box2()
#'
#' # Example 2:
#' plot0()
#' box2('14', fill='grey80', lwd=2)
#' plot0()
#' box2(c(1,4), fill='grey80', lwd=2)
#' plot0()
#' box2(c(1,4), fill='grey80', lwd=2)
#'
#' # Example 3:
#' graphics::par(mfrow=c(2,2),oma=c(2,2,2,2))
#' plot0(0,0)
#' graphics::box('outer',lwd=2)
#' graphics::box('inner',lwd=2)
#' graphics::plot.default(0,0)
#' graphics::plot.default(0,0)
#' plot0()
#' box2(which='figure',lwd=2, fill=2)
#' box2(side=12, lwd=2, fill=8)


box2 <- function(side = 1:4, which = "plot", fill = NULL, ...) {
    ## 
    stopifnot(which %in% c("plot", "figure", "outer", "inner"))
    ## 
    vec <- unlist(strsplit(tolower(as.character(side)), ""))
    ax1 <- match(vec, c("1", "2", "3", "4"))%%5
    ax2 <- match(vec, c("b", "l", "t", "r"))%%5
    ax <- unique(c(ax1, ax2), na.rm = TRUE)
    ax <- ax[!is.na(ax)]
    ## 
    if (length(ax)) {
        coord <- graphics::par()$usr
        if (which != "plot") {
            ## figure margins in user units
            cvx <- (graphics::par()$usr[2] - graphics::par()$usr[1])/graphics::par()$pin[1]
            cvy <- (graphics::par()$usr[4] - graphics::par()$usr[3])/graphics::par()$pin[2]
            mau <- graphics::par()$mai * rep(c(cvy, cvx), 2)
            coord <- coord + c(-mau[2], mau[4], -mau[1], mau[3])
            ## inner margins in user units (get the lenght and adjust!)
            if (which != "figure") {
                diffx <- coord[2] - coord[1]
                diffy <- coord[4] - coord[3]
                lenx <- diffx * 1/(diff(graphics::par()$fig[1:2]))
                leny <- diffy * 1/(diff(graphics::par()$fig[1:2]))
                coord[1L] <- coord[1L] - graphics::par()$fig[1] * lenx
                coord[2L] <- coord[1L] + lenx
                coord[3L] <- coord[3L] - graphics::par()$fig[3] * leny
                coord[4L] <- coord[3L] + leny
                ## outer margins in user units
                if (which != "inner") {
                  omu <- graphics::par()$omi * rep(c(cvy, cvx), 2)
                  coord <- coord + c(-omu[2], omu[4], -omu[1], omu[3])
                }
            }
        }
        op <- graphics::par("xpd")
        graphics::par(xpd = NA)
        mat <- matrix(c(4, 2, 3, 1, 3, 1, 4, 2), ncol = 2)
        if (!is.null(fill)) 
            graphics::rect(coord[1L], coord[3L], coord[2L], coord[4L], col = fill, 
                border = NA)
        for (i in ax) {
            coordb <- coord
            coordb[mat[i, 1L]] <- coordb[mat[i, 2L]]
            graphics::lines(c(coordb[1L], coordb[2L]), c(coordb[3L], coordb[4L]), 
                ...)
        }
        graphics::par(xpd = op)
    } else warning("'bty' does not match any of '1', '2', '3', '4', 'b', 'l', 't', 'r'")
    
    invisible(NULL)
}

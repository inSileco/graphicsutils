#' Alternative box function
#'
#' Draw a box around a plot.
#'
#' @param side a numerical or character vector or a character string specifying which side(s) of the plot the box is to be drawn (see details).
#' @param which a character, one of `plot`, `figure`, `inner` and `outer`.
#' @param fill the color to be used to fill the box.
#' @param ... further graphical parameters (see \code{[graphics::par()]}) may also be supplied as arguments, particularly, line type, `lty`, line width, `lwd`, color, `col` and for \code{type = 'b'}, `pch`.  Also the line characteristics `lend`, `ljoin` and `lmitre`.
#'
#' @keywords box
#'
#' @export
#'
#' @details This function intends to give more flexibility to the \code{[graphics::box()]} function.
#' As `which` parameter, the user provides an object first coerced by \code{as.character} to a character string that is secondly split into single characters. For all of these characters, matches are sought with all elements of \code{1, 2, 3, 4, b, l, t, r} where \code{1=below, 2=left, 3=above, 4=right, b=below, l=left, t=above and r=right}.
#'
#'
#' @seealso \code{[graphics::box()]}
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
            cvx <- (graphics::par()$usr[2L] - graphics::par()$usr[1L])/graphics::par()$pin[1L]
            cvy <- (graphics::par()$usr[4L] - graphics::par()$usr[3L])/graphics::par()$pin[2L]
            mau <- graphics::par()$mai * rep(c(cvy, cvx), 2)
            coord <- coord + c(-mau[2L], mau[4L], -mau[1L], mau[3L])
            ## inner margins in user units (get the lenght and adjust!)
            if (which != "figure") {
                diffx <- coord[2L] - coord[1L]
                diffy <- coord[4L] - coord[3L]
                lenx <- diffx * 1/(diff(graphics::par()$fig[1L:2L]))
                leny <- diffy * 1/(diff(graphics::par()$fig[1L:2L]))
                coord[1L] <- coord[1L] - graphics::par()$fig[1L] * lenx
                coord[2L] <- coord[1L] + lenx
                coord[3L] <- coord[3L] - graphics::par()$fig[3L] * leny
                coord[4L] <- coord[3L] + leny
                ## outer margins in user units
                if (which != "inner") {
                  omu <- graphics::par()$omi * rep(c(cvy, cvx), 2)
                  coord <- coord + c(-omu[2L], omu[4L], -omu[1L], omu[3L])
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

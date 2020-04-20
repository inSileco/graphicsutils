#' Alternative box function
#'
#' Draw a box around a plot.
#'
#' @param side a numerical or character vector or a character string specifying which side(s) of the plot the box is to be drawn (see details).
#' @param which a character, one of `plot`, `figure`, `inner` and `outer`.
#' @param fill the color to be used to fill the box.
#' @param ... further graphical parameters (see [graphics::par()]) may also be supplied as arguments, particularly, line type, `lty`, line width, `lwd`, color, `col` and for \code{type = 'b'}, `pch`.  Also the line characteristics `lend`, `ljoin` and `lmitre`.
#'
#' @keywords box
#'
#' @export
#'
#' @details This function intends to give more flexibility to the [graphics::box()] function.
#' As `which` parameter, the user provides an object first coerced by `as.character` to a character string that is secondly split into single characters. For all of these characters, matches are sought with all elements of `1, 2, 3, 4, b, l, t, r` where `1=below, 2=left, 3=above, 4=right, b=below, l=left, t=above and r=right`.
#'
#'
#' @seealso [graphics::box()]
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
#' par(mfrow=c(2,2),oma=c(2,2,2,2))
#' plot0(0,0)
#' box('outer',lwd=2)
#' box('inner',lwd=2)
#' plot.default(0,0)
#' plot.default(0,0)
#' plot0()
#' box2(which='figure',lwd=2, fill=2)
#' box2(side=12, lwd=2, fill=8)


box2 <- function(side, which = c("plot", "figure", "outer", "inner"),
  fill = NULL, ...) {
    ##
    which <- match.arg(which)
    if (missing(side)) side <- 1:4
    ## get the sides desired
    vec <- unlist(strsplit(tolower(as.character(side)), ""))
    ax1 <- match(vec, as.character(1:4)) %% 5
    ax2 <- match(vec, c("b", "l", "t", "r")) %% 5
    ax <- unique(c(ax1, ax2), na.rm = TRUE)
    ax <- ax[!is.na(ax)]
    ##
    if (length(ax)) {
        opar <- par(no.readonly = TRUE)
        # on.exit(par(opar))$ this will cause a problem!
        coord <- opar$usr
        if (which != "plot") {
            ## figure margins in user units
            cvx <- (opar$usr[2L] - opar$usr[1L])/opar$pin[1L]
            cvy <- (opar$usr[4L] - opar$usr[3L])/opar$pin[2L]
            mau <- opar$mai * rep(c(cvy, cvx), 2)
            coord <- coord + c(-mau[2L], mau[4L], - mau[1L], mau[3L])
            ## inner margins in user units (get the lenght and adjust!)
            if (which != "figure") {
                diffx <- coord[2L] - coord[1L]
                diffy <- coord[4L] - coord[3L]
                lenx <- diffx * 1/(diff(opar$fig[1L:2L]))
                leny <- diffy * 1/(diff(opar$fig[1L:2L]))
                coord[1L] <- coord[1L] - opar$fig[1L] * lenx
                coord[2L] <- coord[1L] + lenx
                coord[3L] <- coord[3L] - opar$fig[3L] * leny
                coord[4L] <- coord[3L] + leny
                ## outer margins in user units
                if (which != "inner") {
                  omu <- opar$omi * rep(c(cvy, cvx), 2)
                  coord <- coord + c(-omu[2L], omu[4L], -omu[1L], omu[3L])
                }
            }
        }
        op <- par("xpd")
        par(xpd = NA)
        mat <- matrix(c(4, 2, 3, 1, 3, 1, 4, 2), ncol = 2)
        if (!is.null(fill))
            rect(coord[1L], coord[3L], coord[2L], coord[4L],
              col = fill, border = NA)
        for (i in ax) {
            coordb <- coord
            coordb[mat[i, 1L]] <- coordb[mat[i, 2L]]
            lines(c(coordb[1L], coordb[2L]), c(coordb[3L], coordb[4L]), ...)
        }
    } else warning("'side' does not match ant of the available values.")

    invisible(ax)
}

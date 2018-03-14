#' Draw a frame around a plot
#'
#' Draw a frame around the plot region as an ensemble of small rectangles whose colors can be specified.
#'
#' @param nbc number of rectangles to be drawn for each axis.
#' @param cex.x control the dimension
#' @param cex.y The radii of the circles.
#' @param col color of the rectangles drawn.
#' @param border color of the borders if the rectangles drawn.
#'
#' @keywords frame, box
#'
#' @export
#'
#' @details
#' The number of rectangles could be different from \code{nbc} as \code{pretty} is called to properly locate them.
#' The \code{col} argument determines the succession of colors to be applied to each axis.
#'
#' @examples
#' #Example 1:
#' plot0()
#' frameIt()
#'
#' #Example 2:
#' plot0()
#' frameIt(cex.x=1.5, col=c(2,3), border=1)


frameIt <- function(nbc = 10, cex.x = 1, cex.y = cex.x, col = c("grey45", "grey85"), 
    border = NA) {
    pu <- graphics::par()$usr
    ## 
    px <- pretty(c(pu[1L], pu[2L]), nbc)
    dx <- px[2L] - px[1L]
    px <- c(px[1L] - dx, px, px[nbc] + dx)
    ## 
    py <- pretty(c(pu[3L], pu[4L]), nbc)
    dy <- py[2L] - py[1L]
    py <- c(py[1L] - dy, py, py[nbc] + dy)
    ## 
    widx <- 0.01 * (pu[4L] - pu[3L]) * cex.x * graphics::par()$pin[1L]/graphics::par()$pin[2L]
    widy <- 0.01 * (pu[2L] - pu[1L]) * cex.y
    ## 
    mycol <- rep_len(col, nbc + 3)
    ## 
    for (i in (1:(nbc + 3))) {
        # axis 1
        graphics::rect(px[i], pu[3L], px[i + 1], pu[3L] + widx, col = mycol[i], border = border)
        # axis 3
        graphics::rect(px[i], pu[4L] - widx, px[i + 1], pu[4L], col = mycol[i], border = border)
        # axis 2
        graphics::rect(pu[1L], py[i], pu[1L] + widy, py[i + 1], col = mycol[i], border = border)
        # axis 4
        graphics::rect(pu[2L] - widy, py[i], pu[2L], py[i + 1], col = mycol[i], border = border)
    }
    invisible(NULL)
}

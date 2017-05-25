#' Draw a frame around a Plot
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
#' frameit()
#'
#' #Example 2:
#' plot0()
#' frameit(cex.x=1.5, col=c(2,3), border=1)


frameit <- function(nbc = 10, cex.x = 1, cex.y = cex.x, col = c("grey45", "grey85"), 
    border = NA) {
    pu <- graphics::par()$usr
    ## 
    px <- pretty(c(pu[1], pu[2]), nbc)
    dx <- px[2] - px[1]
    px <- c(px[1] - dx, px, px[nbc] + dx)
    ## 
    py <- pretty(c(pu[3], pu[4]), nbc)
    dy <- py[2] - py[1]
    py <- c(py[1] - dy, py, py[nbc] + dy)
    ## 
    widx <- 0.01 * (pu[4] - pu[3]) * cex.x * graphics::par()$pin[1]/graphics::par()$pin[2]
    widy <- 0.01 * (pu[2] - pu[1]) * cex.y
    ## 
    mycol <- rep_len(col, nbc + 3)
    ## 
    for (i in (1:(nbc + 3))) {
        # axis 1
        graphics::rect(px[i], pu[3], px[i + 1], pu[3] + widx, col = mycol[i], border = border)
        # axis 3
        graphics::rect(px[i], pu[4] - widx, px[i + 1], pu[4], col = mycol[i], border = border)
        # axis 2
        graphics::rect(pu[1], py[i], pu[1] + widy, py[i + 1], col = mycol[i], border = border)
        # axis 4
        graphics::rect(pu[2] - widy, py[i], pu[2], py[i + 1], col = mycol[i], border = border)
    }
}

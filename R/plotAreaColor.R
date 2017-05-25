#' Color the plot area
#'
#' Color the plot area by drawing a rectangle. Default color is 'grey80'.
#'
#' @param border Color of the border of the rectangle drawn, default is set to NA, that is no border.
#' @param col Color of the rectangle, default is set to 'grey80'.
#' @param ... Additional arguments to be passed to \code{\link{rect}} function.
#'
#' @keywords background, color
#'
#' @export
#'
#' @details The function calls \code{\link{rect}} and draw a colored rectangle (defaut color is set to light blue) whose dimensions are given by argument \code{usr} of function \code{\link{par}}.
#'
#' @note In graphics::par(), argument bg colors all the window, .
#'
#' @examples
#' #Example 1:
#' plot0()
#' plotAreaColor()
#'
#' #Example 2:
#' plot0()
#' plotAreaColor(col=8, lwd=4, border=4)

plotAreaColor <- function(col = "grey80", border = NA, ...) {
    args <- list(...)
    lp <- graphics::par()$usr
    coor <- list(xleft = lp[1], ybottom = lp[3], xright = lp[2], ytop = lp[4])
    if (length(args) > 0) 
        do.call("rect", args = as.list(c(coor, border = border, col = col, args))) else do.call("rect", args = as.list(c(coor, border = border, col = col)))
}

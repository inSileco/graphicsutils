#' Color the plot area
#'
#' Color the plot area by drawing a rectangle. Default color is 'grey80'.
#'
#' @param border Color of the border of the rectangle drawn, default is set to `NA`, that is no border.
#' @param color Color of the rectangle, default is set to 'grey80'.
#' @param ... Additional arguments to be passed to [graphics::rect()] function.
#'
#' @keywords background, color
#'
#' @export
#'
#' @details The function calls [graphics::rect()] and draw a colored rectangle (default color is set to light blue) whose dimensions are given by argument `usr` of function [graphics::par()].
#'
#' @note In [graphics::par()], argument `bg` colors the entire window.
#'
#' @examples
#' #Example 1:
#' plot0()
#' plotAreaColor()
#'
#' #Example 2:
#' plot0()
#' plotAreaColor(col=8, lwd=4, border=4)

plotAreaColor <- function(color = "grey80", border = NA, ...) {
    args <- list(...)
    lp <- graphics::par()$usr
    coor <- list(xleft = lp[1L], ybottom = lp[3L], xright = lp[2L],
      ytop = lp[4L])
    if (!is.null(names(color)))
        names(color) <- NULL
    ##
    if (length(args) > 0) {
        do.call("rect", args = as.list(
          c(coor, border = border, col = color, args)))
    } else do.call("rect", args = as.list(
      c(coor, border = border, col = color)))
    ##
    invisible(NULL)
}

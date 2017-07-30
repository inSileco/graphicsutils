#' An empty plot function
#'
#' \code{plot0} returns an a plot of a specific size without any symbols.
#'
#' @param x the x coordinates of points in the plot.
#' @param y the y coordinates of points in the plot.
#' @param fill The color to be used to fill the plot area.
#' @param ... additional arguments to be passed to the defauls scatterplot
#' function \code{\link[graphics]{plot.default}}.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @seealso \code{\link[shape]{emptyplot}}
#'
#' @examples
#' # Example 1:
#' plot0()
#'
#' # Example 2:
#' plot0(c(-10,10), asp=1)
#'
#' # Example 2:
#' plot0(c(-10,10), asp=1, fill=8)

plot0 <- function(x = c(-1, 1), y = x, fill = NULL, ...) {
    args <- list(...)
    coor <- list(x = x, y = y)
    deft <- list(ann = FALSE, axes = FALSE, type = "n")
    ## 
    if (length(args) > 0) {
        id <- which(names(deft) %in% names(args))
        if (length(id) > 0) 
            deft <- deft[-id]
        do.call(graphics::plot.default, args = as.list(c(coor, args, deft)))
    } else graphics::plot.default(x = x, y = y, ann = FALSE, axes = FALSE, type = "n")
    if (!is.null(fill)) 
        plotAreaColor(col = fill)
    invisible()
}

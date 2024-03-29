#' An empty plot function
#'
#' `plot0` returns an a plot of a specific size without any symbols.
#'
#' @param x the x coordinates of points in the plot or a matrix of coordinates.
#' @param y the y coordinates of points in the plot.
#' @param fill The color to be used to fill the plot area.
#' @param grid.col color of the grid's lines. The default value is `NULL`, in 
#' which case the grid is not drawn.
#' @param grid.lty line type of the grid's lines.
#' @param grid.lwd line width of the grid's lines.
#' @param text A character string or a object to be coerced as character string
#' that will be displayed in the center of the plot region.
#' @param ... further graphical parameters from [graphics::par()]
#' (such as `srt`) or [graphics::plot.default].
#'
#' @keywords empty plot
#'
#' @export
#'
#' @examples
#' # Example 1
#' plot0()
#'
#' # Example 2
#' plot0(c(-10,10), asp=1)
#'
#' # Example 3
#' plot0(c(-10,10), text='cool', cex = 2)
#'
#' # Example 3
#' plot0(c(-10,10), asp=1, fill=8, text='cool', srt=45, cex=4, col=2)
#'
#' # Example 4
#' plot0(c(-10,10), fill='#ebebeb', grid.col = 'white')
#'
#' # Example 4
#' plot0(c(-10,10), grid.col = 2)

plot0 <- function(x = c(-1, 1), y = NULL, fill = NULL, text = NULL,
    grid.col = NULL, grid.lwd = 1, grid.lty = 1, ...) {
    ##
    args <- list(...)
    args_txt <- args[
        names(args) %in% methods::formalArgs(graphics::text.default)
    ]
    deft <- list(ann = FALSE, axes = FALSE, type = "n")
    # default behavior for matrix and vectors
    if (NCOL(as.matrix(x)) > 1 && is.null(y)) {
        if (is.null(y)) {
            y <- x[, 2L]
        }
        x <- x[, 1L]
    } else {
        if (is.null(y))
            y <- x else stopifnot(length(x) == length(y))
    }
    #
    coor <- list(x = x, y = y)

    ##
    if (length(args) > 0) {
        id <- which(names(deft) %in% names(args))
        if (length(id) > 0)
            deft <- deft[-id]
        do.call(plot.default, args = as.list(c(coor, args, deft)))
    } else plot.default(x = x, y = y, ann = FALSE, axes = FALSE, type = "n")

    ##
    if (!is.null(fill))
        plotAreaColor(color = fill)
    #
    if (!is.null(grid.col))
        grid(col = grid.col, lty = grid.lty, lwd = grid.lwd)

    ##
    if (!is.null(text))
        do.call(text.default, args = as.list(c(x = mean(x), y = mean(y),
            labels = as.character(text), args_txt)))
    ##
    invisible(NULL)
}

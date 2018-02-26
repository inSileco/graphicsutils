#' An empty plot function
#'
#' \code{plot0} returns an a plot of a specific size without any symbols.
#'
#' @param x the x coordinates of points in the plot or a matrix of coordinates.
#' @param y the y coordinates of points in the plot.
#' @param fill The color to be used to fill the plot area.
#' @param text A character string or a object to be coerced as character string
#' that will be displayed in the center of the plot region. q
#' @param ... further graphical parameters from \code{\link[graphics]{par}}
#' (such as \code{srt}) or \code{\link[graphics]{plot.default}}.
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
#' plot0(c(-10,10), asp=1, fill=8, text='cool', srt=90, cex=2)
#' plot0(c(-10,10), asp=1, fill=8, text='cool', srt=45, cex=4, col=2)

plot0 <- function(x = c(-1, 1), y = NULL, fill = NULL, text = NULL, ...) {
    args <- list(...)
    coor <- list(x = x, y = y)
    deft <- list(ann = FALSE, axes = FALSE, type = "n")
    ##--- default behavior for matrix and vectors
    if (NCOL(as.matrix(x)) > 1 & is.null(y)) {
        if (is.null(y)) {
            y <- x[, 2L]
        }
        x <- x[, 1L]
    } else {
        if (is.null(y)) {
            y <- x
        }
    }
    
    
    ## 
    if (length(args) > 0) {
        id <- which(names(deft) %in% names(args))
        if (length(id) > 0) 
            deft <- deft[-id]
        do.call(graphics::plot.default, args = as.list(c(coor, args, deft)))
    } else graphics::plot.default(x = x, y = y, ann = FALSE, axes = FALSE, type = "n")
    ## 
    if (!is.null(fill)) 
        plotAreaColor(color = fill)
    ## 
    if (!is.null(text)) 
        text(mean(x), mean(y), labels = as.character(text), ...)
    ## 
    invisible(NULL)
}

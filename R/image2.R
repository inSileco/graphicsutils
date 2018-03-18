#' Alternative image function
#'
#' Creates a grid of colored or gray-scale rectangles. This function is similar
#' to \code{\link[graphics]{image}} when used for a matrix but simpler (*i.e*
#' less available features).
#'
#' @param x a matrix or an object to be coerced as a matrix.
#' @param from matrix values equal to or smaller than \code{from} will be
#' associated with the first color of the color scale.
#' @param to values equal to or larger than \code{from} will be associated with
#' the last color of the color scale.
#' @param color_scale a vector of colors.
#' @param border color for rectangle borders (see \code{\link[graphics]{rect}}).
#' @param ... further arguments to be passed to \code{\link[graphics]{rect}}.
#'
#' @keywords image rectangles
#'
#' @importFrom grDevices colorRampPalette
#' @importFrom graphics par rect
#' @export
#'
#' @details This function actually draws rectangles to create an image from a matrix.
#' Unlike \code{\link[graphics]{image}}, \code{image2} the image is ordered just as the
#' matrix is displayed meaning that the cell (1,1) is at the upper left cell of
#' the plot drawn. Note that currenlty neither titles nor axes' labels are added
#' user should call the \code{\link[graphics]{title}} and \code{\link[graphics]{axis}}.
#' Concerning the latter, the user should be aware that cell's coordinates range
#' from 0 to 1 with 0 being the coordinates of the first cell and 1 the coordinates
#' of the last cell (if there is only one cell then the center of the unique cell
#' is 0).
#'
#' @seealso \code{\link[graphics]{image}}
#'
#' @examples
#' image2(matrix(1:9, 3))
#' image2(matrix(1:27, 3), from=2, border = 2, lwd=2)

image2 <- function(x, from = NULL, to = NULL, color_scale = NULL, border = NA, ...) {
    x <- as.matrix(x)
    
    if (!is.null(from)) {
        x[x < from] <- from
        if (!is.null(to)) 
            stopifnot(from < to)
    } else from <- min(x)
    if (!is.null(to)) 
        x[x > to] <- to else to <- max(x)
    
    nc <- ncol(x)
    seqx <- get_seq(nc)
    # 
    nr <- nrow(x)
    seqy <- get_seq(nr)
    
    # determine color scale
    if (is.null(color_scale)) {
        color_scale <- colorRampPalette(c("grey10", "grey90"))(256L)
    }
    ns <- length(color_scale)
    if (to == from) 
        dis <- 1 else dis <- to - from
    mat_col <- 1 + floor((ns - 1) * ((x - from)/dis))
    
    par(xaxs = "i", yaxs = "i")
    plot0(range(seqx), range(seqy))
    for (i in 1:nc) {
        for (j in 1:nr) {
            rect(seqx[i], seqy[(nr + 2) - j], seqx[i + 1], seqy[(nr + 1) - j], col = color_scale[mat_col[j, 
                i]], border = border, ...)
        }
    }
    
    invisible(x)
}



get_seq <- function(n) {
    if (n > 1) {
        dx <- 0.5/(n - 1)
        seqx <- seq(-dx, 1 + dx, length = n + 1)
    } else seqx <- c(-1, 1)
    seqx
}

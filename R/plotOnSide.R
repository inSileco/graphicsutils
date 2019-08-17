#' Add plot on sides.
#'
#' plotOnSide adds plot areas on the specified sides of the original figures.
#'
#' @param mat a matrix object specifying the location of the next N figures on the output device, see [graphics::layout()].
#' @param dim optional. If provided, then a matrix is created based and this argument specifies its dimensions.
#' @param side the number of the sides on which plot areas must be added.
#' @param quiet if TRUE, no warning message will be displayed.
#' @param ... additional arguments to be passed to [graphics::layout()].
#'
#' @export
#'
#' @details
#' This function eases the creation of plots that include multiple panels that shares information such as axis labels. Instead of
#' repeating or deleting axis labels, `plotOnSide` add plot areas on the specified sides of the original fgures.
#' It is based on [graphics::layout()] and it is no more than a tunned version of it.
#'
#' @examples
#' plotOnSide(matrix(1,2), width=c(0.2,1), height=c(1,1,1,0.6))
#' graphics::layout.show(5)


plotOnSide <- function(mat, side = 1:2, dim = NULL, quiet = FALSE, ...) {
    ##
    mat <- as.matrix(mat)
    ##
    if (!is.null(dim)) {
        stopifnot(length(dim) == 2)
        mat <- matrix(dim[1L] * dim[2L], nrow = dim[1L], ncol = dim[2L])
    }
    slc <- sort(stats::na.exclude(unique(match(side, c(1, 2, 3, 4)))))
    ##
    if (!length(slc)) {
        if (!quiet)
            warning("'side' does not match with any of 1, 2, 3 or 4")
        layout(mat, ...)
    } else {
        sz <- length(slc)
        mydim <- dim(mat)
        mat <- cbind(0, mat + sz, 0)
        mat <- rbind(0, mat, 0)
        for (i in seq_len(sz)) {
            switch(slc[i], {
                mat[nrow(mat), 1 + (1:mydim[2L])] <- 1
            }, {
                mat[1 + (1:mydim[1L]), 1] <- 2
            }, {
                mat[1, 1 + (1:mydim[2L])] <- 3
            }, {
                mat[1 + (1:mydim[1L]), ncol(mat)] <- 4
            })
        }
        if (all(mat[1L, ] == 0))
            mat <- mat[-1L, ]
        if (all(mat[, 1L] == 0))
            mat <- mat[, -1L]
        if (all(mat[nrow(mat), ] == 0))
            mat <- mat[-nrow(mat), ]
        if (all(mat[, ncol(mat)] == 0))
            mat <- mat[, -ncol(mat)]
        ##
        layout(mat, ...)
    }
    invisible(NULL)
}

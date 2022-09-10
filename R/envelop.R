#' Compute the coordinates of an envelop
#'
#' `envelop` eases the computation of the polygons described by to set
#' of y coordinates along the x-axis. Optionally, the polygons could be added
#' on the current plot.
#'
#' @param x vectors containing the x coordinates.
#' @param upper the y coordinates of the upper values.
#' @param lower the y coordinates of the lower values.
#' @param add a logical. If `TRUE` the envelop is drawn as a polygon (default 
#' behavior).
#' @param ... additional arguments to be passed to [graphics::polygon()] 
#' function.
#'
#' @export
#'
#' @return
#' The coordinates of the envelop are returned if assigned.
#'
#' @examples
#' plot0(c(0, 10), c(0, 10))
#' sz <- 100
#' seqx <- seq(0, 10, length.out = sz)
#' seqy1 <- 0.2 * seqx * runif(sz, 0, 1)
#' seqy2 <- 4 + 0.25 * seqx * runif(sz, 0, 1)
#' seqy3 <- 8 + 0.25 * seqx * runif(sz, 0, 1)
#' envelop(seqx, seqy1, seqy2, col = 'grey85', border = NA)
#' envelop(seqx, seqy2, seqy3, col = 'grey25', border = NA)

envelop <- function(x, upper, lower = rep(0, length(upper)), add = TRUE, ...) {
    stopifnot(length(x) == length(upper))
    stopifnot(length(x) == length(lower))
    out <- list(x = c(x, rev(x)), y = c(upper, rev(lower)))
    if (add)
        polygon(c(x, rev(x)), c(upper, rev(lower)), ...)
    invisible(out)
}

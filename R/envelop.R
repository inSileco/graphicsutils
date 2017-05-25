#' Color the area between two lines.
#'
#' \code{envelop} colors the area between two series of y coordinates.
#'
#' @param x vectors containing the x coordinates.
#' @param upper the y coordinates of the upper values.
#' @param lower the y coordinates of the lower values.
#' @param ... additionnal arguments to be passed to \link[graphics]{polygon}.
#'
#' @export
#'
#' @details This function enables to color the areas between two set of values.
#'
#' @examples
#' plot0(c(0,10),c(0,10))
#' sz <- 100
#' seqx <- seq(0, 10, length.out=sz)
#' seqy1 <- 0.2*seqx*runif(sz, 0, 1)
#' seqy2 <- 4+0.25*seqx*runif(sz, 0, 1)
#' seqy3 <- 8+0.25*seqx*runif(sz, 0, 1)
#' envelop(seqx, seqy1, seqy2, col='grey85', border=NA)
#' envelop(seqx, seqy2, seqy3, col='grey25', border=NA)

envelop <- function(x, upper, lower, ...) {
    stopifnot(length(x) == length(upper))
    stopifnot(length(x) == length(lower))
    graphics::polygon(c(x, rev(x)), c(upper, rev(lower)), ...)
}

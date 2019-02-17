#' @title Compass Rose
#'
#' @description This function draws a fully personnalisable compass rose.
#'
#' @param x the x coordinates of the center of the compass rose.
#' @param y the y coordinates of the center of the compass rose.
#' @param labels a vector of four character strings used as labels for the cardinal directions.
#' @param rot rotation for the compass rose in degrees (clockwise).
#' @param col.cr a vector of colors used to draw compass rose (see details).
#' @param col.let a character string specifying the labels' color.
#' @param border a vector of colors of the borders of the compass rose.
#' @param cex.cr the magnification to be used for the whole compass rose.
#' @param cex.let the magnification to be used for labels.
#' @param offset label offset of the cardinal points.
#' @param add a logical. Should the compass rose be added on the current graph?
#' @param ... additional arguments to be passed to \code{[graphics::polygon()]}.
#'
#' @details
#' Both \code{col.cr} and `border` are repeated over (\code{[base::rep()]}
#' is called) so it has a 8 elements, meaning all triangles the compass rose is
#' made of could have their own color.
#'
#' Note that there already exists a similar function by Jim Lemon in `sp` package.
#'
#' @examples
#' compassRose(0, rot=25, cex.cr = 2, col.let =2, add = FALSE)

#' @export
#' @describeIn compassRose A compass rose with the four cardinal directions and additionnal directions.
compassRose <- function(x = 0, y = 0, labels = c("S", "W", "N", "E"), rot = 0, cex.cr = 1,
    cex.let = cex.cr, col.cr = c(1, 8), col.let = 1, border = c(1, 8), offset = 1.2,
    add = TRUE, ...) {
    #
    if (!isTRUE(add))
        plot0(c(-0.1, 0.1), asp = T)
    #
    compassRoseCardinal(x, y, rot + 22.5, cex.cr * 0.65, labels = rep("", 4), cex.let = cex.let,
        offset = offset, col.cr = col.cr, border = border, ...)
    compassRoseCardinal(x, y, rot + 67.5, cex.cr * 0.65, labels = rep("", 4), cex.let = cex.let,
        offset = offset, col.cr = col.cr, border = border, ...)
    compassRoseCardinal(x, y, rot + 45, cex.cr * 0.85, labels = rep("", 4), cex.let = cex.let,
        offset = offset, col.cr = col.cr, col.let = col.let, border = border, ...)
    compassRoseCardinal(x, y, labels = labels, rot, cex.cr, cex.let = cex.let, offset = offset,
        col.cr = col.cr, col.let = col.let, border = border, ...)
    #
    invisible(NULL)
}

#' @export
#' @describeIn compassRose A compass with the four cardinal directions only.
compassRoseCardinal <- function(x, y = x, rot = 0, cex.cr = 1, cex.let = 1, labels = c("S",
    "W", "N", "E"), offset = 1.2, col.cr = c(1, 8), col.let = 1, border = c(1, 8),
    ...) {
    #
    wh <- graphics::strheight("M")
    rot <- pi * rot/180
    mat.rot <- matrix(c(cos(rot), sin(rot), -sin(rot), cos(rot)), 2)
    #
    lwh <- cex.cr * 4 * wh
    swh <- cex.cr * 0.45 * wh
    #
    rex <- rep(c(0, -1, 0, 1), each = 2)
    rey <- rep(c(-1, 0, 1, 0), each = 2)
    rex1 <- c(lwh * rex, swh * c(-1, 1) * rey + rex * swh)
    rey1 <- c(lwh * rey, swh * c(-1, 1) * rex + rey * swh) * rep(c(1, -1), each = 2,
        4)
    # last multiplication for the color order
    matxy <- as.matrix(cbind(rex1, rey1))
    matxy <- matxy %*% mat.rot
    #
    cr.col <- rep(col.cr, length.out = 8)
    cr.bd <- rep(border, length.out = 8)
    #
    for (i in 1:8) {
        graphics::polygon(x + c(0, matxy[i, 1], matxy[8 + i, 1]), y + c(0, matxy[i,
            2], matxy[8 + i, 2]), col = cr.col[i], border = cr.bd[i], ...)
    }
    graphics::text(x + offset * matxy[seq(1, by = 2, length.out = 4), 1], y + offset *
        matxy[seq(1, by = 2, length.out = 4), 2], labels, cex = cex.let, col = col.let)
    #
    invisible(NULL)
}

#' @title Compass Rose
#'
#' @description Draw a compass rose fully customizable.
#'
#' @param x the x coordinates of the center of the compass rose.
#' @param y the y coordinates of the center of the compass rose.
#' @param rot rotation for the compass rose in degrees (clockwise).
#' @param cex.cr the magnification to be used for the whole compass rose.
#' @param cex.let the magnification to be used for labels.
#' @param labels labels for the cardinal direction.
#' @param offset label offset of the cardinal points.
#' @param col colors of the compass rose (see details).
#' @param border colors of the borders of the compass rose.
#' @param lty line type for the border lines.
#'
#' @details
#' This function draw a basic but fully personnalisable compassRose.
#' Note that There already exists one compass rose by Jim Lemon in \code{sp} package.
#'
#'
#' @examples
#' plot0()
#' compassRose(0, rot=25)

#' @export
#' @describeIn compassRose A compass rose with the four cardinal directions and additionnal directions.
compassRose <- function(x = 0, y = 0, rot = 0, cex.cr = 1, cex.let = 1, offset = 1.2, 
    col = c(1, 8), border = c(1, 8), lty = 1) {
    # 
    compassRoseCardinal(x, y, rot + 22.5, cex.cr * 0.65, labels = rep("", 4), cex.let = cex.let, 
        offset = offset, col = col, border = border, lty = lty)
    compassRoseCardinal(x, y, rot + 67.5, cex.cr * 0.65, labels = rep("", 4), cex.let = cex.let, 
        offset = offset, col = col, border = border, lty = lty)
    compassRoseCardinal(x, y, rot + 45, cex.cr * 0.85, labels = c("SW", "NW", "NE", 
        "SE"), cex.let = cex.let, offset = offset, col = col, border = border, lty = lty)
    compassRoseCardinal(x, y, rot, cex.cr, cex.let = cex.let, offset = offset, col = col, 
        border = border, lty = lty)
    # 
    invisible(NULL)
}

#' @export
#' @describeIn compassRose A compass with the four cardinal directions only.
compassRoseCardinal <- function(x, y = x, rot = 0, cex.cr = 1, cex.let = 1, labels = c("S", 
    "W", "N", "E"), offset = 1.2, col = c(1, 8), border = c(1, 8), lty = 1) {
    # 
    wh <- graphics::strheight("M")
    rot < -pi * rot/180
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
    cr.col <- rep(col, length.out = 8)
    cr.bd <- rep(border, length.out = 8)
    # 
    for (i in 1:8) {
        graphics::polygon(x + c(0, matxy[i, 1], matxy[8 + i, 1]), y + c(0, matxy[i, 
            2], matxy[8 + i, 2]), col = cr.col[i], border = cr.bd[i], lty = lty)
    }
    graphics::text(x + offset * matxy[seq(1, by = 2, length.out = 4), 1], y + offset * 
        matxy[seq(1, by = 2, length.out = 4), 2], labels, cex = cex.let)
    # 
    invisible(NULL)
}

#' Donut chart.
#'
#' Draw a donut chart.
#'
#' @param vec a vector of non-negative numerical quantities  that are displayed as the areas of donut slices.
#' @param eaten the eaten part of the donut.
#' @param labels one or more expressions or character strings giving names for the slices.
#' @param rot the rotation angle (in degree) of the donut.
#' @param cx the magnification coefficient to be used for the total horizontal width of the donut.
#' @param cy controls the total vertical width of the donut.
#' @param cex the magnification coefficient to be used for the size of the donut.
#' @param tck the magnification coefficient to be used for the length of the tick marks.
#' @param width the width of the donut (set between 0 and 1).
#' @param mycol vector of colors to be used.
#' @param density the density of shading lines, in lines per inch.  The default value of \code{NULL} means that no shading lines are drawn.
#' @param angle the slope of shading lines, given as an angle in degrees (counter-clockwise).
#' @param dt point density of the drawn circles.
#' @param add should images be added on the current graph ? If FALSE a new plot is created.
#' @param border the border color of the donut. The default value of \code{NA} means that no border lines are drawn.
#' @param clockwise logical. Shall slices be drawn clockwise?
#' @param ... additionnal arguments to be passed to lines methods.
#'
#' @keywords donut
#'
#' @export
#'
#' @details
#' As pie chart, donut charts are a very bad way of displaying information, see \link[graphics]{pie}
#' The aspect of the donut is fully customizable. If \code{width} is set to 1 and \code{eaten} to 0, the donut chart is then a pie chart.
#'
#' @note
#' Substantial part of the code have been inspired by the \code{pie} function.
#'
#' The 'col' argument determines the succession of colors to be applied to each axis.
#'
#' @examples
#' #Example 1:
#' graphics::par(mfrow=c(2,2), mar=rep(2,4))
#' donut(vec=c(10,20,15))
#' donut(c(10,20,15), eaten=0.2)
#' donut(c(10,20,15), eaten=0.2, rot=180, labels=paste('group',1:3), lwd=3, col=8)
#' donut(c(10,20,15), 0.2, cx=4, col=4, mycol=c(4,3,2), density=30, angle=c(20,55,110))
#'
#' #Example 2:
#' plot0(c(0,10),c(0,40), type='n')
#' vec <- runif(7)
#' donut(vec, 0.15, cx=5, cy=20, add=TRUE, col=2)

donut <- function(vec, eaten = 0, labels = NULL, rot = 0, cex = 0.8, tck = 0.05,
    width = 0.6, mycol = 1 + 1:length(vec), density = NULL, angle = 45, dt = 0.001,
    add = FALSE, cx = 0, cy = 0, border = NA, clockwise = TRUE, ...) {
    if (!is.numeric(vec) || any(is.na(vec) | vec < 0))
        stop("'vec' values must be positive.")
    stopifnot(width <= 1 & width > 0)
    # makes 'width' intuitive
    width <- 1 - width
    ## sequence to draw circles
    x <- (2 * pi * rot/360) + seq(-0.5 * pi, -2.5 * pi, -dt)
    if (!clockwise)
        x <- rev(x)
    sz <- length(x)
    d <- floor(0.5 * eaten * sz)
    ## remove the eaten part
    xb <- x[d:(sz - d)]
    szb <- length(xb)
    ## vector
    nb <- length(vec)
    vecb <- floor(vec/sum(vec) * szb)
    ## color
    mycol <- rep(mycol, length.out = nb)
    ## labels
    if (is.null(labels))
        labels <- as.character(1:nb) else labels <- grDevices::as.graphicsAnnot(labels)
    ## Dimension
    wid <- (graphics::par()$usr[2] - graphics::par()$usr[1])
    heg <- (graphics::par()$usr[4] - graphics::par()$usr[3])

    if (!add) {
        graphics::plot.new()
        graphics::plot.window(c(-1, 1), c(-1, 1), asp = 1)
        cx <- cy <- 0
        cex.x <- cex.y <- cex
    } else {
        cex.x <- cex * 0.4 * wid
        aspin <- graphics::par()$pin[1]/graphics::par()$pin[2]
        cex.y <- aspin * cex * 0.4 * heg
    }
    if (!is.null(density)) {
        density <- rep(density, length.out = nb)
        angle <- rep(angle, length.out = nb)
    }
    sx <- 1
    for (i in 1L:nb) {
        vx <- c(cos(xb[sx]), width * cos(xb[sx]), width * cos(xb[sx:(sx + vecb[i])]),
            cos(xb[(sx + vecb[i]):sx]))
        vy <- c(sin(xb[sx]), width * sin(xb[sx]), width * sin(xb[sx:(sx + vecb[i])]),
            sin(xb[(sx + vecb[i]):sx]))
        if (!is.null(density))
            graphics::polygon(cx + cex.x * vx, cy + cex.y * vy, col = mycol[i], border = border,
                density = density[i], angle = angle[i]) else graphics::polygon(cx + cex.x * vx, cy + cex.y * vy, col = mycol[i],
            border = border)
        lab <- as.character(labels[i])
        if (!is.na(lab) && nzchar(lab)) {
            mid <- sx + floor(0.5 * vecb[i])
            pos <- 1 + (sin(xb[mid]) > -0.5 * sqrt(3))
            if (pos > 1)
                pos <- pos + (cos(xb[mid]) > -0.5) + (cos(xb[mid]) > 0.5)
            graphics::lines(cx + cex.x * c(1, 1 + tck) * cos(xb[mid]), cy + cex.y *
                c(1, 1 + tck) * sin(xb[mid]), ...)
            graphics::text(cx + (1 + tck) * cex.x * cos(xb[mid]), cy + cex.y * (1 + tck) * 
                sin(xb[mid]), labels[i], pos = pos, xpd = TRUE)
        }
        sx <- sx + vecb[i]
    }
    graphics::lines(cx + cex.x * cos(xb), cy + cex.y * sin(xb), ...)
    graphics::lines(cx + cex.x * width * cos(xb), cy + cex.y * width * sin(xb), ...)
    if (eaten) {
        graphics::lines(cx + cex.x * c(cos(xb[1]), width * cos(xb[1])), cy + cex.y *
            c(sin(xb[1]), width * sin(xb[1])), ...)
        graphics::lines(cx + cex.x * c(cos(xb[szb]), width * cos(xb[szb])), cy +
            cex.y * c(sin(xb[szb]), width * sin(xb[szb])), ...)
    }
}

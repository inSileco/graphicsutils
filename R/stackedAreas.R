#' Stacked areas chart
#'
#' Draw a stacked areas chart.
#'
#' @param val a dataframe or a matrix containing a series of positive values,
#' rows stand for popultaions.
#' @param index values to be used for the x axis, by default it is set to
#' `NULL` meaning that it is handled by `plot.default`
#' @param rgy a value that determines the range of y values. Default is set to
#' 1 which means that the range of values is \[0,1\].
#' @param cumul a logical. If `TRUE`, data are considered as cumulative sums.
#' @param transp a logical. If `TRUE`, the transpose of the data table is
#' computed.
#' @param legend Text to be used as a legend for each area drawn.
#' @param col vector of colors, repeated if too small.
#' @param add logical. Should stacked areas be added on the current plot?
#' @param pickcolors logical. If `TRUE`, [pickColors()] is called to select
#' colors.
#' @param lty the line type (see [graphics::par()] documentation)
#' @param lwd the line width (see [graphics::par()] documentation)
#' @param border The color to draw the border. The default, `NULL`, means to use `graphics::par('fg')`. Use `border = NA` to omit borders.
#' @param main a main title for the plot.
#' @param xlab a label for the x axis, defaults to a description of `x`.
#' @param ylab a label for the y axis, defaults to a description of `y`.
#'
#' @keywords areas, plot, histogram
#'
#' @export
#'
#' @details Areas are drawn using [graphics::polygon()] and users can take
#' advantage of it to customize their stacked areas (using `lwd`, `lty` or
#' `border` arguments).
#'
#' @note
#' The default colors have been inspired by four palettes found on line:
#' <http:www.color-hex.com/color-palettes/>. [plotrix::stackpoly()] function
#' from the `plotrix` package offers a good alternative.
#'
#' Using a stacked areas chart with more than 20 areas should provide a figure
#' really hard to read.
#'
#' @examples
#' # data for 8 populations at 25 different periods.
#' x <- data.frame(matrix(runif(200,2,10), 8, 25))
#'
#' # plot 1: default plot
#' stackedAreas(x)
#'
#' # plot 2: personalized plot
#' graphics::par(xaxs = 'i', yaxs = 'i', font = 2, cex.axis = 1.2,
#' cex.lab = 1.4, bty = 'l')
#' graphics::plot.default(c(1999, 2027), c(-10, 110), type = 'n',
#' xlab = 'Years', ylab = 'Percentage',
#' main = 'My customized stacked areas chart')
#' plotAreaColor(col = '#f2c4c4')
#' stackedAreas(x, index = 2001:2025, rgy = 100, lwd = 2, add = TRUE,
#' border = 'transparent')

stackedAreas <- function(val, index = NULL, rgy = 1, cumul = FALSE,
    transp = FALSE, legend = NULL, add = FALSE, col = NULL,
    pickcolors = FALSE, lty = 1, lwd = 1, border = NA, main = "",
    xlab = "", ylab = "") {
    ## checking values / converting if required
        stopifnot(ncol(x) > 1)
    x <- as.matrix(val)
    if (sum(x < 0))
        stop("x must be positive")
    if (transp) x <- t(x)
    #
    if (is.null(index)) index <- seq_len(ncol(x))
    vecol <- colSums(x)
    if (sum(vecol != rep(1, ncol(x))) > 0)
        x <- t(t(x)/vecol)
    if (nrow(x) > 1) {
        if (!cumul)
          for (i in seq(2, nrow(x))) x[i, ] <- x[i - 1, ] + x[i, ]
    }
    ## ---- Colors
    if (pickcolors) {
        colors <- pickColors()
    } else {
        if (is.null(col)) {
            d1dark <- c("#05695e", "#710c25", "#82480c", "#69820c", "#0b7687")
            d1light <- c("#38bfaf", "#e23d4f", "#e2913d", "#bfe23d", "#3dcce2")
            bigfail <- c("#e1b54d", "#bd5f2c", "#722121", "#0c505a", "#101029")
            cbacwine <- c("#c7a34b", "#966426", "#7a4a0f", "#541726", "#420518")
            colors <- rep(c(d1light, bigfail, d1dark, cbacwine), length.out = nrow(x))
        } else colors <- rep(col, length.out = nrow(x))
    }
    ## ---- Defaults plotting set
    if (!add) {
        oldpar <- par(no.readonly = TRUE)
        layout(matrix(1:2, 1), widths = c(1, 0.4))
        par(mar = c(5, 4, 4, 1), xaxs = "i", yaxs = "i")
        plot.default(range(index), rgy * c(0, 1), type = "n", main = main,
            xlab = xlab, ylab = ylab)
    }
    ## ---- Stacked areas
    cx <- c(index, rev(index))
    polygon(cx, rgy * c(rep(1, ncol(x)), 1 - rev(x[1, ])), col = colors[1L],
        lty = lty, lwd = lwd, border = border)
    if (nrow(x) > 1)
        polygon(cx, rgy * c(1 - x[nrow(x) - 1, ], rep(0, ncol(x))), col = colors[nrow(x)],
            lty = lty, lwd = lwd, border = border)
    if (nrow(x) > 2) {
        for (i in seq(2, nrow(x) - 1)) {
            cy <- c(1 - x[i - 1, ], rev(1 - x[i, ]))
            polygon(cx, rgy * cy, col = colors[i], lty = lty, lwd = lwd,
                border = border)
        }
    }
    ## ---- Default legend
    if (!add) {
        box(lwd = 1.1)
        par(mar = c(4, 0, 4, 1), xaxs = "i", yaxs = "i")
        if (is.null(legend))
            legend <- paste0("population ", seq_len(nrow(x)))
        plot0(c(0, 1), c(0, 1))
        legend("center", legend, fill = colors, bty = "n", cex = 1.2,
          border = NA)
        par(oldpar)
    }
    ##
    invisible(NULL)
}

#' Polar Plot
#'
#' Draw a polar plot.
#'
#' @export
#'
#' @param seqtime sequence of time values (equivalent to the x axis).
#' @param seqval sequence of values of interest (radial axis, equivalent to the y axis).
#' @param rad radius of the circle.
#' @param from starting point of the circle.
#' @param to ending point of the circle.
#' @param incr increment used to draw the circle.
#' @param atc the points at which tick-marks are to be drawn. By default (when \code{NULL}) tickmark locations are computed.
#' @param labelc character or expression vector of labels to be placed at the tickpoints.
#' @param atr the points at which radial-axis marks are to be drawn.
#' @param tckcol color of the tickmarks.
#' @param labelr character or expression vector specifying the _text_ to be placed at the radial-axis marks.
#' @param clockwise logical. If TRUE, the plot must de read clockwise, otherwise, counter-clockwise.
#' @param n_signif number of significant numbers to be displayed (used when labelc is \code{NULL}).
#' @param add logical. add to current plot?
#' @param ... additional argument to be passed to \code{polygon} function.
#'
#' @details
#' Polar Plot
#'
#' @seealso \code{\link[plotrix]{polar.plot}}
#'
#' @examples
#' polarPlot(1:40, stats::runif(40), to=1.9*pi, col='grey30', border='grey80')


polarPlot <- function(seqtime, seqval = NULL, rad = 1, from = 0, to = 2 * pi, incr = 0.005, 
    labelc = NULL, tckcol = 1, atc = NULL, labelr = NULL, atr = NULL, clockwise = TRUE, 
    n_signif = 2, add = FALSE, ...) {
    
    ## --- format checking
    seqtime <- as.matrix(seqtime)
    if (ncol(seqtime) > 1L) {
        seqval <- seqtime[, -1L]
        seqtime <- seqtime[, 1L]
    } else seqval <- as.matrix(seqval)
    stopifnot(length(seqtime) == length(seqval[]))
    if (from > to) 
        stop("Error : from>to, to use counter-clockwise direction, use 'clockwise' argument !")
    if (to > 2 * pi) 
        warning("to>2*pi, it can generate unexpected outputs !", call = FALSE)
    
    ## --- to polar coordinates
    rgtime <- range(seqtime)
    rgval <- prettyRange(seqval)
    lgv <- floor(log(rgval[2] - rgval[1]))
    ## 
    seqtp <- -0.5 * pi + from + (to - from) * (seqtime - rgtime[1L])/(rgtime[2L] - 
        rgtime[1L])
    if (clockwise) 
        seqtp <- 2 * from - seqtp
    seqvp <- rad * (seqval - rgval[1L])/(rgval[2L] - rgval[1L])
    
    ## --- plot
    if (!add) {
        par(mar = c(1, 1, 1, 1))
        plot.new()
        plot.window(1.2 * c(-1, 1), 1.2 * c(-1, 1), asp = 1)
    }
    
    ## --- circles
    for (i in rad/5 * seq_len(5 - 1)) circle(0, 0, rad * i, col = NA, lwd = 0.5 + 
        0.5 * i, lty = 2)
    circle(0, 0, rad, lwd = 1, col = NA)
    points(0, 0, pch = 20, col = "grey45")
    
    ## --- Lines
    polygon(c(0, seqvp * cos(seqtp), 0), c(0, seqvp * sin(seqtp), 0), ...)
    
    ## --- Points at start and end
    points(seqvp[1L] * cos(seqtp[1L]), seqvp[1L] * sin(seqtp[1L]), pch = 19, cex = 1.2)
    lv <- length(seqval)
    points(seqvp[lv] * cos(seqtp[lv]), seqvp[lv] * sin(seqtp[lv]), pch = 20)
    
    ## --- Values labels
    if (is.null(labelr)) 
        labelr <- round(seq(rgval[1], rgval[2], length.out = 6), digits = -lgv + 
            2)
    if (!is.na(labelr) && nzchar(labelr)) {
        text(rep(0, 6), -0.2 * 0:5, as.graphicsAnnot(labelr), cex = 1.1, pos = 3)
    }
    
    ## --- Circular ticks
    mangle <- -0.5 * pi + from + (0:6)/6 * (to - from)
    if (clockwise) 
        mangle <- 2 * from - mangle
    segments(cos(mangle), sin(mangle), 1.05 * cos(mangle), 1.05 * sin(mangle))
    
    ## --- Circular values
    if (is.null(labelc)) 
        labelc <- as.graphicsAnnot(signif(seq(rgtime[1], rgtime[2], length.out = 7), 
            n_signif)) else labelc <- as.graphicsAnnot(labelc)
    if (!is.na(labelc) && nzchar(labelc)) {
        if (mangle[1]%%(2 * pi) == mangle[length(mangle)]%%(2 * pi)) {
            mg1 <- mangle[1]
            mgl <- mangle[length(mangle)]
            text(1.15 * cos(mg1), 1.15 * sin(mg1), labelc[1], pos = 4, cex = 1.15, 
                col = tckcol)
            text(1.15 * cos(mgl), 1.15 * sin(mgl), labelc[length(labelc)], pos = 2, 
                cex = 1.15, col = tckcol)
            mangle <- mangle[-c(1L, length(mangle))]
            labelc <- labelc[-c(1L, length(labelc))]
        }
        text(1.15 * cos(mangle), 1.15 * sin(mangle), labelc, cex = 1.15, col = tckcol)
    }
    
}

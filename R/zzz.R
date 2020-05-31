#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful functions to create graphics based plots.
#' @import Rcpp
#' @importFrom Rcpp evalCpp
#' @importFrom graphics abline axis axTicks box grid image
#' @importFrom graphics layout layout.show lines lines.default locator par plot
#' @importFrom graphics plot.default plot.new plot.window points polygon text
#' @importFrom graphics text.default segments rect rasterImage
#' @importFrom graphics strheight strwidth
#' @importFrom grDevices as.graphicsAnnot as.raster col2rgb colorRampPalette
#' @importFrom grDevices dev.off palette rgb xy.coords
#' @importFrom stats aggregate as.formula quantile runif rnorm
#' @useDynLib graphicsutils

NULL

.onLoad <- function(libname, pkgname) utils::packageVersion("graphicsutils")



# Functions exposed in inSilecoMisc
scaleWithin <- function(x, n = 100, mn = min(x), mx = max(x)) {
    stopifnot(mn < mx)
    stopifnot(n > 1)
    ##
    out <- 1 + floor(n * (x - mn)/(mx - mn))
    out[out < 1] <- 1
    out[out > n] <- n
    out
}


seqRg <- function(x, n, offset = 0, prop = TRUE) {
  rg <- range(x)
  if (prop) offset <- offset*diff(rg)
  seq(rg[1L] - offset, rg[2L] + offset, length.out = n)
}


#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful functions to create graphics based plots.
#' @import Rcpp
#' @importFrom Rcpp evalCpp
#' @importFrom graphics par lines points lines.default rect plot.new
#' @importFrom graphics plot axis strwidth plot.window polygon locator
#' @importFrom graphics layout layout.show text grid text.default segments
#' @importFrom graphics plot.default strheight rasterImage image box abline
#' @importFrom grDevices colorRampPalette rgb col2rgb as.graphicsAnnot palette
#' @importFrom grDevices xy.coords dev.off
#' @importFrom stats aggregate quantile runif rnorm as.formula
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


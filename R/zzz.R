#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful functions to create graphics based plots.
#' @import Rcpp
#' @importFrom Rcpp evalCpp
#' @importFrom graphics par lines points lines.default rect plot.new
#' @importFrom graphics plot axis strwidth plot.window polygon locator
#' @importFrom graphics layout layout.show text grid text.default
#' @importFrom graphics plot.default strheight rasterImage image box abline
#' @importFrom grDevices colorRampPalette rgb col2rgb as.graphicsAnnot palette
#' @importFrom grDevices xy.coords dev.off
#' @importFrom stats aggregate quantile runif rnorm as.formula
#' @useDynLib graphicsutils
NULL

.onLoad <- function(libname, pkgname) utils::packageVersion("graphicsutils")

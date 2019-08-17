#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful functions to create graphics based plots.
#' @import Rcpp
#' @importFrom Rcpp evalCpp
#' @importFrom graphics par lines points layout text lines.default rect plot.new
#' @importFrom graphics plot axis strwidth plot.window
#' @importFrom grDevices colorRampPalette rgb col2rgb
#' @importFrom stats aggregate quantile runif rnorm
#' @useDynLib graphicsutils
NULL

.onLoad <- function(libname, pkgname) utils::packageVersion("graphicsutils")

# .onAttach <- function(libname, pkgname) { packageStartupMessage(paste0(' -->
# graphicsutils version ', utils::packageVersion('graphicsutils'))) }

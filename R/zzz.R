#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful functions to create graphics based plots.
#' @import Rcpp
#' @importFrom Rcpp evalCpp
#' @useDynLib graphicsutils
NULL

.onLoad <- function(libname, pkgname) utils::packageVersion("graphicsutils")

# .onAttach <- function(libname, pkgname) { packageStartupMessage(paste0(' -->
# graphicsutils version ', utils::packageVersion('graphicsutils'))) }

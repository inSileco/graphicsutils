#' graphicsutils
#'
#' @name graphicsutils
#' @docType package
#' @description A collection of (hopefully) useful function to creat graphics
NULL

# .onLoad <- function(libname, pkgname) { invisible() }

.onAttach <- function(libname, pkgname) {
    packageStartupMessage(paste0(" --> graphicsutils version ", utils::packageVersion("graphicsutils")))
}

#' Complete list of graphisutils' color palettes
#'
#' Color palettes of the graphisutils package.
#'
#' @export

gpuPalettes <- list(atom = c("#dedcd5", "#991f16", "#3b9b6d", "#584b4f", "#72acab", 
    "#ca8c81"), cisl = c("#c7cbce", "#96a3a3", "#687677", "#222d3d", "#25364a", "#c77f20", 
    "#e69831", "#e3af16", "#e4be29", "#f2ea8b"), github = c("#232323", "#d73a49", 
    "#22863a", "#032f62", "#005cc5", "#6f42c1", "#e36209", "#6a737d"), google = c("#fc002e", 
    "#00b852", "#4c67f7", "#ffc100", "#ff2163", "#737373"), google2 = c("#ed003b", 
    "#00b160", "#5078c5", "#fce733", "#c1c1c1"), insileco = c("#212121", "#3fb3b2", 
    "#ffdd55", "#c7254e", "#1b95e0", "#8555b4", "#757575"), slack = c("#2ea664", 
    "#2d9ee0", "#d72b3f", "#4d394b", "#005e99", "#f26130", "#ff9000", "#eb959f", 
    "#a0a0a2", "#0576b9"))


#' graphicsutils colors palette
#'
#' A couple of color palettes mainly insipered by popular websites.
#'
#' @param names names of desired color palettes; if \code{NULL}, color palettes available are printed.
#'
#' @return A vector of character strings of the hexadecimal colors values.
#' @export
#' @keywords colors, palette
#' @examples
#' showPalette(gpuPalette(c('atom', 'cisl')))

gpuPalette <- function(names = NULL) {
    tmp <- names(gpuPalettes)
    if (is.null(names)) 
        message(paste0("Color palettes available are: \n  ", paste(tmp, collapse = ", "))) else stopifnot(all(names %in% names(gpuPalettes)))
    unlist(gpuPalettes[names])
}

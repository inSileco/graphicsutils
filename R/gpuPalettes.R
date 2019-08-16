#' Complete list of graphicsutils' color palettes
#'
#' Color palettes of the graphicsutils package.
#'
#' @export

gpuPalettes <- list(
  atom = c("#dedcd5", "#991f16", "#3b9b6d", "#584b4f", "#72acab",
    "#ca8c81"),
  cisl = c("#c7cbce", "#96a3a3", "#687677", "#222d3d", "#25364a", "#c77f20",
    "#e69831", "#e3af16", "#e4be29", "#f2ea8b"),
  github = c("#232323", "#d73a49", "#22863a", "#032f62", "#005cc5", "#6f42c1",
  "#e36209", "#6a737d"),
  google = c("#fc002e", "#00b852", "#4c67f7", "#ffc100", "#ff2163", "#737373"),
  google2 = c("#ed003b", "#00b160", "#5078c5", "#fce733", "#c1c1c1"),
  insileco = c("#212121", "#3fb3b2","#ffdd55", "#c7254e", "#1b95e0", "#8555b4",
  "#757575"),
  slack = c("#2ea664",
    "#2d9ee0", "#d72b3f", "#4d394b", "#005e99", "#f26130", "#ff9000", "#eb959f",
    "#a0a0a2", "#0576b9")
  )


#' graphicsutils colors palettes
#'
#' A couple of color palettes including our inSileco palette and a couple
#' of other inspired by popular websites.
#'
#' @param id either an integer or a character string matching the names of
#' the desired color palette(s). If missing then color palettes available are
#' prompted.
#' @param ncolors An integer giving the number of colors to be returned. If
#' greater than the number of colors included in the selection, then
#' '[grDevices::colorRampPalette()] is called to expand the palette.
#' If missing, then the entire palette is returned.
#'
#' @return A vector of character strings of the hexadecimal colors values.
#' Note that if several color palette is requested, then the output is a vector
#' with all color palette concatenated.
#'
#' @export
#' @keywords colors, palette
#' @examples
#' showPalette(gpuPalette(c('atom', 'cisl')))
#' showPalette(gpuPalette('cisl', 100))

gpuPalette <- function(id, ncolors) {
    tmp <- names(gpuPalettes)
    if (missing(id)) {
        message(
          "Color palettes currently available are: \n  ",
          paste(tmp, collapse = ", ")
        )
        return(invisible(NULL))
    } else {
        if (is.character(id)) {
          stopifnot(all(id %in% names(gpuPalettes)))
        }
        out <- unlist(gpuPalettes[id])
        if (!missing(ncolors)) {
          if (ncolors > length(out)) {
            colorRampPalette(out)(ncolors)
          } else colorRampPalette(out)(ncolors)
        }  else out
    }
}

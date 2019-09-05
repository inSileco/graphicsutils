#' Blend colors
#'
#' Blend a set of colors and return the color thereby obtained.
#'
#' @param cols set of colors to be mixed.
#'
#' @export
#'
#' @examples
#' blendColors(c("blue", "purple"))

blendColors <- function(cols) {
    tmp <- apply(col2rgb(cols), 1, mean)
    rgb(tmp[1L], tmp[2L], tmp[3L], maxColorValue = 255)
}

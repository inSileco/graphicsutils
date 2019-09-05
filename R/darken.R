#' Lighten or darken colors
#'
#' Returns lightened or darkened colors, vectorised over `percentage`.
#' `ramp` is valid for any couple of colors. Functions `darken()` and
#' `lighten()` call `ramp` to respectively darken and lighten a given color.
#'
#' @param fromcol starting color, i.e. if \code{percentage = 0}, it is the color returned.
#' @param tocol color to nuance `fromcol`, i.e. if \code{percentage = 100}, it is the color returned.
#' @param percentage percentage determining the percentage of `tocol` used to nuance `fromcol`. Note that `darken` and `lighten` support negative percentage.
#' @param col the color to be darkened or lightened.
#' @param as_rgb a logical. Should the color(s) returned as a matrix object?
#'
#' @export
#' @seealso \code{\link{colorRampPalette}}
#' @examples
#' showPalette(ramp("blue", "red", 10*3:7))
#' darken('red', 50)
#' more_reds <- lighten('red', seq(10,90,9))
#' showPalette(more_reds)

#' @describeIn darken Returns a shaded color.
ramp <- function(fromcol, tocol, percentage = 50, as_rgb = FALSE) {
    perc <- as.integer(percentage)
    stopifnot(percentage <= 100 & percentage >= 0)
    outcol <- colorRampPalette(c(fromcol, tocol))(101)[perc + 1]
    if (as_rgb) col2rgb(outcol) else outcol
}

#' @describeIn darken Darken a color.
#' @export
darken <- function(col, percentage = 50, as_rgb = FALSE) {
    if (length(percentage) > 1) {
      do.call(cbind, lapply(percentage, darken, col = col, as_rgb = as_rgb))
    } else {
      if (all(percentage < 0)) {
        lighten(col, -percentage, as_rgb)
      } else ramp(col, "black", percentage = percentage,
        as_rgb = as_rgb)
    }
}

#' @describeIn darken Lighten a color.
#' @export
lighten <- function(col, percentage = 50, as_rgb = FALSE) {
    if (length(percentage) > 1) {
      do.call(cbind, lapply(percentage, lighten, col = col, as_rgb = as_rgb))
    }
    if (percentage < 0) {
      darken(col, -percentage, as_rgb)
    } else  ramp(col, "white", percentage = percentage, as_rgb = as_rgb)
}

#' Lighten or darken colors
#'
#' Returns lightened or darkened colors, vetorized over \code{percentage}.
#' \code{ramp} is valid for any couple of colors. Functions \code{darken} and
#' \code{lightened} actually call \code{ramp} to darken and lighten a given color.
#'
#' @param fromcol starting color, i.e. if \code{percentage = 0}, it is the color returned.
#' @param tocol color to nuance \code{fromcol}, i.e. if \code{percentage = 100}, it is the color returned.
#' @param percentage percentage determining the percentage of \code{tocol} used to nuance \code{fromcol}.
#' @param col the color to be darkened or lightened.
#' @param as_rgb a logical. Should the color(s) returned as a matrix object?
#'
#' @export
#' @seealso \code{\link{colorRampPalette}}
#' @examples
#' darken('red', 50)
#' more_reds <- lighten('red', seq(10,90,9))
#' showPalette(more_reds)

#' @describeIn darken Retuns a shaded color.
ramp <- function(fromcol, tocol, percentage = 50, as_rgb = FALSE) {
    perc <- as.integer(percentage)
    outcol <- (grDevices::colorRampPalette(c(fromcol, tocol)))(100)[perc]
    if (as_rgb) 
        outcol <- grDevices::col2rgb(outcol)
    return(outcol)
}

#' @describeIn darken Returns a darkened color.
#' @export
darken <- function(col, percentage = 50, as_rgb = FALSE) {
    outcol <- ramp(fromcol = col, tocol = "black", percentage = percentage, as_rgb = as_rgb)
    return(outcol)
}

#' @describeIn darken Returns a lightened color.
#' @export
lighten <- function(col, percentage = 50, as_rgb = FALSE) {
    outcol <- ramp(col, "white", percentage = percentage, as_rgb = as_rgb)
    return(outcol)
}

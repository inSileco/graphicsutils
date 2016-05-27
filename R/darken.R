#' Lightened or darkened colors
#'
#' Return lightened or darkened colors, vetorized over \code{percentage}.
#' \code{ramp} is the general function any couple of colors. \code{darken} and
#' \code{lightened} calls \code{ramp} to darken and lighten a given color.
#'
#' @param fromcol The starting color.  color to be changed.
#' @param tocol The color towards which the 'fromcolor' will be nuanced.
#' @param percentage percentage determining to what extent the color .
#' @param col the color to be darkened or lightened.
#' @param as_rgb A logical indicating wheteher color must be returned as a matrix object.
#'
#' @export
#' @seealso \code{\link{colorRampPalette}}
#' @examples
#' darken('red', 50)
#' somereds <- lighten('red', seq(10,90,9))
#' showPalette(somereds)

#' @describeIn darken A color standing between two given hues.
ramp <- function(fromcol, tocol, percentage = 50, as_rgb = FALSE) {
    perc <- as.integer(percentage)
    outcol <- colorRampPalette(c(fromcol, tocol))(100)[perc]
    if (as_rgb) 
        outcol <- col2rgb(outcol)
    return(outcol)
}

#' @describeIn darken A darkened color.
#' @export
darken <- function(col, percentage = 50, as_rgb = FALSE) {
    outcol <- ramp(fromcol = col, tocol = "black", percentage = percentage, as_rgb = as_rgb)
    return(outcol)
}

#' @describeIn darken A lightened color.
#' @export
lighten <- function(col, percentage = 50, as_rgb = FALSE) {
    outcol <- ramp(col, "white", percentage = percentage, as_rgb = as_rgb)
    return(outcol)
}

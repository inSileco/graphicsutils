#' Contrast colors.
#'
#' For a given set of colors, \code{contrastColors} returns an associated set
#' of colors.
#'
#' @param colors vector of any of the three kinds of R color specifications, see \code{\link[grDevices]{col2rgb}}.
#' @param how a method to contrast \code{colors}. Methods currently available are \code{how_borw}, \code{how_cent}, \code{how_oppo} and \code{how_prop}, see details.
#' @param alpha logical value indicating whether the alpha channel (opacity) values should be returned.
#'
#' @keywords colors, contrast
#'
#' @details
#' Based on the sum of colors' saturation \code{how_borw} returns black or white,
#' \code{how_prop} proportially remove or add some saturation. \code{how_oppo}
#' opposes the color (255-x) and \code{how_cent} centers the columns, i.e. remove
#' or add 127.
#'
#' @seealso
#' \link[grDevices]{col2rgb}
#'
#' @importFrom grDevices col2rgb
#' @importFrom magrittr %>% 
#' @export
#'
#' @examples
#' #Example 1:
#' contrastColors('blue')
#' contrastColors('blue', how = 'how_prop')


#' @describeIn contrastColors Retuns a set of colors contrasted.
contrastColors <- function(colors, how = "how_borw", alpha = FALSE) {
    out <- colors %>% col2rgb(alpha = alpha) %>% apply(2L, how) %>% apply(2L, intToHex)
    paste0("#", out)
}

#' @describeIn contrastColors Retuns the hexadecimal string associates to a given vector of colors.
col2Hex <- function(colors, alpha = FALSE) {
    out <- colors %>% col2rgb(alpha = alpha) %>% apply(2L, intToHex)
    paste0("#", out)
}

how_borw <- function(x) {
    out <- x
    if (sum(x[1L:3L]) > 382) 
        out[1L:3L] <- 0 else out[1L:3L] <- 255
    out
}

how_cent <- function(x) {
    out <- x
    out[1L:3L] <- x[1L:3L] + c(127, -127)[(x[1L:3L] > 127) + 1]
    out
}

how_oppo <- function(x) {
    out <- x
    out[1L:3L] <- 255 - x[1L:3L]
    out
}

how_prop <- function(x) {
    out <- x
    n <- 382
    tmp <- sum(x[1L:3L])
    if (tmp > n) {
        out[1L:3L] <- x[1L:3L] - floor(n * x[1L:3L]/tmp)
    } else {
        out[1L:3L] <- x[1L:3L] + floor(n * (255 - x[1L:3L])/(765 - tmp))
    }
    out
}



intToHex <- function(x) {
    vec <- c(0:9, letters[1L:6L])
    stopifnot(x < 256)
    paste0(vec[(x%/%16) + 1], vec[(x%%16) + 1], collapse = "")
}

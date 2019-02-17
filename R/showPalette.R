#' Displays a color palette
#'
#' Displays a color palette and information about the colors it is made of.
#'
#' @param x a vector of colors.
#' @param inline a logical. If `TRUE`, the colors are displayed on a single row.
#' @param add_number a logical. If `TRUE`, color vector's indices are added (default is set to `FALSE`).
#' @param add_codecolor a logical. If `TRUE`, the code color is displayed (default is set to `FALSE`).
#' @param cex_num the magnification coefficient of the color vector's indices.
#'
#' @keywords color, selection
#'
#' @return The color palette displayed as an invisible output.
#'
#' @export
#'
#' @examples
#' showPalette()
#' showPalette(inline=TRUE)
#' showPalette(1)
#' showPalette(sample(1:100, 16), add_number = TRUE, add_codecolor = TRUE)

showPalette <- function(x = grDevices::palette(), inline = FALSE,
    add_number = FALSE, add_codecolor = FALSE, cex_num = 1.2) {

    opar <- graphics::par(no.readonly = TRUE)
    on.exit(graphics::par(opar))
    ##--
    nb_x <- length(x)
    ##
    if (is.numeric(x)) {
        tmp <- grDevices::palette()
        x <- tmp[((x - 1)%%length(tmp)) + 1]
    }
    ##
    if (class(x) != "matrix")
        x <- grDevices::col2rgb(x)
    ramp <- apply(x, 2, function(x) grDevices::rgb(x[1L], x[2L], x[3L], maxColorValue = 255))
    dark <- (apply(x, 2, sum) > 196) + 1
    ## -- compute the number of column and rows
    nb_row <- nb_x
    nb_col <- 1L
    if (!inline) {
        tmp <- howManyRC(nb_x)
        nb_row <- tmp[1L]
        nb_col <- tmp[2L]
    }
    ##-- remove margins
    graphics::par(mfrow = c(nb_row, nb_col), mar = rep(0, 4L))

    for (i in 1:nb_x) {
        plot0(fill = ramp[i])
        txt <- ""
        if (add_number) txt <- paste0(txt, i, ": ")
        if (add_codecolor)  txt <- paste0(txt, ramp[i])
        graphics::text(0, 0, txt, cex = cex_num, col = c("white", "black")[dark[i]])
        box2(col = "white")
    }

    invisible(ramp)
}

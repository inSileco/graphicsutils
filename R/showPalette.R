#' Show a color palette
#'
#' Displays a color palette.
#'
#' @param x A vector of colors.
#' @param inline A logical. If TRUE, the colors are displayed on a single row.
#' @param add_number A logical. If TRUE, color vector's indices are added (default is set to FALSE).
#' @param add_codecolor A logical. If TRUE, the code color is displayed (default is set to FALSE).
#' @param cex_num The maginification coefficient of the color vector's indices.
#'
#' @keywords color, selection
#'
#' @importFrom magrittr %<>%
#'
#' @export
#'
#'
#' @examples
#' showPalette()
#' showPalette(inline=TRUE)
#' showPalette(sample(1:100, 16), add_number=TRUE, add_codecolor = TRUE)

showPalette <- function(x = grDevices::palette(), inline = FALSE, add_number = FALSE, 
    add_codecolor = FALSE, cex_num = 1.2) {
    
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
    x %<>% grDevices::col2rgb()
    ramp <- apply(x, 2, function(x) grDevices::rgb(x[1L], x[2L], x[3L], maxColorValue = 255))
    ## -- compute the number of column and rows
    nb_row <- 1L
    nb_col <- nb_x
    if (!inline) {
        sqr <- sqrt(nb_x)
        fsq <- floor(sqr)
        nb_row <- nb_col <- fsq
        if (sqr - fsq != 0) 
            nb_row <- fsq + 1
        if (nb_x - nb_row * nb_col > 0) 
            nb_col <- fsq + 1
    }
    ##-- remove margins
    graphics::par(mfrow = c(nb_row, nb_col), mar = rep(0, 4L))
    
    for (i in 1:nb_x) {
        plot0(fill = ramp[i])
        txt <- ""
        if (add_number) {
            txt %<>% paste0(i)
            if (add_codecolor) 
                txt %<>% paste0(":  ", ramp[i])
        } else {
            if (add_codecolor) 
                txt %<>% paste0(ramp[i])
        }
        graphics::text(0, 0, txt, cex = cex_num, pos = 3L)
        graphics::text(0, 0, txt, cex = cex_num, pos = 1L, col = "white")
    }
    
    invisible(ramp)
}

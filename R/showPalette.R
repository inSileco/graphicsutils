#' Show a color palette
#'
#' Displays a color palette.
#'
#' @param x A vector of colors.
#' @param inline A logical. If \code{TRUE}, the colors are displayed on a single row.
#' @param add_number A logical. If \code{TRUE}, color vector's indices are added (default is set to FALSE).
#' @param add_codecolor A logical. If \code{TRUE}, the code color is displayed (default is set to FALSE).
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
#' showPalette(1)
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
        if (add_number) {
            txt %<>% paste0(i)
            if (add_codecolor) 
                txt %<>% paste0(":  ", ramp[i])
        } else {
            if (add_codecolor) 
                txt %<>% paste0(ramp[i])
        }
        graphics::text(0, 0, txt, cex = cex_num, col = c("white", "black")[dark[i]])
        box2(col = "white")
    }
    
    invisible(ramp)
}

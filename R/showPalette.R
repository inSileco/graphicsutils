#' Displays a color palette
#'
#' Displays a color palette and color details.
#'
#' @param x a vector of colors.
#' @param inline a logical. If `TRUE`, the colors are displayed on a single 
#' row.
#' @param add_number a logical. If `TRUE`, color vector's indices are added.
#' @param add_codecolor a logical. If `TRUE`, the code color is displayed.
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
#' showPalette(inline = TRUE)
#' showPalette(1)
#' showPalette(sample(1:100, 16), add_number = FALSE, add_codecolor = FALSE)

showPalette <- function(x = palette(), inline = FALSE, add_number = TRUE,
  add_codecolor = TRUE, cex_num = 1.2) {

    ##--
    nb_x <- length(x)
    ##
    if (is.numeric(x)) {
        tmp <- palette()
        x <- tmp[((x - 1) %% length(tmp)) + 1]
    }
    ##
    if (!inherits(x, "matrix")) x <- col2rgb(x)
    ramp <- apply(x, 2, function(x) rgb(x[1L], x[2L], x[3L],
      maxColorValue = 255))
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
    par(mfrow = c(nb_row, nb_col), mar = rep(0, 4L))

    for (i in seq_len(nb_x)) {
        plot0(fill = ramp[i])
        if (add_number) {
            if (add_codecolor) {
                txt <- paste0(i, ": ", ramp[i])
            } else {
                txt <- paste0(i)
            }
        } else {
            if (add_codecolor) txt <- paste0(ramp[i]) else txt <- ""
        }

        text(0, 0, txt, cex = cex_num, col = c("white", "black")[dark[i]])
        box2(col = "white")
    }

    invisible(ramp)
}

#' Pick colors up
#'
#' Generate an interactive interface to pick a set of colors up.
#'
#' @param n The number of colors to be selected (9 by default).
#' @param ramp A vector of colors used as tone palette.
#' @param nb_shades Number of shades to be displayed once a tone is selected.
#' @param preview logical. If \code{TRUE}, colors are displayed once the selection is done. Default is set to \code{FALSE}.
#'
#' @keywords color palettes, interactive plot
#'
#' @export
#'
#' @return
#' A character vector including the colors selected.
#'
#' @details
#' This function generates a graphical window splitted into 6 panels. The top panel serves to select one tone.
#' The panel right below present \code{nb_shades} of the selected tones.
#' The bottom rigth panel presents the selected color that can be stored by clicking on the bottom left panel.
#' The bottom center panel shows the characteristic of the selcted color.
#' Finally, in order to abort, the user can simply clik on the left \code{Stop} panel.


pickColors <- function(n = 9, ramp = grDevices::rainbow(1024), nb_shades = 512, preview = FALSE) {
    
    old.par <- graphics::par(no.readonly = TRUE)
    ## ---
    nb_ramp <- length(ramp)
    slccolor <- 0
    col_ini <- ramp[floor(nb_ramp * 0.5) + 1]
    shades <- (grDevices::colorRamp(c("white", col_ini, "black")))(nb_shades)
    col_foc <- shades[floor(nb_shades * 0.5) + 1]
    ## ---
    
    ## ---
    i <- 0
    while (i == 0) {
        shades <- (grDevices::colorRamp(c("white", col_ini, "black")))(nb_shades)
        drawSelector(ramp, col_ini, col_foc, shades, nb_shades, nb_ramp)
        loc <- graphics::locator(1L)
        ## --
        if (loc$y > 0.6) {
            if (loc$y > 0.8) {
                col_ini <- ramp[floor(nb_ramp * loc$x) + 1]
                shades <- (grDevices::colorRamp(c("white", col_ini, "black")))(nb_shades)
                col_foc <- shades[floor(nb_shades * 0.5) + 1]
            } else col_foc <- shades[floor(nb_shades * loc$x) + 1]
        } else {
            if (loc$x < 0.2) {
                if (loc$y > 0.3) {
                  slccolor <- c(slccolor, col_foc)
                  cat("Stored !\n")
                } else i <- 1
            } else {
                cat("Nothing to do !\n")
            }
        }
    }
    ## ---
    graphics::par(old.par)
    grDevices::dev.off()
    ## ---
    slccolor <- slccolor[-1L]
    if (preview) 
        showPalette(slccolor, add_number = TRUE)
    ## ---
    return(slccolor)
}


## _-------------
drawSelector <- function(ramp, col_ini, col_foc, shades, nb_shades, nb_ramp) {
    ##--
    graphics::par(mar = c(0, 0, 0, 0), xaxs = "i", yaxs = "i")
    plot0()
    ##--
    graphics::par(fig = c(0, 1, 0.8, 1), new = TRUE)
    graphics::image(matrix(1L:nb_ramp), col = ramp, axes = FALSE, ann = FALSE)
    graphics::points(rep(which(ramp == col_ini)[1L]/nb_shades, 2), c(0, 0), col = c("white", 
        1), pch = c(19, 20))
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0, 1, 0.6, 0.8), new = TRUE)
    graphics::image(matrix(1:nb_shades), col = shades, axes = FALSE, ann = FALSE)
    graphics::points(rep(which(shades == col_foc)[1L]/nb_shades, 2), c(0, 0), col = c("white", 
        1), pch = c(19, 20))
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0, 0.2, 0.3, 0.6), new = TRUE)
    plot0()
    plotAreaColor()
    graphics::text(0, 0, label = "Keep it", cex = 2)
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0, 0.2, 0, 0.3), new = TRUE)
    plot0()
    plotAreaColor()  #col='grey80')
    graphics::text(0, 0, label = "Stop", cex = 2)
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0.2, 0.5, 0, 0.6), new = TRUE)
    plot0()
    plotAreaColor(col = "grey90")
    graphics::text(0, 0.6, label = (grDevices::colorRamp(col_foc))(1), cex = 2)
    code_rgb <- grDevices::col2rgb(col_foc)
    graphics::text(0, 0.1, label = paste0("Red: ", code_rgb[1L]), cex = 2)
    graphics::text(0, -0.3, label = paste0("Green: ", code_rgb[2L]), cex = 2)
    graphics::text(0, -0.7, label = paste0("Blue: ", code_rgb[3L]), cex = 2)
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0.5, 1, 0, 0.6), new = TRUE)
    plot0()
    plotAreaColor(col = col_foc)
    graphics::box(lwd = 3, col = "white")
    ## --
    graphics::par(fig = c(0, 1, 0, 1), usr = c(0, 1, 0, 1), new = TRUE)
    ##--
    invisible(NULL)
}

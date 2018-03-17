#' Pick colors up
#'
#' Generate an interactive interface to pick a set of colors up.
#'
#' @param n The number of colors to be selected (9 by default).
#' @param ramp A vector of colors used as tone palette.
#' @param nb_shades Number of shades to be displayed once a tone is selected.
#'
#' @keywords color, palette, interactive
#'
#' @importFrom graphics par image points text box abline layout locator
#'
#' @export
#'
#' @return
#' A character vector including the colors selected.
#'
#' @details
#' This function generates a graphical window splitted into 6 panels. The top
#' panel serves to select one tone. The panel right below presents \code{nb_shades}
#' of the selected tones. The bottom rigth panel displays the current selection
#' that can be stored by clicking on the bottom left panel _Keep it_.
#' The bottom center panel shows the characteristic of the selected color.
#' Finally, in order to abort before completing the selection of colors, the
#' user can simply clik on the left _Stop_ panel.


pickColors <- function(n = 9, ramp = grDevices::rainbow(1024), nb_shades = 512) {
    
    opar <- par(no.readonly = TRUE)
    # output
    colSlc <- rep(NA_character_, n)
    # 
    nb_ramp <- length(ramp)
    # initial values
    col_foc <- col_ini <- ramp[floor(nb_ramp * 0.5) + 1]
    # getLayout
    mat <- getMatrix(n)
    tmp <- howManyRC(n)
    # remove margins
    i <- 0
    k <- 0
    while (i == 0 & k < n) {
        # 
        layout(mat, widths = c(1, 2, rep(1/(tmp[2L]), tmp[2L])), heights = c(1, 1, 
            rep(2/tmp[1L], tmp[1L])))
        par(mar = c(0, 0, 0, 0), xaxs = "i", yaxs = "i")
        shades <- (grDevices::colorRampPalette(c("white", col_ini, "black")))(nb_shades)
        drawSelector2(ramp, col_ini, col_foc, shades, nb_shades, nb_ramp, prod(tmp), 
            colSlc)
        # 
        par(new = T, fig = c(0, 1, 0, 1))
        plot0(c(0, 1), c(0, 1))
        loc <- locator(1L)
        # 
        if (loc$y > 0.5) {
            if (loc$y > 0.75) {
                col_ini <- ramp[floor(nb_ramp * loc$x) + 1]
                shades <- (grDevices::colorRampPalette(c("white", col_ini, "black")))(nb_shades)
                col_foc <- shades[floor(nb_shades * 0.5) + 1]
            } else col_foc <- shades[floor(nb_shades * loc$x) + 1]
        } else {
            if (loc$x < 0.25) {
                if (loc$y > 0.25) {
                  k <- k + 1
                  colSlc[k] <- col_foc
                } else {
                  i <- 1
                }
            }
        }
    }
    # 
    par(opar)
    grDevices::dev.off()
    # 
    colSlc[!is.na(colSlc)]
}


getMatrix <- function(n) {
    ##-- rows and columns
    tmp <- howManyRC(n)
    ## 
    mat <- rbind(1, 2, cbind(3, 4, matrix(4 + (1:prod(tmp)), tmp[1L], tmp[2L], byrow = T)))
    ## 
    mat
}

## -------------
drawSelector2 <- function(ramp, col_ini, col_foc, shades, nb_shades, nb_ramp, nbpanels, 
    colSlc) {
    # 
    image(matrix(1L:nb_ramp), col = ramp, axes = FALSE, ann = FALSE)
    points(rep(which(ramp == col_ini)[1L]/nb_ramp, 2), c(0, 0), col = c("white", 
        1), pch = c(19, 20))
    box(lwd = 3, col = "white")
    # 
    image(matrix(1:nb_shades), col = shades, axes = FALSE, ann = FALSE)
    points(rep(which(shades == col_foc)[1L]/nb_shades, 2), c(0, 0), col = c("white", 
        1), pch = c(19, 20))
    box(lwd = 3, col = "white")
    # 
    plot0(fill = "grey80")
    text(0, 0.5, label = "Keep it", cex = 2, col = "grey20")
    abline(h = 0, lwd = 2, col = "white")
    text(0, -0.5, label = "Stop", cex = 2, col = "grey20")
    # 
    plot0(fill = col_foc)
    code_rgb <- grDevices::col2rgb(col_foc)
    print(sum(code_rgb) < 255)
    if (sum(code_rgb) < 255) 
        txt_col <- "grey80" else txt_col <- "grey20"
    text(0, 0.7, label = as.character(col_foc), cex = 2.5, col = txt_col)
    text(0, 0, label = paste0("Red  :", code_rgb[1L]), cex = 2, col = txt_col)
    text(0, -0.3, label = paste0("Green:", code_rgb[2L]), cex = 2, col = txt_col)
    text(0, -0.6, label = paste0("Blue :", code_rgb[3L]), cex = 2, col = txt_col)
    # box(lwd = 3, col = 'white') --
    for (i in 4 + 1:nbpanels) plot0(fill = colSlc[i - 4])
    
    invisible(NULL)
}

#' Add a Grid to a Plot
#'
#' This function adds a grid to an existing plot (like `box()`). User can
#' specify coordinates on x- and/or y-axis where to draw vertical and/or
#' horizontal lines respectively. User can also color the background of the plot
#' area and add a box around this area (if required).
#'
#' @param at_x coordinates on the x-Axis where to draw vertical lines.
#' @param at_y coordinates on the y-Axis where to draw horizontal lines.
#' @param col the color of the background.
#' @param border the color of lines (and box).
#' @param lwd the width of lines (see `par()`).
#' @param lty the type of lines (see `par()`).
#' @param box a boolean. If `TRUE` add a box around the plot area.
#' @param ... other graphical parameters as in `par()`.
#'
#' @details
#' If user does not specify `at_x` and `at_y`, the grid is aligned with the tick
#' marks on the corresponding default axes (computed by `axTicks`).
#'
#' @export
#'
#' @keywords box, grid, background
#'
#' @author Nicolas CASAJUS, \email{nicolas.casajus@@gmail.com}
#'
#' @examples
#' maps::map()
#' addGrid()
#' addGrid(box = TRUE)
#' addGrid(col = "#ff000044", border = "green", box = TRUE)
#'
#' maps::map()
#' addGrid(at_x = axTicks(1), border = "blue", lwd = 2)
#' addGrid(at_y = axTicks(2), border = "red")
#' addGrid(at_x = NULL, at_y = NULL, lwd = 3, box = TRUE)


addGrid <- function(at_x, at_y, col = NA, border = "black", lwd = 1, lty = 1,
                    box = FALSE, ...) {

  opar <- par(no.readonly = TRUE)
  on.exit(par(opar, no.readonly = TRUE))

  par(...)

  if (missing(at_x) && missing(at_y)) {

    at_x <- axTicks(side = 1)
    at_y <- axTicks(side = 2)

  } else {

    if (missing(at_x)) at_x <- NULL
    if (missing(at_y)) at_y <- NULL
  }

  if (!is.null(at_x)) {

    at_x <- sort(unique(at_x[at_x > par()$usr[1] & at_x < par()$usr[2]]))

    if (!length(at_x)) stop("x-Axis graduations are ouside plot range.")
  }

  if (!is.null(at_y)) {

    at_y <- sort(unique(at_y[at_y > par()$usr[3] & at_y < par()$usr[4]]))

    if (!length(at_y)) stop("y-Axis graduations are ouside plot range.")
  }

  par(xpd = TRUE)

  if (box) {

    rect(par()$usr[1], par()$usr[3], par()$usr[2], par()$usr[4],
         col = col, border = border, lwd = lwd, lty = lty)

  } else {

    rect(par()$usr[1], par()$usr[3], par()$usr[2], par()$usr[4],
         col = col, border = NA, lwd = lwd, lty = lty)
  }

  if (!is.null(at_x)) {

    for (at in at_x) {

      lines(
        x   = rep(at, 2),
        y   = c(par()$usr[3], par()$usr[4]),
        col = border,
        lwd = lwd,
        lty = lty
      )
    }
  }

  if (!is.null(at_y)) {

    for (at in at_y) {

      lines(
        x   = c(par()$usr[1], par()$usr[2]),
        y   = rep(at, 2),
        col = border,
        lwd = lwd,
        lty = lty
      )
    }
  }

  invisible(NULL)
}

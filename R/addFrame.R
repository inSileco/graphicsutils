#' Add a Checkerboard-Like Frame around a Plot
#'
#' This function adds a checkerboard-like frame around an existing plot (or a
#' new one) as an ensemble of small rectangles whose colors, position and width
#' can be specified by user.
#'
#' @param at_x positions on the x-Axis of the borders of rectangles.
#' @param at_y positions on the y-Axis of the borders of rectangles.
#' @param col one or several colors of rectangles background.
#' @param border color of rectangles border.
#' @param width width of the frame.
#' @param lwd thickness of rectangles border (and grid).
#' @param lty type of rectangles border lines (and grid).
#' @param asp aspect ratio of the plot (see `plot.window()`).
#' @param grid a boolean. If `TRUE` adds vertical and horizontal lines at `at_x`
#'             and `at_y`.
#' @param add a boolean. If `TRUE` adds the frame to an existing plot.
#' @param ... other graphical parameters as in `par()`.
#'
#' @details
#' If `add = FALSE`, a new plot is drawn with `xlim = ylim = c(-1, 1)`. Argument
#' `col` can be set with one or multiple colors. If only one color is specified
#' in `col`, border color will be used to draw the checkerboard. If `width` is
#' `NULL`, the width of the frame is equivalent to 4% of the extent of the plot
#' area.
#'
#' @export
#'
#' @keywords frame, box, grid
#'
#' @author Nicolas CASAJUS, \email{nicolas.casajus@@gmail.com}
#'
#' @examples
#' ## Grid and graduations
#' addFrame()
#' addFrame(grid = TRUE)
#' addFrame(grid = TRUE, lwd = 0.25, lty = 3)
#' addFrame(at_x = seq(-1, 1, by = 0.1))
#'
#' ## Frame width
#' addFrame(width = 0.25)
#' addFrame(at_x = seq(-1, 1, by = 0.01), width = 1.00)
#'
#' ## Colors
#' addFrame(col = 1:6)
#' addFrame(col = "lightgray", border = "darkgray")
#'
#' ## Adding to a plot
#' maps::map()
#' addFrame(grid = TRUE, add = TRUE, width = 5)
#' maps::map.axes()
#'
#' ## Other graphical parameters
#' addFrame(bg = "darkgray", xaxs = "i", yaxs = "i")


addFrame <- function(at_x, at_y, col = c("white", border), border = "black",
                     width = NULL, lwd = 1, lty = 1, asp = NA, grid = FALSE,
                     add = FALSE, ...) {


  if (length(border) > 1) stop("Argument 'border' must be a single color.")

  opar <- par(no.readonly = TRUE)
  on.exit(par(opar, no.readonly = TRUE))

  par(...)

  if (!add) {

    if (missing(at_x)) {
      x_lim <- c(-1, 1)
    } else {
      x_lim <- range(at_x)
    }

    if (missing(at_y)) {
      y_lim <- c(-1, 1)
    } else {
      y_lim <- range(at_y)
    }

    plot(0, xlim = x_lim, ylim = y_lim, type = "n", ann = FALSE, axes = FALSE,
         bty = "n", asp = asp)
  }

  if (is.null(width)) width <- 4 * (par()$usr[2] - par()$usr[1]) / 100

  if (missing(at_x)) at_x <- axTicks(side = 1)
  if (missing(at_y)) at_y <- axTicks(side = 2)

  at_x <- at_x[at_x > (par()$usr[1] + width) & at_x < (par()$usr[2] - width)]
  at_y <- at_y[at_y > (par()$usr[3] + width) & at_y < (par()$usr[4] - width)]

  if (!length(at_x)) stop("x-Axis graduations are ouside plot range.")
  if (!length(at_y)) stop("y-Axis graduations are ouside plot range.")

  at_x <- sort(unique(c(par()$usr[1], at_x, par()$usr[2])))
  at_y <- sort(unique(c(par()$usr[3], at_y, par()$usr[4])))

  ats <- list()
  ats[[1]] <- at_x
  ats[[2]] <- at_y
  ats[[3]] <- at_x[length(at_x):1]
  ats[[4]] <- at_y[length(at_y):1]

  if (length(col) == 1) {

    cols <- c(col, border)

  } else {

    cols <- col
  }

  cols <- rep_len(
    x          = cols,
    length.out = 2 * (length(at_x) - 1) + 2 * (length(at_y) - 1)
  )


  if (grid) {

    for (at in at_x) {

      lines(
        x   = rep(at, 2),
        y   = c(par()$usr[3], par()$usr[4]),
        col = border,
        lwd = lwd,
        lty = lty
      )
    }

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


  par(xpd = TRUE)

  k <- 2

  for (side in seq_along(ats)) {

    if (length(ats[[side]]) > 3) {

      for (tick in 2:(length(ats[[side]]) - 2)) {

        if (side == 1) {
          x1 <- ats[[side]][tick]
          x2 <- ats[[side]][tick + 1]
          y1 <- par()$usr[3]
          y2 <- par()$usr[3] + width
        }

        if (side == 2) {
          x1 <- par()$usr[2] - width
          x2 <- par()$usr[2]
          y1 <- ats[[side]][tick]
          y2 <- ats[[side]][tick + 1]
        }

        if (side == 3) {
          x1 <- ats[[side]][tick]
          x2 <- ats[[side]][tick + 1]
          y1 <- par()$usr[4] - width
          y2 <- par()$usr[4]
        }

        if (side == 4) {
          x1 <- par()$usr[1]
          x2 <- par()$usr[1] + width
          y1 <- ats[[side]][tick]
          y2 <- ats[[side]][tick + 1]
        }

        rect(
          xleft   = x1,
          ybottom = y1,
          xright  = x2,
          ytop    = y2,
          col     = cols[k],
          border  = border,
          lwd     = lwd,
          lty     = lty
        )

        k <- k + 1
      }
      k <- k + 2
    }
  }


  ## Corner Bottom-Left ----

  col <- cols[1]

  polygon(
    x      = c(
      par()$usr[1],
      ats[[1]][2],
      ats[[1]][2],
      par()$usr[1] + width
    ),
    y      = c(
      par()$usr[3],
      par()$usr[3],
      par()$usr[3] + width,
      par()$usr[3] + width
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Top-Left ----

  col <- cols[length(ats[[1]]) + length(ats[[2]]) + length(ats[[3]]) - 3]

  polygon(
    x      = c(
      par()$usr[1] + width,
      ats[[1]][2],
      ats[[1]][2],
      par()$usr[1]
    ),
    y      = c(
      par()$usr[4] - width,
      par()$usr[4] - width,
      par()$usr[4],
      par()$usr[4]
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Bottom-Right ----

  col <- cols[length(ats[[1]]) - 1]

  polygon(
    x      = c(
      ats[[1]][length(ats[[1]]) - 1],
      par()$usr[2],
      par()$usr[2] - width,
      ats[[1]][length(ats[[1]]) - 1]
    ),
    y      = c(
      par()$usr[3],
      par()$usr[3],
      par()$usr[3] + width,
      par()$usr[3] + width
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Top-Right ----

  col <- cols[length(ats[[1]]) + length(ats[[2]]) - 1]

  polygon(
    x      = c(
      ats[[1]][length(ats[[1]]) - 1],
      par()$usr[2] - width,
      par()$usr[2],
      ats[[1]][length(ats[[1]]) - 1]
    ),
    y      = c(
      par()$usr[4] - width,
      par()$usr[4] - width,
      par()$usr[4],
      par()$usr[4]
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Right-Bottom ----

  col <- cols[length(ats[[1]])]

  polygon(
    x      = c(
      par()$usr[2] - width,
      par()$usr[2],
      par()$usr[2],
      par()$usr[2] - width
    ),
    y      = c(
      par()$usr[3] + width,
      par()$usr[3],
      ats[[2]][2],
      ats[[2]][2]
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Right-Top ----

  col <- cols[length(ats[[1]]) + length(ats[[2]]) - 2]

  polygon(
    x      = c(
      par()$usr[2] - width,
      par()$usr[2],
      par()$usr[2],
      par()$usr[2] - width
    ),
    y      = c(
      ats[[2]][length(ats[[2]]) - 1],
      ats[[2]][length(ats[[2]]) - 1],
      par()$usr[4],
      par()$usr[4] - width
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Left-Bottom ----

  col <- cols[length(cols)]

  polygon(
    x      = c(
      par()$usr[1],
      par()$usr[1] + width,
      par()$usr[1] + width,
      par()$usr[1]
    ),
    y      = c(
      par()$usr[3],
      par()$usr[3] + width,
      ats[[4]][length(ats[[2]]) - 1],
      ats[[4]][length(ats[[2]]) - 1]
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )


  ## Corner Left-Top ----

  col <- cols[length(ats[[1]]) + length(ats[[2]]) + length(ats[[3]]) - 2]

  polygon(
    x      = c(
      par()$usr[1],
      par()$usr[1] + width,
      par()$usr[1] + width,
      par()$usr[1]
    ),
    y      = c(
      ats[[4]][2],
      ats[[4]][2],
      par()$usr[4] - width,
      par()$usr[4]
    ),
    col    = col,
    border = border,
    lwd    = lwd,
    lty    = lty
  )

  invisible(NULL)
}

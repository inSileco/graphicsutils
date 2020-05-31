#' Add a Box around a Text
#'
#' This function adds a box around a text in an existing plot. It works
#' differently from the `plotrix::textbox()` by giving more control to user (no
#' automatic string cesure).
#'
#' @param x center of the box on the x-axis (see Details).
#' @param y center of the box on the y-axis (see Details).
#' @param labels string (of length 1) to plot and for which a box is added.
#' @param align horizontal alignment of the text inside the box. Possible values:
#' 'center' (or 'c'), 'left' (or 'l'), or 'right' ('r').
#' @param padding amount of space between text limits and box border in the four
#' directions (see Details).
#' @param cex size of the text.
#' @param font font of the text.
#' @param col color of the text.
#' @param family font family of the text
#' @param lheight line height multiplier used to vertically space multi-line
#' text (see Details).
#' @param fill color to fill or shade the rectangle.
#' @param border color of the box border.
#' @param lwd line width for box border (and box shading).
#' @param lty line type for box border (and box shading).
#' @param density density of shading lines (see `rect()`).
#' @param angle angle (in degrees) of the shading lines (see `rect()`).
#'
#' @details
#' The xy coordinates correspond to the center of the box. If left and right
#' paddings are identical (`padding[2] == padding[4]`) and text is centered
#' (`align = 'c'`), then the text is also centered on these coordinates.
#'
#' `padding` may be a vector of 1, 2, or 4 values, corresponding to adjustment
#' of all box borders (1 value), top/bottom and left/right borders (2 values),
#' or bottom/left/top/right borders (4 values). A positive value adds space
#' between box border and text, and a negative value removes space between box
#' border and text.
#'
#' `lheight` defines the vertical inter-line spacing in a multi-line string.
#' If `lheight = 1` (default), no inter-line spacing is added (i.e. each line
#' string is displayed one under the other without space). If `lheight = 2`, a
#' vertical space corresponding to one string height is added between lines. If
#' `lheight = 0`, all line strings will be overlapping.
#'
#' Only the three font families ('sans', 'serif' and 'mono')  for `family` are
#' implemented (no Hershey fonts available).
#'
#' Other arguments have the same behavior as in the `rect()` (`fill` is the
#' equivalent of `col()`) and `text()` functions.
#'
#' @return A list of length 4 with:
#' - **box**, the coordinates of the box (xleft, ybottom, xright, and ytop
#' respectively);
#' - **labels**, the strings on each line (length of 1 if no `\n` is the
#' original string);
#' - **x**, the coordinates on the x-axis of the center of each strings (length
#' of 1 if no `\n` is the original string);
#' - **y**, the coordinates on the y-axis of the center of each strings (length
#' of 1 if no `\n` is the original string).
#'
#' With these coordinates, user can draw the box and the text by himself (only
#' if same parameters are used, e.g. `cex`, `family`, `lheight`, and `font`).
#'
#' @export
#'
#' @keywords text, box
#'
#' @author Nicolas CASAJUS, \email{nicolas.casajus@@gmail.com}
#'
#' @examples
#' ## Setting the scene ----
#' plot(1, type = "n", ann = FALSE, las = 1)
#' coords <- textBox(x = 1, y = 1, labels = "AqA")
#' str(coords)
#'
#' rect(coords$box[1], coords$box[2], coords$box[3], coords$box[4], border = 3)
#' text(x = coords$x, y = coords$y, labels = coords$labels, col = "red")
#'
#' ## Padding ----
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = "Hello World (1)",
#'                    padding = 0.05) # all borders
#' textBox(x = 1, y = 1.0, labels = "Hello World (2)",
#'                    padding = c(0.05, 0.20)) # bottom/top and left/right
#' textBox(x = 1, y = 0.8, labels = "Hello World (3)",
#'                    padding = c(0.05, 0.05, 0.05, 0.35)) # bottom, left, top, right
#'
#' ## Colors ----
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = "Hello World (1)",
#'                    padding = 0.05, col = "yellow", border = "green",
#'                    fill = "red")
#'
#' ## Box Types ----
#' textBox(x = 1, y = 1.0, labels = "Hello World (2)",
#'                    padding = 0.05, lwd = 3, lty = 3)
#' textBox(x = 1, y = 0.8, labels = "Hello World (3)",
#'                    padding = 0.05, density = 30, angle = 45, fill = "gray")
#'
#' ## Text Fonts ----
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = "Hello World (1)",
#'                    padding = 0.05, family = "mono")
#' textBox(x = 1, y = 1.0, labels = "Hello World (2)",
#'                    padding = 0.05, family = "serif")
#' textBox(x = 1, y = 0.8, labels = "Hello World (3)",
#'                    padding = 0.05, family = "serif", font = 3, cex = 3)
#'
#' ## Text Alignment ----
#' texte <- "Hello World!\nHow beautiful you are!"
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = texte, padding = 0.05,
#'                    align = "l")
#' textBox(x = 1, y = 1.0, labels = texte, padding = 0.05,
#'                    align = "c")
#' textBox(x = 1, y = 0.8, labels = texte, padding = 0.05,
#'                    align = "r")
#'
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = texte, padding = 0.05,
#'                    align = "l", lheight = 0)
#' textBox(x = 1, y = 1.0, labels = texte, padding = 0.05,
#'                    align = "l", lheight = 1)
#' textBox(x = 1, y = 0.8, labels = texte, padding = 0.05,
#'                    align = "l", lheight = 2)
#'
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = texte, align = "l",
#'                    padding = c(0.05, 0.05, 0.05, 0.35))
#' textBox(x = 1, y = 1.0, labels = texte, align = "c",
#'                    padding = c(0.05, 0.05, 0.05, 0.35))
#' textBox(x = 1, y = 0.8, labels = texte, align = "r",
#'                    padding = c(0.05, 0.05, 0.05, 0.35))
#'
#' ## Removing Box and/or Text ----
#' plot(1, type = "n", ann = FALSE, las = 1)
#' textBox(x = 1, y = 1.2, labels = texte, col = "transparent")
#' textBox(x = 1, y = 1.0, labels = texte, lwd = 0)
#' textBox(x = 1, y = 0.8, labels = texte, lwd = 0,
#'                    col = "transparent")


textBox <- function(x, y, labels, align = "c", padding = 0, cex = 1, font = 1,
                     col = par("fg"), family = par("family"), lheight = 1,
                     fill = NA, border = par("fg"), density = NULL, angle = 45,
                     lwd = par("lwd"), lty = par("lty")) {


  ## Arguments Checks and Transformations ----

  if (missing(x)) stop("Argument 'x' is required.")
  if (missing(y)) stop("Argument 'y' is required.")
  if (missing(labels)) stop("Argument 'labels' is required.")

  if (is.null(x)) stop("Argument 'x' is required.")
  if (is.null(y)) stop("Argument 'y' is required.")
  if (is.null(labels)) stop("Argument 'labels' is required.")

  if (length(x) != 1 || !is.numeric(x) || sum(is.na(x))) {
    stop("Argument 'x' must a numeric of length 1.")
  }

  if (length(y) != 1 || !is.numeric(y) || sum(is.na(y))) {
    stop("Argument 'y' must a numeric of length 1.")
  }

  if (length(labels) != 1 || !is.character(labels) || sum(is.na(labels))) {
    stop("Argument 'labels' must a character of length 1.")
  }

  if (is.null(padding)) padding <- rep(0, 4)

  if (sum(is.na(padding))) stop("Argument 'padding' cannot contain NA.")
  if (!is.numeric(padding)) stop("Argument 'padding' must be a numeric.")

  if (length(padding) == 1) {
    padding <- rep(padding, 4)

  } else {

    if (length(padding) == 2) {
      padding <- rep(padding, 2)

    } else {

      if (length(padding) != 4) {
        stop("Argument 'padding' must be a numeric of length 1, 2, or 4.")
      }
    }
  }


  if (!is.null(align)) {

    if (length(align) != 1 || !is.character(align)) {
      stop("Argument 'align' must a character of length 1.")
    }

    cases <- c("left", "center", "right")
    align <- cases[pmatch(align, cases)]

    if (is.na(align)) {
      stop("Argument 'align' must be one of 'left', 'center', 'right'.")
    }

  } else {

    align <- "center"
  }


  ## Compute Labels Dimensions ----

  n_lines <- unlist(lapply(strsplit(labels, "\n"), function(x) length(x)))

  ref_string <- "AqjQ"

  ref_string <- switch(
    font,
    ref_string,
    bquote(bold(.(ref_string))),
    bquote(italic(.(ref_string))),
    bquote(bolditalic(.(ref_string)))
  )

  string_height <- graphics::strheight(
    s      = as.expression(ref_string),
    cex    = cex,
    family = family,
    vfont  = NULL
  )

  strings <- switch(
    font,
    labels,
    bquote(bold(.(labels))),
    bquote(italic(.(labels))),
    bquote(bolditalic(.(labels)))
  )

  string_width <- graphics::strwidth(
    s      = as.expression(strings),
    cex    = cex,
    family = family,
    vfont  = NULL
  )


  ## Compute Box Dimensions ----

  box_left   <- x - (string_width / 2 + (padding[2] + padding[4]) / 2)
  box_right  <- x + (string_width / 2 + (padding[2] + padding[4]) / 2)

  box_bottom <- y - (string_height / 2 + (padding[1] + padding[3]) / 2)
  box_top    <- y + (string_height / 2 + (padding[1] + padding[3]) / 2)


  ## Adjust Box Height (if multi-lines labels) ----

  box_top    <- box_top +
                (n_lines - 1) * (string_height / 2) +
                (n_lines - 1) * (lheight - 1) * (string_height / 2)

  box_bottom <- box_bottom -
                (n_lines - 1) * (string_height / 2) -
                (n_lines - 1) * (lheight - 1) * (string_height / 2)


  ## Compute Text Position ----

  labels <- unlist(strsplit(labels, "\n"))

  text_x <- numeric(length = n_lines)
  text_y <- numeric(length = n_lines)

  line <- 1

  while (line <= n_lines) {

    sublab <- switch(
      font,
      labels[line],
      bquote(bold(.(labels[line]))),
      bquote(italic(.(labels[line]))),
      bquote(bolditalic(.(labels[line])))
    )

    string_width <- graphics::strwidth(
      s      = as.expression(sublab),
      cex    = cex,
      family = family,
      vfont  = NULL
    )

    text_x[line] <-switch(
    align,
    "center" = box_left  + (padding[2] + string_width / 2),
    "left"   = box_left  + (padding[2] + string_width / 2),
    "right"  = box_right - (padding[4] + string_width / 2)
    )

    text_y[line] <- box_top -
                    (padding[3] + string_height / 2) -
                    (line - 1) * lheight * string_height

    line <- line + 1
  }


  ## Correction for Centered text ----

  if (align == "center") text_x <- rep(max(text_x), n_lines)


  ## Add Box to Plot ----

  rect(
    xleft   = box_left,
    ybottom = box_bottom,
    xright  = box_right,
    ytop    = box_top,
    col     = fill,
    border  = border,
    lwd     = lwd,
    lty     = lty,
    density = density,
    angle   = angle
  )


  ## Add Text to Plot ----

  for (i in seq_along(labels)) {

    label <- switch(
      font,
      labels[i],
      bquote(bold(.(labels[i]))),
      bquote(italic(.(labels[i]))),
      bquote(bolditalic(.(labels[i])))
    )

    text(
      x      = text_x[i],
      y      = text_y[i],
      labels = as.expression(label),
      cex    = cex,
      col    = col,
      family = family
    )
  }

  return(
    invisible(
      list(
        box    = c(box_left, box_bottom, box_right, box_top),
        labels = labels,
        x      = text_x,
        y      = text_y
      )
    )
  )
  
}

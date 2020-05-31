#' Shadow a Text
#'
#' This function shadows a text and adds it to an existing plot.
#'
#' @param x coordinate(s) of text(s) on the x-axis.
#' @param y coordinate(s) of text(s) on the y-axis.
#' @param labels A character vector to shadow.
#' @param col color of the text.
#' @param bg color of the background (shadow color).
#' @param radius Width of the shadow.
#' @param ... others parameters to pass to `text()`.
#'
#' @importFrom graphics strwidth strheight text
#' @export
#'
#' @keywords text, shadow
#'
#' @author Nicolas CASAJUS, \email{nicolas.casajus@@gmail.com}
#'
#' @examples
#' plot(1, type = "n", ann = FALSE, las = 1)
#' shadowText(x = 0.7, y = 1.3, labels = "This is a\nshadow text")
#' shadowText(x = 1.0, y = 1.3, labels = "This is a\nshadow text",
#'            family = "serif")
#' shadowText(x = 1.3, y = 1.3, labels = "This is a\nshadow text",
#'            family = "mono")
#' shadowText(x = 1.0, y = 1.0, labels = "This is a shadow text",
#'            family = "serif", cex = 3, col = "yellow", bg = "red")
#' shadowText(x = 0.7, y = 0.7, labels = "This is a\nshadow text",
#'            family = "serif", srt = 45)
#' shadowText(x = 1.0, y = 0.7, labels = "This is a\nshadow text",
#'            family = "serif", srt = 180)
#' shadowText(x = 1.3, y = 0.7, labels = "This is a\nshadow text",
#'            family = "serif", srt = -45)


shadowText <- function(x, y, labels, col = "white", bg = par()$fg,
                       radius = 0.1, ...) {

  if (missing(x)) stop("Argument 'x' is required.")
  if (missing(y)) stop("Argument 'y' is required.")
  if (missing(labels)) stop("Argument 'labels' is required.")

  if (is.null(x)) stop("Argument 'x' is required.")
  if (is.null(y)) stop("Argument 'y' is required.")
  if (is.null(labels)) stop("Argument 'labels' is required.")

  if (!is.numeric(x) || sum(is.na(x))) {
    stop("Argument 'x' must a numeric with no NA values.")
  }

  if (!is.numeric(y) || sum(is.na(y))) {
    stop("Argument 'y' must a numeric with no NA values.")
  }

  if (!is.character(labels) || sum(is.na(labels))) {
    stop("Argument 'labels' must a character with no NA values.")
  }

  if (length(x) != length(y)) {
    stop("Arguments 'x' and 'y' must be of the same length.")
  }

  if (length(labels) != length(x)) {
    stop("Argument 'labels'is not of the same length of coordinates.")
  }


  xy <- xy.coords(x, y)
  xo <- radius * strwidth("Aq")
  yo <- radius * strheight("Aq")

  for (i in seq(0, 2 * pi, length.out = 50)) {

    text(
      x      = xy$"x" + cos(i) * xo,
      y      = xy$"y" + sin(i) * yo,
      labels = labels,
      col    = bg,
      ...
    )
  }

  text(
    x      = xy$"x",
    y      = xy$"y",
    labels = labels,
    col    = col,
    ...
  )

  invisible(NULL)
}

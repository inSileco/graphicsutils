#' Add Spatial Cardinal Directions to Axis Labels
#'
#' This function adds cardinal directions to axis labels in a map.
#'
#' @param side an integer between 1 (bottom x-Axis) and 4 (right y-Axis).
#' @param at values on the axis to add labels.
#' @param mgp customize axis positions. See `par()`.
#' @param digits number of digits of labels.
#' @param ... other parameters to pass to `axis()`.
#'
#' @export
#'
#' @keywords axis, spatial
#'
#' @author Nicolas CASAJUS, \email{nicolas.casajus@@gmail.com}
#'
#' @examples
#' maps::map()
#' addFrame(grid = TRUE, add = TRUE, width = 5)
#' addAxis(1)
#' addAxis(2, at = seq(-50, 50, 100), digits = 2)
#' addAxis(3, lwd = 0, lwd.ticks = 0.5)
#' addAxis(4, las = 1, col.axis = "red")


addAxis <- function(side, at = axTicks(side), mgp = par()$mgp, digits = 0,
                    ...) {

  opar  <- par(no.readonly = TRUE)
  on.exit(par(opar, no.readonly = TRUE))

  owarn <- options()$warn
  on.exit(options(warn = owarn))

  options(warn = -1)
  par(mgp = mgp)

  if (side %in% c(1, 3)) {

    labels <- ifelse(at == 0,
                     sprintf("%.0f\u00B0", at),
                     ifelse(at > 0,
                            sprintf(paste0("%.", digits, "f\u00B0E"), at),
                            sprintf(paste0("%.", digits, "f\u00B0W"), -1 * at)))
  } else {

    labels <- ifelse(at == 0,
                     sprintf("%.0f\u00B0", at),
                     ifelse(at > 0,
                            sprintf(paste0("%.", digits, "f\u00B0N"), at),
                            sprintf(paste0("%.", digits, "f\u00B0S"), -1 * at)))
  }

  axis(side = side, at = at, labels = labels, ...)

  invisible(NULL)
}

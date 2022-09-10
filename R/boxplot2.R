#' @title Custom boxplots
#'
#' @description Produce custom box-and-whisker plot(s) of the given (grouped)
#' values.
#'
#' @param x a formula, a an object to be coerced as a data frame.
#' @param ... further arguments to be passed to [stats::aggregate()].
#' @param probs a numeric vector of 5 probabilities used to drawn the boxes.
#' By default `probs=c(.05, 0.25, .5, .75, .95)`.
#' @param vc_cex numeric vector of 3 magnifications coefficients. The
#' first one determines the width of the whiskers, the second one is for the
#' width of the box and the last one is for the symbol indicating the median.
#' @param colors numeric vector of 3 colors for 1- the whiskers 2- the boxes
#' and 3- the symbols that indicates the median.
#' @param med_pch `pch` value used to indicate the median.
#' @param add a logical. Should the boxes be added on the current graph?
#' @param at numeric vector giving the locations where the boxplots should
#' be drawn, particularly when ‘add = TRUE’; defaults to ‘1:n’
#' where ‘n’ is the number of boxes.
#'
#' @author
#' Kevin Cazelles
#'
#' @return
#' Draw a boxplot and returns the coordinates as an invisible output.
#'
#' @export
#'
#' @examples
#' boxplot2(replicate(10, runif(100)))
#' dfa <- data.frame(name = rep(LETTERS[1:4], 25), val = runif(100))
#' plot0(c(0, 5), c(0, 1))
#' boxplot2(val ~ name, data = dfa, add = TRUE, vc_cex = c(4, 40, 2))
#'
boxplot2 <- function(x, ..., probs = c(.05, 0.25, .5, .75, .95),
                     vc_cex = c(5, 18, 1.4), colors = c("grey75", "grey75", "grey20"),
                     med_pch = 3, add = FALSE, at = NULL) {

  ## checks
  probs <- sort(probs)
  stopifnot(length(probs) == 5)
  stopifnot(all(probs <= 1))
  stopifnot(all(probs >= 0))

  if ("formula" %in% class(x)) {
    tmp <- aggregate(x, ..., FUN = quantile, probs = probs)
    val <- as.data.frame(t(tmp[, -1L]))
  } else {
    val <- apply(as.data.frame(x), 2, quantile, probs = probs)
  }
  ##
  if (is.null(at)) xco <- seq_len(ncol(val)) else xco <- rep_len(at, ncol(val))
  ##
  if (!add) {
    plot0(c(.5, ncol(val) + .5), range(val))
  }


  for (i in seq_len(ncol(val))) {
    single_boxplot(xco[i], val[, i],
      vc_cex = vc_cex, colors = colors,
      med_pch = med_pch
    )
  }

  invisible(list(xcoords = xco, ycoords = val))
}


single_boxplot <- function(x, val, vc_cex, colors, med_pch = 3) {
  par(lend = 2)
  lines(c(x, x), c(val[1L], val[5L]), lwd = vc_cex[1L], col = colors[1L])
  lines(c(x, x), c(val[2L], val[4L]), lwd = vc_cex[2L], col = colors[2L])
  points(x, val[3L], pch = med_pch, lwd = 2.4, cex = vc_cex[3L], 
    col = colors[3L])
  #
  invisible(NULL)
}

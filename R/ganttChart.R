#' @title Gantt Chart
#'
#' @description A flexible Gantt Chart.
#'
#' @param df a data.frame (see details).
#' @param order a logical. Should the tasks be ordered? See below for more details.
#' @param mstone_add Should milestones be added?
#' @param mstone_lwd lines width for the milestone.
#' @param mstone_spacing spacing between milestones (expressed as figure unit).
#' @param axes a logical. Should the axes be added?
#' @param mstone_font font of milestone (ignore of `axes` is `FALSE`).
#' @param lighten_done percentage use to lighten done task (see [lighten()]). Default set to 0, so the completed task of a given milestone have the same color as the pending ones.
#' @author David Beauchesne, Kevin Cazelles
#'
#' @details
#' Argument `df` should be a data frame with the following columns (in any order):
#'  - `milestone`: milestones names
#'  - `due`: due date (will be converted into a date with [as.Date()])
#'  - `start`: start date (will be converted into a date with [as.Date()])
#'  - `task`: tasks names
#' It might as well include any of the following optional columns:
#'  - `done`: vector of logicals indicating whether the task if completed
#'  - `col`: to custom the color of the tasks.
#'
#' @export
#'
#' @references
#' https://insileco.github.io/2017/09/20/gantt-charts-in-r/
#'
# @examples
# data(dfGantt)
# ff <- ganttChart(dfGantt, mstone_lwd = 3, mstone_spacing = 0.6, lighten_done = 80)


ganttChart <- function(df, order = TRUE, mstone_add = order,
    mstone_spacing = 1, mstone_lwd = 2, axes = TRUE, mstone_font = 2,
    lighten_done = 0) {
    ##
    opar <- par(no.readonly = TRUE)
    ## checks
    df$start <- as.Date(df$start)
    df$due <- as.Date(df$due)
    stopifnot(all(df$start <= df$due))
    ## order data frame
    if (mstone_add) {
      df <- mstone_add(df)
    } else {
      if ("done" %in% names(df))
        df$done <- c("I", "C")[df$done + 1]
    }
    if (order) df <- order_dfgantt(df)
    ## y coordinates
    tbm <- table(df$milestone)
    nms <- length(tbm)
    if (!order & mstone_add) {
      warning("spacing set to 0")
      mstone_spacing <- 0
     }
    df$y <- rev(seq_len(nrow(df))) + mstone_spacing*(nms - mstone_tonum(df$milestone))
    ##
    plot.new()
    if (axes) {
      # update margins with size of max character
      opar$mai[2L] <- max(strwidth(c(df$task, df$milestone), "inches")) * 1.25
      par(mai = opar$mai)
    }
    plot.window(xlim = range(c(df$due, df$start)), ylim = range(df$y))
    ##
    if (axes) {
      if (mstone_font != opar$font) {
        id <- df$done == "M"
        axis(2, at = df$y[!id], labels = df$task[!id], lwd = 0, las = 1)
        axis(2, at = df$y[id], labels = df$task[id], lwd = 0, las = 1,
          font = mstone_font)
      } else {
        axis(2, at = df$y, labels = df$task, lwd = 0, las = 1)
      }
      vald <- pretty(range(c(df$due, df$start)))
      axis(1, at = vald, labels = vald)
    }
    ##
    if ("col" %in% names(df)) {
      cols <- df$col
    } else {
      cols <- mstone_tonum(df$milestone)
      id <- df$done == "C"
      if (length(id) & lighten_done) {
        cols[id] <- unlist(lapply(cols[id], lighten, lighten_done))
      }
    }
    #
    for (i in seq_len(nrow(df))) {
      tl <- ifelse(df$done[i] == "M", mstone_lwd, opar$lwd)
      lines(c(df$start[i], df$due[i]), rep(df$y[i], 2), col = cols[i],
        lwd = tl)
    }
    ##
    invisible(df)
}


order_dfgantt <- function(df) {
  # use the minimum of the starting day among tasks of a milestone to sort
  # them out properly
  tmp <- merge(df,
    aggregate(start~milestone, df, min),
    by = "milestone", suffixes = c("", "_tmp"))
  ord <- order(tmp$start_tmp, tmp$milestone, tmp$start, tmp$due,
    decreasing = c(FALSE, FALSE, FALSE, TRUE), method = "radix")
  tmp[ord, -ncol(tmp)]
}

mstone_add <- function(df) {
  tmp <- merge(
    aggregate(start~milestone, df, min),
    aggregate(due~milestone, df, max),
    by = "milestone"
  )
  tmp$task <- tmp$milestone
  # convert to letter
  if (!"done" %in% names(df))
    df$done <- "I" else df$done <- c("I", "C")[df$done + 1]
  tmp$done <- "M"
  #
  if ("col" %in% names(df))
    tmp$col <- aggregate(col~milestone, df, blendColors)
  rbind(df, tmp)
}


mstone_tonum <- function(x) as.numeric(factor(x, levels = unique(x)))

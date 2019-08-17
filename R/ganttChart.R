#' @title Gantt Chart
#'
#' @description A flexible Gantt Chart.
#'
#' @param df a data.frame (see details).
#' @param order a logical. Should the tasks be ordered? See below for more details.
#' @param add_milestone Should milestone be abbed? (not implemented yet)
#' @param axes a logical. Should the axes be added?
#'
#' @author David Beauchesne, Kevin Cazelles
#'
#' @details
#' Data frame with the following column (order does not matter):
#'  - `milestone`
#'  - `due`
#'  - `start`
#'  - `task`
#'  - optionally a `status` and `col` columns
#'
#' @references
#' https://insileco.github.io/2017/09/20/gantt-charts-in-r/
#'
# @examples
# data(dfGantt)
# ganttChart(dfGantt)


ganttChart <- function(df, order = TRUE, add_milestone = order, axes = TRUE) {
    ##
    opar <- par(no.readonly = TRUE)
    ## checks
    df$start <- as.Date(df$start)
    df$due <- as.Date(df$due)
    stopifnot(all(df$start <= df$due))
    ## order data frame
    if (order) df <- order_dfgantt(df)
    if (add_milestone) {
      # df <- add_milestone(df)
    }
    ##
    df$y <- rev(seq_len(nrow(df)))
    ##
    plot.new()
    if (axes) {
      # update margin with size of max character
      opar$mai[2L] <- max(strwidth(c(df$task, df$milestone), "inches")) * 1.2
      par(mai = opar$mai)
    }
    plot(range(c(df$due, df$start)), range(df$y), axes = FALSE, ann = FALSE, type = "n")
    ##
    if (axes) {
      axis(2, at = df$y, labels = df$task, lwd = 0, las = 1)
      vald <- pretty(range(c(df$due, df$start)))
      axis(1, at = vald, labels = vald)
    }
    ##
    cols <- as.numeric(factor(df$milestone, levels = unique(df$milestone)))
    for (i in seq_len(nrow(df)))
      lines(c(df$start[i], df$due[i]), rep(df$y[i], 2), col = cols[i])
    ##
    invisible(NULL)
}


order_dfgantt <- function(df) {
  # use the minimum of the starting day among tasks of a milestone to sort
  # them out properly
  tmp <- merge(df,
    aggregate(start~milestone, df, min),
    by = "milestone", suffixes = c("", "_tmp"))
  tmp[order(tmp$start_tmp, tmp$milestone, tmp$start, tmp$due), -ncol(tmp)]
}

add_milestone <- function(df) {
  tmp <- merge(
    aggregate(start~milestone, df, min),
    aggregate(due~milestone, df, max),
  by = "milestone")
  tmp$task <- tmp$milestone
  if ("status" %in% names(df))
    tmp$status <- "M"
  # if ("col" %in% names(df))
  #   tmp$col <-
}

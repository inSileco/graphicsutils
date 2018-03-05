# data(dfGantt)
# dfGantt

ganttChart <- function(df, type = 'all', col = gpuPalette("insileco")[-1], perc_txt = 20, order = T) {
  nml <- unique(df$milestones)
  nbm <- length(nml)
  seq_col <- rep_len(col, nbm)
  rgx <- range(c(df$startDate, df$dueDate))
  # compute the relative heights for the different milestone; add .1 for the
  # x label
  hgt <- c(0.9*table(df$milestones)/sum(table(df$milestones)), .1)
  layout(matrix(1:(nbm+1), ncol = 1), heights = hgt)
  par(lend = 0, mar = c(1,1,1,1))
  for (i in 1:nbm) {
    tmp <- df[df$milestones == nml[i], ]
    plotMilestone(tmp, rgx = rgx, milestone = nml[i], perc_txt = perc_txt, col = seq_col[i], order = order)
  }

  plot0(c(rgx[1L] - .01*perc_txt*diff(rgx), rgx[2L]), c(0,1))
  lines(c(rgx[1L], rgx[2L]), c(1,1), lwd = 2)
  

}



plotMilestone <- function(df, rgx = range(c(df$startDate, df$dueDate)), milestone = df$milestones[1], perc_txt = 20, col = "#795eb9", order = T) {
  ##
  plot0(c(rgx[1L] - .01*perc_txt*diff(rgx), rgx[2L]), c(-0.5, nrow(df)+1))
  if (order) df <- df[order(df$startDate, df$startDate-df$dueDate),]
  for (i in 1:nrow(df)) {
    if (df$status[i] == "C") tmp = lighten(col, 50) else tmp = col
    lines(c(df$startDate[i], df$dueDate[i]), rep(nrow(df)-i, 2), lwd = 10, col = tmp)
    text(rgx[1L], nrow(df)-i, labels = df$task[i], offset = 1.5, pos = 2)
  }
  lines(range(c(df$startDate, df$dueDate)), rep(nrow(df), 2), col = darken(col, 40), lwd = 12)
  text(rgx[1L], nrow(df), labels = milestone, offset=4, pos = 2, cex =1.2)
  #
}

# par(lend = 1)
# plotMilestone(df, perc_txt = 40)
ganttChart(dfGantt)

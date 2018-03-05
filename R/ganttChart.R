#' @title Gantt Chart
#'
#' @description Gant Chart.
#'
#' @param df a data.frame (see details),
#' @param col color palette.
#' @param perc_txt percentage of the wodth dedicated to the description of tasks.
#' @param order a logical should the tasks be ordered.
#'
#' @author David Beauchesne
#'
#' @importFrom graphics par lines layout text
#' @export
#'
#' @examples
#' data(dfGantt)
#' ganttChart(dfGantt)


ganttChart <- function(df, col = gpuPalette("insileco")[-1], perc_txt = 20, order = TRUE) {
    def.par <- par(no.readonly = TRUE)
    ## 
    nml <- unique(df$milestones)
    nbm <- length(nml)
    seq_col <- rep_len(col, nbm)
    rgx <- range(c(df$startDate, df$dueDate))
    # Compute the relative heights of the different panels for the different
    # milestones + add .1 for the common X axis
    hgt <- c(0.85 * table(df$milestones)/sum(table(df$milestones)), 0.15)
    layout(matrix(1:(nbm + 1), ncol = 1), heights = hgt)
    par(lend = 0, mar = c(0.5, 1, 1, 0.5))
    for (i in 1:nbm) {
        tmp <- df[df$milestones == nml[i], ]
        plotMilestone(tmp, rgx = rgx, milestone = nml[i], perc_txt = perc_txt, col = seq_col[i], 
            order = order)
    }
    
    ## x labels
    plot0(c(rgx[1L] - 0.01 * perc_txt * diff(rgx), rgx[2L]), c(0, 1))
    lines(c(rgx[1L], rgx[2L]), c(1, 1), lwd = 2)
    prt <- pretty(c(rgx[1L], rgx[2L]), 10)
    prt <- prt[prt >= rgx[1L] & prt <= rgx[2L]]
    # axis(3, at = prt, labels = prt, las =2)
    text(x = prt, y = rep_len(0.9, length(prt)), labels = prt, pos = 2, srt = 90)
    par(lend = 1)
    for (i in 1:length(prt)) lines(rep(prt[i], 2), c(1, 0.5), lwd = 1)
    ## 
    par(def.par)
    ## 
    invisible(NULL)
}



plotMilestone <- function(df, rgx = range(c(df$startDate, df$dueDate)), milestone = df$milestones[1], 
    perc_txt = 20, col = 1, order = T) {
    ## 
    plot0(c(rgx[1L] - 0.01 * perc_txt * diff(rgx), rgx[2L]), c(-0.5, nrow(df) + 1))
    if (order) 
        df <- df[order(df$startDate, df$startDate - df$dueDate), ]
    for (i in 1:nrow(df)) {
        if (df$status[i] == "C") 
            tmp = lighten(col, 60) else tmp = col
        lines(c(df$startDate[i], df$dueDate[i]), rep(nrow(df) - i, 2), lwd = 10, 
            col = tmp)
        text(rgx[1L], nrow(df) - i, labels = df$task[i], offset = 1.5, pos = 2)
    }
    lines(range(c(df$startDate, df$dueDate)), rep(nrow(df), 2), col = darken(col, 
        30), lwd = 12)
    text(rgx[1L], nrow(df), labels = milestone, offset = 4, pos = 2, cex = 1.2)
    # 
}

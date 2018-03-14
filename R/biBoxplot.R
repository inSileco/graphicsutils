#' A boxplot of two distributions.
#'
#' Double boxplot
#'
#' @param df1 first set of boxplots.
#' @param df2 first set of boxplots.
#' @param prob quantile to be used. 
#' @param width a vector giving the relative widths of the boxes making up the plot.
#' @param median A list of aruments passed to \link[graphics]{lines} to custom the median line.
#' @param staples A list of aruments passed to \link[graphics]{lines} to custom the staples.
#' @param whiskers A list of aruments passed to \link[graphics]{lines} to custom the whishers.
#' @param add a logical. Should the biboxplots be added on the current graph? If \code{FALSE} then a new plot is created.
#'
#' @keywords boxplots
#'
#' @importFrom graphics lines
#' @importFrom stats quantile rnorm
#' @export
#'
#' @details Do not assess the distributions. Based on quantiles only.
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:

biBoxplot <- function(df1 = rnorm(1000, sd = 0.25), df2 = df1, prob = c(0.01, 0.25, 
    0.5, 0.75, 0.99), width = NULL, median = NULL, staples = NULL, whiskers = NULL, 
    add = FALSE) {
    x0 <- 0
    if (is.null(width)) 
        width = 0.25
    par_med <- defaultParam(median, lwd = 4)
    par_sta <- defaultParam(staples)
    par_whi <- defaultParam(whiskers)
    ## 
    seqy1 <- quantile(df1, prob)
    seqy2 <- quantile(df2, prob)
    seqx <- x0 + width * (-1:1)
    plot0()
    par(lend = 1)
    ## 
    lines(rep(seqx[2L], 2), c(min(seqy1, seqy2), max(seqy1, seqy2)), lwd = 2)
    width2 <- 0.25 * width
    lines(seqx[2L] + c(-width2, 0), rep(seqy1[1L], 2), lwd = 2)
    lines(seqx[2L] + c(-width2, 0), rep(seqy1[5L], 2), lwd = 2)
    lines(seqx[2L] + c(width2, 0), rep(seqy2[1L], 2), lwd = 2)
    lines(seqx[2L] + c(width2, 0), rep(seqy2[5L], 2), lwd = 2)
    ## 
    rect(seqx[1L], seqy1[2L], seqx[2L], seqy1[4L], border = NA, col = "grey75")
    lines(seqx[1L:2L], seqy1[c(3, 3)], lwd = 5)
    rect(seqx[2L], seqy2[2L], seqx[3L], seqy2[4L], border = NA, col = "grey75")
    do.call(lines, c(x = seqx[2L:3L], y = seqy2[c(3, 3)], par_med))
    
    
    invisible(NULL)
}

# biBoxplot() biBoxplot <- function(dist1, dist2) { ## invisible(NULL) }

defaultParam <- function(ls = NULL, lty = 1, lwd = 1, col = "grey15", lend = 2) {
    ls <- as.list(ls)
    list(lty = ifelse("lty" %in% names(ls), ls$lty, lty), lwd = ifelse("lwd" %in% 
        names(ls), ls$lwd, lwd), col = ifelse("col" %in% names(ls), ls$col, col), 
        lend = ifelse("lend" %in% names(ls), ls$lend, lend))
}

defaultParam(list(lty = 2))

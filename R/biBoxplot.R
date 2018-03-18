#' A biboxplot.
#'
#' Draws boxplots made of double plot.
#'
#' @param df1 first set of boxplots.
#' @param df2 first set of boxplots.
#' @param probs numeric vector of five probabilities with values in [0,1] (see \code{\link[stats]{quantile}}) used to design the boxes.
#' @param width a vector giving the relative widths of the boxes making up the plot.
#' @param sta_wd staple width.
#' @param median a list of aruments passed to \link[graphics]{lines} to custom the median line.
#' @param staples a list of aruments passed to \link[graphics]{lines} to custom the staples.
#' @param whiskers a list of aruments passed to \link[graphics]{lines} to custom the whiskers.
#' @param col_left color of the left boxes.
#' @param col_right color of the right boxes.
#' @param add a logical. Should the biboxplots be added on the current graph? If \code{FALSE} then a new plot is created.
#' @param at numeric vector giving the locations where the boxplots should be drawn. Same default behabiour as in \code{\link[graphics]{boxplot}}.
#' @keywords boxplots
#'
#' @importFrom graphics lines.default rect
#' @importFrom stats quantile rnorm
#' @export
#'
#' @details Do not attempt to assess the distributions. Based on quantiles only.
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:
#' dis1 <- list(stats::rnorm(1000, sd = 0.25))
#' biBoxplot(dis1)

biBoxplot <- function(df1, df2 = df1, probs = c(0.01, 0.25, 0.5, 0.75, 0.99), width = 0.2, 
    sta_wd = 0.5, median = NULL, staples = NULL, whiskers = NULL, col_left = "grey75", 
    col_right = col_left, add = FALSE, at = NULL) {
    ## 
    stopifnot(length(probs) == 5)
    probs <- sort(probs)
    stopifnot(class(df1) == "list")
    seqy1 <- lapply(df1, quantile, probs)
    seqy2 <- lapply(df2, quantile, probs)
    ## 
    stopifnot(length(df1) == length(df2))
    sz <- length(df1)
    if (is.null(at) & !isTRUE(add)) 
        at <- 1:sz
    stopifnot(length(df1) == sz)
    ## 
    dft_med <- defaultParam(median, lwd = 4)
    dft_sta <- defaultParam(staples)
    dft_whi <- defaultParam(whiskers, lend = 2)
    ## 
    if (!isTRUE(add)) 
        plot0(c(0.5, sz + 0.5), range(unlist(c(seqy1, seqy2))))
    
    for (i in 1:sz) {
        makeUnit(at[i], seqy1[[i]], seqy2[[i]], width, sta_wd, col_left, col_right, 
            dft_med, dft_sta, dft_whi)
    }
    ## 
    invisible(list(distributions_left = seqy1, distributions_right = seqy2))
}

defaultParam <- function(ls = NULL, lty = 1, lwd = 2, col = "grey15", lend = 1) {
    ls <- as.list(ls)
    list(lty = ifelse("lty" %in% names(ls), ls$lty, lty), lwd = ifelse("lwd" %in% 
        names(ls), ls$lwd, lwd), col = ifelse("col" %in% names(ls), ls$col, col), 
        lend = ifelse("lend" %in% names(ls), ls$lend, lend))
}

makeBox <- function(seqx, seqy1, seqy2, col_left, col_right) {
    rect(seqx[1L], seqy1[2L], seqx[2L], seqy1[4L], border = NA, col = col_left)
    rect(seqx[2L], seqy2[2L], seqx[3L], seqy2[4L], border = NA, col = col_right)
}

makeSta <- function(seqx, seqy1, seqy2, sta_wd, width, dft_sta) {
    sta_wd <- sta_wd * width
    do.call(lines.default, c(list(x = seqx[2L] + c(-sta_wd, 0), y = rep(seqy1[1L], 
        2)), dft_sta))
    do.call(lines.default, c(list(x = seqx[2L] + c(-sta_wd, 0), y = rep(seqy1[5L], 
        2)), dft_sta))
    do.call(lines.default, c(list(x = seqx[2L] + c(sta_wd, 0), y = rep(seqy2[1L], 
        2)), dft_sta))
    do.call(lines.default, c(list(x = seqx[2L] + c(sta_wd, 0), y = rep(seqy2[5L], 
        2)), dft_sta))
}

makeMed <- function(seqx, seqy1, seqy2, dft_med) {
    do.call(lines.default, c(list(x = seqx[1L:2L], y = seqy1[c(3L, 3L)]), dft_med))
    do.call(lines.default, c(list(x = seqx[2L:3L], y = seqy2[c(3L, 3L)]), dft_med))
}

makeUnit <- function(x0, seqy1, seqy2, width, sta_wd, col_left, col_right, dft_med, 
    dft_sta, dft_whi) {
    seqx <- x0 + width * (-1:1)
    do.call(lines.default, c(list(x = rep(seqx[2L], 2L), y = c(min(seqy1, seqy2), 
        max(seqy1, seqy2))), dft_whi))
    makeBox(seqx, seqy1, seqy2, col_left, col_right)
    makeMed(seqx, seqy1, seqy2, dft_med)
    makeSta(seqx, seqy1, seqy2, sta_wd, width, dft_sta)
}

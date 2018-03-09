#' An boxplot of two distributions.
#'
#' Double boxplot
#'
#' @param df1 first set of boxplots.
#' @param df2 first set of boxplots.
#' @param width a vector giving the relative widths of the boxes making up the plot.
#' @param median A list of aruments passed to \link[graphics]{lines} to custom the median line.
#' @param staples A list of aruments passed to \link[graphics]{lines} to custom the staples.
#' @param whiskers A list of aruments passed to \link[graphics]{lines} to custom the whishers.
#'
#' @keywords box
#'
#' @export
#'
#' @details Do not assess the distributions. Based on quantiles only.
#'
#' @seealso \code{\link[graphics]{box}}
#'
#' @examples
#' # Example 1:

biBoxplot <- function(df1 = rnorm(1000, sd=.5), df2 = -.15+rnorm(1000, sd=.5), prob = c(.01, .25, .5, .75, .99), width = NULL, median = NULL, staples = NULL, whiskers = NULL, add = FALSE) {
    x0 <- 0
    if (is.null(width)) width =.25
    seqy1 <- quantile(df1, prob)
    seqy2 <- quantile(df2, prob)
    seqx <- x0 + width*(-1:1)
    plot0()
    rect(seqx[1L], seqy1[2L], seqx[2L], seqy1[4L], border = NA, col = "grey75")
    rect(seqx[2L], seqy2[2L], seqx[3L], seqy2[4L], border = NA, col = "grey25")
    ##
    invisible(NULL)
}

# 
# biBoxplot()
#
# biBoxplot <- function(dist1, dist2) {
#     ##
#     invisible(NULL)
# }

#' Plots means and error asociated
#'
#' Plots a set of means computed based on a dataset and draw error asociated.
#'
#' @param formula a formula, see \code{\link[stats]{formula}}.
#' @param data a data frame (or list) from which the variables in formula should be taken.
#' @param FUN_err the function that assess uncertainty. Default function is \code{\link[stats]{sd}}.
#' @param add logical. should images be added on the current graph ? If FALSE a new plot is created.
#' @param seqx the x coordinates of the means to be plotted, if \code{NULL}, default values are used. This is intended to be used when \code{add} parameter is \code{TRUE}.
#' @param draw_axis logical. If \code{TRUE} axes and box are drawn.
#' @param col_err color of the lines that reflect uncertainty.
#' @param col_pt color of the points that stand for means.
#' @param cex_pt magnification coefficient of the points that stand for means.
#' @param connect logical. If TRUE then mean are linked using a lines.
#' @param args_con a list of parameters that are used to customize the lines that links the means.
#' @param ... Further graphical parameters (see \code{\link[graphics]{plot.default}} and ) may also be supplied as arguments, particularly, line type, \code{lty}, line width, \code{lwd}, color, \code{col} and for \code{type = 'b'}, \code{pch}. Also the line characteristics \code{lend}, \code{ljoin} and \code{lmitre}.
#'
#' @keywords means, standard deviation
#'
#' @export
#'
#' @examples
#' # Example:
#' dataset <- data.frame(dat=c(rnorm(50, 10, 2), rnorm(50, 20, 2)) , grp=rep(c('A','D'), each=50))
#' graphics::par(mfrow=c(1,3))
#' plotMeans(dat~grp, data=dataset, pch=19)
#' #
#' plotMeans(dat~grp, data=dataset, FUN_err= function(x) sd(x)*2, pch=15,
#' ylim=c(-5,30), yaxs='i', connect=TRUE, args_con=list(lwd=2, lty=2, col='grey35'))
#' #
#' ser <- function(x) sd(x)/sqrt(length(x))
#' plot0(c(0,4), c(0,30))
#' plotMeans(dat~grp, data=dataset, FUN_err=ser, pch=15,
#' draw_axis=FALSE, add=TRUE, seqx=c(.5,3.5), mar=c(6,6,1,1), cex=1.4)
#' graphics::axis(2)

plotMeans <- function(formula, data, FUN_err = stats::sd, add = FALSE, seqx = NULL, 
    draw_axis = TRUE, col_err = graphics::par()$col, col_pt = graphics::par()$col, 
    cex_pt = 1, connect = FALSE, args_con = list(), ...) {
    ## 
    formu <- stats::as.formula(formula)
    ## 
    args <- list(...)
    ## 
    mn_val <- stats::aggregate(formu, data = data, FUN = mean)
    sd_val <- stats::aggregate(formu, data = data, FUN = FUN_err)
    ## 
    n_val <- nrow(mn_val)
    n_col <- ncol(mn_val)
    ## 
    min_val <- mn_val[, n_col] - sd_val[, n_col]
    max_val <- mn_val[, n_col] + sd_val[, n_col]
    ## 
    if (is.null(seqx)) {
        seqx <- seq(0.5, by = 1, length.out = n_val)
        rgx <- c(0, n_val)
    } else {
        stopifnot(length(seqx) == n_val)
        rgx <- range(seqx)
    }
    ## 
    plt_def <- list(x = c(0, n_val), y = range(min_val, max_val), type = "n", axes = FALSE, 
        xlab = "", ylab = "")
    ## 
    if (length(args)) {
        idpa <- which(names(args) %in% names(graphics::par(no.readonly = TRUE)))
        if (length(idpa)) 
            do.call(graphics::par, args[idpa])
        idpl <- which(names(args) %in% names(formals(graphics::plot.default)))
        if (length(idpl) & !add) {
            idus <- which(names(plt_def) %in% names(args)[idpl])
            if (length(idus)) 
                plt_def <- plt_def[-idus]
            do.call(graphics::plot.default, c(plt_def, args[idpl]))
        } else if (!add) 
            do.call(graphics::plot.default, c(plt_def))
    } else if (!add) 
        do.call(graphics::plot.default, c(plt_def))
    # 
    do.call(graphics::points, list(x = seqx, y = mn_val[, n_col], col = col_pt, cex = cex_pt))
    for (i in 1:n_val) do.call(graphics::lines, list(x = rep(seqx[i], 2), y = c(min_val[i], 
        max_val[i]), col = col_err))
    # 
    if (connect) 
        do.call(graphics::lines, c(list(x = seqx, y = mn_val[, n_col]), args_con))
    # 
    if (draw_axis) {
        graphics::axis(1, at = seqx, labels = mn_val[, 1])
        graphics::axis(2)
        graphics::box(bty = "l", lwd = 1.2)
    }
    # 
    invisible(NULL)
}

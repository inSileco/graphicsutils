#' plot a means an error asociated
#'
#' Draw a Box around a Plot
#'
#' @param formula a formula, such as ‘y ~ x’ or ‘cbind(y1, y2) ~ x1 + x2’, where the ‘y’ variables are numeric data to be split into groups according to the grouping ‘x’ variables (usually factors).
#' @param data a data frame (or list) from which the variables in formula should be taken.
#' @param SE logical. If TRUE then the standard error is computed rather than the standard deviation.
#' @param draw_axis logical. If TRUE axes and box are drawn.
#' @param col_err color of the lines that reflect uncertainty.
#' @param col_pt color of the points that stand for means.
#' @param cex_pt magnification coefficient of the points that stand for means.
#' @param ... Further graphical parameters (see \code{\link[graphics]{plot.default}} and ) may also be supplied as arguments, particularly, line type, \code{lty}, line width, \code{lwd}, color, \code{col} and for \code{type = "b"}, \code{pch}.  Also the line characteristics \code{lend}, \code{ljoin} and \code{lmitre}.
#'
#' @keywords means, standard deviation
#'
#' @export
#'
#' @examples
#' # Example 1:
#' dataset <- data.frame(dat=c(rnorm(50, 10, 2), rnorm(50, 20, 2)) , grp=rep(c("A","D"), each=50))
#' plotMeans(dat~grp, data=dataset, pch=15)

plotMeans <- function(formula, data, SE=FALSE, draw_axis=TRUE, col_err=par()$col, col_pt=par()$col, cex_pt=1, ...){
  ##
  formu <- as.formula(formula)
  ##
  args <- list(...)
  ##
  mn_val <- aggregate(formu, data=data, FUN=mean)
  sd_val <- aggregate(formu, data=data, FUN=sd)
  ##
  n_val <- nrow(mn_val)
  n_col <- ncol(mn_val)
  ##
  if (SE) sd_val[,ncol(mn_val)] <- sd_val[,ncol(mn_val)]/sqrt(aggregate(dat~grp, dataset, FUN=length)[,ncol(mn_val)])
  print(sd_val)
  ##

  ##
  min_val <- mn_val[,n_col]-sd_val[,n_col]
  max_val <- mn_val[,n_col]+sd_val[,n_col]
  ##
  seqx <- seq(.5,by=1,length.out=n_val)
  ##
  plt_def <-  list(x=c(0, n_val), y=range(min_val,max_val), type="n", axes=FALSE, xlab="", ylab="")
  ##
  if (length(args)) {
    idpa <- which(names(args)%in%graphics:::.Pars)
    if (length(idpa)) do.call(par, args[idpa])
    idpl <- which(names(args)%in%names(formals(plot.default)))
    if (length(idpl)) {
      idus <- which(names(plt_def)%in%names(args)[idpl])
      if (length(idus)) plt_def <- plt_def[-idus]
      do.call(plot.default, c(plt_def,args[idpl]))
    }
    else do.call(plot.default, c(plt_def))
  }
  else do.call(plot.default, c(plt_def))
  #
  do.call(points, list(x=seqx, y=mn_val[,n_col], col=col_pt, cex=cex_pt))
  for (i in 1:n_val) do.call(lines, list(x=rep(seqx[i],2), y=c(min_val[i],max_val[i]), col=col_err))
  #
  if (draw_axis){
    axis(1, at=seqx, labels=mn_val[,1])
    axis(2)
    box(bty="l", lwd=1.2)
  }
}

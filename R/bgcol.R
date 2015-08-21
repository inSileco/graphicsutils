#' Background color
#'
#' Color the background of the plot region. Default color is a light blue. 
#'
#' @param ... Additional arguments to be passed to \code{\link{rect}} function.
#'
#' @keywords background, color
#'
#' @export
#'
#' @details The function calls \code{\link{rect}} and draw a colored rectangle (defaut color is set to light blue) whose dimensions are given by argument \code{usr} of function \code{\link{par}}.
#'
#' @note In par(), the argument bg colors all the window.
#'
#' @examples
#' #Example 1:
#' plot0()
#' bgcol()
#'
#' #Example 2:
#' plot0()
#' bgcol(col=8, lwd=4, border=4)

bgcol <- function(...){
    args<-list(...)
    lp<-par()$usr
    coor<-list(xleft=lp[1], ybottom=lp[3], xright=lp[2], ytop=lp[4])
    deft<-list(border=NA, col="#A2E3FF")
    if (length(args)>0){
      id<-which(names(deft) %in% names(args))
      if (length(id)>0) deft<-deft[-id]
      do.call("rect", args=as.list(c(coor,deft,args)))
    }
    else do.call("rect", args=as.list(c(coor,deft)))
}

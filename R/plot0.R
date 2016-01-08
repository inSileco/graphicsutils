#' An empty plot function
#'
#' \code{plot0} returns an empty plot.
#'
#' @param x The x coordinates of points in the plot.
#' @param y The y coordinates of points in the plot.
#' @param ... Additional arguments affecting the plot.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @details The function is based on the plot.defaut function. It simply makes the creation of an empty plot quicker
#'
#' @seealso \code{\link[shape]{emplyplot}}
#'
#' @examples
#' # Example 1:
#' plot0()
#'
#' # Example 2:
#' plot0(c(-10,10), asp=1)


plot0 <- function(x=c(-1,1), y = c(-1,1), ...){
    args <- list(...)
    coor <- list(x=x, y=y)
    deft <- list(ann=FALSE, axes=FALSE, type="n")
    ##
    if (length(args)>0){
      id <- which(names(deft) %in% names(args))
      if (length(id)>0) deft<-deft[-id]
      do.call("plot.default", args=as.list(c(coor,args,deft)))
    }
    else plot.default(x=x, y=y, ann=FALSE, axes=FALSE, type="n")
}

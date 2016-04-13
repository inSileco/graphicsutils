#' Add plot on sides.
#'
#' plotOnSide adds plot areas on the specified sides of the original figures.
#'
#' @param mat a matrix object specifying the location of the next N figures on the output device, see \link[graphics]{layout}.
#' @param dim optionnal. If provided, then a matrix is created based and this argument speciefies its dimensions.
#' @param side the number of the sides on which plot areas must be added.
#' @param quiet if TRUE, no warning message will be displayed.
#' @param ... additionnal arguments to be passed to \link[graphics]{layout}.
#'
#' @export
#'
#' @details
#' This function eases the creation of plots with multiple panels that shares information such as axis labels. Instead of
#' repeating or deleting axis labels, \code{plotOnSide} add plot areas on the specified sides of the original fgures.
#' It is based on \link[graphics]{layout} and it is no more than a tunned version of it.
#'
#' @examples
#' par(mar=c(0,0,0,0))
#' plotOnSide(1:3, width=c(0.2,1), height=c(1,1,1,0.6))
#' layout.show(5)


plotOnSide <- function(mat, side=1:2, dim=NULL, quiet=FALSE, ...){
  ##
  mat <- as.matrix(mat)
  ##
  if (!is.null(dim)){
    stopifnot(length(dim)==2)
    mat <- matrix(dim[1]*dim[2], nrow=dim[1], ncol=dim[2])
  }
  slc <- sort(na.exclude(unique(match(side, c(1,2,3,4)))))
  ##
  if (!length(slc)) {
    if (!quiet) warning("'side' does not match with any of 1, 2, 3 or 4")
    layout(mat, ...)
  }
  else {
    sz <- length(slc)
    mydim <- dim(mat)
    mat <- cbind(0,mat+sz,0)
    mat <- rbind(0,mat,0)
    for (i in 1L:sz){
      switch(slc[i],
        {mat[nrow(mat),1+(1:mydim[2])]<-1},
        {mat[1+(1:mydim[1]),1]<-2},
        {mat[1,1+(1:mydim[2])]<-3},
        {mat[1+(1:mydim[1]),ncol(mat)]<-4}
      )
    }
    if (all(mat[1L,]==0)) mat <- mat[-1L,]
    if (all(mat[,1L]==0)) mat <- mat[,-1L]
    if (all(mat[nrow(mat),]==0)) mat <- mat[-nrow(mat),]
    if (all(mat[,ncol(mat)]==0)) mat <- mat[,-ncol(mat)]
    ##
    print(mat)
    layout(mat, ...)
  }
}

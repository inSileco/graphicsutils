#' Add
#'
#' Return the values of either x-axis or y-axis for a given percentage.
#'
#' @param mat a matrix object specifying the location of the next N figures on the output device.
#' @param dim dimension of the matrix to be created.
#' @param side the number of the side plot must be added.
#'
#' @details
#' This function intends to ease the positionning of additionnal marks such as text when axis have not common axis.


panel <- function(mat, dim=NULL, side=1:4){
  ##
  if (!is.null(dim)){
    stopifnot(length(dim)==2)
    mat <- matrix(dim[1]*dim[2], nrow=dim[1], ncol=dim[2])
  }
  # ax1 <- match(vec, c("1","2","3","4"))%%5
  out <- mat+4
  return(out)
}

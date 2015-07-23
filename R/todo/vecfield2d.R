#' Vector Fields in 2 dimension. 
#'
#' Draw a vector field associated to a 2 dimensions dynamics system. 
#'
#' @param seqx The x coordinates of the first set of vector.
#' @param seqy The y coordinates of the first set of vector.
#' @param cex.arrow The x coordinates of the second set of vector.
#' @param lwd The y coordinates of the second set of vector.
#' @param col logical. If TRUE, angles are returned in radians.
#' @param add logical. If TRUE, angles are returned in radians.
#' @param FUN 
#' @param ...
#'
#' @keywords empty plot
#'
#' @export
#'
#' @details
#'
#' @examples
#' #Example:
#' plot0(c(-10,10),c(-10,10))        
#' arrows(c(0,3),c(0,0),c(3,0),c(3,-3))
#' cool <- getangle2d(c(0,3),c(0,0),c(3,0),c(3,-3))


vecfield2d <- function(seqx, seqy, add=FALSE, cex.x=0.1, cex.y=0.1, cex.h=0.25, lwd=1, col=1, FUN, ...){
	gridin <- expand.grid(seqx,seqy)
	gridout <- gridin*0
	for (i in 1:nrow(gridin)) gridout[i,] <- FUN(c(gridin[i,1],gridin[i,2]), ...)
	if (!add) plot0(range(seqx),range(seqy))
	print(gridout)
 	for (i in 1:nrow(gridout)) arrows2(gridin[i,1], gridin[i,2], 
 		gridin[i,1]+cex.x*gridout[i,1], gridin[i,2]+cex.y*gridout[i,2], length=cex.h*sqrt((gridout[i,1]^2+gridout[i,1]^2)), angle=20, lwd=lwd, col=col)
}

lotvol <- function(X, args){
    Y <- matrix(0,ncol=2)
    Y[1] <- X[1]*(args[1]-args[2]*X[1]-args[3]*X[2])
    Y[2] <- X[2]*(args[4]-args[5]*X[1]-args[6]*X[2])
    return(Y)
}
seqx <- seq(0,1,0.1)
seqy <- seq(0,1,0.1)
vecfield2d(seqx, seqy, FUN=lotvol, args=c(1,1,0.5,-1,0.5,1))

#' Vector Fields. 
#'
#' Draw a vector field associated to a dynamical system of dimension 2. 
#'
#' @param seqx The x coordinates of the set of vector.
#' @param seqy The y coordinates of the set of vector.
#' @param FUN The function that describes the dynamical system (see details).
#' @param args The parameters of the dynamical system (see details).
#' @param cex.x The magnification coefficient to be used for the x coordinates of the vectors.
#' @param cex.y The magnification coefficient to be used for the y coordinates of the vectors.
#' @param log logical. If TRUE, the lenghts of arrows are log-transformed. 
#' @param add logical. If TRUE, the vector field is added on the current plot. 
#' @param ... Additionnal arguments to be passed to \code{arrows2}.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @details
#' The \code{FUN} function to be used must be a function of two arguments. The first argument must contain the dynamical variables 
#' as a vector of two elements. Values in \code{seqx} and \code{seqy} will be used as the values of the dynamical variables.
#' The second arguments must contain all the other parameters that shapes the dynamical system. 
#'
#' @examples
#' # Example:
#' systLin <- function(X, beta){
#'     Y <- matrix(0,ncol=2)
#'     Y[1] <- beta[1]*X[1]+beta[2]*X[2]
#'     Y[2] <- beta[3]*X[1]+beta[4]*X[2]
#'     return(Y)
#' }
#' seqx <- seq(-2,2,0.35)
#' seqy <- seq(-2,2,0.35)
#' # Plot 1: 
#' vecfield2d(seqx, seqy, FUN=systLin, args=c(0,-1,1,0))
#' # Plot 2: 
#' vecfield2d(seqx, seqy, FUN=systLin, args=c(0,-1,1,0), log=FALSE, cex.hh=1.4, cex.sk=0.8, col=8)


vecfield2d <- function(seqx, seqy, FUN, args, cex.x=0.25, cex.y=0.25, log=TRUE, add=FALSE, ...){
    ## ----
    gridin <- expand.grid(seqx, seqy)
    gridout <- gridin*0
    for (i in 1:nrow(gridin)) gridout[i,] <- FUN(c(gridin[i,1], gridin[i,2]), args)
    if (!add) plot0(range(seqx), range(seqy))
    ## ----
    for (i in 1:nrow(gridout)) {
        dstx <- cex.x*gridout[i, 1]
        dsty <- cex.y*gridout[i, 2]
        if (log) {
            dstx <- log(abs(dstx)+1)
            if (gridout[i,1]<0) dstx <- -dstx
            dsty <- log(abs(dsty)+1)
            if (gridout[i,2]<0) dsty <- -dsty
        }
        arrows2(gridin[i,1], gridin[i,2], gridin[i,1]+dstx, gridin[i,2]+dsty, ...)
    }
}
#' Vector Fields.
#'
#' Draw a vector field associated to a system of at least two ODE.
#'
#' @param coords A matrix with two columns or more that is optionnally used to alternatively define the coordinates of the vector field.
#' @param FUN The function that describes the dynamical system (see details).
#' @param args The parameters of the dynamical system (see details).
#' @param ndim Number of dimension of the system. If \code{NULL} the values is based on \code{coords} and \code{slice}
#' @param slices A vector of 2 elements providing the dimensions to be displayed, (default set to c(1,2)).
#' @param fixed The values used for non drawn dimension, if \code{NULL} the values will be set to 0.
#' @param cex.x The magnification coefficient to be used for lengths of vectors along the x axis.
#' @param cex.y The magnification coefficient to be used for lengths of vectors along the y axis.
#' @param log logical. If TRUE, the lenghts of arrows are log-transformed.
#' @param add logical. If TRUE, the vector field is added on the current plot.
#' @param ... Additionnal arguments to be passed to \code{arrows2}.
#'
#' @keywords empty plot
#'
#' @export
#'
#' @details
#' The \code{FUN} function to be used must be a function of at least two arguments. The first argument must contain the dynamical variables as a vector and the second arguments must contain all the other parameters that shapes the dynamical system. When some dimension are missing, the order of \code{fixed} is the one in FUN once the drawn dimension are withdrawn.
#'
#' @examples
#' systLin <- function(X, beta){
#'     Y <- matrix(0,ncol=2)
#'     Y[1] <- beta[1,1]*X[1]+beta[1,2]*X[2]
#'     Y[2] <- beta[2,1]*X[1]+beta[2,2]*X[2]
#'     return(Y)
#' }
#' seqx <- seq(-2,2,0.31)
#' seqy <- seq(-2,2,0.31)
#' beta1 <- matrix(c(0,-1,1,0),2)
#' # Plot 1:
#' vecfield2d(coords=expand.grid(seqx, seqy), FUN=systLin, args=list(beta=beta1))
#' # Plot 2:
#' graphics::par(mar=c(2,2,2,2))
#' vecfield2d(coords=expand.grid(seqx, seqy), FUN=systLin,
#'    args=list(beta=beta1), cex.x=0.35, cex.arr=0.25,
#'    border=NA,cex.hh=1, cex.shr=0.6, col=8)
#' graphics::abline(v=0,h=0)

vecfield2d <- function(coords, FUN, args = NULL, ndim = NULL, slices = c(1, 2), fixed = NULL, 
    cex.x = 0.25, cex.y = cex.x, log = FALSE, add = FALSE, ...) {
    
    ##-- Format checking
    grid <- as.matrix(coords)
    stopifnot(ncol(grid) > 1)
    stopifnot(length(slices) == 2)
    
    ##-- Generating a grid based on coords / slices / fixed
    if (is.null(ndim)) 
        ndim <- max(ncol(grid), length(fixed) + length(slices), slices)
    gridin <- matrix(0, ncol = ndim, nrow = nrow(grid))
    # 
    if (ncol(grid) < ndim) {
        gridin[, slices] <- grid
        if (is.null(fixed)) 
            fixed <- rep(0, ndim - 2)
        grid_val <- matrix(rep(fixed, each = nrow(grid)), ncol = length(fixed))
        print(grid_val)
        gridin[, -slices] <- grid_val
    } else gridin <- grid
    ##---
    gridout <- gridin * 0
    fun_names <- names(formals(FUN))
    for (i in 1:nrow(gridin)) {
        args[[fun_names[1]]] <- gridin[i, ]
        gridout[i, ] <- do.call(FUN, args)
    }
    if (!add) 
        plot0(range(gridin[, slices[1L]]), range(gridin[, slices[2L]]))
    ## ----
    for (i in 1:nrow(gridout)) {
        dstx <- cex.x * gridout[i, 1L]
        dsty <- cex.y * gridout[i, 2L]
        if (log) {
            dstx <- log(abs(dstx) + 1)
            if (gridout[i, 1] < 0) 
                dstx <- -dstx
            dsty <- log(abs(dsty) + 1)
            if (gridout[i, 2] < 0) 
                dsty <- -dsty
        }
        arrows2(gridin[i, 1L], gridin[i, 2L], gridin[i, 1L] + dstx, gridin[i, 2L] + 
            dsty, ...)
    }
    invisible(NULL)
}

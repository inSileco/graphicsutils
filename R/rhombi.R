#' Rhombi
#'
#' Add rhombi on a plot and optionnaly returns areas.
#'
#' @param x a vector of x coordinates of the centers of the losange
#' @param y a vector of y coordinates of the centers of the losange
#' @param ldg vector of length of the large diagonals.
#' @param sdg vector of length of the small diagonals.
#' @param rot rotation angles (in degree) of the rhombi.
#' @param area logical. If TRUE the area of rhombis are returned.
#' @param ... additionnal arguments to be passed to \code{\link[graphics]{polygon}} function.
#'
#' @keywords rhumbus
#'
#' @export
#'
#' @details
#' The number of rhombus maximual is provided by the length of the largest argument among x, y, ldg, sdg and rot.
#' Other arguments are repeated with the largest length as the desired one (see \code{rep_len}).
#' Additionnal arguments remain the same for every rhombus.
#'
#' @return
#' If \code{area} is set to TRUE then areas of rhonbi drawn are returned.
#'
#' @examples
#' # Example 1:
#' plot0(asp=1)
#' rhombi(0)
#'
#' # Example 2:
#' plot0(c(-0.4,1.4),c(-0.4,1.4))
#' rhombi(runif(6), runif(5), runif(2), runif(3))
#'
#' # Example 3:
#' plot0(asp=1)
#' rhombi(x=0, rot=seq(0,180,20), col=2, border=NA)
#' rhombi(x=0, rot=seq(0,180,30), ldg=0.6, col=7, border=NA)


rhombi <- function(x, y=x, ldg=1, sdg=ldg, rot=0, area=FALSE, ...){
    sz <- max(sapply(list(x, y, ldg, sdg, rot), length))
    x <- rep_len(x, sz)
    y <- rep_len(y, sz)
    ldg <- rep_len(ldg, sz)
    sdg <- rep_len(sdg, sz)
    rot <- rep_len(rot, sz)
    rot <- pi*rot/180
    ## ----
    for (i in 1:sz){
        corh <- matrix(0,2,4)
        corh[1,] <- c(.5*ldg[i],0,-.5*ldg[i],0)
        corh[2,] <- c(0,.5*sdg[i],0,-.5*sdg[i])
        mat.rot <- matrix(c(cos(rot[i]), sin(rot[i]), -sin(rot[i]), cos(rot[i])),2)
        pt.los <- mat.rot%*%corh
        polygon(x[i]+pt.los[1,], y[i]+pt.los[2,], ...)
    }
    ## ----
    if (area) return(.5*ldg*sdg)
}

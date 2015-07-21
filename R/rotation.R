#' Rotation
#'
#' Rotates a set of points.
#'
#' @param x The x coordinates of points.
#' @param y The y coordinates of points.
#' @param rot Angle of the rotation expressed in degree.
#' @param xrot Optional x coordinate for the center of rotation.
#' @param yrot Optional y coordinate for the center of rotation.
#'
#' @keywords rotation
#'
#' @export
#'
#' @details This function returns the coordinates of the points after rotation. If The coordinates of the rotation center are not specified, the rotation center is taken as the means of coordinates.
#'
#' @examples
#' #Example:
#' plot0(c(0,10),c(0,10))
#' y<-c(6,6,9)
#' x<-c(2,5,3.5)
#' polygon(x,y, lwd=2)
#' myrot<-rotation(x, y, rot=90)
#' polygon(myrot$x,myrot$y, lwd=2, border=4)
#' myrot2<-rotation(x, y, rot=-40, 0,0)
#' polygon(myrot2$x,myrot2$y, lwd=2, border=3)

rotation <-
function(x, y, rot=90, xrot=NULL, yrot=NULL){

    ## Format checking
    x<-as.matrix(x)
    stopifnot(ncol(x)<=2)
    x <- matrix(as.numeric(x),ncol=ncol(x))
    if (ncol(x)>1){
        y <- x[,2]
        x<-x[,1]
    }
    else {
        sz <- max(length(x),length(y))
        x <- rep_len(x,sz)
        y <- rep_len(y,sz)
    }
    ## if null, xrot/yrot are the mean of x/y coordinates
    if (is.null(xrot)) xrot<-mean(x)
    if (is.null(yrot)) yrot<-mean(y)
    matxy<-matrix(c(x-xrot,y-yrot), nrow=2, byrow=TRUE)
    rot<-pi*rot/180
    mat.rot<-matrix(c(cos(rot),sin(rot),-sin(rot),cos(rot)),2)
    matxy2<-mat.rot%*%matxy
    return(list(x=matxy2[1,]+xrot,y=matxy2[2,]+yrot))
}



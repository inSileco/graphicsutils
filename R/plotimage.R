#' Plot a picture.
#'
#' Function that returns a plot that displays an image. It enables to users to directly include a png or a jpeg file in a plot region by providing their path.
#'
#' @param obj An object of class \code{nativeRaster} function.
#' @param file A path to either a \code{.png} file or a \code{.jpeg} file.
#' @param add logical. Should images be added on the current graph? If FALSE a new plot is created.
#' @param ... Additional arguments to be passed to \code{rasterImage} function.
#'
#' @keywords plot, image.
#'
#' @export
#'
#' @details
#' Either obj or file must be defined.
#' If a path is provided either \code{readPNG} or \code{readJPEG} according to the end of the file extension.
#'
#' @examples
#' # Example:
#' img <- png::readPNG(system.file("img", "Rlogo.png", package="png"), native=TRUE)
#' op <- par(no.readonly = TRUE)
#' par(mfrow=c(4,4), mar=rep(2,4))
#' for (i in 1:16) plotImage(img)
#' par(op)

plotImage <- function(obj=NULL, file=NULL, add=FALSE, ...){

    stopifnot(!is.null(c(obj,file)))
    if (!is.null(obj)) stopifnot(class(obj)=="nativeRaster")

    ## if obj is not defined we use the file to define it
    else {
        # if the file ends with jpeg or jpg we use readJPG from "jpeg" package
        # if the file ends with png we use readPNG from "png" package
        ext <- sapply(c(".jpeg$",".jpg$",".png$"),grepl,file)
        if (sum(ext)==0) stop("No method found for the given file.")
        nb<-which(ext==TRUE)
        if (nb==3) obj<-png::readPNG(file, native=TRUE)
        else obj<-jpeg::readJPEG(file, native=TRUE)
    }
    ##
    dm <- dim(obj)
    if (!add) plot0(c(1,dm[1]), c(1,dm[2]), asp=1)
    pu <- par()$usr
    rasterImage(obj, pu[1], pu[3], pu[2], pu[4], ...)
}

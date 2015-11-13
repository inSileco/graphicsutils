#' Images as ploting characters.
#'
#' \code{pchimage} returns a plot that displays an image. It enables to users to directly include a png or a jpeg file in a plot region by providing their path.
#'
#' @param x The x coordinates of images to be drawn.
#' @param y The y coordinates of images to be drawn.
#' @param obj An object of class \code{nativeRaster}.
#' @param file A path to either a \code{.png} file or a \code{.jpeg} file.
#' @param cex.x A numerical value giving the amount by which the horizontal width of the image should be magnified relative to the default.
#' @param cex.y A numerical value giving the amount by which the vertical width of the image should be magnified relative To the default.
#' @param atcenter logical. If TRUE x and y coordinates describe the center of the image. Otherwise they represent the bottom-left coordinates of the image.
#' @param add logical. Should images be added on the current graph ? If FALSE a new plot is created.
#' @param ... Additional arguments to be passed to \code{rasterImage} function.
#'
#' @keywords plot, image, plotting character
#'
#' @export
#'
#' @details
#' Either obj or file must be defined.
#'
#' If a path is provided either \code{readPNG} or \code{readJPEG} according to the end of the file extension.
#'
#' @examples
#' # Example:
#' img<-png::readPNG(system.file("img", "Rlogo.png", package="png"), native=TRUE)
#' n<-15
#' plot0(c(0,1),c(0,1))
#' pchImage(0.1+0.8*stats::runif(n), 0.1+0.8*stats::runif(n), cex.x=0.2+1.6*stats::runif(n),
#' obj=img, angle=360*runif(n))

pchImage<-
function(x, y, obj=NULL,file=NULL, cex.x=1, cex.y=cex.x, atcenter=TRUE, add=TRUE,...){
    ## obj or file must be defined
    stopifnot(!is.null(c(obj,file)))
    ## obj class must be "nativeRaster"
    if (!is.null(obj)) stopifnot(class(obj)=="nativeRaster")
    ## if obj is not defined we use the file to define it
    else {
        # if the file ends with jpeg or jpg we use readJPG from "jpeg" package
        # if the file ends with png we use readPNG from "png" package
        ext<-sapply(c(".jpeg$",".jpg$",".png$"),grepl,file)
        if (sum(ext)==0) stop("No method found for the given file.")
        nb<-which(ext==TRUE)
        if (nb==3) obj<-png::readPNG(file, native=TRUE)
        else obj<-jpeg::readJPEG(file, native=TRUE)
    }
    dx<-cex.x*0.05*(par()$usr[2] - par()$usr[1])
    dy<-cex.y*0.05*(par()$usr[4] - par()$usr[3])
    ##
    if (!add) plot(x,y,type="n")
    if (atcenter==TRUE) rasterImage(obj, x-dx, y-dy, x+dx, y+dy, ...)
    else rasterImage(obj, x, y, x+2*dx, y+2*dy, ...)
}

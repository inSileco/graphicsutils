#' Gradient or an image.
#'
#' Draw a polygon colored by a color gradient or an image.
#'
#' @param x The x coordinates of points in the plot.
#' @param y The y coordinates of points in the plot.
#' @param gradient The x coordinates of points in the plot.
#' @param image The y coordinates of points in the plot.
#' @param res The resolution of the graodient (ignored if image is not \code{NULL})
#' @param ... Additional arguments to be passed to \code{polygon}.
#' @param radian logical. If TRUE, then radian are used rather that degree.
#'
#' @keywords empty plot
#'
#'
#' @details The function is based on the plot.defaut function. It simply makes the creation of an empty plot quicker
#'
#' @examples
#' # Example 1:
#' plot0(c(0,10),c(0,10))


gradientPolygons <- function(x, y, color_palette=rainbow(100), image=NULL, res=300, angle=0, radian=FALSE, ...){

  if (!radian) angle <- pi*angle/180

  rgx <- range(x)
  rgy <- range(y)

  if (is.null(image)){
    seqx <- rep(seq(1/res,1,length.out=res), each=res)
    seqy <- rep(seq(1/res,1,length.out=res), res)
    ##
    szcol <- length(color_palette)
    score <- seqx*cos(angle)+seqy*sin(angle)
    scoreb <- floor((szcol-1)*(score-min(score))/(max(score)-min(score)))+1
    ##
    ptx <- rgx[1]+seqx*(rgx[2]-rgx[1])
    pty <- rgy[1]+seqy*(rgy[2]-rgy[1])
    ##
    pt_incl <- pointsInPolygon(ptx, pty, x, y)
    scoreb[!pt_incl] <- NA
    mat <- matrix(color_palette[scoreb], nrow=res, ncol=res)
    pict <- as.raster(mat)
    graphics::rasterImage(apply(t(pict),1,rev), rgx[1], rgy[1], rgx[2], rgy[2], col=2)#gradient(resx))
  }
  else {
    class_img <- class(image)
    if (class_img%in%c("character","nativeRaster")){
        if (class_img != "nativeRaster"){
          if (grepl(".jpeg$",image) | grepl(".jpg$",image)) pict <- jpeg::readJPEG(image, native=TRUE)
          else if (grepl(".png$",image)) pict <- png::readPNG(image, native=TRUE)
          else stop("class(image) is neither a jpeg nor a png file.")
        }
        else pict <- image
    }
    else stop("class(image) is neither 'nativeRaster' nor a bitmap file")
  #   ##
  #   dmig <- dim(pict)
  #   ptx <- rgx[1] + (rgx[2]-rgx[1])*rep(seq(1/res,1,length.out=dmig[1]), each=dmig[2])
  #   pty <- rgy[1] + (rgy[2]-rgy[1])*rep(seq(1/res,1,length.out=dmig[2]), each=dmig[1])
  #   pt_incl <- pointsInPolygon(ptx, pty, x, y)
  #   ##
  #   # mat <- matrix(pict, dmig[1], dmig[2])
  #   # mat[!pt_incl] <- 0L
  #   grid::grid.raster(mat, rgx[1], rgy[1], rgx[2], rgy[2], col=2)
  #   # seqx <- rep(seq(1/res,1,length.out=res), each=res)
  #   # seqy <- rep(seq(1/res,1,length.out=res), res)
  }
  graphics::polygon(x, y, ...)
}

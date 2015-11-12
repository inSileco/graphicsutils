#' getIcon
#'
#' Draw a compass rose fully customizable.
#'
#' @param name Name of the ocon to be dowloaded.
#' @param res The resolution of the icon to be downloaded.
#' @param destfile A character string with the name where the downloaded file is saved.  Tilde-expansion is performed.
#' @param col Color of the image.
#' @param quiet logical. If TRUE, no message are printed.
#' @param preview logical. If TRUE, the icon is displayed once downloaded.
#' @param get_path logical. If TRUE, the path to the file downloaded is returned. Otherwise a objet of class \code{nativeRaster} is returned.
#'
#' @details
#' The list of icons is available at \link{https://github.com/encharm/Font-Awesome-SVG-PNG/commit/161b9457c423f2dd53ce106360505ad0b286fa3e}
#' Resolutions available are 16, 22, 24, 32, 48, 64, 128 or 256.
#' To obtain the list of name that can be used in \code{getIcon}, use getIconNames().
#' If argument \code{destfile} is not specified, then the icon is stored in a temporary file.
#' Colour gradient as it may appear in original icon is not yet handled once the color is changed.
#'
#' @export
#'
#' @examples
#' getIconNames()
#' getIcon(name="beer", col="grey80")


#' @describeIn getIcon Return the list of names available for downloading.
getIconNames <- function(){
    adr <- RCurl::getURL("https://github.com/encharm/Font-Awesome-SVG-PNG/tree/master/black/png/128")
    wbp <- readLines(tc <- textConnection(adr))
    close(tc)
    ## ---
    wic <-  wbp[which(lapply(wbp, function(x) grep("\\.png",x))==1)]
    wic <- wic[which(lapply(wic, function(x) grep("span",x))==1)]
    wicl <- lapply(wic, function(x) strsplit(x,"href|>|.png")[[1]][7])
    return(unlist(wicl))
}

#' @export
#' @describeIn getIcon Download an icon based on its name.
getIcon <- function(name, res=256, destfile=NULL, col=NULL, quiet=FALSE, preview=FALSE, get_path=FALSE){
    if (!res%in%c(16,22,24,32,48,64,128,256)) stop("Available resolution are 16, 22, 24, 32, 48, 64, 128 or 256")
    base <- "https://raw.githubusercontent.com/encharm/Font-Awesome-SVG-PNG/master/black/png/"
    tmp <- paste0(base,res,"/",name,".png?raw=true")
    ## ---
    if (is.null(NULL)) destfile <- paste0(tempdir(),name,".png")
    downloader::download(tmp, destfile=destfile, quiet=TRUE)
    if (!quiet) cat(paste0("Downloaded and stored at ''", destfile, "'\n"))
    raset <- png::readPNG(destfile, native=TRUE)
    ## ---
    if (!is.null(col)) raset[which(raset!=0)] <- col
    ## ---
    if (preview) plotImage(raset)
    if (get_path)  return(destfile)
    else return(raset)
}

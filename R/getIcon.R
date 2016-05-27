#' getIcon
#'
#' Draw a compass rose fully customizable.
#'
#' @param name name of the ocon to be dowloaded.
#' @param res the resolution of the icon to be downloaded.
#' @param destfile a character string with the name where the downloaded file is saved.  Tilde-expansion is performed.
#' @param col color of the image.
#' @param quiet logical. if TRUE, no message are printed.
#' @param preview logical. if TRUE, the icon is displayed once downloaded.
#' @param get_path logical. if TRUE, the path to the file downloaded is returned. Otherwise a objet of class \code{nativeRaster} is returned.
#'
#' @details
#' Resolutions available are 16, 22, 24, 32, 48, 64, 128 or 256.
#' To obtain the list of name that can be used in \code{getIcon}, use getIconNames().
#' If argument \code{destfile} is not specified, then the icon is stored in a temporary file.
#' Color gradient as it may appear in original icon is not yet handled once the color is changed.
#'
#' @export
#'
#' @references
#' <URL: 'https://github.com/encharm/Font-Awesome-SVG-PNG/tree/master/black/png>
#'
#' @examples
#' names <- getIconNames()
#' my_icon <- getIcon(name='beer', col='grey80')
#' plotImage(my_icon)


#' @describeIn getIcon Return the list of names available for downloading.
getIconNames <- function() {
    adr <- RCurl::getURL("https://github.com/encharm/Font-Awesome-SVG-PNG/tree/master/black/png/128")
    wbp <- readLines(tc <- textConnection(adr))
    close(tc)
    ## ---
    wic <- wbp[which(lapply(wbp, function(x) grep("\\.png", x)) == 1)]
    wic <- wic[which(lapply(wic, function(x) grep("span", x)) == 1)]
    wicl <- lapply(wic, function(x) strsplit(x, "href|>|.png")[[1]][7])
    return(unlist(wicl))
}

#' @export
#' @describeIn getIcon Download an icon based on its name.
getIcon <- function(name, res = 256, destfile = NULL, col = NULL, quiet = FALSE, 
    preview = FALSE, get_path = FALSE) {
    if (!res %in% c(16, 22, 24, 32, 48, 64, 128, 256)) 
        stop("Available resolution are 16, 22, 24, 32, 48, 64, 128 or 256")
    base <- "https://raw.githubusercontent.com/encharm/Font-Awesome-SVG-PNG/master/black/png/"
    tmp <- paste0(base, res, "/", name, ".png?raw=true")
    ## ---
    if (is.null(NULL)) 
        destfile <- paste0(tempdir(), name, ".png")
    downloader::download(tmp, destfile = destfile, quiet = TRUE)
    if (!quiet) 
        cat(paste0("Downloaded and stored at ''", destfile, "'\n"))
    raset <- png::readPNG(destfile, native = TRUE)
    ## ---
    if (!is.null(col)) 
        raset[which(raset != 0)] <- col
    ## ---
    if (preview) 
        plotImage(raset)
    if (get_path) 
        return(destfile) else return(raset)
}

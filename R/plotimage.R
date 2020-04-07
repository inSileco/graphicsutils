#' Display an image
#'
#' Returns a plot that displays an image. It enables users to directly include a
#' `.png` or a `.jpeg` file in a plot region by providing their path.
#'
#' @param obj an object of class `nativeRaster` function.
#' @param file a path to either a `.png` file or a `.jpeg` file.
#' @param add logical. Should images be added on the current graph? If FALSE a new plot is created.
#' @param ... additional arguments to be passed to `rasterImage` function.
#'
#' @details
#' Note that either `obj` or `file` must be defined.
#' If a path is provided either `readPNG` or `readJPEG` according to
#' the end of the file extension.
#'
#' @export
#' @examples
#' img <- png::readPNG(system.file('img', 'Rlogo.png', package='png'), native=TRUE)
#' op <- par(no.readonly = TRUE)
#' par(mfrow=c(4,4), mar=rep(2,4))
#' for (i in seq_len(16)) plotImage(img)
#' par(op)

plotImage <- function(obj = NULL, file = NULL, add = FALSE, ...) {

    stopifnot(!is.null(c(obj, file)))
    if (!is.null(obj)) {
        stopifnot(class(obj) == "nativeRaster")
    } else {
        # if the file ends with jpeg or jpg we use readJPG from 'jpeg' package if the
        # file ends with png we use readPNG from 'png' package
        ext <- unlist(lapply(c(".jp[e]?g$", ".png$"), grepl, file))
        if (sum(ext) == 0)
            stop("No method found for the given file.")
        nb <- which(ext == TRUE)
        if (nb == 3) {
            obj <- png::readPNG(file, native = TRUE)
        } else obj <- jpeg::readJPEG(file, native = TRUE)
    }
    ##
    dm <- dim(obj)
    if (!add)
        plot0(c(1, dm[1L]), c(1, dm[2L]), asp = 1)
    pu <- par()$usr
    rasterImage(obj, pu[1L], pu[3L], pu[2L], pu[4L], ...)
    ##
    invisible(NULL)
}

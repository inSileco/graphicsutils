#' Convert coordinates
#'
#' Convert user coordinates to figure region coordinates and conversely.
#'
#' @param x the x coordinates of a set of points. Alternatively, a
#'       single argument \code{x} can be provided.
#' @param y the y coordinates of a set of points.
#'
#' @export
#'
#' @details
#' These functions can be used anytime, however, there are usefull only once a
#' \link[graphics]{plot.new} has been called.
#'
#' @describeIn toFig Convert figure region coordinates into user coordinates.
toFig <- function(x, y = NULL) {
    tmp <- out <- grDevices::xy.coords(x, y)
    fig <- graphics::par()$fig
    usr <- graphics::par()$usr
    out$x <- ((tmp$x - usr[1L])/diff(usr[1:2]) * diff(fig[1:2])) + fig[1L]
    out$y <- ((tmp$y - usr[3L])/diff(usr[3:4]) * diff(fig[3:4])) + fig[3L]
    return(data.frame(x = out$x, y = out$y))
}


#' @describeIn toFig Convert user coordinates into figure region coordinates.
#' @export
toUser <- function(x, y = NULL) {
    tmp <- out <- grDevices::xy.coords(x, y)
    fig <- graphics::par()$fig
    usr <- graphics::par()$usr
    out$x <- ((tmp$x - fig[1L])/diff(fig[1:2]) * diff(usr[1:2])) + usr[1L]
    out$y <- ((tmp$y - fig[3L])/diff(fig[3:4]) * diff(usr[3:4])) + usr[3L]
    return(data.frame(x = out$x, y = out$y))
}

#' How many rows and columns
#'
#' Compute the number of rows and columns to split a graphic window into panels
#' as equally as possible.
#'
#' @param n a number.
#'
#' @export
#'
#' @return
#' A vector of two elements: the number of rows followed by the number of columns.

howManyRC <- function(n) {
    sqr <- sqrt(n)
    fsq <- floor(sqr)
    nbr <- nbc <- fsq
    # 
    if (sqr - fsq != 0) 
        nbr <- fsq + 1
    if (n - nbr * nbc > 0) 
        nbc <- fsq + 1
    # 
    c(nbr, nbc)
}

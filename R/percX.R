#' Values at a given percentage of the axis
#'
#' Return the values of either x-axis or y-axis for a given percentage.
#'
#' @param percentage The percentage of the axis for which the values is returned.
#'
#' @details
#' This function intends to ease the positionning of additionnal marks such as text when axis have not common axis.
#'
#' @export
#'
#' @examples
#' plot0()
#' text(x=percX(90), y=percY(90), label='cool')

#' @describeIn percX Return the values of x-axis for a given percentage.
percX <- function(percentage = 90) {
    stopifnot(percentage >= 0 & percentage <= 100)
    alg.x <- graphics::par()$usr[1L] + 0.01 * percentage * (graphics::par()$usr[2L] - 
        graphics::par()$usr[1L])
    return(alg.x)
}


#' @describeIn percX Return the values of y-axis for a given percentage.
#' @export
percY <- function(percentage = 90) {
    stopifnot(percentage >= 0 & percentage <= 100)
    alg.y <- graphics::par()$usr[3L] + 0.01 * percentage * (graphics::par()$usr[4L] - 
        graphics::par()$usr[3L])
    return(alg.y)
}

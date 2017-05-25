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
    alg.x <- graphics::par()$usr[1] + 0.01 * percentage * (graphics::par()$usr[2] - 
        graphics::par()$usr[1])
    return(alg.x)
}


#' @describeIn percX Return the values of y-axis for a given percentage.
#' @export
percY <- function(percentage = 90) {
    stopifnot(percentage >= 0 & percentage <= 100)
    alg.y <- graphics::par()$usr[3] + 0.01 * percentage * (graphics::par()$usr[4] - 
        graphics::par()$usr[3])
    return(alg.y)
}

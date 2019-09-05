#' Pretty range
#'
#' This function returns a pretty range of values for a given a vector of type
#' `numeric`.
#'
#' @param x A vector of numerical values.
#'
#' @keywords range, interval.
#'
#' @export
#'
#' @return
#' A vector of two values specifying the pretty the range of values.
#'
#' @details
#' This function intends to generate range with round values.
#'
#' @seealso
#' `[base::pretty()]`
#'
#' @examples
#' # Example 1:
#' vec <- stats::runif(20)
#' range(vec)
#' prettyRange(vec)
#' # Example 2:
#' prettyRange(c(3.849,3.88245))

prettyRange <- function(x) {
    ## --- format checking
    rgx <- as.numeric(range(x))
    ## Not that below also test the case where length is 1!
    stopifnot(min(rgx) != max(rgx))
    ## --- Assess the range of values
    dif <- rgx[2L] - rgx[1L]
    pow <- floor(log(dif, 10))
    ## --- Get the 'fixed part' (e.g. if the range values is [3.85;3.88] then we set
    ## 3.8 apart.)
    base <- floor(rgx[1L]/10^pow) * 10^pow
    rgx <- rgx - base
    ## --- Create a sequence of small values to select the min and max
    seqp <- 10^(pow + 1) * seq(0, 1.1, 0.05)
    minp <- seqp - rgx[1L]
    minpa <- abs(minp)
    indp <- which(minpa == min(minpa))
    if (minp[indp] > 0)
        indp <- indp - 1
    rgx[1L] <- seqp[indp]
    ## ---
    maxp <- seqp - rgx[2L]
    maxpa <- abs(maxp)
    indp <- which(maxpa == min(maxpa))
    if (maxp[indp] < 0)
        indp <- indp + 1
    rgx[2L] <- seqp[indp]
    ##
    rgx + base
}

#' Wordcloud
#'
#' A simple wordcloud function
#'
#' @param word A vector of characters strings.
#'
#'
#'

kwordcloud <- function(words, weights, add=FALSE, font=1, log=FALSE, upper=FALSE){
  stopifnot(all(weights>0))
  nwr <- length(words)
  stopifnot(nwr==length(weights))
  ## ----
  if (!add){
    par(mar=rep(1,4), font=font)
    plot0(c(0,1),c(0,1))
  }
  if (upper) words <- toupper(words)
  weights <- weights/sum(weights)
  ## ----
  areas <- double(nwr)
  for (i in 1:nwr) areas[i] <- strheight(words[i],cex=weights[i])*strwidth(words[i],cex=weights[i])
  print(areas)
  usr <- par()$usr
  totarea <- (usr[2]-usr[1])*(usr[4]-usr[3])
  print(c(totarea, sum(areas)))
}

kwordcloud(words=c("elephants","pippin","computer","saskatchewan","owl"), weights=c(1,2,2,4,3))

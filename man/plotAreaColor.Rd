% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotAreaColor.R
\name{plotAreaColor}
\alias{plotAreaColor}
\title{Color the plot area}
\usage{
plotAreaColor(color = "grey80", border = NA, ...)
}
\arguments{
\item{color}{Color of the rectangle, default is set to 'grey80'.}

\item{border}{Color of the border of the rectangle drawn, default is set to
\code{NA}, that is no border.}

\item{...}{Additional arguments to be passed to \code{\link[graphics:rect]{graphics::rect()}} function.}
}
\description{
Color the plot area by drawing a rectangle. Default color is 'grey80'.
}
\details{
The function calls \code{\link[graphics:rect]{graphics::rect()}} and draw a colored rectangle
(default color is set to light blue) whose dimensions are given by argument
\code{usr} of function \code{\link[graphics:par]{graphics::par()}}.
}
\note{
In \code{\link[graphics:par]{graphics::par()}}, argument \code{bg} colors the entire window.
}
\examples{
#Example 1:
plot0()
plotAreaColor()

#Example 2:
plot0()
plotAreaColor(col=8, lwd=4, border=4)
}
\keyword{background,}
\keyword{color}

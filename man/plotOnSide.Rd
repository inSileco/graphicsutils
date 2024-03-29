% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotOnSide.R
\name{plotOnSide}
\alias{plotOnSide}
\title{Add plot on sides.}
\usage{
plotOnSide(mat, side = 1:2, dim = NULL, quiet = FALSE, ...)
}
\arguments{
\item{mat}{a matrix object specifying the location of the next N figures on the output device, see \code{\link[graphics:layout]{graphics::layout()}}.}

\item{side}{the number of the sides on which plot areas must be added.}

\item{dim}{optional. If provided, then a matrix is created based and this argument specifies its dimensions.}

\item{quiet}{if TRUE, no warning message will be displayed.}

\item{...}{additional arguments to be passed to \code{\link[graphics:layout]{graphics::layout()}}.}
}
\description{
plotOnSide adds plot areas on the specified sides of the original figures.
}
\details{
This function eases the creation of plots that include multiple panels that
shares information such as axis labels. Instead of repeating or deleting
axis labels, \code{plotOnSide} add plot areas on the specified sides of the
original figures. It is based on \code{\link[graphics:layout]{graphics::layout()}} and it is no more
than a tuned version of it.
}
\examples{
plotOnSide(matrix(1, 2), width = c(0.2, 1), height = c(1, 1, 1, 0.6))
graphics::layout.show(5)

}

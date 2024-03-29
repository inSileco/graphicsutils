% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rhombi.R
\name{rhombi}
\alias{rhombi}
\title{Rhombi}
\usage{
rhombi(x, y = x, ldg = 1, sdg = ldg, rot = 0, add = FALSE, ...)
}
\arguments{
\item{x}{a vector of x coordinates of the centers of the losange}

\item{y}{a vector of y coordinates of the centers of the losange}

\item{ldg}{vector of length of the large diagonals.}

\item{sdg}{vector of length of the small diagonals.}

\item{rot}{rotation angles (in degree) of the rhombi.}

\item{add}{logical. If \code{TRUE} rhombi are added to the current plot (default
behavior).}

\item{...}{additional arguments to be passed to \code{\link[graphics:polygon]{graphics::polygon()}}
function.}
}
\value{
A vector including rhombi areas is returned if assigned.
}
\description{
Add rhombi on a plot and returns areas.
}
\details{
The number of rhombus maximal is provided by the length of the largest
argument among x, y, ldg, sdg and rot. Other arguments are repeated with the
largest length as the desired one (see \code{\link[=rep_len]{rep_len()}}).
Additional arguments remain the same for every rhombus.
}
\examples{
# Example 1:
plot0(asp = 1)
rhombi(0)

# Example 2:
plot0(c(-0.4, 1.4), c(-0.4, 1.4))
rhombi(runif(6), runif(5), runif(2), runif(3))

# Example 3:
plot0(asp = 1)
rhombi(x = 0, rot = seq(0, 180, 20), col = 2, border = NA)
rhombi(x = 0, rot = seq(0, 180, 30), ldg = 0.5, col = 7, border = NA)

}
\keyword{rhumbus}

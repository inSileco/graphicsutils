% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/envelop.R
\name{envelop}
\alias{envelop}
\title{Compute the coordinates of an envelop}
\usage{
envelop(x, upper, lower = rep(0, length(upper)), add = TRUE, ...)
}
\arguments{
\item{x}{vectors containing the x coordinates.}

\item{upper}{the y coordinates of the upper values.}

\item{lower}{the y coordinates of the lower values.}

\item{add}{a logical. If \code{TRUE} the envelop is drawn as a polygon (default
behavior).}

\item{...}{additional arguments to be passed to \code{\link[graphics:polygon]{graphics::polygon()}}
function.}
}
\value{
The coordinates of the envelop are returned if assigned.
}
\description{
\code{envelop} eases the computation of the polygons described by to set
of y coordinates along the x-axis. Optionally, the polygons could be added
on the current plot.
}
\examples{
plot0(c(0, 10), c(0, 10))
sz <- 100
seqx <- seq(0, 10, length.out = sz)
seqy1 <- 0.2 * seqx * runif(sz, 0, 1)
seqy2 <- 4 + 0.25 * seqx * runif(sz, 0, 1)
seqy3 <- 8 + 0.25 * seqx * runif(sz, 0, 1)
envelop(seqx, seqy1, seqy2, col = 'grey85', border = NA)
envelop(seqx, seqy2, seqy3, col = 'grey25', border = NA)
}

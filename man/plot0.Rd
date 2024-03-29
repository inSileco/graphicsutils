% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot0.R
\name{plot0}
\alias{plot0}
\title{An empty plot function}
\usage{
plot0(
  x = c(-1, 1),
  y = NULL,
  fill = NULL,
  text = NULL,
  grid.col = NULL,
  grid.lwd = 1,
  grid.lty = 1,
  ...
)
}
\arguments{
\item{x}{the x coordinates of points in the plot or a matrix of coordinates.}

\item{y}{the y coordinates of points in the plot.}

\item{fill}{The color to be used to fill the plot area.}

\item{text}{A character string or a object to be coerced as character string
that will be displayed in the center of the plot region.}

\item{grid.col}{color of the grid's lines. The default value is \code{NULL}, in
which case the grid is not drawn.}

\item{grid.lwd}{line width of the grid's lines.}

\item{grid.lty}{line type of the grid's lines.}

\item{...}{further graphical parameters from \code{\link[graphics:par]{graphics::par()}}
(such as \code{srt}) or \link[graphics:plot.default]{graphics::plot.default}.}
}
\description{
\code{plot0} returns an a plot of a specific size without any symbols.
}
\examples{
# Example 1
plot0()

# Example 2
plot0(c(-10,10), asp=1)

# Example 3
plot0(c(-10,10), text='cool', cex = 2)

# Example 3
plot0(c(-10,10), asp=1, fill=8, text='cool', srt=45, cex=4, col=2)

# Example 4
plot0(c(-10,10), fill='#ebebeb', grid.col = 'white')

# Example 4
plot0(c(-10,10), grid.col = 2)
}
\keyword{empty}
\keyword{plot}

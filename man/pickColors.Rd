% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pickColors.R
\name{pickColors}
\alias{pickColors}
\title{Pick colors up}
\usage{
pickColors(n = 9, ramp = grDevices::rainbow(1024), nb_shades = 512)
}
\arguments{
\item{n}{The number of colors to be selected (9 by default).}

\item{ramp}{A vector of colors used as tone palette.}

\item{nb_shades}{Number of shades to be displayed once a tone is selected.}
}
\value{
A character vector including the colors selected.
}
\description{
Generate an interactive interface to pick a set of colors up.
}
\details{
This function generates a graphical window splitted into 6 panels. The top
panel serves to select one tone. The panel right below presents \code{nb_shades}
of the selected tones. The bottom rigth panel displays the current selection
that can be stored by clicking on the bottom left panel _Keep it_.
The bottom center panel shows the characteristic of the selected color.
Finally, in order to abort before completing the selection of colors, the
user can simply clik on the left _Stop_ panel.
}
\keyword{color,}
\keyword{interactive}
\keyword{palette,}
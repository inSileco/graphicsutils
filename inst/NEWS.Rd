\name{NEWS}
\title{News for Package \pkg{graphicsutils}}
\newcommand{\ghpr}{\href{https://github.com/KevCaz/graphicsutils/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/KevCaz/graphicsutils/issues/#1}{##1}}


\section{Changes in graphicsutils version 1.1-2 (Unreleased)}{
  \itemize{
    \item Addition of R functions:
    \itemize{
      \item So far nothing
    }
    \item Changes in existing R functions:
    \itemize{
      \item \code{showPalette()} now displays the first colors of the palette properly.
      \item \code{showPalette()} shows the colors from palette() by default.
      \item \code{showPalette()} now adds only one line when displaying the hex color code and tune the color according to the background.
      \item Must of functions that creates new plots now ends by \code{invisible(NULL)}.
      \item \code{graphicsutils.R} has been renamed \code{zzz.R} and introduce a
      startup message including the version of the package.
    }
    \item Changes in the package structure:
    \itemize{
      \item a new dataset has been added: \code{gpu} that includes a list of color palettes.
      \item some improvement in the code coverage.
    }
  }
}


\section{Changes in graphicsutils version 1.1-1 (Unreleased)}{
  \itemize{
    \item Addition of R functions:
    \itemize{
      \item New R functions \code{toFig()} and \code{toFig()} that allow conversion from figure
      region coordinates to the user coordinates and conversely.
      \item New R function encircle that encirle points.
      \item New R function \code{box2()}, a flexible version of \code{box()}.
      \item New R functions \code{ramp()}, \code{darken()}, \code{lighten()} to ease the creation of color shades.
    }
    \item Changes in existing R functions:
    \itemize{
      \item Add the proper namespace for all functions used for \code{grDevices}
      and \code{graphics} package.
      \item \code{plot0()} now has a \code{fill} argument that calls \code{plotAreaColor()} tp color
      the plot region.
      \item a vignette has been added to showcase the package.
    }
    \item Changes in the package structure:
    \itemize{
      \item remove todo and deprecated folder in R folder.
    }
  }
}


\section{Changes in graphicsutils version 1.1.0 (2015-11-12)}{
  \itemize{
    \item Addition of new R functions:
    \itemize{
      \item New R function \code{arrows2()} to draw pretty arrows.
      \item New R function \code{circle()} to draw circle.
      \item New R functions \code{compassRose1()}, compassRose2 to draw compass rose.
      \item New R function \code{donut()} to draw donut.
      \item New R function \code{ellipse()} to draw ellipse.
      \item New R function \code{frames()} to add a frame to a given.
      \item New R function \code{homothety()} to do homthethy.
      \item New R function \code{getAngle2d()} to get the angles between two vectors.
      \item New R function \code{getIcon()}, getIconNames to get Font-Awesome icons.
      \item New R function \code{layout2()} to create layout interecatively
      \item New R function \code{pchImage()} to use image as plotting points
      \item New R functions \code{percX()} (\code{percY()}) to get the x (y) coordinate from a
      percentage of total x (y) axis length.
      \item New R function \code{pickColors} to interactively select colors .
      \item New R function \code{plotAreaColor} to color the plot region.
      \item New R function \code{plotImage} to ease the creation of plot including an image.
      \item New R function \code{plot0} to draw empty plotes.
      \item New R function \code{polarPlot} to draw polar plots.
      \item New R function \code{prettyRange} to get pretty range from a set of values.
      \item New R function \code{rhombi} to draw rhombi.
      \item New R function \code{rotation} to rotate a set of coordinates.
      \item New R function \code{showPalette} to show color palettes.
      \item New R function \code{stackedareas} to create stacked areas charts.
      \item New R function \code{translation} to translate a set of points.
      \item New R function \code{vecfield2d} to create vector fields.
    }
  }
}

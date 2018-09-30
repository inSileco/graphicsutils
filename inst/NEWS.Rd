\name{NEWS}
\title{News for Package \pkg{graphicsutils}}
\newcommand{\ghpr}{\href{https://github.com/KevCaz/graphicsutils/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/KevCaz/graphicsutils/issues/#1}{##1}}


\section{Changes in graphicsutils version 1.2-1}{

}


\section{Changes in graphicsutils version 1.2-0}{
  \itemize{
    \item Addition of new functions:
    \itemize{
      \item new set of functions \code{contrastColors()} to easily contrast colors using different methods, see \ghpr{12}.
      \item new function \code{biBoxplot()} to draw asymmetrical boxplots, see \ghpr{12}.
    }
    \item Changes in existing R functions:
    \itemize{
      \item The Ray-casting algorithm is now implemented in a cpp function, see \code{src/pointsInPolygon_core.cpp}, see \ghpr{10}.
      \item A grid can be added in \code{plot0}, three arguments control its color (\code{grid.col}), its width (\code{grid.lwd}) and type (\code{grid.lty}).
      \item `frameit` renamed \code{frameIt()}for the sack of naming consistency.
      \item \code{compassRose1()} and \code{compassRose2()} respectively renamed \code{compassRoseCardinal()} and \code{compassRose()}.
      \item Rotation is now properly handled in \code{compassRose()}, there was a mispelled assignation: \code{< -} instead of \code{<-}.
      \item \code{layout2()} renamed \code{interactiveLayout()} to better reflect what it does.
      \item \code{circle()} renamed \code{circles()}.
      \item Argument `lower` from \code{envelop()} now has a default values.
      \item \code{gpuPalette()} now has a new argument: `ncol`, that calls `colorRampPalette` (grDevices package) to custom the number of colors.
      \item \code{pchImage()} now uses native representation of raster when importing image from file.
      \item \code{circles()} has a new argument `clockwise` and is now tested.
      \item \code{howManyRC()} and \code{prettyRange()} are now tested.
    }
    \item Changes in the package's structure:
    \itemize{
      \item Rcpp added see \ghpr{10}.
      \item A website has beeen built with pkgdown.
      \item Code coverage has increased from 17\% to 31\%.
    }
    \item Changes in the package's metadata:
    \itemize{
      \item DESCRIPTION now includes authors' ORCID.
      \item A LICENSE has been added (GPL-2).
    }

  }
}

\section{Changes in graphicsutils version 1.1-2}{
  \itemize{
    \item Addition of R functions:
    \itemize{
      \item \code{howManyRC()} compute the number of rows and columns to split a graphic window into panels as equally as possible.
      \item \code{image2()} an alternative `image`
    }
    \item Changes in existing R functions:
    \itemize{
      \item Color palettes added through \code{gpuPalette()}, this adresses \ghit{#5}.
      \item \code{getIcon.R} has been removed as recommended in \ghit{9}.
      \item \code{showPalette()} now displays the first colors of the palette properly.
      \item \code{showPalette()} shows the colors from palette() by default.
      \item \code{showPalette()} now adds only one line when displaying the hex color code and tune the color according to the background.
      \item Must of functions that creates new plots now ends by \code{invisible(NULL)}.
      \item \code{graphicsutils.R} has been renamed \code{zzz.R} and introduce a
      startup message including the version of the package.
      \item \code{pickColors()} has been reviewed to adress \ghit{3}.
      \item \code{plot0()} properly handle matrix of coordinates.
      \item New argument `text` in \code{plot0()} to add centered text in the plot region.
    }
    \item Changes in the package structure:
    \itemize{
      \item Code coverage has increased from 3\% to 17\%.
      \item \code{pickcolors()} has been renamed \code{pickColors()}.
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
      \item Add the proper namespace for all functions used for `grDevices`
      and `graphics` package.
      \item \code{plot0()} now has a `fill` argument that calls \code{plotAreaColor()} tp color
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
      \item New R function `pickColors` to interactively select colors .
      \item New R function `plotAreaColor` to color the plot region.
      \item New R function `plotImage` to ease the creation of plot including an image.
      \item New R function \code{plot0} to draw empty plotes.
      \item New R function `polarPlot` to draw polar plots.
      \item New R function `prettyRange` to get pretty range from a set of values.
      \item New R function `rhombi` to draw rhombi.
      \item New R function `rotation` to rotate a set of coordinates.
      \item New R function `showPalette` to show color palettes.
      \item New R function `stackedareas` to create stacked areas charts.
      \item New R function `translation` to translate a set of points.
      \item New R function \code{vecfield2d} to create vector fields.
    }
  }
}

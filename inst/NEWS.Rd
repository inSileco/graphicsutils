\name{NEWS}
\title{News for Package \pkg{graphicsutils}}
\newcommand{\ghpr}{\href{https://github.com/KevCaz/graphicsutils/pull/#1}{##1}}
\newcommand{\ghit}{\href{https://github.com/KevCaz/graphicsutils/issues/#1}{##1}}


\section{Changes in graphicsutils version 1.1.1 (Unreleased)}{
  \itemize{
    \item Addition of R functions:
    \itemize{
      \item New R functions toFig and toUser that allow conversion from figure
      region coordinates and user coordinates and conversely.
      \item New R function encircle that encirle points.
      \item New R function box2 that encirle points.
      \item New R functions ramp, darken, lighten to ease the creation of color shades.
    }
    \item Changes in existing R functions:
    \itemize{
      \item Add the proper namespace for all functions used for \code{grDevices}
      and \code{graphics} package
      \item plot0 now have a \code{fill} parameter that calls plotAreaColor tp color
      the plot region
      \item a vignette is added
    }
    \item Changes in the package structure:
    \itemize{
      \item remove todo and deprecated folder in R folder
    }
  }
}


\section{Changes in graphicsutils version 1.1.0 (2015-11-12)}{
  \itemize{
    \item Addition of new R functions:
    \itemize{
      \item New R function arrows2 to draw pretty arrows.
      \item New R function circle to draw circle.
      \item New R functions compassRose1, compassRose2 to draw compass rose.
      \item New R function donut to draw donut.
      \item New R function ellipse to draw ellipse.
      \item New R function frames to add a frame to a given.
      \item New R function homothety to do homthethy.
      \item New R function getAngle2d to get the angles between two vectors.
      \item New R function getIcon, getIconNames to get Font-Awesome icons.
      \item New R function layout2 to create layout interecatively
      \item New R function pchImage to use image as plotting points
      \item New R functions percX, percY to get the x (y) coordinate from a
      percentage of total x (y) axis length.
      \item New R function pickColors to interactively select colors .
      \item New R function plotAreaColor to color the plot region.
      \item New R function plotImage to ease the creation of plot including an image.
      \item New R function plot0 to draw empty plotes.
      \item New R function polarPlot to draw polar plots.
      \item New R function prettyRange to get pretty range from a set of values.
      \item New R function rhombi to draw rhombi.
      \item New R function rotation to rotate a set of coordinates.
      \item New R function showPalette to show color palettes.
      \item New R function stackedareas to create stacked areas charts.
      \item New R function translation to translate a set of points.
      \item New R function vecfield2d to create vector fields.
    }
  }
}

# graphicsutils 1.5.0

* New function `colorScale()` to add a custom color scale on a plot.
* Fix cross-references throughout the documentation (see #19).
* Fix a bug in `darken()` and `darken()` introduced in 1.4.0 (via #17).
* `inst/News.Rd` has been converted and moved to `./NEWS.md`.


# graphicsutils 1.4.0

* New arguments `add_val`, `val_cex` and `n_signif` to add value in `image2()` and control the size of the text.
* `gpuPalette()` now supports numeric vectors to select palettes and expand palettes (calling `colorRampPalette()`) when necessary.
* Add `blendColors()` (via #16).
* Add `ganttChart()` (via #16).
* `darken()` and `lighten()` now support negative percentage by calling each other.
* A bunch of small changes have been done to follow good practice :recycle:.


# graphicsutils 1.3.0

* Addition of new functions:
  * new function `boxplot2()` that generates boxplots with a different visual that `boxplot()`.

* Changes in the package's structure:
    * magrittr is no longer imported and changes in various functions have been made accordingly.

* Change in documentation:
  * The vignette has been reviewed.
  * Several typos have been fixed throughout the documentation.


# graphicsutils 1.2.0

* Addition of new functions:
  * new set of functions `contrastColors()` to easily contrast colors using different methods, see #12.
  * new function `biBoxplot()` to draw asymmetrical boxplots, see #12.

* Changes in existing R functions:
  * The Ray-casting algorithm is now implemented in a cpp function, see `src/pointsInPolygon_core.cpp`, see #10.
  * A grid can be added in `plot0`, three arguments control its color (`grid.col`), its width (`grid.lwd`) and type (`grid.lty`).
  * `frameit` renamed `frameIt()`for the sack of naming consistency.
  * `compassRose1()` and `compassRose2()` respectively renamed `compassRoseCardinal()` and `compassRose()`.
  * Rotation is now properly handled in `compassRose()`, (`< -` instead of `<-`).
  * `layout2()` renamed `interactiveLayout()` to better reflect what it does.
  * `circle()` renamed `circles()`.
  * Argument `lower` from `envelop()` now has a default values.
  * `gpuPalette()` now has a new argument: `ncol`, that calls `colorRampPalette` (grDevices package) to custom the number of colors.
  * `pchImage()` now uses native representation of raster when importing image from file.
  * `circles()` has a new argument `clockwise` and is now tested.
  * `howManyRC()` and `prettyRange()` are now tested.

* Changes in the package's structure:
  * Rcpp added see #10.
  * A website has been built with `pkgdown`.
  * Code coverage has increased from 17\% to 31\%.

* Changes in the package's metadata:
  * DESCRIPTION now includes authors' ORCID.
  * A LICENSE file has been added (GPL-2).


# graphicsutils 1.1-2

* Addition of R functions:
  * `howManyRC()` compute the number of rows and columns to split a graphic window into panels as equally as possible.
  * `image2()` an alternative `image`

* Changes in existing R functions:
  * Color palettes added through `gpuPalette()`, this adresses #5.
  * `getIcon.R` has been removed as recommended in #9.
  * `showPalette()` now displays the first colors of the palette properly.
  * `showPalette()` shows the colors from palette() by default.
  * `showPalette()` now adds only one line when displaying the hex color code and tune the color according to the background.
  * Must of functions that creates new plots now ends by `invisible(NULL)`.
  * `graphicsutils.R` has been renamed `zzz.R` and introduces a
      startup message including the version of the package.
  * `pickColors()` has been reviewed to address #3.
  * `plot0()` properly handle matrix of coordinates.
  * New argument `text` in `plot0()` to add centered text in the plot region.

* Changes in the package structure:
  * Code coverage has increased from 3\% to 17\%.
  * `pickcolors()` has been renamed `pickColors()`.



# graphicsutils version 1.1.1

* Addition of R functions:
  * New R functions `toFig()` and `toFig()` that allow conversion from figure
    region coordinates to the user coordinates and conversely.
  * New R function encircle that encirle points.
  * New R function `box2()`, a flexible version of `box()`.
  * New R functions `ramp()`, `darken()`, `lighten()` to ease the creation of color shades.

* Changes in existing R functions:
  * Add the proper namespace for all functions used for `grDevices`
    and `graphics` package.
  * `plot0()` now has a `fill` argument that calls `plotAreaColor()` to color
    the plot region.
  * a vignette has been added to showcase the package.

* Changes in the package structure:
  * remove todo and deprecated folder in R folder.


# graphicsutils 1.1.0 (2015-11-12)

* New R function `arrows2()` to draw pretty arrows.
* New R function `circle()` to draw circle.
* New R functions `compassRose1()`, `compassRose2()` to draw compass rose.
* New R function `donut()` to draw donut.
* New R function `ellipse()` to draw ellipse.
* New R function `frames()` to add a frame to a given.
* New R function `homothety()` to do homthethy.
* New R function `getAngle2d()` to get the angles between two vectors.
* New R function `getIcon()`, `getIconNames()` to get Font-Awesome icons.
* New R function `layout2()` to create layout interecatively
* New R function `pchImage()` to use image as plotting points
* New R functions `percX()` (`percY()`) to get the x (y) coordinate from a
  percentage of total x (y) axis length.
* New R function `pickColors()` to interactively select colors .
* New R function `plotAreaColor()` to color the plot region.
* New R function `plotImage()` to ease the creation of plot including an image.
* New R function `plot0()` to draw empty plots.
* New R function `polarPlot()` to draw polar plots.
* New R function `prettyRange()` to get pretty range from a set of values.
* New R function `rhombi()` to draw rhombi.
* New R function `rotation()` to rotate a set of coordinates.
* New R function `showPalette()` to show color palettes.
* New R function `stackedareas()` to create stacked areas charts.
* New R function `translation()` to translate a set of points.
* New R function `vecfield2d()` to create vector fields.

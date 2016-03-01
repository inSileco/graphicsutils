DESCRIPTION
===========

*graphicsutils* is an R package that includes a set of graphical functions as the valuable [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html) package do. It is intended to use help users to deal with typical issues they may encounter when they use the core package *graphics*. Note that *graphicsutils* is not intended to be used with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html) package.

Travis: [![Travis](https://travis-ci.org/KevCaz/graphicsutils.svg?branch=master)](https://travis-ci.org/KevCaz/graphicsutils)

Installation
============

To install the package, use the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package.

devtools::install\_git("<https://github.com/KevCaz/graphicsutils.git>")

or

devtools::install\_github("KevCaz/graphicsutils")

Then, load it:

library(graphicsutils)

License
=======

The *graphicsutils* package is licensed under the GPLv3 (<http://www.gnu.org/licenses/gpl.html>).

To do list
==========

1.  Add example
2.  grapdientPolygon must be completed to include images before exporting it.
3.  Add interactive mode in 'showPalette Function'
4.  Review Vectfield2d function, I think it will be better to provide 3 coordinates rather than a dynamic system.

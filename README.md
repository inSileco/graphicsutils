# DESCRIPTION
*graphicsutils* is an R package including functions that add the graphical facilities. It is basically a set of functions, not necessary related, as the valuable package [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html). This should help R users that use basic graphic packages such as *graphics*. It is not intended to be used with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html) package.

Travis: [![Travis](https://travis-ci.org/KevCaz/graphicsutils.svg?branch=master)](https://travis-ci.org/KevCaz/graphicsutils)

# Installation
You can install this package using the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package. Once "devtools" is installed and loaded, enter:

  install_git("https://github.com/KevCaz/graphicsutils.git")

or

  install_github("KevCaz/graphicsutils")

Then, load it:

  library(graphicsutils)

# License
The *graphicsutils* package is licensed under the GPLv3 (http://www.gnu.org/licenses/gpl.html).


# To do

1. grapdientPolygon must be completed to include images before exporting it.
2. Add interactive mode in 'showPalette Function'
3. box2 must include the possibility to draw a box either around the plot area either around the all figure.
4. Review Vectfield2d function, I think it will be better to provide 3 coordinates rather than a dynamic system.

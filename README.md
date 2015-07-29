# DESCRIPTION
*graphicsutils* is an R package including functions that may help editing plots in R. It is basically a set of functions, not necessary related, as the valuable package [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html). This should help R users that use basic graphic packages such as *graphics*. This is not intended to be used with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html) package.

# Installation
You can install this package using the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package. Once "devtools" is installed and loaded, enter:

> install_git("https://github.com/KevCaz/graphicsutils.git")

or

> install_github("KevCaz/graphicsutils")

Then, load it:

> library(graphicsutils)

# License
The *graphicsutils* package is licensed under the GPLv3 (http://www.gnu.org/licenses/gpl.html).

# Future direction
1. One specific goal to be achieved is to help users navigating among subplots. Currently, layout2 help splitting the graphical window. Also function *pickcolor* shows how it is possible to navigate among subplots although it is quite a pain.  
2. Continuing the integration of basic geometric transformations. Currently rotation, homothety and translation are implemented.
3. A new color viewer will be implemented, much simpler than pickcolor and pickcolor2.

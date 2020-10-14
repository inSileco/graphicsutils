# graphicsutils
[![Build
Status](https://travis-ci.org/inSileco/graphicsutils.svg?branch=master)](https://travis-ci.org/inSileco/graphicsutils)
[![Build
status](https://ci.appveyor.com/api/projects/status/330p7f0djhpl998q?svg=true)](https://ci.appveyor.com/project/KevCaz/graphicsutils-qo99s)
[![codecov](https://codecov.io/gh/inSileco/graphicsutils/branch/master/graph/badge.svg)](https://codecov.io/gh/inSileco/graphicsutils)
[![lifecycle](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)


## Description

*graphicsutils* is a R package that adds various graphics utilities
based on the core package *graphics*. Similar functions may already exist
elsewhere (most likely in the [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html)
package). However this package may help users to overcome some difficulties they may encounter with *graphics*.

Also, as *graphicsutils* is based on the *graphics* package, it is not
designed to work with the
[*grid*](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/grid-package.html)
system (and thereby it does not work with
[ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html)).
Related with this, is one very helpful article by Paul Murrell: [The
gridGraphics
Package](https://journal.r-project.org/archive/2015-1/murrell.pdf).


## Installation

The easiest way to install `graphicsutils` is to use 
[`remotes`](https://CRAN.R-project.org/package=remotes):

```R
install.packages("remotes")
remotes::install_github("inSileco/graphicsutils")
```

Then, load it:

```R
library(graphicsutils)
```

## Main features

See our [tour vignette](http://insileco.github.io/graphicsutils/articles/overview.html) to have a overview of the functionalities included in the package.


## Code of Conduct

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

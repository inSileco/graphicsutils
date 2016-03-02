Description
===========

*graphicsutils* is an R package that includes a set of graphical functions as the valuable [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html) package do. It is intended to use help users to deal with typical issues they may encounter when they use the core package *graphics*. Note that *graphicsutils* is not intended to be used with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html) package.

Travis: [![Travis](https://travis-ci.org/KevCaz/graphicsutils.svg?branch=master)](https://travis-ci.org/KevCaz/graphicsutils)

Install
=======

To install the package, use the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package.

``` r
install.packages("devtools")
devtools::install_github("sckott/rphylopic")
```

Then, load it:

``` r
library(graphicsutils)
```

Principal feature
=================

Empty your plot
---------------

``` r
plot0(c(0,1),c(0,1))
```

![](inst/assets/img/unnamed-chunk-4-1.png) Empty isn't it ?

Add a box
---------

``` r
plot0()
box2(which="figure",lwd=2, col2fill=2)
box2(side=12, lwd=2, col2fill=8)
```

![](inst/assets/img/unnamed-chunk-5-1.png)

My version of the stacked areas
-------------------------------

x &lt;- data.frame(matrix(runif(200,2,10), 8, 25)) \#plot 1: default plot stackedareas(x)

Interactive functions
---------------------

Some functions are interactive are fairly understandable ! So, try:

``` r
pickColors()
```

and also

``` r
layout2()
```

License
=======

The *graphicsutils* package is licensed under the GPLv3 (<http://www.gnu.org/licenses/gpl.html>).

To do list
==========

1.  Add more examples
2.  Create a sustainable system to include different shapes (I am thinking about it ).
3.  grapdientPolygon must be completed to include images before exporting it.
4.  Add interactive mode in 'showPalette Function'
5.  Vectfield2d needs to be reviewed.

Description
===========

*graphicsutils* is an R package that includes a set of graphical functions. As the [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html) package, it ads some graphics utilities based on the core package *graphics*. Note that this package is not intended to be sumitted to the CRAN. First, because many of these functions already exist in other packages (in a different form though). Second, because I use it to improve my coding skill and my experience in writing a R package. This allows me to make some functions disappearing without me explaining why !! Nevertheless, this package may help users to deal with typical issues they may encounter when using *graphics*. If some of these functions turn out to be really helpful then they will likely appear in a different package which will be submitted to the CRAN. Also, *graphicsutils* is not intended to be used with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html) package.

Travis: [![Travis](https://travis-ci.org/KevCaz/graphicsutils.svg?branch=master)](https://travis-ci.org/KevCaz/graphicsutils)

Install
=======

To install the package, use the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package.

``` r
install.packages("devtools")
devtools::install_github("KevCaz/graphicsutils")
```

Then, load it:

``` r
library(graphicsutils)
```

Main features
=============

Empty your plot
---------------

``` r
plot0(c(0,1),c(0,1))
```

![](inst/assets/img/unnamed-chunk-4-1.png)<!-- --> Empty isn't it ?

Add a box
---------

``` r
par(mar=rep(2,4))
plot0()
box2(which="figure",lwd=2, fill="grey30")
box2(side=12, lwd=2, fill="grey80")
axis(1)
axis(2)
```

![](inst/assets/img/unnamed-chunk-5-1.png)<!-- -->

A stacked areas chart
---------------------

### A simple area

``` r
plot0(c(0,10),c(0,10))
sz <- 100
seqx <- seq(0, 10, length.out=sz)
seqy1 <- 0.2*seqx*runif(sz, 0, 1)
seqy2 <- 4+0.25*seqx*runif(sz, 0, 1)
seqy3 <- 8+0.25*seqx*runif(sz, 0, 1)
envelop(seqx, seqy1, seqy2, col="grey85", border=NA)
```

![](inst/assets/img/unnamed-chunk-6-1.png)<!-- -->

### A complete stacked areas

``` r
x <- data.frame(matrix(runif(200,2,10), 8, 25))
stackedAreas(x)
```

![](inst/assets/img/unnamed-chunk-7-1.png)<!-- -->

Polar plot
----------

``` r
polarPlot(1:40, stats::runif(40), to=1.9*pi, col="grey30", border="grey80")
```

![](inst/assets/img/unnamed-chunk-8-1.png)<!-- -->

Get pretty ranges
-----------------

``` r
vec <- stats::runif(20)
range(vec)
#> [1] 0.1041567 0.9812158
prettyRange(vec)
#> [1] 0.1 1.0
prettyRange(c(3.85,3.88245))
#> [1] 3.850 3.885
```

Interactive functions
---------------------

Some functions are interactive and fairly understandable ! So, I suggest you try:

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
2.  Create a sustainable system to include different shapes (I am curenlty thinking about it).
3.  grapdientPolygon must be completed to include images before exporting it.
4.  Add interactive mode in 'showPalette Function'
5.  Vectfield2d needs to be reviewed.

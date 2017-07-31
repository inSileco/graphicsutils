Description
===========

The *graphicsutils* is an R package that add various graphics utilities based on the core package *graphics*. For now, I do not intend to submit this package to the CRAN. First, because similar functions already exist elsewhere (see the [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html) package). Second, because I use this package to improve my coding skills, not being on the CRAN allows me some liberty, *e.g* making some functions/arguments disappear without having to explain why :smile\_cat:! Nevertheless, this package may help users to overcome some difficulties they may encounter with *graphics*.

Also, as *graphicsutils* is based on the *graphics* package, it is not designed to work with the [*grid*](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/grid-package.html) system (and thereby it does not work with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html)).

Status
------

[![Build status](https://ci.appveyor.com/api/github/webhook?id=ckmm09dear2cty1w)](https://ci.appveyor.com/project/KevCaz/graphicsutils) [![Travis](https://travis-ci.org/KevCaz/graphicsutils.svg?branch=master)](https://travis-ci.org/KevCaz/graphicsutils) [![codecov](https://codecov.io/gh/KevCaz/graphicsutils/branch/master/graph/badge.svg)](https://codecov.io/gh/KevCaz/graphicsutils) [![](https://img.shields.io/badge/licence-GPLv3-8f10cb.svg)](http://www.gnu.org/licenses/gpl.html)

-   Note that functions are written using Camel case (e.g. `showPalette()`)

Installation
============

To install the package, the easiest way is to use the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package:

``` r
install.packages("devtools")
devtools::install_github("KevCaz/graphicsutils")
```

Then, load it:

``` r
library(graphicsutils)
```

<!-- use devel version -->
Main features
=============

Empty your plot
---------------

To start a figure from scratch it is often useful to get a plot without nothing but the correct size of axes. `plot0()` allows the user to do so:

``` r
plot0(c(0,1),c(0,1))
```

![](inst/assets/img/plot0-1.png)

Empty, isn't it? Also, it can be filled with any color using the `fill` parameter.

``` r
plot0(c(0,1),c(0,1), fill="lightskyblue1")
```

![](inst/assets/img/plot0v2-1.png)

Add a box
---------

The `box2` function allows the user to add any axes around the plot in a more flexible way.

``` r
par(mar=rep(2,4))
plot0()
box2(which="figure", lwd=2, fill="grey30")
box2(side=12, lwd=2, fill="grey80")
axis(1)
axis(2)
```

![](inst/assets/img/box2-1.png)

Encircle points
---------------

``` r
coords <- cbind(runif(10), runif(10))
plot0(coords)
points(coords, bg="grey25", pch=21)
encircle(coords, border="#7b11a1", lwd=2)
```

![](inst/assets/img/encircle-1.png)

Add an image
------------

The `pchImage()` function eases the uses of `rasterImage()` to add images (including png and jpeg files) on a graph. It allows to change the color of the whole image.

``` r
pathLogo <- system.file("img", "Rlogo.png", package="png")
par(mar=c(4,1,4,1), mfrow=c(1,2))
plot0()
pchImage(0, 0, file=pathLogo, cex.x =4.5, cex.y=4)
plot0()
pchImage(0, 0, file=pathLogo, cex.x =4.5, cex.y=4, col="grey25", angle=25)
```

![](inst/assets/img/pchImage-1.png)

A stacked areas chart
---------------------

### A simple stacked areas

``` r
plot0(c(0, 10),c(0, 10))
sz <- 100
seqx <- seq(0, 10, length.out=sz)
seqy1 <- 0.2*seqx*runif(sz, 0, 1)
seqy2 <- 4+0.25*seqx*runif(sz, 0, 1)
seqy3 <- 8+0.25*seqx*runif(sz, 0, 1)
envelop(seqx, seqy1, seqy2, col="grey85", border=NA)
```

![](inst/assets/img/envelop-1.png)

    #> $x
    #>   [1]  0.0000000  0.1010101  0.2020202  0.3030303  0.4040404  0.5050505
    #>   [7]  0.6060606  0.7070707  0.8080808  0.9090909  1.0101010  1.1111111
    #>  [13]  1.2121212  1.3131313  1.4141414  1.5151515  1.6161616  1.7171717
    #>  [19]  1.8181818  1.9191919  2.0202020  2.1212121  2.2222222  2.3232323
    #>  [25]  2.4242424  2.5252525  2.6262626  2.7272727  2.8282828  2.9292929
    #>  [31]  3.0303030  3.1313131  3.2323232  3.3333333  3.4343434  3.5353535
    #>  [37]  3.6363636  3.7373737  3.8383838  3.9393939  4.0404040  4.1414141
    #>  [43]  4.2424242  4.3434343  4.4444444  4.5454545  4.6464646  4.7474747
    #>  [49]  4.8484848  4.9494949  5.0505051  5.1515152  5.2525253  5.3535354
    #>  [55]  5.4545455  5.5555556  5.6565657  5.7575758  5.8585859  5.9595960
    #>  [61]  6.0606061  6.1616162  6.2626263  6.3636364  6.4646465  6.5656566
    #>  [67]  6.6666667  6.7676768  6.8686869  6.9696970  7.0707071  7.1717172
    #>  [73]  7.2727273  7.3737374  7.4747475  7.5757576  7.6767677  7.7777778
    #>  [79]  7.8787879  7.9797980  8.0808081  8.1818182  8.2828283  8.3838384
    #>  [85]  8.4848485  8.5858586  8.6868687  8.7878788  8.8888889  8.9898990
    #>  [91]  9.0909091  9.1919192  9.2929293  9.3939394  9.4949495  9.5959596
    #>  [97]  9.6969697  9.7979798  9.8989899 10.0000000 10.0000000  9.8989899
    #> [103]  9.7979798  9.6969697  9.5959596  9.4949495  9.3939394  9.2929293
    #> [109]  9.1919192  9.0909091  8.9898990  8.8888889  8.7878788  8.6868687
    #> [115]  8.5858586  8.4848485  8.3838384  8.2828283  8.1818182  8.0808081
    #> [121]  7.9797980  7.8787879  7.7777778  7.6767677  7.5757576  7.4747475
    #> [127]  7.3737374  7.2727273  7.1717172  7.0707071  6.9696970  6.8686869
    #> [133]  6.7676768  6.6666667  6.5656566  6.4646465  6.3636364  6.2626263
    #> [139]  6.1616162  6.0606061  5.9595960  5.8585859  5.7575758  5.6565657
    #> [145]  5.5555556  5.4545455  5.3535354  5.2525253  5.1515152  5.0505051
    #> [151]  4.9494949  4.8484848  4.7474747  4.6464646  4.5454545  4.4444444
    #> [157]  4.3434343  4.2424242  4.1414141  4.0404040  3.9393939  3.8383838
    #> [163]  3.7373737  3.6363636  3.5353535  3.4343434  3.3333333  3.2323232
    #> [169]  3.1313131  3.0303030  2.9292929  2.8282828  2.7272727  2.6262626
    #> [175]  2.5252525  2.4242424  2.3232323  2.2222222  2.1212121  2.0202020
    #> [181]  1.9191919  1.8181818  1.7171717  1.6161616  1.5151515  1.4141414
    #> [187]  1.3131313  1.2121212  1.1111111  1.0101010  0.9090909  0.8080808
    #> [193]  0.7070707  0.6060606  0.5050505  0.4040404  0.3030303  0.2020202
    #> [199]  0.1010101  0.0000000
    #> 
    #> $y
    #>   [1] 0.000000000 0.006901947 0.024758563 0.059069359 0.062697945
    #>   [6] 0.004486337 0.055302482 0.017228697 0.049533198 0.098675717
    #>  [11] 0.066424224 0.101091195 0.083092337 0.105842377 0.268446661
    #>  [16] 0.123654190 0.251355092 0.002513562 0.067084021 0.247698944
    #>  [21] 0.337112087 0.062948295 0.344582407 0.310740520 0.232040431
    #>  [26] 0.331252002 0.266963655 0.227552726 0.297703357 0.568243967
    #>  [31] 0.211927879 0.414598233 0.428792968 0.611186504 0.181741178
    #>  [36] 0.372119643 0.544605494 0.724135189 0.620584698 0.352224922
    #>  [41] 0.364560941 0.314153694 0.413522955 0.378384640 0.863194609
    #>  [46] 0.403940114 0.606665095 0.056220392 0.512760477 0.683617282
    #>  [51] 0.646484390 0.598127539 0.838726132 0.710186824 0.914300486
    #>  [56] 0.547689836 0.329915412 0.123940531 0.007238810 0.563407929
    #>  [61] 0.270765644 0.573197238 1.252439702 0.345992305 0.269787429
    #>  [66] 0.784431784 0.554037810 1.021894679 1.171584327 0.407413317
    #>  [71] 0.343100346 1.124910601 0.497364969 0.598078772 1.143303099
    #>  [76] 1.105327407 1.218756044 1.545391030 0.536813164 0.470032585
    #>  [81] 1.096881171 0.148153412 0.200069209 1.305833304 1.260705983
    #>  [86] 0.136002486 1.227730193 0.512796770 0.100755594 1.509566023
    #>  [91] 0.042795945 1.155551810 0.246871617 0.317614122 0.356091826
    #>  [96] 0.838323658 1.069809842 0.229947164 1.657607128 1.434373626
    #> [101] 6.067943210 5.648447564 5.826591947 6.389639598 5.669305710
    #> [106] 5.428324600 5.214491784 5.615759111 5.390918498 5.055076347
    #> [111] 5.984734837 5.135114475 4.176451703 5.747340097 4.361009401
    #> [116] 5.602603419 5.938880308 4.133499399 5.076180983 5.211076329
    #> [121] 4.696762293 4.280447477 5.199039743 4.888707379 5.613307612
    #> [126] 4.899237002 5.215813523 5.566387188 5.031147468 5.566281454
    #> [131] 5.319415121 5.265568417 4.370383860 5.382862790 4.859763796
    #> [136] 4.949952816 4.491865254 4.673542095 5.414794413 4.780707352
    #> [141] 5.457987736 5.331362225 5.379749100 4.954097122 4.482484906
    #> [146] 4.783351439 4.927901452 5.100922854 4.072167904 4.239216208
    #> [151] 4.137763700 4.024014442 4.487696993 4.019672077 5.103632334
    #> [156] 4.768989717 4.531095960 4.562360113 4.491016063 4.517501253
    #> [161] 4.374739008 4.657381786 4.305280767 4.281365493 4.162506124
    #> [166] 4.148461284 4.003627257 4.329891061 4.153257440 4.376471312
    #> [171] 4.463429049 4.533662042 4.476626471 4.296629913 4.092694367
    #> [176] 4.013086599 4.046646580 4.368916449 4.124359688 4.059013770
    #> [181] 4.452565181 4.448869264 4.107467827 4.373090842 4.332219719
    #> [186] 4.315326224 4.078903279 4.034833419 4.162936613 4.146479843
    #> [191] 4.082032612 4.058152582 4.131199539 4.029443629 4.079716331
    #> [196] 4.068640918 4.007332335 4.044635246 4.010455230 4.000000000

### A complete stacked areas

``` r
x <- data.frame(matrix(runif(200, 2, 10), 8, 25))
stackedAreas(x)
```

![](inst/assets/img/stackedArea-1.png)

Polar plot
----------

``` r
polarPlot(1:40, stats::runif(40), to=1.9*pi, col="grey30", border="grey80")
```

![](inst/assets/img/polarPlot-1.png)

Get pretty ranges
-----------------

``` r
vec <- stats::runif(20)
range(vec)
#> [1] 0.1159704 0.8940520
prettyRange(vec)
#> [1] 0.1 0.9
prettyRange(c(3.85, 3.88245))
#> [1] 3.850 3.885
```

Interactive functions
---------------------

Some functions are interactive and fairly understandable! So, I suggest you try the following functions:

``` r
pickColors()
```

``` r
layout2()
```

Colors
------

`darken()` and `lighten()` functions are convenient way to produce consistent set of colors with minimal effort. They can be displayed using the `showPalette()` function as for any color palette.

``` r
someblue <- darken("blue", 10*1:9)
showPalette(someblue)
```

![](inst/assets/img/darken-1.png)

``` r
somered <- lighten("red", 10*1:9)
showPalette(somered, add_codecolor=TRUE)
```

![](inst/assets/img/lighten-1.png)

Access to Font-Awesome's icons
==============================

``` r
names <- getIconNames()
my_icon <- getIcon(name='beer', col='grey80')
#> Downloaded and stored at '/var/folders/vw/vkx0lvqd69jf9blhj1c3b3t00000gn/T//RtmpnCKVk7/icon29a55a5b4ce3.png'
plotImage(my_icon)
```

![](inst/assets/img/getIcon-1.png)

Vector fields
=============

``` r
systLin <- function(X, beta){
    Y <- matrix(0,ncol=2)
    Y[1] <- beta[1,1]*X[1]+beta[1,2]*X[2]
    Y[2] <- beta[2,1]*X[1]+beta[2,2]*X[2]
    return(Y)
}
seqx <- seq(-2,2,0.31)
seqy <- seq(-2,2,0.31)
beta1 <- matrix(c(0,-1,1,0),2)
# Plot 1:
vecfield2d(coords=expand.grid(seqx, seqy), FUN=systLin, args=list(beta=beta1))
```

![](inst/assets/img/vectorfields-1.png)

``` r
# Plot 2:
graphics::par(mar=c(2,2,2,2))
vecfield2d(coords=expand.grid(seqx, seqy), FUN=systLin,
   args=list(beta=beta1), cex.x=0.35, cex.arr=0.25,
   border=NA,cex.hh=1, cex.shr=0.6, col=8)
graphics::abline(v=0,h=0)
```

![](inst/assets/img/vectorfields-2.png)

To do list
==========

-   \[ \] Improve the code coverage,
-   \[ \] Add a vignette gathering examples (I may create a simple cookbook website),
-   \[ \] add interactive mode in `showPalette()` function,
-   \[ \] `vectfield2d()` needs to be reviewed =&gt; I'll do so when I'll integrate nice looking arrows.

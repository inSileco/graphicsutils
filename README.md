Description
===========

The *graphicsutils* is an R package that add various graphics utilities based on the core package *graphics*. For now, I do not intend to submit this package to the CRAN. First, because similar functions already exist elsewhere (see the [*plotrix*](http://cran.r-project.org/web/packages/plotrix/index.html) package). Second, because I use this package to improve my coding skills, not being on the CRAN allows me some liberty, *e.g* making some functions/arguments disappear without having to explain why :smile\_cat:! Nevertheless, this package may help users to overcome some difficulties they may encounter with *graphics*.

Also, as *graphicsutils* is based on the *graphics* package, it is not designed to work with the [*grid*](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/grid-package.html) system (and thereby it does not work with [ggplot2](http://cran.r-project.org/web/packages/ggplot2/index.html)).

Status
------

[![Build Status](https://travis-ci.org/inSileco/graphicsutils.svg?branch=master)](https://travis-ci.org/inSileco/graphicsutils) [![Build status](https://ci.appveyor.com/api/projects/status/330p7f0djhpl998q?svg=true)](https://ci.appveyor.com/project/KevCaz/graphicsutils-qo99s) [![codecov](https://codecov.io/gh/inSileco/graphicsutils/branch/master/graph/badge.svg)](https://codecov.io/gh/inSileco/graphicsutils) [![](https://img.shields.io/badge/licence-GPLv3-8f10cb.svg)](http://www.gnu.org/licenses/gpl.html)

-   Note that functions are written using Camel case (e.g. `showPalette()`)

Installation
============

The easiest way to install this package is to use the [*devtools*](http://cran.r-project.org/web/packages/devtools/index.html) package:

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

To start a figure from scratch it is often useful to get a plot without nothing but having the correct size of axes. `plot0()` allows the user to do so:

``` r
plot0(c(0,1),c(0,1))
```

![](inst/assets/img/plot0-1.png)

Quite empty, isn't it? Also, it can be filled with any color using the `fill` parameter.

``` r
plot0(c(0,1), c(0,1), fill="lightskyblue1")
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

    R>>  $x
    R>>    [1]  0.0000000  0.1010101  0.2020202  0.3030303  0.4040404  0.5050505
    R>>    [7]  0.6060606  0.7070707  0.8080808  0.9090909  1.0101010  1.1111111
    R>>   [13]  1.2121212  1.3131313  1.4141414  1.5151515  1.6161616  1.7171717
    R>>   [19]  1.8181818  1.9191919  2.0202020  2.1212121  2.2222222  2.3232323
    R>>   [25]  2.4242424  2.5252525  2.6262626  2.7272727  2.8282828  2.9292929
    R>>   [31]  3.0303030  3.1313131  3.2323232  3.3333333  3.4343434  3.5353535
    R>>   [37]  3.6363636  3.7373737  3.8383838  3.9393939  4.0404040  4.1414141
    R>>   [43]  4.2424242  4.3434343  4.4444444  4.5454545  4.6464646  4.7474747
    R>>   [49]  4.8484848  4.9494949  5.0505051  5.1515152  5.2525253  5.3535354
    R>>   [55]  5.4545455  5.5555556  5.6565657  5.7575758  5.8585859  5.9595960
    R>>   [61]  6.0606061  6.1616162  6.2626263  6.3636364  6.4646465  6.5656566
    R>>   [67]  6.6666667  6.7676768  6.8686869  6.9696970  7.0707071  7.1717172
    R>>   [73]  7.2727273  7.3737374  7.4747475  7.5757576  7.6767677  7.7777778
    R>>   [79]  7.8787879  7.9797980  8.0808081  8.1818182  8.2828283  8.3838384
    R>>   [85]  8.4848485  8.5858586  8.6868687  8.7878788  8.8888889  8.9898990
    R>>   [91]  9.0909091  9.1919192  9.2929293  9.3939394  9.4949495  9.5959596
    R>>   [97]  9.6969697  9.7979798  9.8989899 10.0000000 10.0000000  9.8989899
    R>>  [103]  9.7979798  9.6969697  9.5959596  9.4949495  9.3939394  9.2929293
    R>>  [109]  9.1919192  9.0909091  8.9898990  8.8888889  8.7878788  8.6868687
    R>>  [115]  8.5858586  8.4848485  8.3838384  8.2828283  8.1818182  8.0808081
    R>>  [121]  7.9797980  7.8787879  7.7777778  7.6767677  7.5757576  7.4747475
    R>>  [127]  7.3737374  7.2727273  7.1717172  7.0707071  6.9696970  6.8686869
    R>>  [133]  6.7676768  6.6666667  6.5656566  6.4646465  6.3636364  6.2626263
    R>>  [139]  6.1616162  6.0606061  5.9595960  5.8585859  5.7575758  5.6565657
    R>>  [145]  5.5555556  5.4545455  5.3535354  5.2525253  5.1515152  5.0505051
    R>>  [151]  4.9494949  4.8484848  4.7474747  4.6464646  4.5454545  4.4444444
    R>>  [157]  4.3434343  4.2424242  4.1414141  4.0404040  3.9393939  3.8383838
    R>>  [163]  3.7373737  3.6363636  3.5353535  3.4343434  3.3333333  3.2323232
    R>>  [169]  3.1313131  3.0303030  2.9292929  2.8282828  2.7272727  2.6262626
    R>>  [175]  2.5252525  2.4242424  2.3232323  2.2222222  2.1212121  2.0202020
    R>>  [181]  1.9191919  1.8181818  1.7171717  1.6161616  1.5151515  1.4141414
    R>>  [187]  1.3131313  1.2121212  1.1111111  1.0101010  0.9090909  0.8080808
    R>>  [193]  0.7070707  0.6060606  0.5050505  0.4040404  0.3030303  0.2020202
    R>>  [199]  0.1010101  0.0000000
    R>>  
    R>>  $y
    R>>    [1] 0.0000000000 0.0164566885 0.0124188173 0.0030100404 0.0219540866
    R>>    [6] 0.0264840354 0.0854590526 0.0006012048 0.0356439981 0.0193438381
    R>>   [11] 0.0453425897 0.0395401843 0.0198751629 0.0085573199 0.1092115579
    R>>   [16] 0.0148018299 0.0628836848 0.1117344275 0.2508450972 0.1295765286
    R>>   [21] 0.0961407635 0.3540419781 0.0472925546 0.1534260799 0.0190329814
    R>>   [26] 0.2878449687 0.0446768734 0.3937478518 0.2819325625 0.0986475368
    R>>   [31] 0.3268800216 0.4194899063 0.2704335582 0.4447808100 0.0417022598
    R>>   [36] 0.5408449588 0.3113463123 0.6327870223 0.2277470667 0.4335126736
    R>>   [41] 0.0335137571 0.0650985353 0.1322367789 0.6354401489 0.6676365826
    R>>   [46] 0.7814672526 0.0808009032 0.7863829362 0.8679913084 0.1950865750
    R>>   [51] 0.2384292340 0.8345059031 0.4656359936 0.2472636856 0.7020685630
    R>>   [56] 0.2747101947 1.1021488868 0.5667861786 0.7076180498 0.1634524891
    R>>   [61] 0.5786952210 0.0543195056 1.1064644265 0.1499873419 1.1725310364
    R>>   [66] 0.0060555684 1.2107681253 0.8201504511 0.3687253516 0.9560472053
    R>>   [71] 0.6002756856 0.5647707025 0.1796772036 0.4964672666 0.1681138437
    R>>   [76] 0.1911198262 0.4924513504 1.0242036985 1.3016902067 0.5939997509
    R>>   [81] 0.6659315858 0.2745034397 0.0411408517 0.5815285395 0.8626929838
    R>>   [86] 1.0340196716 0.9987405590 1.1328912302 1.1533916841 0.1699016559
    R>>   [91] 1.3638248663 0.0034069608 1.3747824406 1.7531268591 1.0459345780
    R>>   [96] 1.8417960912 0.0770674623 0.7246014309 1.6931034109 1.7941227648
    R>>  [101] 5.4805840445 6.0001588199 6.4101273684 4.3769846069 5.3115546312
    R>>  [106] 6.2690707917 5.6962463966 5.1046246692 4.4749629258 5.4585407377
    R>>  [111] 4.1560076648 6.0699817418 4.2475753747 4.2771345117 4.9250665892
    R>>  [116] 4.8593895312 5.1269053938 5.2486042776 5.7834154704 5.6710690510
    R>>  [121] 5.9408258132 5.3275837554 4.8990751888 4.9459255971 4.1890160277
    R>>  [126] 4.2270879459 5.4993779294 4.0797278667 4.4055356537 4.8581923150
    R>>  [131] 5.5072062089 5.4393958079 4.3187834103 5.1053712092 4.4262377245
    R>>  [136] 4.1643804905 5.2318033518 4.8844683209 4.0652411337 5.0281583986
    R>>  [141] 5.3679963236 5.0411332734 5.3114803339 4.9053154018 4.3094743711
    R>>  [146] 5.1485091333 5.1253774140 4.1330619590 4.7735753407 5.1909455617
    R>>  [151] 5.0575677164 4.4906294831 4.7304140634 4.1164560029 4.3204529983
    R>>  [156] 4.7729430836 4.2848896239 4.8814961679 4.3665688069 4.4337105733
    R>>  [161] 4.1943343193 4.9332830748 4.4350054265 4.6759326314 4.3933184047
    R>>  [166] 4.3657053347 4.5849979414 4.3798171987 4.5751285006 4.0406116408
    R>>  [171] 4.5295029513 4.2951020589 4.2726881631 4.6453117429 4.5732532932
    R>>  [176] 4.4153455227 4.3286160730 4.2431487743 4.3802379582 4.0783647862
    R>>  [181] 4.4454604913 4.3734822033 4.1312976274 4.2598668521 4.1685144378
    R>>  [186] 4.3334752793 4.3177697248 4.0407440335 4.0065981611 4.1714194536
    R>>  [191] 4.0800878570 4.1460370755 4.1556587913 4.1425345318 4.1018654914
    R>>  [196] 4.0878087823 4.0017647524 4.0326175407 4.0167172230 4.0000000000

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
R>>  [1] 0.1084253 0.7721065
prettyRange(vec)
R>>  [1] 0.1 0.8
prettyRange(c(3.85, 3.88245))
R>>  [1] 3.850 3.885
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
R>>  Downloaded and stored at '/tmp/RtmpdSBYoW/icon5eb07d9b2291.png'
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
-   \[ \] Add a contributing section
-   \[ \] Add a vignette gathering examples (I may create a simple cookbook website),
-   \[ \] add interactive mode in `showPalette()` function,
-   \[ \] `vectfield2d()` needs to be reviewed =&gt; I'll do so when I'll integrate nice looking arrows.

# pkgup2date

setwd("~/Github/rpackages")

devtools::load_all("./graphicsutils")
devtools::document("./graphicsutils")
# devtools::build(pkg = "./graphicsutils", binary=TRUE)
cat(date(), "   done \n" , file = "./graphicsutils/check.txt", append=TRUE)

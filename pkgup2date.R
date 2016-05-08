# pkgup2date

setwd("~/Github/rpackages")

devtools::load_all("./graphicsutils")
devtools::document("./graphicsutils")
devtools::build(pkg = "./graphicsutils", binary=TRUE)

# rmarkdown::render("./graphicsutils/README.Rmd","all")

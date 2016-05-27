# pkg2date.R
# scipt to update the package
# 2016-05-18
# Kevin Cazelles

args <- commandArgs(trailingOnly = TRUE)

## change working directory
setwd(args[1])

## update README / documentation
decor <- function(){
  cat("DONE  ", paste(rep("=",60), collapse=""), "\n")
}

if (!as.numeric(args[2])) {
  ##
  rmarkdown::render("README.Rmd", "all", quiet=TRUE)
} else {
  ## format the code
  cat("tidying ........")
  formatR::tidy_dir("./R")
  decor()
  ## load the package
  cat("loading ........")
  devtools::load_all(".")
  decor()
  ## document the package
  cat("documenting ....")
  devtools::document(".")
  decor()
  ## testing the code
  #cat("testing ........")
  #devtools::test()
  ## recording update
  cat(date(), "   DONE \n", file = "record_updates.txt", append=TRUE)
}

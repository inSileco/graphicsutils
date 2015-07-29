library(RCurl)
library(downloader)


plotImage <- function(obj=NULL,file=NULL,boxcol=0,...){

    require(jpeg)
    require(png)
    ## obj or file must be defined
    stopifnot(!is.null(c(obj,file,url)))
    ## obj class must be "nativeRaster" 
    if (!is.null(obj)) stopifnot(class(obj)=="nativeRaster")  
    ## if obj is not defined we use the file to define it
    else {
        # if the file ends with jpeg or jpg we use readJPG from "jpeg" package 
        # if the file ends with png we use readPNG from "png" package
        ext <- sapply(c(".jpeg$",".jpg$",".png$"),grepl,file)
        if (sum(ext)==0) stop("No method found for the given file.")
        nb <-which(ext==TRUE)
        if (nb==3) obj<-readPNG(file, native=TRUE)
        else obj<-readJPEG(file, native=TRUE)
    }

    dm <- dim(obj)
    plot(c(1,dm[1]), c(1,dm[2]), ann=FALSE, axes=FALSE, type="n")
    rasterImage(obj, 1, 1, dm[1], dm[2], ...)
    box(lwd=2,col=boxcol)
}


getIconNames <- function(){

    adr <- getURL("https://github.com/encharm/Font-Awesome-SVG-PNG/tree/master/black/png/128")
    wbp <- readLines(tc <- textConnection(adr))
    close(tc)
    wic <-  wbp[which(lapply(wbp, function(x) grep("\\.png",x))==1)]
    wic <- wic[which(lapply(wic, function(x) grep("span",x))==1)]
    wicl <- lapply(wic, function(x) strsplit(x,"href|>|.png")[[1]][7])
    return(unlist(wicl))

}

getIconFile <- function(name, res=128){

    if (!res%in%c(16,22,24,32,48,64,128,256)) stop("available resolution are c(16,22,24,32,48,64,128,256)")

    base <- "https://raw.githubusercontent.com/encharm/Font-Awesome-SVG-PNG/master/black/png/"
    tmp <- paste0(base,res,"/",name,".png?raw=true")
    tfile <- paste0(tempdir(),name,".png")
    download(tmp,destfile=tfile, quiet=TRUE)
    return(tfile)
}


ploticon <- function(name,res=128,plotnew=TRUE){

    tfile <- getIconFile(name=name,res=res)
    print(tfile)
    #pchimage(runif(10),runif(10),file=tfile)
    plotImage(file=tfile)
}


nameicon <- getIconNames()

andro <- getIconFile(nameicon[9])
apple <- getIconFile(nameicon[19])
linux <- getIconFile(nameicon[279])
flute <- getIconFile(nameicon[336])

plot0()
pchimage(5,5,file=andro, cex.x=2)
pchimage(-5,5,file=apple, cex.x=2)
pchimage(-5,-5,file=linux, cex.x=2)
pchimage(5,-5,file=flute, cex.x=2)


nameicon <- getIconNames()
par(mar=rep(1,4),mfrow=c(10,10))
for (i in 1:400) ploticon(name=nameicon[i])


pchimage(runif(10),runif(10),


#' Compass Rose
#'
#' Draw a compass rose fully customizable.
#'
#' @param percentage The percentage of the axis for which the values is returned.
#' @param x The x coordinates of the center of the compass rose.
#' @param y The y coordinates of the center of the compass rose.
#' @param rot Rotation for the compass rose in degrees (clockwise).
#' @param cex.cr The magnification to be used for the whole compass rose.
#' @param cex.let The magnification to be used for labels.
#' @param labels Labels for the cardinal direction.
#' @param offset Label offset of the cardinal points.
#' @param col Colors of the compass rose (see details).
#' @param border Colors of the borders of the compass rose.
#' @param lty Line type for the border lines.
#'
#' @details
#' This function draw a basic but fully personnalisable compassRose.
#' There already exists one compass rose by Jim Lemon in \code{sp} package.
#'
#' @export
#'
#' @examples
#' plot0()
#' compassRose2(0, rot=25)

#' @describeIn compassRose1 A compass rose with the four cardinal directions.
compassRose1<-
function(x, y=x, rot=0, cex.cr=1, cex.let=1, labels=c("S","W","N","E"), offset=1.2, col=c(1,8), border=c(1,8), lty=1){
    ## ---
    wh <- strheight("M")
    rot < -pi*rot/180
    mat.rot<-matrix(c(cos(rot),sin(rot),-sin(rot),cos(rot)),2)
    ## ---
    lwh <- cex.cr*4*wh
    swh <- cex.cr*.45*wh
    ## ---
    rex <- rep(c(0,-1,0,1),each=2)
    rey <- rep(c(-1,0,1,0),each=2)
    rex1 <- c(lwh*rex,swh*c(-1,1)*rey+rex*swh)
    rey1 <- c(lwh*rey,swh*c(-1,1)*rex+rey*swh)*rep(c(1,-1),each=2,4)
    # last multiplication for the color order
    matxy <- as.matrix(cbind(rex1,rey1))
    matxy <- matxy%*%mat.rot
    ## ---
    cr.col <- rep(col,length.out=8)
    cr.bd <- rep(border,length.out=8)
    ## ---
    for (i in 1:8) {
        polygon(cx+c(0,matxy[i,1],matxy[8+i,1]),cy+c(0,matxy[i,2],matxy[8+i,2]), col=cr.col[i], border=cr.bd[i], lty=lty)
    }
    text(cx+offset*matxy[seq(1,by=2,length.out=4),1],cy+offset*matxy[seq(1,by=2,length.out=4),2], labels, cex=cex.let)
}


#' @describeIn compassRose2 A compass rose with the four cardinal directions and additionnal directions.
#' @export
compassRose2<-
function(cx=0, cy=0, rot=0, cex.cr=1, cex.let=1, offset=1.2, col=c(1,8), border=c(1,8), lty=1){
    compassRose1(cx,cy,rot+22.5,cex.cr*0.65, label=rep("",4), cex.let=cex.let, offset=offset, col=col, border=border, lty=lty)
    compassRose1(cx, cy ,rot+67.5,cex.cr*0.65, label=rep("",4), cex.let=cex.let, offset=offset, col=col, border=border, lty=lty)
    compassRose1(cx,cy,rot+45,cex.cr*0.85, label=c("SW","NW","NE","SE"), cex.let=cex.let, offset=offset, col=col, border=border, lty=lty)
    compassRose1(cx, cy, rot, cex.cr, offset=offset, cex.let=cex.let, offset=offset, col=col, border=border, lty=lty)
}

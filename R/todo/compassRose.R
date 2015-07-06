compassRose <-
function(cx=0, cy=0, rot=0, cex.cr=1, cex.let=1, label=c("S","W","N","E"), offset=1.2, col=c(1,8), border=c(1,8)){
    
    #wh <- par()$usr[c(2,4)]-par()$usr[c(1,3)]
    wh <- strheight("M")

    rot <- pi*rot/180 
    mat.rot <- matrix(c(cos(rot),sin(rot),-sin(rot),cos(rot)),2)
    
    lwh <- cex.cr*4*wh
    swh <- cex.cr*.45*wh

    rex <- rep(c(0,-1,0,1),each=2)
    rey <- rep(c(-1,0,1,0),each=2)
    rex1 <- c(lwh*rex,swh*c(-1,1)*rey+rex*swh)
    rey1 <- c(lwh*rey,swh*c(-1,1)*rex+rey*swh)*rep(c(1,-1),each=2,4)
    # last multiplication for the color order
    matxy <- as.matrix(cbind(rex1,rey1))
    matxy <- matxy%*%mat.rot

    cr.col <- rep(col,length.out=8)
    cr.bd <- rep(border,length.out=8)

    for (i in 1:8) {
        polygon(cx+c(0,matxy[i,1],matxy[8+i,1]),cy+c(0,matxy[i,2],matxy[8+i,2]), col=cr.col[i], border=cr.bd[i])
    }
    text(cx+offset*matxy[seq(1,by=2,length.out=4),1],cy+offset*matxy[seq(1,by=2,length.out=4),2], label, cex=cex.let)

}

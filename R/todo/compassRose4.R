compassRose4 <-
function(cx=0, cy=0, rot=0,cex.cr=1, ...){
    compassRose(cx,cy,rot+22.5,cex.cr*0.65, offset=1.4, label=rep("",4), ...)
    compassRose(cx,cy,rot+67.5,cex.cr*0.65, offset=1.4,label=rep("",4), ...)
    compassRose(cx,cy,rot+45,cex.cr*0.85, offset=1.4, label=c("SW","NW","NE","SE"), cex.let=0.8,  ...)
    compassRose(cx,cy,rot,cex.cr,  ...)
}

library(readxl)
Ranalysis <- read_excel("/Users/balazslazar/Documents/WU Master/Master Thesis/GitHub/CONCAT4.xlsx")
library(TraMineR)
library(cluster)
library(DiagrammeR)
library(WeightedCluster)

dat = Ranalysis[ ,6:304]
alphab = c("build","version","software component","software testing","baseline","configuration","software quality","software engineering methods","configuration control","software requirements","document control","software engineering process","work product","software item","configuration management","software release management","configuration management system","baselince","software engineering models","software engineering management","software configuration")

seq = seqdef(dat, alphabet = alphab)

#computing LCS dissimilarity matrix
diss = seqdist(seq, method="LCS")


dissmfacw(diss ~ Ranalysis$Publisher, data=Ranalysis)

##Publisher Analysis
booktree=seqtree(seq ~ Ranalysis$Publisher, data = Ranalysis, pval = 0.05, diss = diss)
print(booktree)
#Analysing Publishers
seqtreedisplay(booktree, type = "d", sortv = cmdscale(sqrt(diss), k = 1), border=NA, show.tree = TRUE, show.depth = TRUE, filename="/Users/balazslazar/Downloads/retaintree.png", cex.legend = 1.1, ncol = 4, cex.main = 2)

clusterward = agnes(diss, diss = TRUE, method = "ward")
mvad.cl4 = cutree(clusterward, k=6)
cl4.lab = factor(mvad.cl4, labels = paste("Cluster", 1:6))
r = seqdplot(seq, group=cl4.lab, border = NA, cex.legend = .85, ncol = 4)
sp = seqplot(seq, group=NULL, type="d", xlab = "Position", axes = "all", cex.legend = .47, ncol =4, border = NA)

Rplot1 = hclust(as.dist(diss), method = "ward.D2")
Rplottree = as.seqtree(Rplot1, seqdata = seq, pval = 0.05, diss = diss, ncluster = 6)
seqtreedisplay(Rplottree, type = "d", border = NA, show.depth = TRUE, show.tree = TRUE, cex.legend = 1.1, ncol = 4, cex.main = 2)

library(ggplot2)

p <- boxplot(Length~Year, data = Ranalysis)
library(plot3D)
z=Ranalysis$Length
x=Ranalysis$`Number of Unique Keywords Used`
y=Ranalysis$Year
# grey background with white grid lines
scatter3D(x, y, z, phi = 0, bty = "g",  type = "h",  main = "Year Analysis", xlab = "Unique Keywords Used",
          ylab ="Year", zlab = "Sequence Length", ticktype = "detailed", pch = 19, cex = 0.5)

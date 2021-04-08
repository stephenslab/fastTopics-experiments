library(fastTopics)
load("../data/pbmc_68k.RData")
load("../output/pbmc68k/fits-pbmc68k.RData")
fits <- lapply(fits,poisson2multinom)
fit1 <- fits[["fit-pbmc68k-em-k=7"]]
fit2 <- fits[["fit-pbmc68k-scd-ex-k=7"]]
plot(fit1$L[,c(1:3,5)],fit2$L[,c(1:3,5)],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
plot(fit1$L[,c(4,6,7)],fit2$L[,c(4,6,7)],pch = 20)
abline(a = 0,b = 1,col = "skyblue",lty = "dotted")
celltype <- as.character(samples$celltype)
celltype[celltype == "CD56+ NK"] <- "NK"
celltype[celltype == "CD14+ Monocyte"] <- "CD14+"
celltype[celltype == "CD19+ B"] <- "B-cell"
celltype[celltype == "CD4+ T Helper2"] <- "T-cell"
celltype[celltype == "CD4+/CD25 T Reg"] <- "T-cell"
celltype[celltype == "CD4+/CD45RA+/CD25- Naive T"] <- "T-cell"
celltype[celltype == "CD8+ Cytotoxic T"] <- "T-cell"
celltype[celltype == "CD4+/CD45RO+ Memory"] <- "T-cell"
celltype[celltype == "CD8+/CD45RA+ Naive Cytotoxic"] <- "T-cell"
celltype <- factor(celltype)
loadings_plot(fit1,celltype)
loadings_plot(fit2,celltype)

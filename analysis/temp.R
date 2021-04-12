fit  <- fits[["fit-pbmc68k-scd-ex-k=7"]]
pca  <- prcomp(fit$L)$x
n    <- nrow(pca)
x    <- rep("U",n)
pc4  <- pca[,4]
pc6  <- pca[,6]
x[pc4 > 0.25] <- "A"
x[pc4 < -0.25] <- "B"
x[pc6 > 0.8] <- "C"
x <- factor(x)

pca_plot(fit,pcs = 1:2,fill = x)

table(samples$celltype,x)

topic_colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c",
                  "#fb9a99","#e31a1c","#fdbf6f")
set.seed(1)
rows <- sort(c(sample(which(x == "A"),500),
               sample(which(x == "B"),500),
               which(x == "C"),
               sample(which(x == "U"),1000)))
p3 <- structure_plot(select_loadings(fit,loadings = rows),
                     grouping = x[rows],topics = 1:7,colors = topic_colors,
                     n = Inf,perplexity = 70,gap = 30,num_threads = 4,
                     verbose = FALSE)


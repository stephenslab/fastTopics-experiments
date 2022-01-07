set.seed(1)
topics <- c(1:5,7,6)
topic_colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c",
                  "#fb9a99","#e31a1c","#fdbf6f")
fit1 <- fits[["fit-pbmc68k-scd-ex-k=7"]]
fit2 <- fits[["fit-pbmc68k-em-k=7"]]
rows <- sort(c(sample(which(clusters == "B"),746),
               sample(which(clusters == "CD14+dendritic"),806),
               which(clusters == "CD34+"),
               sample(which(clusters == "T+NK"),1213)))
fit1 <- select_loadings(fit1,loadings = rows)
fit2 <- select_loadings(fit2,loadings = rows)
tsne <- tsne_from_topics(fit1,dims = 1)
p1 <- structure_plot(fit1,loadings_order = order(tsne[,1]),
                     grouping = clusters[rows],topics = topics,
                     colors = topic_colors[topics],gap = 30)
p2 <- structure_plot(fit2,loadings_order = order(tsne[,1]),
                     grouping = clusters[rows],topics = topics,
                     colors = topic_colors[topics],gap = 30)
plot_grid(p1,p2,nrow = 2,ncol = 1)

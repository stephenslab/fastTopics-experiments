library(fastTopics)
library(ggplot2)
library(cowplot)

# Load the newsgroups data, the K = 10 topic model fit, and the
# results of running the DE analysis with this topic model.
load("../data/newsgroups.RData")
load("../output/newsgroups/fits-newsgroups.RData")
load("../output/newsgroups/de-newsgroups.RData")
fit <- fits[["fit-newsgroups-scd-ex-k=10"]]
fit <- poisson2multinom(fit)


# Create a Structure plot from the topic model.
set.seed(1)
topics <- factor(topics,
                 c("sci.med","rec.autos","rec.motorcycles","alt.atheism",
                 "soc.religion.christian","talk.religion.misc",
                 "rec.sport.baseball","rec.sport.hockey",
                 "talk.politics.mideast","talk.politics.guns","sci.crypt",
                 "talk.politics.misc","sci.space","sci.electronics",
                 "misc.forsale","comp.sys.ibm.pc.hardware",
                 "comp.sys.mac.hardware","comp.os.ms-windows.misc",
                 "comp.graphics","comp.windows.x"))
topic_colors <- c("#a6cee3","#1f78b4","#b2df8a","#33a02c","#fb9a99",
                  "#e31a1c","#fdbf6f","#ff7f00","#cab2d6","#6a3d9a")
p <- structure_plot(fit,grouping = topics,topics = 10:1,
                    colors = topic_colors,perplexity = 20,gap = 20)

# Visualize key words for topic 2 (cryptography, privacy).
volcano_plot(de,k = 2,ymax = 25,
             do.label = function (lfc, z) lfc > 5 | (z > 10 & lfc > 2))

# Visualize key words for topic 7 (medicine).
volcano_plot(de,k = 7,ymax = 20,
             do.label = function (lfc, z) lfc > 5 | (z > 10 & lfc > 2))

# Visualize key words for topic 9 (sports).
volcano_plot(de,k = 9,ymax = 30,
             do.label = function (lfc, z) lfc > 6 | (z > 12 & lfc > 2))

# Visualize key words for topic 7 (medicine).
volcano_plot(de,k = 7,ymax = 20,
             do.label = function (lfc, z) lfc > 5 | (z > 10 & lfc > 2))

# Visualize key words for topic 1.
volcano_plot(de,k = 1,
             do.label = function (lfc, z) lfc > 2 | (z > 10 & lfc > 1))

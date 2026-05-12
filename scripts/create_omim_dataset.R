# Script to generate a topic modeling data set using the OMIM
# database. This idea comes from Eraslan et al, Science (2022),
# doi:10.1126/science.abl4290 (see in particular "Topic modeling of
# OMIM diseases" in the supplementary text).
#
# See https://api.omim.org/api/html/ 
#
# Also see https://omim.org/help/faq for an explanation of the
# "prefix" for each entry.
#
# See https://www.omim.org/entry/272800 for an example OMIM entry
# (for Tay-Sachs disease).
#
# First I downloaded mim2gene.txt from 
# https://www.omim.org/downloads/
# 
# Also, need to set "apikey" variable before running.
#
library(Matrix)
library(tools)
library(httr)
library(jsonlite)

# Get the list of phenotypes.
mim2gene <- read.table("../data/mim2gene.txt.gz",sep = "\t",
                       header = FALSE)
names(mim2gene) <- c("mim","entry_type","gene_entrez","gene_hgnc","ensembl")
mim2gene <- transform(mim2gene,entry_type = factor(entry_type))
mim2gene <- subset(mim2gene,entry_type == "phenotype")

# Query the OMIM API to retrieve the disease descriptions.
# n <- nrow(mim2gene)
n <- 2000 # *** TESTING ***
meta_data <- data.frame(prefix         = rep(as.character(NA),n),
                        mim            = rep(0,n),
                        status         = rep(as.character(NA),n),
                        preferredTitle = rep(as.character(NA),n),
                        stringsAsFactors = FALSE)
tokens <- vector("list",n)
cat("Querying OMIM API: ")
for (i in 1:n) {
  mim <- mim2gene[i,"mim"]
  cat(mim,"")
  out <- GET(sprintf(paste("https://api.omim.org/api/entry?mimNumber=%d",
                           "include=text","format=json","apiKey=%s",sep="&"),
                     mim,apikey))
  dat <- fromJSON(rawToChar(out$content))
  dat <- dat[[1]]$entryList$entry
  meta_data[i,"prefix"] <- dat$prefix
  meta_data[i,"mim"]  <- dat$mimNumber
  meta_data[i,"status"] <- dat$status
  meta_data[i,"preferredTitle"] <- dat$titles$preferredTitle
  s <- dat$textSectionList[[1]]$textSection$textSectionContent
  s <- tolower(s)
  s <- str_remove_all(s,fixed("."))
  s <- str_remove_all(s,fixed(","))
  s <- str_remove_all(s,fixed("?"))
  s <- str_remove_all(s,fixed(":"))
  s <- str_remove_all(s,fixed(";"))
  s <- str_remove_all(s,fixed("'"))
  s <- str_remove_all(s,fixed('"'))
  s <- str_remove_all(s,fixed(")"))
  s <- str_remove_all(s,fixed("("))
  s <- str_remove_all(s,fixed("{"))
  s <- str_remove_all(s,fixed("}"))
  s <- str_replace_all(s,fixed("\n")," ")
  s <- strsplit(s," ")
  s <- unlist(s)
  s <- s[nchar(s) > 0]
  s <- s[is.element(substr(s,1,1),letters)]
  tokens[[i]] <- s
}
cat("\n")

# Keep only the entries with the "#" prefix which are "live"
i         <- which(with(meta_data,prefix == "#" & status == "live"))
meta_data <- meta_data[i,]
tokens    <- tokens[i]
meta_data <- transform(meta_data,
                       prefix = factor(prefix),
                       status = factor(status))

# Build the vocabulary.
cat("Building vocabulary: ")
vocabulary <- NULL
n <- nrow(meta_data)
for (i in 1:n) {
  mim <- mim2gene[i,"mim"]
  cat(mim,"")
  vocabulary <- c(vocabulary,unique(tokens[[i]]))
}
cat("\n")
vocabulary <- unique(vocabulary)
vocabulary <- sort(vocabulary)

# Convert the tokens to a (sparse) matrix of word counts.
cat("Converting tokens to sparse counts matrix: ")
rows   <- NULL
cols   <- NULL
values <- NULL
for (i in 1:n) {
  mim <- mim2gene[i,"mim"]
  cat(mim,"")
  x      <- table(tokens[[i]])
  m      <- length(x)
  j      <- match(names(x),vocabulary)
  rows   <- c(rows,rep(i,m))
  cols   <- c(cols,j)
  values <- c(values,x)
}
cat("\n")
counts <- sparseMatrix(i = rows,j = cols,x = values,
                       dims = c(n,length(vocabulary)))
rownames(counts) <- meta_data$mim
colnames(counts) <- vocabulary
rm(tokens)
gc(verbose = TRUE)

# Remove singletons.
x <- colSums(counts)
j <- which(x > 1)
counts <- counts[,j]

# This is the final size and sparsity of the counts matrix.
print(dim(counts))
print(nnzero(counts)/prod(dim(counts)))

# Save the data to an .RData file.
save(list = c("meta_data","counts"),
     file = "omim.RData")
resaveRdaFiles("omim.RData")

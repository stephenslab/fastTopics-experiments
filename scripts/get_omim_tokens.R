# First script I run to generate a topic modeling data set using the
# OMIM database. This idea comes from Eraslan et al, Science (2022),
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

# Query the OMIM API to first retrieve diseases' prefix and status.
n <- nrow(mim2gene)
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
                           "format=json","apiKey=%s",sep="&"),mim,apikey))
  dat <- fromJSON(rawToChar(out$content))
  meta_data[i,"prefix"] <- dat$omim$entryList$entry$prefix
  meta_data[i,"mim"]    <- dat$omim$entryList$entry$mimNumber
  meta_data[i,"status"] <- dat$omim$entryList$entry$status
  meta_data[i,"preferredTitle"] <- 
    dat$omim$entryList$entry$titles$preferredTitle
}
cat("\n")


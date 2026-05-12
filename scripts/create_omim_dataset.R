# Script to generate a topic modeling data set using the OMIM
# database. This idea comes from Eraslan et al, Science (2022),
# doi:10.1126/science.abl4290
#
# See https://api.omim.org/api/html/ 
#
# Also see https://omim.org/help/faq for an explanation of the
# "prefix" for each entry.
#
# First I downloaded mim2gene.txt from 
# https://www.omim.org/downloads/
# 
# Also, need to set "apikey" variable before running.
#
library(Matrix)
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
n <- 100 # *** TESTING ***
meta_data <- data.frame(prefix         = rep(as.character(NA),n),
                        mim            = rep(0,n),
                        status         = rep(as.character(NA),n),
                        preferredTitle = rep(as.character(NA),n))
tokens <- vector("list",n)
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
i <- which(with(meta_data,prefix == "#" & status == "live"))
meta_data <- meta_data[i,]
tokens    <- tokens[i]

# Convert the tokens to a (sparse) matrix of word counts.
# TO DO.

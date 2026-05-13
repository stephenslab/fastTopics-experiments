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
library(httr)
library(jsonlite)

# Search the OMIM API for all "live" entries with the "#" prefix.
omim_url <- "https://api.omim.org/api"
out <- GET(paste0(omim_url,
                  paste("/entry/search?search=prefix%3A%23",
                        "status=live","format=json","limit=10000",
                        "apiKey=",sep="&"),
                  apikey))
dat <- fromJSON(rawToChar(out$content))
meta_data <- 
  data.frame(
    mim    = dat$omim$searchResponse$entryList$entry$mimNumber,
    title  = dat$omim$searchResponse$entryList$entry$titles$preferredTitle,
    stringsAsFactors = FALSE)

# Retreive the text from the OMIM entries.
# n <- nrow(meta_data)
n <- 100 # *** TESTING ***
tokens <- NULL
mims   <- NULL
for (start in seq(0,n,20)) {
  cat(start,"")
  out <- GET(paste0(omim_url,
                    paste("/entry/search?search=prefix%3A%23",
                          "include=text","format=json",
                          paste0("start=",start),
                          "limit=20","apiKey=",sep="&"),
                    apikey))
  dat <- fromJSON(rawToChar(out$content))
  mims <- c(mims,dat$omim$searchResponse$entryList$entry$mimNumber)
  tokens_batch <- 
    lapply(dat$omim$searchResponse$entryList$entry$textSectionList,
           function (x) x$textSection$textSectionContent)
  tokens <- c(tokens,tokens_batch)
}
cat("\n")

#
# TO DO: Check that the MIM numbers agree.
#
print(all(meta_data$mim == mims))

#
# TO DO: Save the tokens to an .RData file.
#

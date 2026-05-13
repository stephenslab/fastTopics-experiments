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

stop()

# Retreive the text from the OMIM entries.
#
# NOTE: When doing this, make sure that the MIM numbers are the same
# as in the meta_data.
# 
n <- nrow(meta_data)
tokens <- NULL
for (start in seq(0,100,20)) {
  start_text <- paste0("start=",start)
  out <- GET(paste0(omim_url,
                    paste("/entry/search?search=prefix%3A%23",
                          "include=text","format=json",start_text,
                          "limit=20","apiKey=",sep="&"),
                    apikey))
  dat <- fromJSON(rawToChar(out$content))
tokens_batch <- 
  lapply(dat$omim$searchResponse$entryList$entry$textSectionList,
         function (x) x$textSection$textSectionContent)
}

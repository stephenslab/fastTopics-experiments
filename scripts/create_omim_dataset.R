# First run get_omim_tokens.R to query the OMIM API and retrieve the
# text data. This will create the input "omim_tokens.RData".
library(Matrix)
library(tools)
library(stringr)
load("omim_tokens.RData")

# Process the text data.
n <- nrow(meta_data)
for (i in 1:n) {
  cat(meta_data[i,"mim"],"")
  s <- unlist(tokens[[i]])
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
  s <- unlist(strsplit(s," "))
  s <- s[nchar(s) > 0]
  s <- s[is.element(substr(s,1,1),letters)]
  tokens[[i]] <- s
}
cat("\n")

# Build the vocabulary.
cat("Building vocabulary: ")
vocabulary <- NULL
n <- nrow(meta_data)
for (i in 1:n) {
  cat(meta_data[i,"mim"],"")
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
  cat(meta_data[i,"mim"],"")
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

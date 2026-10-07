# This is a stub function to take two strings
# and calculate the hamming distance
hamming <- function(strand1, strand2) {
  
  if (nchar(strand1) != nchar(strand2)) {
    stop("This function only supports calculation in strands with the same length")
  }

  vector_dna_strand1 <- unlist(strsplit(strand1, ""))
  vector_dna_strand2 <- unlist(strsplit(strand2, ""))
  
  sum(vector_dna_strand1 != vector_dna_strand2)
}
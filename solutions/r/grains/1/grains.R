square <- function(n) {
  ifelse(n > 64 | n <= 0, error("square must be between 1 and 64"), 2^(n-1))
}

total <- function() {
  accum_grains <- 0
  for (square_number in 1:64) {
    accum_grains <- accum_grains + square(square_number)
  }
  accum_grains
}
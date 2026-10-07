score <- function(x, y) {
  
  inner_radius  <-  1
  middle_radius <-  5
  outer_radius  <- 10

       if (x^2 + y^2 <= inner_radius^2)  {10}
  else if (x^2 + y^2 <= middle_radius^2) { 5}
  else if (x^2 + y^2 <= outer_radius^2)  { 1}
  else                              return(0)
  
}
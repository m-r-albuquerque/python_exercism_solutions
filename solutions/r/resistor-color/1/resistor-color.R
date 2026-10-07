colors <- c("black", "brown", "red", "orange", "yellow",
            "green", "blue", "violet", "grey", "white")

color_code <- function(color) {
  which(color == colors) - 1
}
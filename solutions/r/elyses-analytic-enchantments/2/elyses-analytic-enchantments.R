does_stack_include_card <- function(stack, card) {
  card %in% stack
}

get_card_position <- function(stack, card) {
  ifelse(does_stack_include_card(stack, card), which(card == stack)[1], -1)
}

is_each_card_even <- function(stack) {
  all(stack %% 2 == 0)
}

does_stack_include_odd_card <- function(stack) {
  any(stack %% 2 != 0)
}

get_first_odd_card <- function(stack) {
  ifelse(does_stack_include_odd_card(stack), stack[stack %% 2 != 0][1] , -1)
}

get_first_even_card_position <- function(stack) {
  ifelse(any(stack %% 2 == 0), which(stack %% 2 == 0)[1], -1)                     
}
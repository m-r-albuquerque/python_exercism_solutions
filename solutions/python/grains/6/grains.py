"""
Grãos de Milho no Tabuleiro:
Função que traz o cálculo da qtde em determinada casa do tabuleiro
"""
def square(number):
    # when the square value is not in the acceptable range
    if number > 64 or number <= 0:
        raise ValueError("square must be between 1 and 64")   
    square_grains = 2 ** (number - 1)
    return square_grains

"""
Grãos de Milho no Tabuleiro:
Função que traz o cálculo da qtde acumulada em todo o tabuleiro
"""
def total():
    accumulate_grains = 0 
    for number in range(1, 65):
        accumulate_grains = accumulate_grains + square(number)   
    return accumulate_grains
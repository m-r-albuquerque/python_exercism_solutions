"""
Problema dos Grãos de Milho no Tabuleiro de Xadrez
Função que traz o cálculo da qtde em determinada casa do tabuleiro 
"""
def square(nbr):
    # when the square value is not in the acceptable range
    if nbr > 64 or nbr <= 0:
        raise ValueError("square must be between 1 and 64")
    
    square_grains = 2 ** (nbr - 1)
    return square_grains

"""
Problema dos Grãos de Milho no Tabuleiro de Xadrez
Função que traz o cálculo da qtde acumulada até a casa 64 do tabuleiro"""
def total():
    accumulate_grains = 0
        
    for square_number in range(1, 65):
        accumulate_grains = accumulate_grains + square(square_number)
        
    return accumulate_grains
"""This function return the points scored in the Darts game
according the coordinates of where the dart landed"""
def score(x, y):
    """Function returning the score"""
    inner_radius = 1
    middle_radius = 5
    outer_radius = 10
    
    if x ** 2 + y ** 2 <= inner_radius ** 2:
        return 10
    elif x ** 2 + y ** 2 <= middle_radius ** 2:
        return 5
    elif x ** 2 + y ** 2 <= outer_radius ** 2:
        return 1
    return 0
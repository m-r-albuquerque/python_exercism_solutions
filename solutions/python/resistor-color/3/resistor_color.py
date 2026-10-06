"""
Constant definition according the resistors colors
in the correct order to the index
"""
COLORS_LIST = ["black",
    "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

"""
This function returns the index related to a specific color
"""
def color_code(color):
    """Fuction creation"""
    for index, name_color in enumerate(COLORS_LIST):
        if name_color == color:
            return index

def colors():
    """Fuction creation"""
    return COLORS_LIST
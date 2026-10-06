"""
Constant definition according the resistors colors
in the correct order to the index
"""
COLORS_LIST = ["black",
    "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

"""
This function returns the index related to the first two colors
showing in the arguments' slot
"""
def value(colors):
    """Fuction creation"""
    return COLORS_LIST.index(colors[0]) * 10 + COLORS_LIST.index(colors[1])
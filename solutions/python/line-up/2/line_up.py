"""
This function returns a phrase for the client in the line up,
according his name and position in line
"""
def line_up(name, number):
    """Function creation to brings the phrase to the client"""
    if str(number)[-1] == "1" and str(number)[-2:] != "11":
        return f"{name}, you are the {number}st customer we serve today. Thank you!"
    if str(number)[-1] == "2" and str(number)[-2:] != "12":
        return f"{name}, you are the {number}nd customer we serve today. Thank you!"
    if str(number)[-1] == "3" and str(number)[-2:] != "13":
        return f"{name}, you are the {number}rd customer we serve today. Thank you!"
    return f"{name}, you are the {number}th customer we serve today. Thank you!"
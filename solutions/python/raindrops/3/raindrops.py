"""Module providing a function for the classic Raindrops exercise"""
def convert(number):
    """Function 'convert' brings the resultant string according the exercise criteria"""
    result = ""
    if number % 3 == 0:
        result = result + "Pling"
    if number % 5 == 0:
        result = result + "Plang"
    if number % 7 == 0:
        result = result + "Plong"
    if result == "":
        result = str(number)
    return result

"""
This fuction verifies if the isbn displayed
is a valid ISBN number or not
"""
def is_valid(isbn):
    """Fucntion creation"""    
    # Remove "-"
    isbn = isbn.replace("-", "")

    # Do we have the right number of symbols?
    if len(isbn) != 10:
        return False

    # Is this a valid check digit?
    check_digit = isbn[-1]
    if not check_digit in "0123456789X":
        return False

    # Rest of string should not be letters, instead numbers:
    for item in isbn[:-1]:
        if not item in "0123456789":
            return False

    list_digits = []
    for index in range(0, 10):
        list_digits.append(isbn[index])

    list_factors = range(10, 0, -1)

    list_products = []
    
    for index in range(0, 10):
        if list_digits[index] == "X":
            list_digits[index] = "10"
        list_products.append(int(list_digits[index]) * int(list_factors[index]))

    return sum(list_products) % 11 == 0
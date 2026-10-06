def is_valid(isbn: str) -> bool:
    
    # Remove "-"
    isbn = isbn.replace("-", "")

    # Do we have the right number of symbols?
    if len(isbn) != 10:
        return False

    # Is this a valid check digit?
    check = isbn[-1]
    if not check in "0123456789X":
        return False

    # Rest of string should be letters
    for ch in isbn[:-1]:
        if not ch in "0123456789":
            return False

    list_digits = []
    for i in range(0, 10):
        list_digits.append(isbn[i])

    list_factors = range(10, 0, -1)

    list_products = []
    
    for i in range(0, 10):
        if list_digits[i] == "X":
            list_digits[i] = "10"
        list_products.append(int(list_digits[i]) * int(list_factors[i]))

    return (sum(list_products) % 11 == 0)   
def is_armstrong_number(number):
    """
    This function calculates the Armstrong number:
    is a number that is the sum of its own digits 
    each raised to the power of the number of digits
    """

    #list with the digits of the number
    digit_list = [int(digit) for digit in str(number)]
    
    armstrong_sum = 0

    #loop to reach the calculations needed:
    for index in digit_list:
        factor = index ** len(digit_list)
        armstrong_sum = armstrong_sum + factor
    
    if number == armstrong_sum:
        return True
    else:
        return False
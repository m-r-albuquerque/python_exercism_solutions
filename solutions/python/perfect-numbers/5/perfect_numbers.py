"""This function verifies the Perfect Numbers according 
the classification scheme created by Nicomachus' (60 - 120 CE)"""
def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    factors = []

    if number <= 0 or not isinstance(number, int):
        raise ValueError("Classification is only possible for positive integers.")
        
    for factor in range(1, number // 2 + 1):
        if number % factor == 0:
            factors.append(factor)
    if sum(factors) == number: return "perfect"
    if sum(factors) > number:  return "abundant"
    if sum(factors) < number:  return "deficient"
    return None
"""Verifying the Triangle Format"""

def equilateral(sides):
    """This function verifies if the triangle is equilateral"""
    a, b, c = sides
    lenght_sides = (a + b >= c) and (b + c >= a) and (a + c >= b)
    if (a <= 0 or b <= 0 or c <= 0) or not lenght_sides:
        return False
    if a == b == c:
        return True
    return False

def isosceles(sides):
    """This function verifies if the triangle is isosceles"""
    a, b, c = sides
    lenght_sides = (a + b >= c) and (b + c >= a) and (a + c >= b)
    if (a <= 0 or b <= 0 or c <= 0) or not lenght_sides:
        return False
    if a == b or b == c or a == c:
        return True
    return False


def scalene(sides):
    """This function verifies if the triangle is scalene"""
    a, b, c = sides
    lenght_sides = (a + b >= c) and (b + c >= a) and (a + c >= b)
    if (a <= 0 or b <= 0 or c <= 0) or not lenght_sides:
        return False
    if a != b and b != c and a != c:
        return True
    return False

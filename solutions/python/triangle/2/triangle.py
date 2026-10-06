"""Verifying the Triangle Format"""

def equilateral(sides):
    """This function verifies if the triangle is equilateral"""
    side_a, side_b, side_c = sides
    lenght_sides = (side_a + side_b >= side_c) and (side_b + side_c >= side_a) and (side_a + side_c >= side_b)
    if (side_a <= 0 or side_b <= 0 or side_c <= 0) or not lenght_sides:
        return False
    if side_a == side_b == side_c:
        return True
    return False

def isosceles(sides):
    """This function verifies if the triangle is isosceles"""
    side_a, side_b, side_c = sides
    lenght_sides = (side_a + side_b >= side_c) and (side_b + side_c >= side_a) and (side_a + side_c >= side_b)
    if (side_a <= 0 or side_b <= 0 or side_c <= 0) or not lenght_sides:
        return False
    if side_a == side_b or side_b == side_c or side_a == side_c:
        return True
    return False


def scalene(sides):
    """This function verifies if the triangle is scalene"""
    side_a, side_b, side_c = sides
    lenght_sides = (side_a + side_b >= side_c) and (side_b + side_c >= side_a) and (side_a + side_c >= side_b)
    if (side_a <= 0 or side_b <= 0 or side_c <= 0) or not lenght_sides:
        return False
    if side_a != side_b and side_b != side_c and side_a != side_c:
        return True
    return False

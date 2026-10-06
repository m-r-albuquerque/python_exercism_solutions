"""Leap Year: True or False"""

def leap_year(year):
    """This function brings the calculation if certain year is leap or not"""
    return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)

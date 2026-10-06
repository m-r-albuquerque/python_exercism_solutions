number = 12

def steps(number):
    steps = 0
    if number < 1:
        raise ValueError("Only positive integers are allowed")
    if number == 1:
        return steps
    result = number
    while result > 1:
        if result % 2 == 0:
            result = result // 2
            steps = steps + 1
            if result == 1:
                return steps
        else:
            result = result * 3 + 1
            steps = steps + 1
    return steps

steps(number)

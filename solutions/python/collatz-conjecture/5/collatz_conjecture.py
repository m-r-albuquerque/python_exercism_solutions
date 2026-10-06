def steps(number):
    count_steps = 0
    if number < 1:
        raise ValueError("Only positive integers are allowed")
    if number == 1:
        return count_steps
    result = number
    while result > 1:
        if result % 2 == 0:
            result = result // 2
            count_steps = count_steps + 1
            if result == 1:
                return count_steps
        else:
            result = result * 3 + 1
            count_steps = count_steps + 1
    return count_steps

steps(12)

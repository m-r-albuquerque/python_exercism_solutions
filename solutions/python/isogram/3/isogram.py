"""
This function verifies if a phrase is a isogram
(a word or phrase without a repeating letter, 
however spaces and hyphens are allowed to appear multiple times)
"""
def is_isogram(phrase):
    """Function for isogram verification"""
    phrase = phrase.lower() # this funtion isn't case sensitive
    counter = {} # dict to brings the letters (keys) and qtt (values)

    # frequency counter of each item in phrase
    for letter in phrase:
        if letter in counter:
            counter[letter] += 1
        else:
            counter[letter] = 1

    # dict creation and decision according the criteria 
    for letter, qtde in counter.items():
         
        if letter == " ":
            continue
        if qtde > 1 and letter != "-":
            return False
    
    return True

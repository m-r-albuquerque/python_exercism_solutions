"""
This function verifies if a sentence is a 'Pangram', that is:
if it contains all the letters of the alphabet
"""
def is_pangram(sentence):
    """Function creation"""
    alphabet = "abcdefghijklmnopqrstuvwxyz"
    lower_sentence = sentence.lower()

    for letter in alphabet:
        if letter not in lower_sentence:
            return False
    return True
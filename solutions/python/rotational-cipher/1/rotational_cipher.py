"""
This fuction creates the alghoritm for the Rotational Cipher
"""
def rotate(text, key):
    """Function creation"""
    result = ""

    for letter in text:
        if "a" <= letter <= "z":
            position = ord(letter) - ord("a")
            new_position = (position + key) % 26
            result += chr(new_position + ord("a"))
        elif "A" <= letter <= "Z":
            position = ord(letter) - ord("A")
            new_position = (position + key) % 26
            result += chr(new_position + ord("A"))
        else:
            result += letter
    return result
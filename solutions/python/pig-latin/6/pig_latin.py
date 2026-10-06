"""This fuction does the translation from English to 'Pig Latin', covering all his internal rules"""
def translate(text):
    """Function creation"""
    
    # variables definition
    vowels = {"a", "e", "i", "o", "u"}
    vowels_y = {"a", "e", "i", "o", "u", "y"}
    specials = {"xr", "yt"}
    
    piggyfied = []

    for word in text.split():
        if word[0] in vowels or word[0:2] in specials:
            piggyfied.append(word + "ay")
            continue

        for pos in range(1, len(word)):
            if word[pos] in vowels_y:
                final_pos = pos + (1 if word[pos] == "u" and word[pos - 1] == "q" else 0)
                piggyfied.append(word[final_pos:] + word[:final_pos] + "ay")
                break

    return " ".join(piggyfied)
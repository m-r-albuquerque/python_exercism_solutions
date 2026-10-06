"""This function gives the 'Bobs' response for each kind of entry argument or question, according some rules"""

def response(hey_bob):
    """Function creation for the Bob conversation method"""
    hey_bob = hey_bob.strip()

    if not hey_bob:
        return "Fine. Be that way!"

    is_shout = hey_bob.isupper()    
    is_question = hey_bob.endswith("?")

    if is_shout and is_question:
        return "Calm down, I know what I'm doing!"
    if is_question:
        return "Sure."
    if is_shout:
        return "Whoa, chill out!"
    return "Whatever."
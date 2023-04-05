import re


def capital_space(s:str)-> str:
    regex = r"(?<!^)(?=[A-Z])"
    modify_str = re.sub(regex, r" ", s)
    return modify_str



test = capital_space("TheFirstProgrammingBootcamp")
print(test)

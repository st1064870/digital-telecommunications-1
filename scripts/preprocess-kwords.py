import string

with open('kwords.txt') as kw, open('pkwords.txt',"w+") as pkw:
    str = "".join(line.strip() for line in kw)
    for char in string.punctuation + string.whitespace:
        str = str.replace(char,"").lower()
    pkw.write(str)
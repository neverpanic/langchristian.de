import markdown as md

def markdown(value):
    return md.markdown(value, output_format="html5", tab_length=2)

def fromfile(filename):
    with open(filename, "r", encoding="utf-8") as inf:
        text = inf.read()
    return text

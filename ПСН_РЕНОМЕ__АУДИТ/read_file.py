import sys

with open(sys.argv[1], 'r', encoding='cp1251') as f:
    lines = f.readlines()
    for line in lines[:100]:
        print(line, end='')
import sys

if len(sys.argv) < 2:
    print("Usage: python read_file_part.py <filepath> [start] [end]")
    sys.exit(1)

filepath = sys.argv[1]
start = int(sys.argv[2]) if len(sys.argv) > 2 else 0
end = int(sys.argv[3]) if len(sys.argv) > 3 else 100

with open(filepath, 'r', encoding='cp1251') as f:
    content = f.read()
    lines = content.split('\n')
    for line in lines[start:end]:
        print(line)
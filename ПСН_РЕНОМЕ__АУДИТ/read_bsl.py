import sys

# Определяем кодировку
try:
    with open(sys.argv[1], 'r', encoding='cp1251') as f:
        content = f.read()
except:
    try:
        with open(sys.argv[1], 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        with open(sys.argv[1], 'r', encoding='cp866') as f:
            content = f.read()

# Выводим первые 100 строк
lines = content.split('\n')[:100]
print('\n'.join(lines))
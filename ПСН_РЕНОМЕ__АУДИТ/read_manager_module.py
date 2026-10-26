import sys

filepath = r'src\DataProcessors\ФинансовыйРезультат\ManagerModule.bsl'

try:
    with open(filepath, 'rb') as f:
        raw = f.read()
    
    # Try UTF-8 first
    try:
        text = raw.decode('utf-8')
        encoding = 'utf-8'
    except UnicodeDecodeError:
        # Try CP1251
        text = raw.decode('cp1251')
        encoding = 'cp1251'
    
    lines = text.split('\n')
    print(f"File read successfully with encoding: {encoding}")
    print(f"Total lines: {len(lines)}")
    print()
    
    # Print first 100 lines
    print("=" * 80)
    print("FIRST 100 LINES:")
    print("=" * 80)
    for i, line in enumerate(lines[:100], 1):
        print(f"{i:4d}: {line}")
    
    print()
    print("=" * 80)
    print("LINES 101-200:")
    print("=" * 80)
    for i, line in enumerate(lines[100:200], 101):
        print(f"{i:4d}: {line}")
    
    print()
    print("=" * 80)
    print("LINES 201-300:")
    print("=" * 80)
    for i, line in enumerate(lines[200:300], 201):
        print(f"{i:4d}: {line}")
        
except Exception as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)
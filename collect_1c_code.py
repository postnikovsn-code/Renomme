#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Скрипт для сбора всего кода 1С из проекта EDT в один текстовый файл.
Сохраняет структуру путей и имена файлов для контекста.
"""

import os
import sys
from pathlib import Path
from datetime import datetime

def collect_1c_code(root_dir, output_file):
    """
    Собирает все файлы .bsl из директории root_dir в один файл output_file.
    
    Args:
        root_dir: Корневая директория проекта 1С (EDT)
        output_file: Путь к выходному файлу
    """
    root_path = Path(root_dir)
    
    if not root_path.exists():
        print(f"Ошибка: Директория {root_dir} не найдена")
        return False
    
    # Находим все файлы .bsl
    bsl_files = sorted(root_path.rglob("*.bsl"))
    
    if not bsl_files:
        print(f"Предупреждение: Файлы .bsl не найдены в {root_dir}")
        return False
    
    print(f"Найдено файлов .bsl: {len(bsl_files)}")
    
    with open(output_file, 'w', encoding='utf-8') as out_f:
        # Заголовок
        out_f.write("=" * 80 + "\n")
        out_f.write("СОБРАННЫЙ КОД ПРОЕКТА 1С (EDT)\n")
        out_f.write(f"Дата генерации: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        out_f.write(f"Корневая директория: {root_path.absolute()}\n")
        out_f.write(f"Всего файлов: {len(bsl_files)}\n")
        out_f.write("=" * 80 + "\n\n")
        
        # Оглавление
        out_f.write("ОГЛАВЛЕНИЕ:\n")
        out_f.write("-" * 80 + "\n")
        for idx, file_path in enumerate(bsl_files, 1):
            rel_path = file_path.relative_to(root_path)
            out_f.write(f"{idx:4d}. {rel_path}\n")
        out_f.write("-" * 80 + "\n\n")
        
        # Содержимое файлов
        for idx, file_path in enumerate(bsl_files, 1):
            rel_path = file_path.relative_to(root_path)
            
            out_f.write("\n" + "=" * 80 + "\n")
            out_f.write(f"Файл #{idx}: {rel_path}\n")
            out_f.write("=" * 80 + "\n\n")
            
            try:
                with open(file_path, 'r', encoding='utf-8') as in_f:
                    content = in_f.read()
                    out_f.write(content)
                    if not content.endswith('\n'):
                        out_f.write('\n')
            except Exception as e:
                error_msg = f"Ошибка чтения файла: {e}\n"
                out_f.write(error_msg)
                print(f"Ошибка при чтении {rel_path}: {e}")
            
            out_f.write("\n")
    
    # Размер выходного файла
    output_size = Path(output_file).stat().st_size
    size_mb = output_size / (1024 * 1024)
    
    print(f"Успешно собрано {len(bsl_files)} файлов")
    print(f"Выходной файл: {output_file}")
    print(f"Размер выходного файла: {size_mb:.2f} МБ")
    
    return True

if __name__ == "__main__":
    # По умолчанию ищем проект в текущей директории или используем аргумент
    if len(sys.argv) > 1:
        project_dir = sys.argv[1]
    else:
        # Автоматический поиск директории с проектом 1С
        workspace = Path("/workspace")
        project_dirs = [d for d in workspace.iterdir() if d.is_dir() and not d.name.startswith('.')]
        
        if len(project_dirs) == 1:
            project_dir = str(project_dirs[0])
        elif len(project_dirs) > 1:
            # Ищем директорию, содержащую файлы .bsl
            for d in project_dirs:
                if list(d.rglob("*.bsl")):
                    project_dir = str(d)
                    break
            else:
                project_dir = str(project_dirs[0])
        else:
            project_dir = "/workspace"
    
    output_file = "/workspace/1c_project_full_code.txt"
    
    print(f"Сбор кода из директории: {project_dir}")
    print(f"Выходной файл: {output_file}")
    print("-" * 50)
    
    success = collect_1c_code(project_dir, output_file)
    
    if success:
        print("\nГотово! Теперь вы можете загрузить файл 1c_project_full_code.txt для анализа.")
    else:
        print("\nПроизошла ошибка при сборе кода.")
        sys.exit(1)

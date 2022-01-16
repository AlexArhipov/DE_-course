
import os
import tempfile
from sys import argv
import json
import os.path

def append_dic(dic):
    """Открываем файл для редкатирования и вносим новые значения в словарь ключей"""
    with open(storage_path, 'w+') as f:
        if argv[2] in dic:
            dic[argv[2]].append(argv[4])
        else:
            dic[argv[2]] = []
            dic[argv[2]].append(argv[4])
        json.dump(dic, f)

def add_key():
    """Режим добавления ключей"""
    dic = {}
    if os.path.exists(storage_path):
        with open(storage_path) as f:
            dic = json.load(f)
    append_dic(dic)

def show_key():
    """Режим отображения значения по ключу"""
    if os.path.exists(storage_path):
        with open(storage_path, 'r') as f:
            dic = json.load(f)
            if argv[2] in dic:
                print(*dic[argv[2]], sep=', ')
            else:
                print("Нет такого ключа")
    else:
        print("Ошибка чтения файла")

storage_path = os.path.join(tempfile.gettempdir(), 'storage.data')
if len(argv) == 5:
    add_key()
elif len(argv) == 3:
    show_key()
else:
    print("Не верный формат ввода данных")

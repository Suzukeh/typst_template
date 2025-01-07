#変換対象のファイル名(拡張子なし)
filename="refs"

import bibtexparser #bibファイルのパーサー pip install --no-cache-dir --force-reinstall git+https://github.com/sciunto-org/python-bibtexparser@main
import yaml #ymlファイルのパーサー pip install pyyaml
from pathlib import Path
import subprocess
import sys

#zoteroからエクスポートしたbibファイルをhayagrivaでymlに変換する
bibpath = Path(__file__).parents[0]/Path("./" + filename + ".bib")
ymlpath = Path(__file__).parents[0]/Path("./" + filename + ".yml")

#hayagrivaの実行
#powershellでも動く
#シェルでリダイレクトの上書き許可(clobber)がされているか注意
haya_run="hayagriva \""+str(bibpath)+"\" > \""+ str(ymlpath)+"\""
print(haya_run)
subprocess.call(haya_run,shell=True)


#欠落したlanguageを補完する
# ただし、andありなし問題対応が目的なのでjp系のみが対象

#想定される日本語ロケール
jpcode=["ja","ja-JP","japanese","jp"]

#bibファイルの読み込み(パーサー)
with open(bibpath, "r",encoding='utf-8') as file:
    bib = bibtexparser.parse_string(file.read())

#languageが日本語のものをリストアップ
haslang = {} #key:entry.key, value:language
for entry in bib.entries:
    ent_dict = entry.fields_dict
    key=entry.key
    if "language" in ent_dict:
        language = ent_dict["language"].value
        #print(key,language)
        if language in jpcode:
            haslang[key]=language
    else:
        #print(key,"[no language]")
        continue

#ymlファイルの読み込み(パーサー)
with open(ymlpath, 'r', encoding='utf-8') as file:
    yml = yaml.safe_load(file)

#languageを追加
for key, value in haslang.items():
    if key in yml:
        if "language" in yml[key]:
            print(key, "[already has language]")
        else:
            yml[key]["language"]=value
            print(key, "added", value)
    else:
        print(key,"not found in yml")

#ymlファイルの書き込み
with open(ymlpath, 'w', encoding='utf-8') as file:
    yaml.safe_dump(yml, file, default_flow_style=False, allow_unicode=True)
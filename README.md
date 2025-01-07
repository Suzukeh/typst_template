# typstテンプレート
VSCode(tinymist) + typst + Zotero環境で卒論を書くためのテンプレート

# 導入
以下をcloneまたはダウンロード
```
sample.typ サンプル文書
lib.typ テンプレート
refs.yml typst用の参考文献書式Hayagrivaで書かれたyml
libs/
  bxjaref.typ 日本語参照環境
  noandjp.csl 参考文献で日本語の著者にandがいらない問題の解決
```
必要に応じて以下を追加する
```
main.typ サンプル抜きの最小構成(コピペ用)
refs.bib ZoteroのBetter BibTeXからエクスポートされた想定のbib
bib2hayaml.py bibからymlの変換(languageの修復機能付き)
```

# 使い方
typst本体とVSCodeのtynymist拡張機能を導入する。やり方はtypst-jp-conf-templateの [ローカル開発環境構築](https://github.com/m20027/typst-jp-conf-template?tab=readme-ov-file#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89) を参照。

* 本文はsample.typ または main.typの`#show: project.with(~~`以下の行に書き込む
* テンプレートを編集したいときはlib.typを編集したりlibs/以下に新しいtypファイルを追加したりする
* 参考文献リストを変更したいとき
  * 文献管理ソフトを使っていない場合はymlを直接編集する
  * ZoteroのBetterBibTeXでbibファイルをauto export (または別ソフトで相当する機能) している場合は、適宜bib2hayaml.pyを実行してymlに変換する<br>
    bib2hayaml.py内のfilename変数はあらかじめ書き換えておく
* 参考文献の書式を変更したいときはnoandjp.cslを編集するか、新しいcslファイルを作成して本文ファイルの参照先をそちらにする

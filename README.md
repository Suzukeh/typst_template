# typstテンプレート
VSCode(tinymist) + typst + Zotero環境で卒論を書くためのテンプレート

サンプル https://suzukeh.github.io/typst_template/sample.pdf

# 導入
以下をcloneまたはダウンロード。
```
sample.typ  サンプル文書
lib.typ  テンプレート
refs.yml  typst用の参考文献書式Hayagrivaで書かれたyml
libs/
  bxjaref.typ  日本語参照環境
  noandjp.csl  参考文献で日本語の著者にandがいらない問題の解決
```

必要に応じて以下を追加する。
```
main.typ  サンプル抜きの最小構成(コピペ用)
refs.bib  ZoteroのBetter BibTeXからエクスポートされた想定のbib
bib2hayaml.py  bibからymlの変換(languageの修復機能付き)
```

bib2hayaml.pyを使用する場合はpipで依存関係をインストールする。
```
pip install --no-cache-dir --force-reinstall git+https://github.com/sciunto-org/python-bibtexparser@main
pip install pyyaml
```


原ノ味フォントのインストールを推奨。<br>
TeXLive2020以降における標準の日本語フォントなので、LaTeXと同じ雰囲気の文書が作りやすい。<br>
https://www.ctan.org/pkg/haranoaji <br>
zipの中にあるotfをすべてインストールする。

# 使い方
typst本体とVSCodeのtynymist拡張機能を導入する。<br>
やり方・使い方はtypst-jp-conf-templateの [ローカル開発環境構築](https://github.com/m20027/typst-jp-conf-template?tab=readme-ov-file#%E3%83%AD%E3%83%BC%E3%82%AB%E3%83%AB%E9%96%8B%E7%99%BA%E7%92%B0%E5%A2%83%E6%A7%8B%E7%AF%89) ・ [VS Code を使用する場合](https://github.com/m20027/typst-jp-conf-template?tab=readme-ov-file#vs-code-%E3%82%92%E4%BD%BF%E7%94%A8%E3%81%99%E3%82%8B%E5%A0%B4%E5%90%88)を参照。

* 本文はsample.typ または main.typの`#show: project.with(~~`以下の行に書き込む。
* テンプレートを編集したいときはlib.typを編集したりlibs/以下に新しいtypファイルを追加したりする<br>
  libs/以下に追加した場合は`#import "libs/mytemplate.typ": *`のようにlib.typへ追記する
* 参考文献リストを変更したいとき
  * 文献管理ソフトを使っていない場合はymlを直接編集する。
  * ZoteroのBetterBibTeXでbibファイルをauto export (または別ソフトで相当する機能) している場合は、適宜bib2hayaml.pyを実行してymlに変換する。<br>
    bib2hayaml.py内のfilename変数はあらかじめ書き換えておく。
* 参考文献の書式を変更したいときはnoandjp.cslを編集するか、新しいcslファイルを作成する。<br>
  新しいcslファイルを作成した場合は本文ファイル末尾の`#bibliography(..., style: "libs/noandjp.csl")`の参照先を変更する。

# 日本語文献の著者にandがいらない問題
このテンプレートにbib2hayaml.pyが必要な理由がこれ。

ymlで日本語の文献にだけlanguageフィールドを用意すればCSL側で判別が付くようになって解決する
<br>vs<br>
`hayagriva refs.bib > refs.yml` で生成されるymlにはlanguageフィールドがない

ので、pythonでちょっといじってlanguageフィールドを復活させた。

~~(どっかで別記事にするかも)~~<br>
書いた。

https://qiita.com/Suzukeh/items/986793803f8ae0158122

# その他
* Table Generatorが便利<br>
https://gitlab.mma.club.uec.ac.jp/gae/typst-for-ekken#typst-table-generator
* Actionsでコンパイルしてpagesで公開するの、これ参考にした<br>
  https://github.com/SnO2WMaN/typst-report-template/actions/runs/12272935678/workflow
* これ誰かどうにかして(他力本願)<br>
  https://github.com/typst/hayagriva/issues/263

# 参考

* https://github.com/satshi/typst-jp-template/
* https://github.com/kimushun1101/typst-ja-conf-template
* https://gist.github.com/zr-tex8r/d758ec18e69165e601436e0efd93e0d1

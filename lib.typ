
//参考
//https://github.com/satshi/typst-jp-template/
// https://github.com/kimushun1101/typst-ja-conf-template
//https://gist.github.com/zr-tex8r/d758ec18e69165e601436e0efd93e0d1

//ありがとう
//https://gitlab.mma.club.uec.ac.jp/gae/typst-for-ekken/-/blob/main/tablegenerator.js

#import "@preview/unify:0.7.0": * //siunitx 単位のやつ色々あるけど、rangeと不確かさ両対応はこれだけっぽい
#import "@preview/physica:0.9.3": * //数式記号

#import "@preview/whalogen:0.2.0": * //mhchem 化学式

#import "@preview/quick-maths:0.2.0": shorthands //数式スニペット

#import "@preview/showybox:2.0.1": * //枠線


#import "libs/bxjaref.typ": * //日本語ref
#import "libs/temporary.typ": * //書類ごとの一時的な設定用 単語とか
//fake-bibliographyは色々あって不採用
// CSLでの対応に切り替えた
//#import "bib.typ": fake-bibliography //日本語vs英語文献のand問題を解決
//#let std-bibliography = bibliography

//呼び出し用関数

#let project(fontsize: 11pt, body) = {
  show: use-ja-ref //bxjaref

  //フォント設定
  // LuaLaTeXの再現
  //https://ctan.org/pkg/newcomputermodern ←Mathも入れる
  //https://www.ctan.org/pkg/haranoaji ←全部
  let serif = ("New Computer Modern", "Harano Aji Mincho", "Noto Serif JP")
  let sans = ("Harano Aji Gothic", "Noto Sans JP")
  set text(lang: "ja", font: serif, fontsize)
  show math.equation: set text(font: "New Computer Modern Math") //数式のフォント
  show raw: set text(font: ("HackGenNerd", "DejaVu Sans Mono")) //コードブロックのフォント

  //A4用紙
  set page(
    paper: "a4",
    margin: auto,
  )

  set par(justify: true) //両端揃え

  set page(numbering: "1", number-align: center) //ページ

  // 行間の調整
  set par(
    leading: 1em,
    justify: true,
    first-line-indent: 1.1em,
  )
  set par(spacing: 1.2em)


  show heading: set block(above: 1.6em, below: 0.6em)

  set heading(numbering: "1.") //見出しの番号
  show heading: set text(font: sans) //見出しのフォント

  // 見出しの下の段落を字下げするため & 見出しの上下のスペースを調整
  show heading: it => {
    par(text(size: 0em, ""))
    it
    par(text(size: 0em, ""))
  }

  // 数式番号
  set math.equation(numbering: "(1)")
  show ref: it => {
    let eq = math.equation
    let el = it.element
    if el != none and el.func() == eq {
      // Override equation references.
      link(
        el.label,
        numbering(
          el.numbering,
          ..counter(eq).at(el.location()),
        ),
      )
    } else {
      // Other references as usual.
      it
    }
  }


  let hbar = (sym.wj, text(font: "New Computer Modern Math")[#math.planck.reduce], sym.wj).join()


  set table(inset: 7pt, align: horizon)

  set table(stroke: none)
  set table.hline(stroke: .5pt)
  set table.vline(stroke: .5pt)
  show figure.where(kind: table): set figure.caption(position: top)


  // 図のキャプション
  set figure(gap: 0.5em)
  show figure.caption: it => [
    #block(width: 90%, [#it])
    #v(0.5em)
  ]
  show figure.caption: set text(0.9 * fontsize)
  show figure.caption: set align(center)

  //目次
  show outline.entry.where(level: 1): it => {
    v(1.2 * fontsize, weak: true)
    it
  }
  set outline(indent: auto)

  //句読点の置き換え
  show "、": "，"
  show "。": "．"


  // \TODOの強調\
  show "TODO": highlight(fill: red, text("TODO", font: sans))

  //スニペット
  //let cdot = dots.c
  show: shorthands.with(
    ($+-$, $plus.minus$), //±
    ($-+$, $minus.plus$), //∓
  )

  //unifyの設定
  let qtyrange = qtyrange.with(delimiter: "\か\ら")

  body
}

#let appendix(app) = [
  #counter(heading).update(0)
  #set heading(numbering: "A.1     ")
  #app
]

//複数引用 #refs(<label1>,<label2>,<label3>,.....)
// https://qiita.com/tomoyatajika/items/bf52a066874f7370c77a#%E8%A4%87%E6%95%B0%E3%81%AE%E5%AE%9A%E7%90%86%E3%82%84%E8%A1%A8%E3%81%AA%E3%81%A9%E3%82%92%E5%8F%82%E7%85%A7%E3%81%99%E3%82%8B
//複数形の辞書
#let plurals_dic = (
  "Proposition": "Propositions",
  "Theorem": "Theorems",
  "Lemma": "Lemmata",
  "Definition": "Definitions",
  "Table": "Tables",
  "Assumption": "Assumptions",
  "Figure": "Figures",
  "Example": "Examples",
  "Fact": "Facts",
)

//単数形に対して辞書を参照したうえで複数形を与える関数．
#let plurals(single, dict) = {
  if single in dict.keys() {
    return dict.at(single)
  } else {
    return single
  }
}

#let refs(..sink, dict: plurals_dic, add: ", ", comma: ", ") = {
  let args = sink.pos()
  let numargs = args.len()
  let current_titles = ()
  let titles_dic = (:)
  if numargs == 1 { link(ref(args.at(0)).target)[#ref(args.at(0))] } else {
    show ref: it => plurals(it.element.supplement.text, dict)
    ref(args.at(0)) + " "
    show ref: it => {
      let c_eq = it.element.counter
      numbering(
        it.element.numbering,
        ..c_eq.at(it.element.location()),
      )
    }
    if numargs == 2 { link(ref(args.at(0)).target)[#ref(args.at(0))] + "" + add + "" + link(ref(args.at(1)).target)[#ref(args.at(1))] } else {
      for i in range(numargs) {
        if i < numargs - 1 { link(ref(args.at(i)).target)[#ref(args.at(i))] + comma + "" } else { add + "" + link(ref(args.at(i)).target)[#ref(args.at(i))] }
      }
    }
  }
}

#import "lib.typ": * //テンプレートのインポート
#show: project.with(fontsize: 11pt) //テンプレートの適用

#page(footer: none)[
  #align(center)[
    #v(10%)
    #text(size: 14pt)[
      令和n年
    ]
    #v(20%)
    #text(size: 22pt)[
      Typstテンプレート
    ]
    #v(20%)

    #text(size: 16pt)[
      電気通信大学
    ]
    #v(2%)
    #text(size: 16pt)[
      鈴木太郎
    ]
    #pagebreak()
  ]
]


#counter(page).update(1) //表紙をページ数に含めない
#outline() //目次

#pagebreak()

= 序論

== 背景
latex (latex) が遅すぎて死にそうなとき、ありますよね。
そこで次世代の組版ソフト、Typstです。

= 方法
先行研究によると、typstでは参考文献を示すことができる#cite(<Someone-TheBest-2000>)。日本語文献との混在もどうにかなった#cite(<誰-すごい-2020>)。

TODOとかもできたりする。これは`temporary.typ`で設定しています。
= まとめ
はやい、やすい、うまい！

#pagebreak()

#set text(lang: "en") //andが「と」になるのを防ぐ
#bibliography("refs.yml", title: "参考文献", style: "libs/noandjp.csl")


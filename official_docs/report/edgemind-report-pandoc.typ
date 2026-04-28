// EdgeMind Pandoc Template for Typst
// This template is used by Pandoc to generate Typst documents with EdgeMind styling

#import "edgemind-report.typ": edgemind-report

#show: edgemind-report.with(
  title: "$title$",
  $if(subtitle)$
  subtitle: "$subtitle$",
  $endif$
  author: "$author$",
  $if(date)$
  date: "$date$",
  $endif$
  version: "$version$",
  $if(verif)$
  verif: "$verif$",
  $endif$
  customer: "$customer$",
  $if(ref-customer)$
  ref-customer: "$ref-customer$",
  $endif$
  ref-edgemind: "$ref-edgemind$",
  $if(abstract)$
  abstract: [
$abstract$
  ],
  $endif$
  $if(logo-left)$
  logo-left: "$logo-left$",
  $endif$
  $if(logo-right)$
  logo-right: "$logo-right$",
  $endif$
  $if(logo-footer)$
  logo-footer: "$logo-footer$",
  $endif$
)

// Customize figure supplements
#set figure(supplement: [Figure])
#show figure.where(kind: table): set figure(supplement: [Tableau])

// Reduce gap only for Mermaid diagrams (kind: "diagram")
// #show figure.where(kind: "diagram"): set figure(gap: -4em)

// Customize figure caption separator
#show figure.caption: it => {
  [#it.supplement #it.counter.display(it.numbering). #it.body]
}

$body$

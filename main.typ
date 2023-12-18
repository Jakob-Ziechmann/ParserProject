#import "template.typ": *

#show: script.with(
  title: "Parser Project",
  authors: (
    "Timo Plieth",
    "Jakob Ziechmann",
  )
)

= Grammatik
```
Ausdruck        -> '(' Ausdruck ')' | InfixAusdruck | PrefixAusdruck | 
                   Literal | Identifier
InfixAusdruck   -> Ausdruck InfixOperator Ausdruck 
PrefixAusdruck  -> PrefixAusdruck Ausdruck
InfixOperator   -> '&' | '|' | '=>' | '<=' | '<=>'
PrefixAusdruck  -> '!'
Literal         -> 'WAHR' | 'FALSCH' | '1' | '0'
Identifier      -> char {char}
```


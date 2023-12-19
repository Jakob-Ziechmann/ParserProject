#import "template.typ": *

#show: script.with(
  title: "Parser Project",
  authors: (
    "Timo Plieth",
    "Jakob Ziechmann",
  )
)

= Aufgabe
Bei diesem Parser Projekt handelt es sich um eine freiwillige Übung aus der 
Universität. Der Parser soll logische Formeln Interpretieren können, welche 
die Operationen $and$(und), $or$(oder), $not$(nicht), $=>$(Implikation rechts),
$<=$(Implikation links) und $<=>$(Äquivalenz) beinhalten können. Dazu soll der 
Parser nachdem er einen Ausdruck gelesen hat ihn mit dem Quine–McCluskey 
Algorithmus vereinfachen.

= Grammatik
```
Ausdruck        -> '(' Ausdruck ')' | InfixAusdruck | PrefixAusdruck | 
                   Literal | Identifier
InfixAusdruck   -> Ausdruck InfixOperator Ausdruck 
PrefixAusdruck  -> PrefixAusdruck Ausdruck
InfixOperator   -> '&' | '|' | '=>' | '<=' | '<=>'
PrefixAusdruck  -> '!'
Literal         -> '1' | '0'
Identifier      -> char {char}
```

= Tokenizer
Die Idee für den Tokenizer ist, dass wir einen Automaten haben, der valide 
Tokens akzeptiert. Darunter sind zum Beispiel Identifier, welche aus Buchstaben
von $a$ bis $z$ bestehen oder der Und-Oprator. Der Automat erlaubt es uns nun 
den zu Parsenden String Buchstabe für Buchstabe durchlaufen und zu gucken, ob
der 

#align(center)[#automaton((
    q0: (q1: "a, ..., z", q2: "(, ), &, |, !", q3: ("<"), q4: ("="), 
      q6: ("0,1")),
    q1: (q1: "a, ..., z"),
    q2: (),
    q3: (q7: "="),
    q4: (q5: ">"),
    q5: (),
    q6: (),
    q7: (q5: ">")
  ), layout: (
    q0: (0, 0),
    q1: (4, 0),
    q2: (4, 2),
    q3: (4, -4),
    q4: (4, -2), 
    q5: (8, -2),
    q6: (4, 4),
    q7: (8, -4),
  ), style: (
    q0-q1: (curve: 0),
    q0-q2: (curve: 0.5),
    q0-q4: (curve: -.5),
    q0-q3: (curve: -1),
    q3-q4: (curve: 0),
    q4-q5: (curve: 0),
    q3-q7: (curve: 0),
    q7-q5: (curve: 0),
    q1-q1: (anchor: right),
    q1: (final: true),
    q2: (final: true),
    q5: (final: true), 
    q6: (final: true), 
    q7: (final: true),
  )
)]


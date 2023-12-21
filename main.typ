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
$arrow.double.l$(Implikation links) und $<=>$(Äquivalenz) beinhalten können. 
Dazu soll der Parser nachdem er einen Ausdruck gelesen hat ihn mit dem 
Quine–McCluskey Algorithmus vereinfachen.

= Syntax
Die Syntax der logischen Ausdrücke soll den Regeln, welche in der boolschen 
Algebra definiert sind, folgen mit ein par kleineren Änderungen, damit gegebene
Ausdrücke leichter per Tastatur umzusetzen sind. So werden die Operatoren 
$and$, $or$, $not$, $=>$, $arrow.double.l$ und $<=>$ durch folgende Zeichen 
dargestellt: \*, +, !, =>, <=, <=> 

== Grammatik
Die erste Aufgabe ist an dieser Stelle eine Grammatik zu definieren, auf 
welcher die nachfolgenden Systeme und Entscheidungen basieren werden.  
```
Ausdruck        -> '(' Ausdruck ')' | Ausdruck InfixOperator Ausdruck | 
                    PrefixOperator Ausdruck | Literal | Identifier
InfixOperator   -> '*' | '+' | '=>' | '<=' | '<=>'
PrefixAusdruck  -> '!'
Literal         -> '1' | '0'
Identifier      -> ['a'|...|'z']
```

= Implementierung
== Lexer
Die erste ebene eines jeden Parsers ist der Lexer oder auch Tokenizer genann.
Er hat die Aufgabe einen gegebenen String in seine Einzelteile zu zerlegen.
Um das in einem Beispiel zu verdeutlichen betrachtn wir den String 
$(p * q) => a$, welcher von dem Tokenizer in 
\'(\', \'p\', \'\*\', \'q\', \')\', \'=>\' \'a\'
zerlegt wird. Wichtig dabei ist, dass der Tokenizer immer das längste valide
Token bilden möchte, sonst wird nämlich aus abc \'a\', \'b\', \'c\' und nicht 
\'abc\'.

Wir lösen das in unserm Projekt mit einem Deterministischen Automat, welcher 
die Sprache aller gültigen Tokens akzeptiert. Die Idee ist and dieser Stelle, 
dass wir den Inputstring Zeichen für Zeichen lesen, bis wir in einer Senke 
landen. Danach geht man bis zum letzten akzeptierenden Zustand zurück und gibt
den bis dort hin gelesenen String aus. 

== Abstract Syntax Tree

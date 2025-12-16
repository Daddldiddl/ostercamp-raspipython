Basteln mit dem Raspberry Pi Pico \
und MicroPython

Vorab-Handout DGhK Ostercamp 2026

Jochen Brinkmann

= <anchor><anchor-1>Vorbereitung auf das Camp
<vorbereitung-auf-das-camp>
== <anchor-2><anchor-3>Was braucht Ihr?
<was-braucht-ihr>
Wichtig ist erstmal der Rechner:

- #blockquote[
  #strong[Notebook] mit Windows 10/11 oder einem aktuellen Linux
  ]

#blockquote[
Macbooks gehen natürlich auch, da kann ich aber nicht viel helfen.
]

Große Ansprüche an die Leistung gibt es nicht, allerdings sollte das
Betriebssystem auf einem aktuellen Stand sein, ihr solltet mit dem
Umgang vertraut sein, und die USB-Ports sollten funktionieren.

Auf dem Rechner solltet ihr zuhause bereits folgendes vorinstalliert
haben:

- #blockquote[
  #strong[Python 3].x (aktuell ist 3.13)
  ]

- #blockquote[
  Die Entwicklungsumgebung #strong[Thonny] 4.x (aktuell 4.17)
  ]

Außerdem braucht ihr:

- #blockquote[
  #strong[ein MicroUSB-Kabel] zum Verbinden des Raspberry Pi Pico mit
  dem Rechner \
  (das sind die älten USB-Kabel mit dem flachen trapezförmigen Stecker!)
  ]

- #blockquote[
  #strong[einen USB-Stick], um eure Programme zu sichern und
  auszutauschen
  ]

== <anchor-4><anchor-5>Installation der benötigten Software
<installation-der-benötigten-software>
=== <anchor-6><anchor-7>Variante 1: Über die Paketverwaltung eures
Systems
<variante-1-über-die-paketverwaltung-eures-systems>
==== Windows:
<windows>
Neuere Windowssysteme kommen ähnlich wie Linux mit einem Paketmanager
vorinstalliert. Einfach mal eine Kommandozeile öffnen und
winget#footnote[ Für mehr Details siehe
#emph[#strong[https://learn.microsoft.com/de-de/windows/package-manager/winget/]]]
eingeben – wenn ihr danach keine Fehlermeldung, sondern eine
Befehlsliste bekommt, dann gebt ihr nacheinander jeweils die folgenden
Befehle in eine neue Zeile ein (jeweils mit einem Enter abschließen):

- #blockquote[
  winget install Python.Python.3.13
  ]

- #blockquote[
  winget install AivarAnnamaa.Thonny
  ]

⚠️Wichtig: erst abwarten, bis das jeweilige Tool fertig installiert ist.
Dabei poppt auch mal ein Installationsdialog auf, den ihr gegebenenfalls
mit der Maus bestätigen müsst.

==== Linux
<linux>
Unter Linux sind Paketmanager seit Jahrzehnten Standard. Und die
benötigten Pakete sollten auf allen gängigen Distributionen verfügbar
sein. Hier am Beispiel von Ubuntu (Debian-basiert mit Paketmanager
#emph[#strong[apt]]). Wie oben in einem Terminal eingeben und mit
#emph[Enter] abschließen:

- sudo apt install python3.13 thonny
- sudo apt autoremove brltty

Wichtig: ihr braucht hierfür #emph[sudo]-Rechte – sonst lasst das von
eurem „Admin“ erledigen.

=== <anchor-8>Variante 2: Manueller Download
<variante-2-manueller-download>
- #blockquote[
  Python gibt es als Installer hier:
  #link("https://www.python.org/downloads/")[#emph[https://www.python.org/downloads/]]
  ]

- #blockquote[
  Thonny gibt es hier:
  #link("https://thonny.org/")[#emph[https://thonny.org/]]
  ]

Ladet die Files für euer System runter und installiert zuerst Python und
dann Thonny.

Auf den Webseiten gibt es jeweils systemspezifische Instruktionen, folgt
diesen und holt euch notfalls bei euren Eltern Hilfe (für Python
benötigt ihr Admin-Rechte!).

== <anchor-9><anchor-10>Python
<python>
Python ist eine beliebte Programmiersprache, die sich aufgrund eines
reichhaltigen Angebots an Bibliotheken (fertige Funktionspakete für
jeglichen Bedarf) und einer guten Zugänglichkeit großer Beliebtheit
erfreut. Auch der Raspberry Pi Pico und viele andere Microcontroller
unterstützen diese Sprache, so dass es erstaunlich einfach ist, diese zu
programmieren.

Wem es auf Geschwindigkeit ankommt und wer das letzte aus begrenzter
Hardware herauskitzeln muss, der greift zu Programmiersprachen wie C,
C++ oder Rust - die aber auch viel mehr Vorkenntnisse und Einarbeitung
voraussetzen. Für uns und die meisten Bastelprojekte reicht die
Performance von Python allemal – und der deutlich leichtere Einstieg
führt zu schnellen Resultaten. Von daher ist diese einsteigerfreundliche
Sprache genau die richtige für uns.

⚠️Vorkenntnisse in Python sind von Vorteil, weil ihr dann weniger mit
dem Lernen der Sprache beschäftigt seid, und euch mehr auf die
Ansteuerung der Hardware sowie das kreative Ausprobieren konzentrieren
könnt. Vielleicht habt ihr ja die Gelegenheit nebenbei schon vorher
etwas in die Sprache reinzuschnuppern! Aber keine Sorge: wir brauchen
nur Grundlagen, und die gehen wir alle nebenbei auch nochmal durch!

Im nächsten Teil findet ihr eine Kurzeinführung in Python. Damit könnt
ihr gerne etwas rumspielen bis das Camp losgeht – und es beim Kurs dann
als Spickzettel nutzen!

== <anchor-11><anchor-12>Hardware
<hardware>
Wir werden mit dem Raspberry Pi Pico arbeiten. Das ist ein kleiner
Mikrocontroller, der neben einer einfachen Programmierung via Python
eine Menge Schnittstellen bietet, um darüber Sensoren, LEDs, Taster,
Motoren oder ähnliches anzusteuern.

#image("Pictures/10000001000002C30000013669C3EABD.png", width: 8.664cm, height: 3.798cm)

Abbildung 1 Der Raspberry Pi Pico (Serie 1)

Die Materialien (Pico, Breadboards, Kabel, Sensoren, LEDs…) für den Kurs
werden von mir gestellt, das Starterkit könnt ihr am Ende des Kurses
dann mitnehmen und zuhause damit weiterbasteln.

= <anchor-13><anchor-14>Python Kurzeinführung
<python-kurzeinführung>
== <anchor-15><anchor-16>Programmieren mit Python
<programmieren-mit-python>
Diese Kurzeinführung für Python soll keine vollwertige Anleitung sein,
sondern mehr eine Schnellreferenz, die sich auf die wenigen und
grundlegenden Teile von Python beschränkt, welche wir im Kurs brauchen.
Jeden einzelnen Punkt könnte man noch um viele Details und
Besonderheiten ergänzen – und vieles lassen wir ganz aus. Wer tiefer
einsteigen möchte findet weiter hinten entsprechende Links und
Literaturhinweise.

Um ein Programm in Python zu erstellen, braucht man eigentlich nur einen
beliebigen Texteditor. Wer es etwas bequemer haben möchte, der nimmt
eine spezielle Entwicklungsumgebung – in unserem Fall #strong[Thonny].
Darin schreibt man Zeile für Zeile die Anweisungen, welche ausgeführt
werden sollen und führt das Programm dann mit einem Python-Interpreter
(\= \"Übersetzer\") aus. Das ist ein Programm, welches die zuvor
geschriebenen Anweisungen ausliest, abarbeitet und für den Computer in
ausführbare Instruktionen übersetzt. Der Python-Interpreter auf dem
Raspberry Pi Pico heißt #strong[MicroPython] und bringt unter anderem
spezielle Anpassungen für diesen Mikrocontroller (z.B. Unterstützung der
Pins und Schnittstellen) mit sich.

Beim Schreiben der Programme nutzt man #strong[Variablen], um sich Werte
zu merken, sowie #strong[Bedingungen], #strong[Schleifen] und
#strong[Funktionen], um den Programmablauf zu strukturieren und zu
steuern. Zusätzliche, von anderen Leuten zur Verfügung gestellte
Funktionalitäten lädt man über sogenannte #strong[Module] hinzu, um sie
für die eigenen Programme zu verwenden. Diese Programmbausteine werden
hier, zusammen mit ein paar nützlichen Grundfunktionalitäten (z.B.
Textausgabe, Kommentare) kurz vorgestellt.

Eine Besonderheit – und häufige Fehlerquelle - bei Schreiben von
Python-Code ist die Tatsache, dass die Sprache es mit Einrückungen im
Text sehr genau nimmt.

Egal ob eine bedingte Ausführung, Schleife oder eine Funktionsdefinition
einen Codeblock einleitet – der Inhalt wird mit Tab eingerückt (oder 4
Leerzeichen), und wenn die Einrückung endet, dann endet auch der
Codeblock. Das erhöht die Lesbarkeit des Codes enorm.

Ein #strong[Codeblock] ist eine aufeinanderfolgende Reihe von Zeilen im
Quellcode, die nacheinander abgearbeitet werden und zusammengehören. Ein
Codeblock kann aus einer einzelnen Zeile oder vielen bestehen und auch
selbst wieder Codeblöcke enthalten. Beispiele für Codeblöcke sind das
Innere einer Funktion, Schleife oder Bedingung.

== <anchor-17><anchor-18>Variablen
<variablen>
Variablen sind Namen für Werte, welche im Vorfeld nicht bekannt sind
(z.B. ein Messwert, ein Zähler, ein Name,...), und die #strong[variabel]
(\= veränderlich) sind. Einer Variablen kann immer wieder ein neuer Wert
zugewiesen werden, der dann überall wo diese verwendet wird automatisch
zur Verfügung steht. Für die Zuweisung wird das einfache
Gleichheitszeichen verwendet (\'#strong[\=]\').

=== <anchor-19><anchor-20>Beispiele
<beispiele>
- #blockquote[
  Einer Variablen namens a den Wert 3 zuweisen: #emph[a \= 3]
  ]

- #blockquote[
  Einer Variablen namens stadt den Text (auch #strong[String] genannt)
  „Hamburg“ zuweisen: \
  #emph[stadt \= \'Hamburg\' ] ⬅️ #emph[wichtig: nur einfache
  Anführungsstriche!]
  ]

- #blockquote[
  Einer Variablen loesung ein Rechenergebnis zuweisen: \
  #emph[loesung \= 20 \* (a - 2)] ⬅️ #emph[es gelten die Klammerregeln
  wie in Mathe!]
  ]

#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [#emph[a #strong[+] b] #emph[addiert zwei Zahlen a und b]],
  [#emph[a #strong[\*] b] #emph[multipliziert a mit b]],
  [#emph[a #strong[–] b ] #emph[zieht den Wert b von a ab]],
  [#emph[a #strong[/] b] #emph[teilt a durch b]],
)
]

- #blockquote[
  Fließkommazahlen werden einfach mit einem Punkt (statt Komma)
  definiert, also #emph[2.0] oder #emph[27.33] (keinen Punkt als Trenner
  für die Tausender verwenden!): \
  ergebnis \= 2.5 \* 2.5 \* 3.14
  ]

- #blockquote[
  Einer Variablen den Wert WAHR (#emph[True]) oder FALSCH (#emph[False])
  zuweisen: \
  #emph[echt \= True]
  ]

- #blockquote[
  Einer Variablen eine Liste von mehreren Werten zuweisen: \
  #emph[obst \= \[\"Apfel\", \"Birne\", \"Traube\"\]]
  ]

#blockquote[
⚠️Variablennamen, aus denen man Sinn und Zwecke der Variable klar
erkennen kann, erhöhen die Lesbarkeit eures Codes enorm! Vermeidet Namen
wie #emph[a], #emph[b], #emph[x], #emph[y], #emph[var],…
]

=== <anchor-21><anchor-22>Globale Variablen
<globale-variablen>
Bestimmte Variablen werden immer wieder gebraucht, auch in Funktionen,
wo diese eigentlich nicht verfügbar sind. Normalerweise können sie dort
nur gelesen werden. Über das Schlüsselwort global kann ihnen aber
trotzdem einen Wert zuweisen:

#emph[externeVariable \= False \
\
def meineFunktion(): \
global externeVariable \
externeVariable \= True \
\
print(externeVariable) \
meineFunktion() \
print(externeVariable)]

Der obige Code gibt zuerst #emph[False], dann #emph[True] aus - die
Funktion verändert die Variable.

Ohne die Variable mit dem Stichwort global innerhalb der Funktion
freizugeben, würde die ursprüngliche Variable nicht verändert und das
Ergebnis wäre eine Ausgabe von #emph[False] und #emph[False]… (innerhalb
der Funktion würde aber der zugewiesene Wert verwendet!)

== <anchor-23><anchor-24>Ausgabe von Texten auf dem Bildschirm
<ausgabe-von-texten-auf-dem-bildschirm>
Um zu sehen, was das Programm gerade macht, kann man in Python unter
anderem Texte auf dem Bildschirm ausgeben, das funktioniert mit der
eingebauten print()-Funktion. Der Befehl

#emph[print(\'Hallo!\')]

gibt zum Beispiel

#emph[Hallo!]

auf dem Bildschirm aus.

==== Strings verknüpfen
<strings-verknüpfen>
Durch Kombinieren von Text und Variablen kann man komplexe und
veränderbare Ausgaben erzeugen:

#emph[print(\'Hallo \' + name + \', Du bist \' + str(alter) + \' Jahre
alt!\')]

Wenn hier die Variable name den Wert \'Anton\' und alter den Wert 12
zugewiesen hat, lautet die Ausgabe:

#emph[Hallo Anton, Du bist 12 Jahre alt!]

Das #emph[+] wirkt hier als Verknüpfung zwischen den vorgegebenen und
den variablen Teilen der Ausgabe. Damit der Zahlenwert an den String
angehängt werden kann, muss er erst selbst in einen Text umgewandelt
werden – das übernimmt die Funktion #emph[str()]. Die Leerzeichen für
den Abstand zwischen den Variablenwerten und dem fixen Text fügt man
einfach bei letzterem bereits hinzu. Eleganter geht es mit der
formatierten Ausgabe.

==== Formatierte Ausgabe
<formatierte-ausgabe>
Alternativ kann man auch Platzhalter (\'#emph[{}]\') in einen String
einbauen und diesen dann über die String-Funktion #emph[format()] um die
einzusetzenden Werte ergänzen.

#emph[textMitPlatzhaltern \= \'Hallo {}, Du bist {} Jahre alt!\' \
textMitErsetzung \= textMitPlatzhaltern.format(name, alter) \
print(textMitErsetzung)]

Die Ausgabe ist wie oben, nur muss man den eigentlichen String nicht
einzeln zusammensetzen oder die Zahlen erst in Strings konvertieren.
Noch einfacher geht es, wenn man format direkt am String aufruft:

#emph[print(\'Hallo {}, Du bist {} Jahre alt!\'.format(name, alter))]

Was man verwendet, ist Geschmackssache - wobei die formatierte Ausgabe
deutlich mächtiger ist und zusätzlich weitreichende
Formatierungsmöglichkeiten bietet (z.B. feste Anzahl Nachkommastellen
für Fließkommawerte).

Auf dem Raspberry Pi Pico funktioniert die normale Textausgabe mangels
Bildschirms natürlich im normalen Betrieb nicht - aber solange er am
Rechner angeschlossen ist, kann man die Textausgabe wunderbar zum Testen
und bei der Fehlersuche verwenden.

== <anchor-25><anchor-26>Bedingungen
<bedingungen>
Bedingungen sind wichtig, um im Laufe des Programms Entscheidungen zu
treffen und das Verhalten des Programms an verschiedene Situationen
anzupassen. Sie funktionieren nach eine simplen #strong[WENN … DANN
…]-Muster. Wenn nötig kann dies durch ein oder mehrere #strong[ANSONSTEN
WENN … DANN …]-Entscheidungen und/oder ein #strong[ANSONSTEN …] ergänzt
werden. In Python ist das auf Englisch und verkürzt (if, elif und else)
und das DANN wird durch Doppelpunkt und nachfolgende Einrückung
angezeigt.

#align(center)[#table(
  columns: 3,
  align: (col, row) => (auto,auto,auto,).at(col),
  inset: 6pt,
  [], [], [],
  [Umgangsprachlich],
  [Python],
  [Wann verwenden?],
  [WENN #emph[\<Bedingung ist WAHR\>,] DANN #emph[\<mache dies und
  jenes\>]],
  [#emph[#strong[if]] #emph[\<Bedingung\>:] \
  #emph[\<mache dies\>] \
  #emph[\<mache jenes\>]],
  [#strong[Immer]: Anfang einer bedingten Ausführung. Nur wenn die
  Bedingung erfüllt ist, soll etwas bestimmtes getan werden],
  [ANSONSTEN WENN #emph[\<Bedingung ist WAHR\>,] DANN #emph[\<mache was
  anderes\>]],
  [#emph[#strong[elif]] #emph[\<andere Bedingung\>#strong[:]] \
  #emph[\<mache was anderes\>]],
  [#strong[Optional]: Wenn die vorhergehende Bedingung nicht erfüllt
  ist, und dafür abhängig von einer anderen Bedingung etwas anderes
  getan werden soll],
  [ANSONSTEN #emph[\<mache was ganz anderes\>]],
  [#emph[#strong[else]#strong[:]] \
  #emph[\<mache was ganz anderes\>]],
  [#strong[Optional]: Wenn die vorhergehenden Bedingungen nicht erfüllt
  sind und für diesen Fall etwas bestimmtes passieren soll],
)
]

Die Bedingung prüft dabei immer einen \'boolschen Ausdruck\'. Das ist
eine Variable, eine Funktion oder eine Vergleichsoperation, die als
Ergebnis oder Inhalt einen Boolean, also einen \"Wahrheitswert\" ergibt,
welcher entweder #emph[True] (WAHR) oder #emph[False] (FALSCH) ist.
Mehrere boolsche Ausdrücke können mit #emph[and] (\= logisches
#emph[UND]), #emph[or] (logisches #emph[ODER]) verknüpft oder mit
#emph[not] (\= logisches #emph[NICHT]) umgekehrt werden.

Bedingungen können dabei geschachtelt werden. Dabei hat sowohl die
Reihenfolge wie auch die Klammersetzung Einfluss auf die Bedeutung eines
Ausdrucks:

- #blockquote[
  #emph[a and b or c] ⬅️ a und b müssen wahr sein – oder nur c oder alle
  drei
  ]

- #blockquote[
  #emph[a and (b or c)] ⬅️ a und entweder b oder c müssen wahr sein -
  oder alle drei
  ]

Es empfiehlt sich durch Klammern vorzugeben, wie der Ausdruck bewertet
werden soll.

=== <anchor-27><anchor-28><anchor-29>Vergleichsoperatoren für
Bedingungen
<vergleichsoperatoren-für-bedingungen>
#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [Python],
  [Bedeutung],
  [#emph[A #strong[\<] B]],
  [A #strong[kleiner als] B (es gibt auch \'\<\=\' für kleiner oder
  gleich)],
  [#emph[A #strong[\>] B]],
  [A #strong[größer als] B (es gibt auch \'\>\=\' für größer oder
  gleich)],
  [#emph[A #strong[\=\=] B]],
  [A #strong[hat den gleichen Wert wie] B \
  ⚠️Wichtig: doppeltes Gleichheitszeichen (\'\=\=\') für Vergleiche!!!],
  [#emph[A #strong[!\=] B]],
  [A #strong[hat NICHT den gleichen Wert wie] B],
  [#emph[BedingungA #strong[or] BedingungB]],
  [Logisches #emph[ODER] \
  Bedingung A #strong[und/oder] Bedingung B #strong[ist erfüllt]. \
  Nur falsch, wenn keine der beiden Bedingungen erfüllt ist!],
  [#emph[BedingungA #strong[and] BedingungB]],
  [Logisches #emph[UND] \
  Bedingung A #strong[und] Bedingung B #strong[sind beide erfüllt]. \
  Falsch, wenn mindestens eine der Bedingungen nicht erfüllt ist!],
  [#emph[#strong[n]#strong[ot ]BedingungA]],
  [Logisches #emph[NICHT] \
  Bedingung A #strong[ist nicht erfüllt]. Das logische NICHT kehrt die
  Bedeutung einer Bedingung um – aus f#emph[alse] wird #emph[true] und
  umgekehrt!],
  [#emph[BedingungA #strong[and] #strong[(]BedingungB #strong[or]
  BedingungC#strong[)]]],
  [Klammern können genutzt werden, um mehrere Bedingungen zu einer
  zusammenzufassen und mit anderen zu kombinieren. \
  Hier: Bedingung A muss erfüllt sein UND Bedingung B ODER C müssen
  erfüllt sein. Ohne die Klammer wurde dieser Ausdruck anders
  interpretiert.],
)
]

=== <anchor-30><anchor-31>Beispiele
<beispiele-1>
#emph[ergebnis \= \'unbekannt\' \
if a \=\= b: \
ergebnis \= \'gleich\' \
elif a \< b: \
ergebnis \= \'kleiner als\' \
else: \
ergebnis \= \'groesser als\' \
print(\'A ist \' + ergebnis + \' B\')]

#emph[if], #emph[elif] oder #emph[else] sind nicht eingerückt, die Zeile
endet aber jeweils auf einen Doppelpunkt (\'#emph[#strong[:]]\'). Der
Codeblock mit den dazugehörigen Befehlen ist eingerückt (ein Tab bzw. 4
Leerzeichen gegenüber der Bedingungszeile).

Geschachtelte Bedingungen werden einfach immer weiter eingerückt:

#emph[if a \> b: \
print(\'A ist groesser\') \
if c \=\= 3: \
print(\'C ist DREI!\') \
else: \
print(C ist\' + c) \
else: \
print(\'A ist kleiner!\')]

== <anchor-32><anchor-33>Schleifen
<schleifen>
Schleifen erlauben es einen Codeblock wiederholt auszuführen, entweder

- #blockquote[
  so lange, bis eine Bedingung nicht mehr erfüllt ist
  ]

- #blockquote[
  alle Elemente einer Liste abgearbeitet wurden
  ]

- #blockquote[
  bis der Code eine bestimmte Anzahl mal ausgeführt wurde
  ]

Ein Beispiel ist z.B. eine Schleife, in der der Wert eines Sensors immer
wieder abgefragt wird, bis ein bestimmter Wert erreicht oder
überschritten wurde, oder eine Schleife, welche eine LED immer wieder
ein und ausschaltet, so dass diese blinkt.

=== <anchor-34><anchor-35>while-Schleife (\"Wiederhole, bis Bedingung
nicht mehr erfüllt\")
<while-schleife-wiederhole-bis-bedingung-nicht-mehr-erfüllt>
Bei der while-Schleife (übersetzt etwa #strong[WÄHREND]) wird der
zugehörige Codeblock so lange wiederholt, wie die Bedingung erfüllt ist.
Auch hier ist die Einrückung wichtig!

#emph[temperatur \= temperatur\_auslesen() \
while temperatur \> 2.0: \
if knopf\_gedrueckt(): \
break \
temperatur \= temperatur\_auslesen()]

Die Schleife kann auch mittendrin abgebrochen werden (die
#emph[break]-Anweisung oben im Beispiel), oder man kann mit
#emph[continue] direkt zurück an den Anfang der Schlaufe für den
nächsten Durchlauf springen.

=== <anchor-36><anchor-37>for-Schleife (\"Für jeden Wert in…\" bzw.
\"Von 0 bis #emph[n erreicht ist]…\")
<for-schleife-für-jeden-wert-in-bzw.-von-0-bis-n-erreicht-ist>
==== Eine Liste Element für Element abarbeiten
<eine-liste-element-für-element-abarbeiten>
Im Gegensatz zur #emph[while]-Schleife kann man mit
#emph[for]…#emph[in]… (\= \'für…in…\') für jedes Element einer Liste den
Code der Schleife ausführen. Beispielsweise hat man eine Liste mit
Früchten und möchte für jede einen Text ausgeben:

#emph[obst \= \[\'Äpfel\', \'Birnen\', \'Trauben\'\] \
#strong[for] frucht #strong[in] obst#strong[:] \
print(\'Lecker, ich mag \' + frucht + \'!\')]

Dabei muss man keine Bedingung prüfen oder Variablen hochzählen – die
Variable #emph[frucht] wird automatisch bei jeder Runde auf den nächsten
Wert in der Liste gesetzt und kann dann verwendet werden. Wenn alle
Elemente der Liste abgearbeitet sind, endet die Schleife.

==== Eine Schleife genau n-mal ausführen
<eine-schleife-genau-n-mal-ausführen>
Um einen Codeblock genau eine bestimmte Anzahl mal auszuführen, nutzt
man die Funktion #emph[#strong[range(]#emph[\<Anzahl\>]#strong[)]] –
diese gibt eine Liste mit der gewünschten Anzahl von Zahlen von 0
aufwärts zurück, die man dann wie oben gezeigt in einer
#emph[for]-Schleife durchlaufen kann.

Auch hier kann mit #emph[break] die Schleife abgebrochen oder mit
#emph[continue] direkt zur nächste Runde gesprungen werden.

#emph[#strong[for] i #strong[in] range#strong[(]5#strong[)]: \
print(\'Schritt \' + str(i))]

== <anchor-38><anchor-39>Funktionen
<funktionen>
Programme können leicht unübersichtlich werden, und bestimmte
Funktionalitäten werden immer wieder gebraucht. Anstatt nun jedes Mal
den gleichen Code erneut zu schreiben, wird er in einen separaten Teil
des Programmes ausgelagert, der dann über einen Namen von überall im
Code aufgerufen werden kann. Dabei können diesem Codeteil Variablen und
Werte als #strong[Parameter] übergeben werden, die für die Ausführung
benötigt werden. Und als Ergebnis kann die Funktion einen Wert
zurückgeben, den #strong[Rückgabewert].

#emph[#strong[def ]printHallo#strong[():] \
print(\'Hallo!\')]

Dies ist eine einfach Funktionsdefinition. Die Methode hat keine
Parameter und keinen Rückgabewert. In der Praxis würde man dafür
natürlich keine extra Funktion schreiben.

Die Funktion kann nun im Code wie ein normaler Befehl verwendet werden:

#emph[if not schonBegruesst: \
#strong[printHallo()] \
schonBegruesst \= true;]

Funktionen mit #strong[Parametern] und #strong[Rückgabewert] sehen wie
folgt aus:

#emph[#strong[def] calcKreisflaeche#strong[(radius):] \
flaeche \= 3.14159 \* radius \* radius \
#strong[return flaeche]]

Die Parameter sind als Variablennamen in der Klammer definiert, die
Rückgabe eines Wertes erfolgt über den #strong[return] Befehl. Und nein,
Pi sollte man nicht als Zahl im Code eintragen – die gibt es als
Konstante mit deutlich höherer Genauigkeit im Modul math (math.pi).

Will man nun eine Fläche berechnen, so ruft man einfach die Funktion
auf:

#emph[kreisflaeche \= #strong[calcKreisflaeche(2.5)]]

Statt Werten könnten hier auch Variablen übergeben werden, deren
aktueller Wert dann in der Funktion verwendet wird, z.B. ein Messwert
oder eine Benutzereingabe. Wichtig ist dabei nur, die Werte der
Parameter müssen natürlich zur Funktion passen. Würde man hier einen
Text übergeben, dann würde das zu einem Fehler führen.

⚠️Für Funktionen gilt das gleiche, wie für Variablen: vergebt Namen,
welche sofort erkennen lassen, was die Aufgabe der Funktion ist. Nutzt
entweder Großbuchstaben (sogenanntes Camel Case, z.B.
\'#emph[retteDieWelt()]\') oder Unterstriche (z.B.
\'#emph[rette\_die\_welt()]\') zur Worttrennung und beginnt den Namen
mit einem Verb – die Funktion macht ja etwas bestimmtes, das soll
beschrieben werden!

== <anchor-40><anchor-41>Module nutzen
<module-nutzen>
Nicht alles kann oder muss man selbst schreiben – sei es aus Zeitmangel
oder fehlendem Fachwissen. Dafür gibt es Module, das sind Sammlungen an
Objekttypen, Funktionen und Konstanten (feste Werte), die man in seinem
Projekt nutzen kann. Dies macht man über den Befehl #emph[import]:

#emph[import time]

Der obige Befehl importiert (\= macht verfügbar) das Modul #emph[time],
welches verschiedene Funktionen zu Zeit und Timern zur Verfügung stellt.
Wenn man das Modul importiert hat, dann kann man fortan die enthaltenen
Funktionen in seinem Programm nutzen - z.B. den Befehl
#emph[time.sleep(zeitInSekunden)], um das Programm eine bestimmte Zeit
warten zu lassen.

=== <anchor-42><anchor-43>Häufig genutzte Module
<häufig-genutzte-module>
Python bringt bereits viele nützliche Module von Haus aus mit:

#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [#emph[Modulname]],
  [#emph[Wofür?]],
  [#emph[time]],
  [Funktionalitäten rund um Zeit, aber auch Pausieren],
  [#emph[machine]],
  [Modul für die speziellen Funktionalitäten des Raspberry Pi Pico],
  [#emph[random]],
  [Zufallszahlen erzeugen],
  [#emph[math]],
  [Mathematische Funktionen und Konstanten],
  [#emph[sys]],
  [Verschiedene Systeminfos (aber auch z.B. die Parameter mit denen das
  Programm gestartet wurde)],
  [#emph[network]],
  [Wifi-Funktionalität (nur Raspberry Pi Pico W)],
  [#emph[bluetooth]],
  [Bluetooth-Funktionalität (nur Raspberry Pi Pico W)],
)
]

<anchor-44>Beispiel \
In der Praxis sieht das dann beispielsweise wie folgt aus (kleiner
Vorgeschmack auf den Kurs):

#emph[#strong[import time \
import machine] \
\# Hole Pin 15 als Ausgabe und weise ihn der Variablen led zu \
led \= #strong[machine.Pin(15, machine.Pin.OUT) \# aus Modul machine] \
\# Endlosschleife, LED an PIN 15 wird alle 200ms umgeschaltet (an/aus) \
while True: \
led.toggle() \
#strong[time.sleep(0.2) \# aus Modul time]]

Wenn an Pin 15 eine LED angeschlossen ist, dann würde sich diese nun bis
zum Beenden des Programms alle 200 Millisekunden an- und im nächsten
Durchlauf wieder ausschalten – sie würde blinken!

Hier werden erst die beiden benötigten Module importiert, dann wird
einer der Pins des Raspberry Pi Pico als Ausgabe-Pin konfiguriert (aus
dem Modul #emph[machine]) und einer Variablen namens #emph[led]
zugewiesen. Die Variable ist vom Typ Pin und besitzt eine Funktion
namens #emph[toggle()], über die das Signal an diesem Pin umgeschaltet
werden kann. Über #emph[time.sleep(0.2)] (aus dem Modul #emph[time])
pausiert das Programm 0.2 Sekunden (\= 200ms) bevor es weitergeht.

== <anchor-45><anchor-46>Code-Kommentare
<code-kommentare>
Um auch später noch gut nachvollziehen zu können, was das gerade
geschriebene Programm genau macht, hilft es dieses möglichst gut zu
dokumentieren. Der einfachste Weg hierfür ist es Code-Kommentare
einzufügen. Das sind Zeilen im Programm, die vom Interpreter ignoriert
werden und einen beliebigen Text enthalten können. In Python beginnen
Kommentarzeilen mit einer Raute (\'#emph[#strong[\#]]\').

#emph[#strong[\# Dieser Kommentar könnte erklären, was die Funktion
macht… \
]def zaehleBisWert(maximum): \
for schritt in range(maximum): \
print(\'Schritt {}…\'.format(schritt)) #strong[\# Auch ein Kommentar] \
print(\'Ziel von {} erreicht\'.format(maximum))]

Alles nach der Raute wird in der jeweiligen Zeile vom Interpreter
ignoriert, Kommentare funktionieren daher auch am Ende einer Zeile.

Es macht Sinn fleißig zu kommentieren: was macht diese Funktion, was
bedeutet diese Variable, was sind gültige Werte für einen Parameter… -
alles, was hilft den Code auch noch nach Monaten auf einen Blick zu
verstehen, ist gut!

== <anchor-47><anchor-48><anchor-49>Literatur und Links
<literatur-und-links>
Es gibt massig gute Quellen im Netz, wenn man Python lernen möchte - und
natürlich auch Bücher, teilweise sogar speziell für Kinder und
Jugendliche. Hier eine kleine Auswahl.

=== <anchor-50><anchor-51>Links
<links>
- #blockquote[
  #emph[https://www.python-lernen.de/] \
  Eine sehr gute Seite, um Python zu lernen. Von den absoluten
  Grundlagen hin zu fortgeschrittenen Themen, alles gut erklärt und mit
  vielen Beispielen.
  ]

- #blockquote[
  #link("https://docs.python.org/3/library/") \
  Die Python-Standardbibliothek – hier finden sich detaillierte
  Informationen zu den häufig in Programmen genutzten Modulen (z.B.
  time, math, random, …), die Python von Haus aus mitbringt. In vielen
  Sprachen verfügbar, leider nicht auf Deutsch.
  ]

=== <anchor-52><anchor-53>Bücher
<bücher>
- #blockquote[
  #strong[Python 3 – Das fundierte und praxisorientierte
  Handbuch]#emph[, Simon Flaig, A/S Verlag 2020] - 126 Seiten kompakte
  und verständliche Einführung in die Grundlagen von Python und der
  Programmierung.
  ]

- #blockquote[
  #strong[Python für Kids: Programmieren lernen ohne
  Vorkenntnisse]#emph[, Hans-Georg Schumann, mitp Verlag 2022] - gute
  Einführung in die Python-Programmierung für Kinder und Jugendliche.
  ]

- #blockquote[
  #strong[Python 3 – Das umfassende Handbuch]#emph[, Johannes Ernesti &
  Peter Kaiser, 7. aktualisierte und korrigierte Auflage, Rheinwerk
  Verlag Bonn 2024] - fast zwei Kilogramm geballtes Wissen auf 1100
  Seiten. Eher kein Einsteigerbuch, sondern mehr was zum Nachschlagen -
  und wenn man es genauer wissen muss
  ]

#blockquote[
]

#blockquote[
Es gibt natürlich massenhaft Bücher zu Python, das ist hier nur eine
kleine Auswahl als Anregung – wer mag darf gerne mal reinschauen, ich
habe diese wahrscheinlich dabei!
]

Basteln mit dem Raspberry Pi Pico \
und MicroPython

Vorab-Handout DGhK Ostercamp 2025

Jochen Brinkmann

= <anchor><anchor-1>Vorbereitung auf das Camp
<vorbereitung-auf-das-camp>
== <anchor-2><anchor-3>Was braucht Ihr?
<was-braucht-ihr>
Wichtig ist erstmal der Rechner:

- #blockquote[
  #strong[Notebook] mit Windows 10/11
  ]

#blockquote[
Linux und Macbook gehen natürlich auch, da kann ich aber nicht immer
helfen.
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
  Die Entwicklungsumgebung #strong[Thonny] 4.x (aktuell 4.16 oder 4.17)
  ]

Außerdem braucht ihr:

- #blockquote[
  #strong[MicroUSB-Kabel] zum Verbinden des Raspberry Pi Pico mit dem
  Rechner \
  (das sind die alten USB-Kabel mit dem flachen trapezförmigen Stecker!)
  ]

- #blockquote[
  #strong[USB-Stick], um eure Programme zu sichern und auszutauschen
  ]

== <anchor-4><anchor-5>Installation der Software
<installation-der-software>
=== <anchor-6><anchor-7>Variante 1: alle Systeme – manueller Download
<variante-1-alle-systeme-manueller-download>
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

Auf den Seiten gibt es systemspezifische Instruktionen, folgt diesen und
holt euch notfalls bei euren Eltern Hilfe (für Python benötigt ihr
Admin-Rechte!).

=== <anchor-8><anchor-9>Variante 2: Windows winget
<variante-2-windows-winget>
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
mit der Maus bestätigen müsst. Ihr benötigt auch auf diesem Weg
Admin-Rechte für die Python-Installation!

== <anchor-10><anchor-11>Python
<python>
Python ist eine beliebte Programmiersprache, die sich aufgrund eines
reichhaltigen Angebots an Bibliotheken (fertige Funktionspakete für
jeglichen Bedarf) und einer guten Zugänglichkeit großer Beliebtheit
erfreut. Auch der Raspberry Pi Pico und viele andere Microcontroller
unterstützen diese Sprache, so dass es erstaunlich einfach ist, diese zu
programmieren.

Wem es auf Geschwindigkeit ankommt und wer das letzte aus der begrenzten
Hardware rauskitzeln möchte, der greift zu Programmiersprachen wie C,
C++ oder Rust - die aber auch viel mehr Vorkenntnisse und Einarbeitung
voraussetzen. Für uns und die meisten Bastelprojekte reicht die
Perfomance von Python allemal – und der deutlich leichtere Einstieg
führt zu schnellen Resultaten. Von daher ist diese einsteigerfreundliche
Sprache genau die richtige für uns.

⚠️Vorkenntnisse in Python sind von Vorteil, weil ihr dann weniger mit
dem Lernen der Sprache beschäftigt seid, und euch mehr auf die
Ansteuerung der Hardware sowie das kreative Ausprobieren konzentrieren
könnt. Vielleicht habt ihr ja die Gelegenheit nebenbei schonmal etwas in
die Sprache reinzuschnuppern! Aber keine Sorge: wir brauchen nur
Grundlagen, und die gehen wir alle nebenbei auch nochmal durch!

Im nächsten Teil findet ihr eine Kurzeinführung in Python. Damit könnt
ihr gerne schonmal etwas rumspielen bis das Camp losgeht – und es beim
Kurs dann als Spickzettel nutzen!

== <anchor-12><anchor-13>Hardware
<hardware>
Wir werden mit dem Raspberry Pi Pico arbeiten. Das ist ein kleiner
Microcontroller, der neben einer einfachen Programmierung via Python
eine Menge Schnittstellen bietet, um darüber Sensoren, LEDs, Taster,
Motoren oder ähnliches anzusteuern.

#image("Pictures/10000001000002C30000013669C3EABD.png", width: 8.664cm, height: 3.798cm)

Abbildung 1 Der Raspberry Pi Pico (Serie 1)

Die Materialien (Breadboards, Kabel, Sensoren, LEDs…) für den Kurs
werden von mir gestellt, den Pico selbst (inklusive StarterKit mit
Breadboard, Kabeln, LEDs, etc.) könnt ihr am Ende des Kurses mitnehmen
und zuhause damit weiterbasteln.

= <anchor-14><anchor-15>Python Kurzeinführung
<python-kurzeinführung>
== <anchor-16><anchor-17>Programmieren mit Python
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

== <anchor-18><anchor-19>Variablen
<variablen>
Variablen sind Namen für Werte, welche im Vorfeld nicht bekannt sind
(z.B. ein Messwert, der Status eines Schalters, ein Name oder Wert,
welchen der Nutzer erst während des Programmablaufs eingibt), und die
#strong[variabel] (\= veränderlich) sind. Im Laufe des Programm-verlaufs
kann der Variablen immer wieder ein neuer Wert zugewiesen werden. Für
die Zuweisung wird das einfache Gleichheitszeichen verwendet
(\'#strong[\=]\').

=== <anchor-20><anchor-21>Beispiele
<beispiele>
- #blockquote[
  Einer Variablen namens a den Wert 3 zuweisen: a \= 3
  ]

- #blockquote[
  Einer Variablen namens stadt den Text (auch #strong[String] genannt)
  „Hamburg“ zuweisen: \
  stadt \= \'Hamburg\' ⬅️ #emph[wichtig: nur einfache
  Anführungsstriche!]
  ]

- #blockquote[
  Einer Variablen loesung ein Rechenergebnis zuweisen: \
  loesung \= 20 \* (a - 2) ⬅️ #emph[es gelten die Klammerregeln wie in
  Mathe!]
  ]

#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [a #strong[+] b #emph[addiert zwei Zahlen a und b]],
  [a #strong[\*] b #emph[multipliziert a mit b]],
  [a #strong[–] b #emph[zieht den Wert b von a ab]],
  [a #strong[/] b #emph[teilt a durch b]],
)
]

- #blockquote[
  Fließkommazahlen werden einfach mit einem Punkt (statt Komma)
  definiert, also 2.0 oder 27.33 (keinen Punkt als Trenner für die
  Tausender verwenden!): \
  ergebnis \= 2.5 \* 2.5 \* 3.14
  ]

- #blockquote[
  Einer Variablen den Wert WAHR (True) oder FALSCH (False) zuweisen: \
  echt \= True
  ]

- #blockquote[
  Einer Variablen eine Liste von mehreren Werten zuweisen: \
  obst \= \[\"Apfel\", \"Birne\", \"Traube\"\]
  ]

#blockquote[
⚠️Variablennamen, aus denen man Sinn und Zwecke der Variable klar
erkennen kann, erhöhen die Lesbarkeit eures Codes enorm! Vermeidet Namen
wie a, b, x, y, var,…
]

=== <anchor-22><anchor-23>Globale Variablen
<globale-variablen>
Bestimmte Variablen werden immer wieder gebraucht, auch in Funktionen,
wo diese eigentlich nicht verfügbar sind. Normalerweise können sie dort
nur gelesen werden. Über das Schlüsselwort global kann ihnen aber
trotzdem einen Wert zuweisen:

externeVariable \= False \
\
def meineFunktion(): \
global externeVariable \
externeVariable \= True \
\
print(externeVariable) \
meineFunktion() \
print(externeVariable)

Der obige Code gibt zuerst False, dann True aus - die Funktion verändert
die Variable.

Ohne die Variable mit dem Stichwort global innerhalb der Funktion
freizugeben, würde die ursprüngliche Variable nicht verändert und das
Ergebnis wäre eine Ausgabe von False und False… (innerhalb der Funktion
würde aber der zugewiesene Wert verwendet!)

== <anchor-24><anchor-25>Ausgabe von Texten auf dem Bildschirm
<ausgabe-von-texten-auf-dem-bildschirm>
Um zu sehen, was das Programm gerade macht, kann man in Python unter
anderem Texte auf dem Bildschirm ausgeben, das funktioniert mit der
eingebauten print()-Funktion. Der Befehl

print(\'Hallo!\')

gibt zum Beispiel

Hallo!

auf dem Bildschirm aus.

==== Strings verknüpfen
<strings-verknüpfen>
Durch Kombinieren von Text und Variablen kann man komplexe und
veränderbare Ausgaben erzeugen:

print(\'Hallo \' + name + \', Du bist \' + str(alter) + \' Jahre alt!\')

Wenn hier die Variable name den Wert \'Anton\' und alter den Wert 12
zugewiesen hat, lautet die Ausgabe:

Hallo Anton, Du bist 12 Jahre alt!

Das + wirkt hier als Verknüpfung zwischen den vorgegebenen und den
variablen Teilen der Ausgabe. Damit der Zahlenwert an den String
angehängt werden kann, muss er erst selbst in einen Text umgewandelt
werden – das übernimmt die Funktion str(). Die Leerzeichen für den
Abstand zwischen den Variablenwerten und dem fixen Text fügt man einfach
bei letzterem bereits hinzu. Eleganter geht es mit der formatierten
Ausgabe.

==== Formatierte Ausgabe
<formatierte-ausgabe>
Alternativ kann man auch Platzhalter (\'{}\') in einen String einbauen
und diesen dann über die String-Funktion format() um die einzusetzenden
Werte ergänzen.

textMitPlatzhaltern \= \'Hallo {}, Du bist {} Jahre alt!\' \
textMitErsetzung \= textMitPlatzhaltern.format(name, alter) \
print(textMitErsetzung)

Die Ausgabe ist wie oben, nur muss man den eigentlichen String nicht
einzeln zusammensetzen oder die Zahlen erst in Strings konvertieren.
Noch einfacher geht es, wenn man format direkt am String aufruft:

print(\'Hallo {}, Du bist {} Jahre alt!\'.format(name, alter))

Was man verwendet, ist Geschmackssache - wobei die formatierte Ausgabe
deutlich mächtiger ist und zusätzlich weitreichende
Formatierungsmöglichkeiten bietet (z.B. feste Anzahl Nachkommastellen
für Fließkommawerte).

Auf dem Raspberry Pi Pico funktioniert die normale Textausgabe mangels
Bildschirms natürlich im normalen Betrieb nicht - aber solange er am
Rechner angeschlossen ist, kann man die Textausgabe wunderbar zum Testen
und bei der Fehlersuche verwenden.

== <anchor-26><anchor-27>Bedingungen
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
  [#emph[#strong[else:]] \
  #emph[\<mache was ganz anderes\>]],
  [#strong[Optional]: Wenn die vorhergehenden Bedingungen nicht erfüllt
  sind und für diesen Fall etwas bestimmtes passieren soll],
)
]

Die Bedingung prüft dabei immer einen \'boolschen Ausdruck\'. Das ist
eine Variable, eine Funktion oder eine Vergleichsoperation, die als
Ergebnis oder Inhalt einen Boolean, also einen \"Wahrheitswert\" ergibt,
welcher entweder True (WAHR) oder False (FALSCH) ist. Mehrere boolsche
Ausdrücke können mit and (\= logisches #emph[UND]), or (logisches
#emph[ODER]) verknüpft oder mit not (\= logisches #emph[NICHT])
umgekehrt werden.

Bedingungen können dabei geschachtelt werden. Dabei hat sowohl die
Reihenfolge wie auch die Klammersetzung Einfluss auf die Bedeutung eines
Ausdrucks:

- #blockquote[
  a and b or c ⬅️ a und b müssen wahr sein – oder nur c oder alle drei
  ]

- #blockquote[
  a and (b or c) ⬅️ a und entweder b oder c müssen wahr sein - oder alle
  drei
  ]

Es empfiehlt sich durch Klammern vorzugeben, wie der Ausdruck bewertet
werden soll.

=== <anchor-28><anchor-29><anchor-30>Vergleichsoperatoren für
Bedingungen
<vergleichsoperatoren-für-bedingungen>
#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [Python],
  [Bedeutung],
  [A #strong[\<] B],
  [A #strong[kleiner als] B (es gibt auch \'\<\=\' für kleiner oder
  gleich)],
  [A #strong[\>] B],
  [A #strong[größer als] B (es gibt auch \'\>\=\' für größer oder
  gleich)],
  [A #strong[\=\=] B],
  [A #strong[hat den gleichen Wert wie] B \
  ⚠️Wichtig: doppeltes Gleichheitszeichen (\'\=\=\') für Vergleiche!!!],
  [A #strong[!\=] B],
  [A #strong[hat NICHT den gleichen Wert wie] B],
  [BedingungA #emph[#strong[or]] BedingungB],
  [Logisches #emph[ODER] \
  Bedingung A #strong[und/oder] Bedingung B #strong[ist erfüllt]. \
  Nur falsch, wenn keine der beiden Bedingungen erfüllt ist!],
  [BedingungA #emph[#strong[and]] BedingungB],
  [Logisches #emph[UND] \
  Bedingung A #strong[und] Bedingung B #strong[sind beide erfüllt]. \
  Falsch, wenn mindestens eine der Bedingungen nicht erfüllt ist!],
  [#emph[#strong[n]#strong[ot]]#strong[ ]BedingungA],
  [Logisches #emph[NICHT] \
  Bedingung A #strong[ist nicht erfüllt]. Das logische NICHT kehrt die
  Bedeutung einer Bedingung um – aus false wird true und umgekehrt!],
  [Bedingung A #emph[#strong[and] #strong[(]]BedingungB
  #emph[#strong[or]] BedingungC#emph[#strong[)]]],
  [Klammern können genutzt werden, um mehrere Bedingungen zu einer
  zusammenzufassen und mit anderen zu kombinieren. \
  Hier: Bedingung A muss erfüllt sein UND Bedingung B ODER C müssen
  erfüllt sein. Ohne die Klammer wurde dieser Ausdruck anders
  interpretiert.],
)
]

=== <anchor-31><anchor-32>Beispiele
<beispiele-1>
ergebnis \= \'unbekannt\' \
if a \=\= b: \
ergebnis \= \'gleich\' \
elif a \< b: \
ergebnis \= \'kleiner als\' \
else: \
ergebnis \= \'groesser als\' \
print(\'A ist \' + ergebnis + \' B\')

if, elif oder else sind nicht eingerückt, die Zeile endet aber jeweils
auf einen Doppelpunkt (\'#strong[:]\'). Der Codeblock mit den
dazugehörigen Befehlen ist eingerückt (ein Tab bzw. 4 Leerzeichen
gegenüber der Bedingungszeile).

Geschachtelte Bedingungen werden einfach immer weiter eingerückt:

if a \> b: \
print(\'A ist groesser\') \
if c \=\= 3: \
print(\'C ist DREI!\') \
else: \
print(C ist\' + c) \
else: \
print(\'A ist kleiner!\')

== <anchor-33><anchor-34>Schleifen
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

=== <anchor-35><anchor-36>while-Schleife (\"Wiederhole, bis Bedingung
nicht mehr erfüllt\")
<while-schleife-wiederhole-bis-bedingung-nicht-mehr-erfüllt>
Bei der while-Schleife (übersetzt etwa #strong[WÄHREND]) wird der
zugehörige Codeblock so lange wiederholt, wie die Bedingung erfüllt ist.
Auch hier ist die Einrückung wichtig!

temperatur \= temperatur\_auslesen() \
while temperatur \> 2.0: \
if knopf\_gedrueckt(): \
break \
temperatur \= temperatur\_auslesen()

Die Schleife kann auch mittendrinn abgebrochen werden (die
break-Anweisung oben im Beispiel), oder man kann mit continue direkt
zurück an den Anfang der Schlaufe für den nächsten Durchlauf springen.

=== <anchor-37><anchor-38>for-Schleife (\"Für jeden Wert in…\" bzw.
\"Von 0 bis #emph[n erreicht ist]…\")
<for-schleife-für-jeden-wert-in-bzw.-von-0-bis-n-erreicht-ist>
==== Eine Liste Element für Element abarbeiten
<eine-liste-element-für-element-abarbeiten>
Im Gegensatz zur while-Schleife kann man mit for…in… (\= \'für…in…\')
für jedes Element einer Liste den Code der Schleife ausführen.
Beispielsweise hat man eine Liste mit Früchten und möchte für jede einen
Text ausgeben:

obst \= \[\'Äpfel\', \'Birnen\', \'Trauben\'\] \
#strong[for] frucht #strong[in] obst#strong[:] \
print(\'Lecker, ich mag \' + frucht + \'!\')

Dabei muss man keine Bedingung prüfen oder Variablen hochzählen – die
Variable frucht wird automatisch bei jeder Runde auf den nächsten Wert
in der Liste gesetzt und kann dann verwendet werden. Wenn alle Elemente
der Liste abgearbeitet sind, endet die Schleife.

==== Eine Schleife genau n-mal ausführen
<eine-schleife-genau-n-mal-ausführen>
Um einen Codeblock genau eine bestimmte Anzahl mal auszuführen, nutzt
man die Funktion #strong[range(]#emph[\<Anzahl\>]#strong[)] – diese gibt
eine Liste mit der gewünschten Anzahl von Zahlen von 0 aufwärts zurück,
die man dann wie oben gezeigt in einer for-Schleife durchlaufen kann.

Auch hier kann mit break die Schleife abgebrochen oder mit continue
direkt zur nächste Runde gesprungen werden.

#strong[for] i #strong[in] range#strong[(]5#strong[)]: \
print(\'Schritt \' + str(i))

== <anchor-39><anchor-40>Funktionen
<funktionen>
Programme können leicht unübersichtlich werden, und bestimmte
Funktionalitäten werden immer wieder gebraucht. Anstatt nun jedes Mal
den gleichen Code erneut zu schreiben, wird er in einen separaten Teil
des Programmes ausgelagert, der dann über einen Namen von überall im
Code aufgerufen werden kann. Dabei können diesem Codeteil Variablen und
Werte als #strong[Parameter] übergeben werden, die für die Ausführung
benötigt werden. Und als Ergebnis kann die Funktion einen Wert
zurückgeben, den #strong[Rückgabewert].

#strong[def ]printHallo#strong[():] \
print(\'Hallo!\')

Dies ist eine einfach Funktionsdefinition. Die Methode hat keine
Parameter und keinen Rückgabewert. In der Praxis würde man dafür
natürlich keine extra Funktion schreiben.

Die Funktion kann nun im Code wie ein normaler Befehl verwendet werden:

if not schonBegruesst: \
#strong[printHallo()] \
schonBegruesst \= true;

Funktionen mit #strong[Parametern] und #strong[Rückgabewert] sehen wie
folgt aus:

#strong[def] calcKreisflaeche#strong[(radius):] \
flaeche \= 3.14159 \* radius \* radius \
#strong[return flaeche]

Die Parameter sind als Variablennamen in der Klammer definiert, die
Rückgabe eines Wertes erfolgt über den #strong[return] Befehl. Und nein,
Pi sollte man nicht als Zahl im Code eintragen – die gibt es als
Konstante mit deutlich höherer Genauigkeit im Modul math (math.pi).

Will man nun eine Fläche berechnen, so ruft man einfach die Funktion
auf:

kreisflaeche \= #strong[calcKreisflaeche(2.5)]

Statt Werten könnten hier auch Variablen übergeben werden, deren
aktueller Wert dann in der Funktion verwendet wird, z.B. ein Messwert
oder eine Benutzereingabe. Wichtig ist dabei nur, die Werte der
Parameter müssen natürlich zur Funktion passen. Würde man hier einen
Text übergeben, dann würde das zu einem Fehler führen.

⚠️Für Funktionen gilt das gleiche, wie für Variablen: vergebt Namen,
welche sofort erkennen lassen, was die Aufgabe der Funktion ist. Nutzt
entweder Großbuchstaben (sogenanntes Camel Case, z.B.
\'retteDieWelt()\') oder Unterstriche (z.B. \'rette\_die\_welt()\') zur
Worttrennung und beginnt den Namen mit einem Verb – die Funktion macht
ja etwas bestimmtes, das soll beschrieben werden!

== <anchor-41><anchor-42>Module nutzen
<module-nutzen>
Nicht alles kann oder muss man selbst schreiben – sei es aus Zeitmangel
oder fehlendem Fachwissen. Dafür gibt es Module, das sind Sammlungen an
Objekttypen, Funktionen und Konstanten (feste Werte), die man in seinem
Projekt nutzen kann. Dies macht man über den Befehl import:

import time

Der obige Befehl importiert (\= macht verfügbar) das Modul time, welches
verschiedene Funktionen zu Zeit und Timern zur Verfügung stellt. Wenn
man das Modul importiert hat, dann kann man fortan die enthaltenen
Funktionen in seinem Programm nutzen - z.B. den Befehl
time.sleep(zeitInSekunden), um das Programm eine bestimmte Zeit warten
zu lassen.

=== <anchor-43><anchor-44>Häufig genutzte Module
<häufig-genutzte-module>
Python bringt bereits viele nützliche Module von Haus aus mit:

#align(center)[#table(
  columns: 2,
  align: (col, row) => (auto,auto,).at(col),
  inset: 6pt,
  [], [],
  [Modulname],
  [Wofür?],
  [time],
  [Funktionalitäten rund um Zeit, aber auch Pausieren],
  [machine],
  [Modul für die speziellen Funktionalitäten des Raspberry Pi Pico],
  [random],
  [Zufallszahlen erzeugen],
  [math],
  [Mathematische Funktionen],
  [sys],
  [Verschiedene Systeminfos (aber auch z.B. die Parameter mit denen das
  Programm gestartet wurde)],
  [network],
  [Wifi-Funktionalität (nur Raspberry Pi Pico W)],
  [bluetooth],
  [Bluetooth-Funktionalität (nur Raspberry Pi Pico W)],
)
]

<anchor-45>Beispiel \
In der Praxis sieht das dann beispielsweise wie folgt aus (kleiner
Vorgeschmack auf den Kurs):

#strong[import time \
import machine] \
\# Hole Pin 15 als Ausgabe und weise ihn der Variablen led zu \
led \= #strong[machine.Pin(15, machine.Pin.OUT) \# aus Modul machine] \
\# Endlosschleife, LED an PIN 15 wird alle 200ms umgeschaltet (an/aus) \
while True: \
led.toggle() \
#strong[time.sleep(0.2) \# aus Modul time]

Wenn an Pin 15 eine LED angeschlossen ist, dann würde sich diese nun bis
zum Beenden des Programms alle 200 Millisekunden an- und im nächsten
Durchlauf wieder ausschalten – sie würde blinken!

Hier werden erst die beiden benötigten Module importiert, dann wird
einer der Pins des Raspberry Pi Pico als Ausgabe-Pin konfiguriert (aus
dem Modul machine) und einer Variablen namens led zugewiesen. Die
Variable ist vom Typ Pin und besitzt eine Funktion namens toggle(), über
die das Signal an diesem Pin umgeschaltet werden kann. Über
time.sleep(0.2) (aus dem Modul time) pausiert das Programm 0.2 Sekunden
(\= 200ms) bevor es weitergeht.

== <anchor-46><anchor-47>Code-Kommentare
<code-kommentare>
Um auch später noch gut nachvollziehen zu können, was das gerade
geschriebene Programm genau macht, hilft es dieses möglichst gut zu
dokumentieren. Der einfachste Weg hierfür ist es Code-Kommentare
einzufügen. Das sind Zeilen im Programm, die vom Interpreter ignoriert
werden und einen beliebigen Text enthalten können. In Python beginnen
Kommentarzeilen mit einer Raute (\'#strong[\#]\').

#strong[\# Dieser Kommentar könnte erklären, was die Funktion macht… \
]def zaehleBisWert(maximum): \
for schritt in range(maximum): \
print(\'Schritt {}…\'.format(schritt)) #strong[\# Auch ein Kommentar] \
print(\'Ziel von {} erreicht\'.format(maximum))

Alles nach der Raute wird in der jeweiligen Zeile vom Interpreter
ignoriert, Kommentare funktionieren daher auch am Ende einer Zeile.

Es macht Sinn fleißig zu kommentieren: was macht diese Funktion, was
bedeutet diese Variable, was sind gültige Werte für einen Parameter… -
alles, was hilft den Code auch noch nach Monaten auf einen Blick zu
verstehen, ist gut!

== <anchor-48><anchor-49><anchor-50>Literatur und Links
<literatur-und-links>
Es gibt massig gute Quellen im Netz, wenn man Python lernen möchte - und
natürlich auch Bücher, teilweise sogar speziell für Kinder und
Jugendliche. Hier eine kleine Auswahl.

=== <anchor-51><anchor-52>Links
<links>
- #blockquote[
  #link("https://www.python-lernen.de/")[#emph[https://www.python-lernen.de/]]
  \
  Eine sehr gute Seite, um Python zu lernen. Von den absoluten
  Grundlagen hin zu fortgeschrittenen Themen, alles gut erklärt und mit
  vielen Beispielen.
  ]

- #blockquote[
  https://docs.python.org/3/library/ \
  Die Python-Standardbibliothek – hier finden sich detaillierte
  Informationen zu den häufig in Programmen genutzten Modulen (z.B.
  time, math, random, …), die Python von Haus aus mitbringt. In vielen
  Sprachen verfügbar, leider nicht auf Deutsch.
  ]

=== <anchor-53><anchor-54>Bücher & Zeitschriften
<bücher-zeitschriften>
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

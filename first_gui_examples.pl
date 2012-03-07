% Autor:
% Datum: 20.12.2011

% Laden der XPCE Bibliotheken
:- use_module(library(pce)).

% Ein Objekt mit new erzeugen
% erstes Argument bekommt von XPCE eine Referenz f�r den Zugriff
% zweites Argument ist ein Term, des Funktor die zu ladende Klasse(Objekt) angibt

% Dialogfenster anlegen
firstDialog:-new(Dialog,dialog('First Dialog - Hello World')),
send(Dialog, open).

% Dialogfenster anlegen
secondDialog:-new(Dialog,dialog('Second Dialog')),
% Button einf�gen
send(Dialog, append, button('Hello')),
% Dialog �ffnen
send(Dialog, open).

% Dialogfenster anlegen
thirdDialog:-new(Dialog,dialog('Third Dialog')),
% Button with event Prolog event function.
% On press call function event
send(Dialog, append, button('Cancel',message(@prolog,event,Dialog))),
% Dialog �ffnen
send(Dialog, open).
% Event objekt bekommt die Dialogreferenz und ruft �ber diese die destroy funktion auf
event(Dialog):- send(Dialog, destroy).

% Dialogfenster anlegen
textDialog:-new(Dialog,dialog('Text Dialog')),
% Textelement anlegen
new(Text, text_item('Eingabe:')),
% Textelement im Dialogfesnter einf�gen
send(Dialog, append, Text),
% Dem Textelement einen Vorlagetext senden
send(Text, value, 'Text Vorgabe...'),
% Dialog �ffnen
send(Dialog, open).

% Dialogfenster anlegen
text2terminalDialog:-new(Dialog,dialog('Text Dialog')),
% Textelement anlegen
%
new(Text, text_item('Eingabe:')),
% Textelement im Dialogfesnter einf�gen
send(Dialog, append, Text),
% Dem Textelement einen Vorlagetext senden
send(Text, value, '\nDiesen Text auf der Konsole ausgeben!\n'),
% Dialog �ffnen
send(Dialog, open),
% Text aus dem Textelement auslesen
get(Text, value, GetText),
% text auf der Konsole ausgeben
writeln(GetText).

% Dialogfenster anlegen
textandbuttonsDialog:- new(Dialog,dialog('Text Dialog')),
% Textelement anlegen
new(TextItem, text_item('Eingabe:')),
% Textelement im Dialogfesnter einf�gen
send(Dialog, append, TextItem),
send(Dialog, append, button('Ok',message(@prolog,senden,TextItem))),
send(Dialog, append, button('Cancel',message(@prolog,cancel,Dialog))),
% Dem Textelement einen Vorlagetext senden
send(TextItem, value, 'Test!\n'),
% Dialog �ffnen
send(Dialog, open).
senden(TextItem):- get(TextItem, value, GetText), writeln(GetText).
cancel(Dialog):- send(Dialog, destroy).

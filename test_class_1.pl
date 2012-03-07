% Autor:
% Datum: 15.01.2012

% Eine eigene Klasse definieren
:- module(myclass, [test_myclass/0]).
:- use_module(library(pce)).

% Die Klasse beginnt hier
% hat den Namen myclass
% und ist von object abgeleitet
:-pce_begin_class(myclass, object).
% Eine zu dem Objekt gehörende globale ’Variable’ anlegen.
% Dieses Objekt wird erst angelegt, wenn es benötigt wird
:-pce_global(@number,new(number(0))).
% Konstruktor
initialise(Self,V):->
       % Supermethode aufrufen, in dem Fall den Konstruktor
       send_super(Self,initialise),
       send(@number,value,V).
% Eingabemethode um den Wert zu ¨andern
value(_,V):-> send(@number, value ,V).

% Wert bekommen mittels Ausgabemethode
value(_,V):<-
"Eine kurze Beschreibung für die Onlinehilfe"::
get(@number, value ,V).
% Klassendefinition endet hier
:-pce_end_class.

% Die Klasse testen
 test_myclass:-
 new(M, myclass(10)), % neue Instanz der Klasse erzeugen
 send(M, value, 20), % Eingabe Methode
 get(M, value, V), % Ausgabe Methode
 writeln(V).


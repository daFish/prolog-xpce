% Autor:
% Datum: 27.07.2010

% Laden der XPCE Bibliotheken
:- use_module(library(pce)).
:- use_module(library(pce_style_item)).
% Mit use_module wird eine XPCE Bibliothek eingebunden
:- use_module(library(find_file)).
% Erstellt einen global verfügbaren Zeiger auf einen Dateiöffnungsdialog
:- pce_global(@finder, new(finder)).

editor :-
       new(Frame, frame('Editor')),
       new(View,view),
       new(Dialog,dialog),
       send(Frame, append(View)),
       send(Frame, append(Dialog)),
       send(View, font, normal),
       send(Dialog, below(View)), % legt Dialogfeld unterhalb des Viewfeldes an
       send(View, width(100)),
       send(View, height(20)),
       new(Load,button('Laden',message(@prolog,load, View))),
       new(Store,button('Speichern',message(@prolog,store, View, Dialog))),
       new(Close,button('Schließen',message(Frame,destroy))),
       send(Dialog,append(Load)),
       send(Dialog,append(Store)),
       send(Dialog,append(Close)),
       %new(A, text_item('Ergebnis')),
       %send(Dialog,append(A)),
       send(Frame,open).
       
load(V) :-
       working_directory(Dir,Dir),
       % Voreinstellungen für Dateiöffnungsdialog: @on = nur Existierente Dateien können ausgewählt werden,
       % '.txt' nur Dateien mit der Endung "txt", Dir = Arbeitsverzeichnis...
       get(@finder, file(@on,'.txt', Dir), Datei),
       send(V,load(Datei)).
store(V,D) :-
       % Hole Dateiname von View -> view besitzt editor der besitzt die Dateivariable
       % also greift man von view auf den editor zu und über seine file Variable auf den Dateinamen.
       % Buchseite 161
       get(V?editor?file, name, Datei),
       create_filename(Datei,Filename),
      %get(D,member('Ergebnis'),A_1),
      %send(A_1,selection(Filename)),
       send(V, save(Filename)).

create_filename(SourceName,ReturnName) :-
      ( SourceName == nil
        -> get(@finder, file, off, '.txt', ReturnName)   % gui.pl  row 1223
        ; ReturnName = SourceName
      ).
set_style(Fr, Style) :-
            get(Fr, member, view, View),
            get(View, selection, point(Start, End)),
            (   Start == End
            -> send(Fr, report, warning, 'No selection')
            ;   get(View, text_buffer, TB),
                new(_, fragment(TB, Start, End-Start, Style))
            ).
   %Define a new style and add it to the menu and the view.
   define_style(Fr) :-
   ask_style(Fr, Name, Style), append_style(Fr, Name, Style).

append_style(Fr, Name, Style) :-
   get(Fr, member, dialog, D),
   get(D, member, style, Menu),
   send(Menu, append, Name),
   send(Menu, active, @on),
   get(Fr, member, view, View),
   send(View, style, Name, Style).

ask_style(Fr, Name, Style) :-
    new(D, dialog('Define Style')),
    send(D, append,
    new(N, text_item(name, ''))),
    % Definierter Style Kontext(Ansicht)
    send(D, append,new(S, style_item(style))),
    % OK - Button der das Objekt ok zurück geben soll
    send(D, append, button(ok, message(D, return, ok))),
    % Cancel - Button der das Objekt cancel zurück geben soll
    send(D, append,button(cancel, message(D, return, cancel))),
    % defaultbutton = ok => reagiert auf ENTER Taste
    send(D, default_button, ok),
    send(D, transient_for, Fr),
    repeat,
    get(D, confirm_centered, Fr?area?center, Answer),
    (   Answer == ok
        -> get(N, selection, Name),
        (    Name == ''
             -> send(D, report, error, 'Please enter a name'),
             fail
             ;    !,
             get(S, selection, Style),
             send(Style, lock_object, @on),
             send(D, destroy)
         )
         ;   !,
         send(D, destroy),
         fail
     ).


% use with -> editor.

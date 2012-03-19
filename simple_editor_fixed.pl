% Autor:
% Datum: 15.03.2012

% Dialogfenster anlegen
textandbuttonsDialog:-
        new(Dialog,dialog('Text Dialog')),
        % Textelement anlegen

        new(TextItem, text_item('Eingabe:')),
        % Textelement im Dialogfesnter einfügen
        send(Dialog, append, TextItem),
        send(Dialog, append, button('Ok',message(@prolog,senden,TextItem))),
        send(Dialog, append, button('Cancel',message(Dialog,return,@nil))),
        % Dem Textelement einen Vorlagetext senden
        send(TextItem, value, 'Test!'),
        % Dialog öffnen
        send(Dialog, open),
        get(Dialog,confirm,_),
        send(Dialog,destroy).

senden(TextItem):-
            get(TextItem, value, GetText),
            write(GetText),
            nl.
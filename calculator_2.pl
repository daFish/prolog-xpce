% Autor:
% Datum: 18.07.2010


calculator :-
        new(D, dialog('Calculator')),
        send(D, append, new(TI, text_item('Eingabe'))),
        send(D, append, new(T2, text_item('Ausgabe'))),
        %dialog_group -> gruppiert graphical elements first para=NAME second="box=rahmen or group=ohne rahmen"
        send(D, append,new(NumRows, dialog_group(buttons, group))),
        % Elementeabstand 2 = vertikal 10 = horizontal
        send(NumRows, gap, size(2, 10)),
        send(NumRows, append, button(1,message(@prolog,stringAppend,D,'1'))),
        send(NumRows, append, button(2,message(@prolog,stringAppend,D,'2'))),
        send(NumRows, append, button(3,message(@prolog,stringAppend,D,'3'))),
        send(NumRows, append, button(4,message(@prolog,stringAppend,D,'4')), below),
        send(NumRows, append, button(5,message(@prolog,stringAppend,D,'5'))),
        send(NumRows, append, button(6,message(@prolog,stringAppend,D,'6'))),
        send(NumRows, append, button(7,message(@prolog,stringAppend,D,'7')), below),
        send(NumRows, append, button(8,message(@prolog,stringAppend,D,'8'))),
        send(NumRows, append, button(9,message(@prolog,stringAppend,D,'9'))),
        send(NumRows, append, button('(',message(@prolog,stringAppend,D,'(')), below),
        send(NumRows, append, button(0,message(@prolog,stringAppend,D,'0'))),
        send(NumRows, append, button(')',message(@prolog,stringAppend,D,')'))),
        send(NumRows, layout_dialog),% ohne diese Option kein verrücken von den Op buttons
        send(D, append, new(OpRows, dialog_group(operation, group)), right),
        send(OpRows, gap, size(2, 10)),
        send(OpRows, append, button(+,message(@prolog,stringAppend,D,'+'))),
        send(OpRows, append, button(-,message(@prolog,stringAppend,D,'-')), below),
        send(OpRows, append, button(*,message(@prolog,stringAppend,D,'*')), below),
        send(OpRows, append, button(/,message(@prolog,stringAppend,D,'/')), below),
        send(OpRows, append, button(=,message(@prolog,calc,D)), below),
        send(OpRows, alignment, left),
        send(D, layout),
        send(D, open).

% store key
stringAppend(Dialog,Str):-
    get(Dialog, member('Eingabe'),Ein),
    get(Ein, selection, Eingabe),
    string_concat(Eingabe,Str,Ausgeben),
    % Ausgabe in Dialog schreiben
    get(Dialog,member('Eingabe'),Aus),
    send(Aus,selection(Ausgeben)).

% calculate output
calc(Dialog):-
    get(Dialog, member('Eingabe'),Ein),
    get(Ein, selection, Eingabe),
    string_concat(Eingabe,'.',Ergebnis2),
    %string als Stream oeffen
    pce_open(Ergebnis2, read, Stream),
    %den Inhalt aus Stream lesen
    read(Stream, Term),
    %stream schliessen
    close(Stream),
    %und mittels is und eval auswerten
    Res is (eval(Term)),
    % Ausgabe in Dialog schreiben
    get(Dialog,member('Ausgabe'),Aus),
    send(Aus,selection(Res)).


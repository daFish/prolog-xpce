% Autor: Andreas Richter
% Datum: 18.07.2010

% CALL with -> small_calculator.


small_calculator:-
      new(Dialog, dialog('Taschenrechner')),
      new(Text_E, text_item('Text')),
      new(Text_A, text_item('Ergebnis')),
      send(Dialog,append(Text_E)),
      send(Dialog,append(Text_A)),
      % Button anlegen und als Signal das Prädikat berechne mit dem Zeiger Dialog übergeben
      new(B_Calc,button(berechne,message(@prolog,berechne,Dialog))),
      new(B_Close,button(abbrechen,message(Dialog,destroy))),
      send(Dialog,append(B_Calc)),
      send(Dialog,append(B_Close)),
      send(Dialog,default_button(B_Calc)),
      send(Dialog, open).

berechne(Dialog):-
    % Eingabe aus Dialog holen
    get(Dialog, member('Text'),T_1),
    get(T_1, selection, E1),

    %Berechnen
    %string aufbereiten ( Punkt anhängen )
    string_concat(E1,'.',E2),
    %string als Stream oeffen
    pce_open(E2, read, In),
    %den Inhalt aus Stream lesen
    read(In, Term),
    %stream schliessen
    close(In),
    %und mittels is und eval auswerten
    Res is (eval(Term)),

    % Ausgabe in Dialog schreiben
    get(Dialog,member('Ergebnis'),A_1),
    send(A_1,selection(Res)).

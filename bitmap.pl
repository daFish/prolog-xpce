% Autor: XPCE
% Datum: 31.07.2010

viewer :-
new(P, picture),
send(P?frame, label, 'Image Viewer'), % naträgliches ändern des Namens...
new(I, image('pce.bm')),
new(B, bitmap(I)),
send(P,display,B),
send(new(D, dialog), below, P),
 send(D, append, button(quit, message(P, destroy))),
send(P, open).

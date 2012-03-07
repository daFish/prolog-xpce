% Autor:
% Datum: 12.01.2012

% Laden der XPCE Bibliotheken
:- use_module(library(pce)).

% von http://kamelzeug.wordpress.com/2010/02/23/gui-programmierung-in-prolog/
gfx:-
    new(P,picture('Bunte Formen')),
    new(Box,box(100,100)),
    new(Circle,circle(100)),
    send(Box,fill_pattern,orange),
    send(Circle,fill_pattern,red),
    send(P,display(Box,point(10,10))),
    send(P,display(Circle,point(150,10))),
    send(P,open).
 
picture:-
    new(@Picture,picture('Demo Picture')),
    send(@Picture, display, new(@bo, box(110,110))),
    send(@Picture, display, new(@ci, circle(60)), point(25,25)),
    send(@Picture, display, new(@bm, bitmap('32x32/books.xpm')), point(200,110)),
    send(@Picture, display, new(@tx, text('Hello World')), point(120, 50)),
    %                                             %list of points
    send(@Picture, display, new(@bz, bezier_curve(point(50,110),point(200,132),point(50, 160),point(150, 250)))),
    send(@Picture, open).
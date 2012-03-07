% Autor: Gerhard Röhner
% Buch: Informatik mit Prolog
% Datum: 24.01.2012

:- use_module(library(pce)).
:- use_module(library(pce_style_item)).
% Mit use_module wird eine XPCE Bibliothek eingebunden
:- use_module(library(find_file)).

% Gloabal objects
:- pce_global(@graph_link, new(link(link,link,line(0,0,0,0)))).

graph:-
       new(F, frame('Graph')),
       new(V, view),
       send(V, width(25)),
       new(P, picture),
       new(D, dialog),
       send(F, append(V)),
       send(P, right(V)),
       send(D, below(V)),
       new(Open, button('Open',message(@prolog,open, V))),
       new(Paint, button('Paint',message(@prolog,paint, P))),
       new(Print, button('Print',message(@prolog,print, P,V))),
       new(Store, button('Store',message(@prolog,store, V))),
       new(Cancel, button('Cancel',message(F,destroy))),
       send(D, append(Open)),
       send(D, append(Paint)),
       send(D, append(Print)),
       send(D, append(Store)),
       send(D, append(Cancel)),
       send(D, open).
       
open(V):-
          working_directory(Dir,Dir),
          get(@finder, file(@on, '.pl', Dir), File),
          send(V, load(File)),
          consult(File).

print(P,V):-
           send(V?editor, clear),
           node(Node,_,_),
           get(P, member(Node),Device),
           get(Device,offset,point(X,Y)),
           send(V?editor, append(string('node(%s,%d,%d).\n',Node,X,Y))),fail.

print(P,V):-
            edge(Node1,Node2, _),
            get(P, member(Node1), D1),
            get(P, member(Node2), D2),
            get(D1, offset, point(X1,Y1)),
            get(D2, offset, point(X2,Y2)),
            Dis is round(sqrt((X1-X2)^2+(Y1-Y2)^2)),
            send(V?editor, append(string('edge(%s,%s,%d).\n',Node1,Node2,Dis))), fail.
%print(_,_).

store(V):-
          get(V?editor?file, name, File),
          send(V, save(File)).


          
paint(P):-
          forall(node(Name, X, Y), paintNode(P,Name, X, Y)),
          forall(edge(From, To, D), paintEdge(P,From, To, D)).
          
paintNode(P, Name, X, Y):-
          new(Device, device),
          send(Device, name(Name)),
          new(Circle, circle(15)),
          send(Device, display(Circle)),
          new(Identifier, text(Name)),
          send(Device, display(Identifier, point(5,0))),
          send(P, display(Device, point(X,Y))),
          new(M, move_gesture(left)),
          send(Device, recogniser(M)),
          send(Device, handle(handle(w/2, 0, link, link))),
          send(Device, handle(handle(w/2, h, link, link))),
          send(Device, handle(handle(0, h/2, link, link))),
          send(Device, handle(handle(w, h/2, link, link))).
          
paintEdge(P, From, To, _D):-
          get(P, member(From), Node1),
          get(P, member(To), Node2),
          send(Node1, connect, Node2, @graph_link).
          

% use with -> graph.
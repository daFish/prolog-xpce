% Autor:
% Datum: 04.03.2012

% Laden der XPCE Bibliotheken
:- use_module(library(pce)).

create_list:-
    new(Dialog,dialog('New List')),
    % send list of items to Dialog
    send_list(Dialog,append,
    [
    %
    new(Name,text_item('Text')),
    %                 %menuname
    new(Dropdown,menu(dropdown,cycle)),
    %
    new(Numbers,int_item('Change Number',low:=1,high:=100)),
    %
    new(Ok,button('OK'))
    ]),
   % send list of elements to dropbox
   send_list(Dropdown, append, [element_1,element_2,element_3]),
   send(Dialog,open).
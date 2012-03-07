% Autor:
% Datum: 16.01.2012

% run with -> run.

% http://www.humbug.in/stackoverflow/de/howto-read-from-a-prolog-predicate-in-xpce-4391136.html

:- use_module(library(pce)).

% Die Klasse beginnt hier und hat den Namen demo
% und ist von dialog abgeleitet
:- pce_begin_class(demo, dialog).
/* Instance variables
 *        name,   type,  access, description */
variable(result, name*, get,    "Result from Prolog Callback").

initialise(Demo) :->
    "Create something that get/4 and send/3 can work with."::
    send(Demo, send_super, initialise, 'Demo'),
    send(Demo, append, new(InputText, text_item(input, 'Demo Text'))),
    send(Demo, append,
         button(execute_command,
            and(message(@prolog,doIt, Demo,InputText?selection),
            message(@prolog,printIt,Demo)))).
:- pce_end_class.

%%% Create a new value based on the input string
%%% Write the new value back to the 'input' member of the
%%% 'demo' object.  Also put the value int the 'result' slot.
doIt(Demo,Word) :-
    concat_atom(['*** ' , Word, ' *** '] ,WordGotDid),
    format("doIt: Setting result: ~w...~n", [WordGotDid]),
    get(Demo,member,input,InputText),
    send(InputText,selection,WordGotDid),
    send(Demo,slot,result,WordGotDid).

%%% Read and display the 'result' slot.
printIt(Demo) :-
    get(Demo,slot,result,Result),
    write('\nResult: "'),
    write(Result),
    write('"\n').

%%% Create an object that has fields that can be mutated.
run :- new(Demo,demo),
    send(Demo,open).

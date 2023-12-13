%%%% -*- Mode: Prolog -*-
%%%% 858101 Nicoletta Davide

%%fields/2, fields/3
fields(X, Y):-
   % assert(field(X, Y)).

fields(X, Y, Z):-
    %assert(field(X, Y, Z)).

%% def_class/2, def_class/3
def_class(_, []).
def_class(_, [_]).
def_class(X, [], Z):-
    is_list(Z),
    %aggiungere is_fields
    assert(class(X, Z)).
def_class(_, [_], [_]).
    
%%%% end of file -- oop.pl    

%%%% -*- Mode: Prolog -*-
%%%% 858101 Nicoletta Davide

%%fields/2, fields/3
%fields(_, _).
   % assert(field(X, Y)).

%fields(_, _, _).
%assert(field(X, Y, Z)).
is_field([]).
is_field(field(_, _)).
is_field(field(_, _, _)).
is_field([X | Rest]):-
    is_field(X),
    is_field(Rest).

%% def_class/2, def_class/3
def_class(_, []).
def_class(_, [_]).
def_class(X, [], Z):-
    is_field(Z),
    assert(class(X, [], Z)).
def_class(_, [_], [_]).
    
%%%% end of file -- oop.pl    

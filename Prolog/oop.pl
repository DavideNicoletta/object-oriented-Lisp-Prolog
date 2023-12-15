%%%% -*- Mode: Prolog -*-
%%%% 858101 Nicoletta Davide

%%% Predicati dinamici (per evitare warnings), cambiare
:- dynamic class/1.


%%% is_parts/1
%% The is_parts(Element) predicate is True whene the elements of the
%% list Element are field or method

is_parts([]).

is_parts(field(_Name, _Value)).

is_parts(field(_Name, _Value, _Type)).

is_parts(method(_Name, ArgList, _Form)):-
    is_list(ArgList).

is_parts([First | Rest]):-
    is_parts(First),
    is_parts(Rest).




%%% def_class/2
%% The def_class predicate defines the structure of a class and stores
%% it in the “knowledge base” by Prolog.

def_class(Name, []):-
    atom(Name),
    assert(class([Name, [], []])).

def_class(Name, Parents):-
    atom(Name),
    is_list(Parents),
    maplist(is_class, Parents),
    assert(class([Name, Parents, []])).

%%% def_class/3
%% The def_class predicate defines the structure of a class and stores
%% it in the “knowledge base” by Prolog.

def_class(Name, Parents, Parts):-
    atom(Name),
    is_list(Parents),
    is_parts(Parts),
    maplist(is_class, Parents),
    assert(class([Name, Parents, Parts])).




%%% is_class/1
%% True when the atom passed to it is the name of a class

is_class(ClassName):-
    atom(ClassName),
    current_predicate(class/1), !,
    class([ClassName, _, _]).




%%%  make/2
make(InstanceName, ClassName):-
    atom(InstanceName),
    atom(ClassName),
    is_class(ClassName),
    assert(instance([InstanceName, ClassName])).

make(InstanceName, ClassName):-
    var(InstanceName),
    atom(ClassName),
    is_class(ClassName),
    assert(instance([InstanceName, ClassName])),
    InstanceName = istance([InstanceName, ClassName]).

%%verificare
make(InstanceName, ClassName):-
    atom(InstanceName),
    is_class(ClassName),
    InstanceName =.. Instance,
    %verificare
    second(Instance, X),
    is_istance(X).

%    assert(istance([InstanceName, ClassName])).


%%% field/3






%def_class(student, [person], [field(name, "Eva Lu Ator"), field(university, "Berkeley"), method(talk, [], (write("My name is "), field(this, name, N), writeln(N), write("My age is "), field(this, age, A), writeln(A)))]).

%%%% end of file -- oop.pl    

%%%% -*- Mode: Prolog -*-
%%%% 858101 Nicoletta Davide

%%% Predicati dinamici
:- dynamic class/1.
:- dynamic instance/1.

%%% is_parts/1
%% The is_parts(Element) predicate is True whene the elements of the
%% list Element are field or method

is_parts([]).

is_parts(field(_Name, _Value)).

is_parts(field(_Name, _Value, _Type)).

is_parts(method(_Name, ArgList, _Form)):-
    is_list(ArgList).
    %assert(method([Name, ArgList, Form])).

is_parts([First | Rest]):-
    is_parts(First),
    is_parts(Rest).

%%% is_method/1
is_method(method(_, _, _)).

%%% is_field/1
is_field(field(_Name, _Value, _Type)).

%%% is_write/1
is_write(write(_)).

%%% load_method/1
%% True quando carica i metodi nella base di conoscenza prolog
%load_method(_Name, _ArgList, Form):-
%     write(Form).



%%% create_method/1
%create_method([write(X), field(this, X, _)], Method):-
%    is_write(Element),
    
%    atom_concat(Method, Element)

%create_method([Element | Rest], Method):-
%    is_field(Element).




%%% check_method/1
%check_method([method(X, Y, Z) | _]):-
%    load_method(X, Y, Z).

%check_method([_ | Rest]):-
%    check_method(Rest).
    

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



%%% is_instance/1
is_instance(Value):-
    instance([Value, _]).


%%% is_instance/2
is_instance(Value, ClassName):-
    instance([Value, Class]),
    class([Class, [ClassName], _]).



%%%  make/2
make(InstanceName, ClassName):-
    atom(InstanceName),
    atom(ClassName),
    is_class(ClassName),
%    class([ClassName, _, X]),
%    check_method(X),
    assert(instance([InstanceName, ClassName])).

make(InstanceName, ClassName):-
    var(InstanceName),
    atom(ClassName),
    is_class(ClassName),
%    class([ClassName, _, X]),
%    check_method(X),
    assert(instance([InstanceName, ClassName])),
    InstanceName = istance([InstanceName, ClassName]).

%%verificare
make(InstanceName, ClassName):-
    atom(InstanceName),
    is_class(ClassName),
%    class([ClassName, _, X]),
%    check_method(X),
    InstanceName =.. Instance,
    %verificare
    second(Instance, X),
    is_istance(X).

%   assert(istance([InstanceName, ClassName])).


%%% inst/2
inst(InstanceName, Instance):-
    atom(InstanceName),
    current_predicate(instance/1),
    instance([InstanceName ,  Instance]).

%%% field/3
field(Instance, FieldName, Result):-
    is_instance(Instance),
    instance([Instance, ClassName]),
    class([ClassName, _, Field]),
    throwField(Field, FieldName, Result).


%%% throwField/3
throwField([field(FieldName, Result) | _], FieldName, Result).
throwField([_ | Rest], FieldName, Result):-
    throwField(Rest, FieldName, Result).
					    





%def_class(student, [person], [field(name, "Eva Lu Ator"), field(university, "Berkeley"), method(talk, [], (write("My name is "), field(this, name, N), writeln(N), write("My age is "), field(this, age, A), writeln(A)))]).

%%%% end of file -- oop.pl    

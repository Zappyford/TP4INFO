% test daughter

:- set(i,2).
:- set(verbose,1).

:- modeh(1,daughter(+person,+person)).
:- modeb(1,mother(-person,+person)).
:- modeb(*,mother(+person,-person)).
:- modeb(1,father(-person,+person)).
:- modeb(*,father(+person,-person)).
:- modeb(1,male(+person)).
:- modeb(1,female(+person)).


:- determination(daughter/2,mother/2).
:- determination(daughter/2,father/2).
:- determination(daughter/2,male/1).
:- determination(daughter/2,female/1).


% type definitions
person(ann).
person(mary).
person(rosy).
person(tom).
person(eve).
person(lisa).
person(bob).

% ann
female(ann).
mother(ann,mary).
mother(ann,tom).

% mary
female(mary).
mother(mary,rosy).

% rosy
female(rosy).

% tom
male(tom).
father(tom,eve).
father(tom,lisa).
father(tom,bob).

% eve
female(eve).

% lisa
female(lisa).

% bob
male(bob).


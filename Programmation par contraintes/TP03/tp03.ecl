%%%%%%%%%%%%%%%%%%%%%%%
%% Contraintes 4INFO %%
%%       TP 03       %%
%%   Guillaume ROY   %%
%%   Antoine CHENON  %%
%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).
:-lib(ic_symbolic).
%:-lib(arrays).

%% Définition des domaines
:- local domain(machine(m1,m2)).

%% Question 3.1 %%
%% taches(?Taches) : unifie Taches au tableau des tâches
taches([](tache(3,[], m1, _),
		tache(8,[],m1, _),
		tache(8,[4,5],m1, _),
		tache(6,[],m2, _),
		tache(3,[1],m2, _),
		tache(4,[1,7],m1, _),
		tache(8,[3,5],m1, _),
		tache(6,[4],m2, _),
		tache(6,[6,7],m2, _),
		tache(6,[9,12],m2, _),
		tache(3,[1],m2, _),
		tache(6,[7,8],m2, _))).

%% Question 3.2
%% affiche(+Taches) affiche les taches
affiche(Taches) :-
				dim(Taches, [Dim]), 
				(for(I, 1, Dim), param(Taches)
					do
						tache(Duree, Nom, Machine, _) is Taches[I],
						writeln(X)
				).

%% Question 3.3
%% domaines(+Taches, ?Fin)
domaines(Taches,Fin) :-
		(foreachelem(tache(Duree,_Noms,_Machine,Debut),Taches), param(Fin)
		do
		(Debut #>= 0,
		Debut + Duree #< Fin)). 

%% Question 3.4
%% getVarList(+Taches,?Fin,?List) recupère la liste des variables
getVarList(Taches, Fin, List):-
			(foreachelem(tache(_Duree,_Noms,_Machine,Debut),Taches),
			fromto([Fin],In, Out, List)
			do
				Out = [Debut| In]
			).

%% Question 3.5
%% solve(?Taches, ?Fin) trouve un ordonnancement
solve(Taches,Fin) :-
		taches(Taches),
		domaines(Taches,Fin),
		getVarList(Taches,Fin,Liste),
		labeling(Liste).

%% Question 3.6
%% precedence(+Taches)
precedence(Taches) :-
(foreachelem(tache(_Duree,Noms,_Machine,Debut),Taches), param(Taches)
	do
	(
	foreach(X,Noms), param(Taches,Debut)
		do
		(
		tache(Duree2, _Noms2, _Machine2, Debut2) is Taches[X],
		Debut #>= Duree2 + Debut2
		)
	)
).

%% Question 3.7
%% conflits(+Taches)

conflits(Taches):-
(
	for(I, 1, 12),
	param(Taches)
	do
	(
		for(J, I+1, 12),
		param(Taches), param(I)
		do
			tache(Duree1, _, Machine1, Debut1) is Taches[I],
			tache(Duree2, _, Machine2, Debut2) is Taches[J],
			(Machine1 &= Machine2) => (Debut2#>=Debut1+Duree1 or Debut2#=<Debut1-Duree2)
	)
).


/*

Yes (0.08s cpu)
affiche([](tache(3,[], m1, _),
tache(8,[],m1, _),
tache(8,[4,5],m1, _),
tache(6,[],m2, _),
tache(3,[1],m2, _),
tache(4,[1,7],m1, _),
tache(8,[3,5],m1, _),
tache(6,[4],m2, _),
tache(6,[6,7],m2, _),
tache(6,[9,12],m2, _),
tache(3,[1],m2, _),
	tache(6,[7,8],m2, _)).
syntax error: unexpected fullstop
| tache(6,[7,8],m2, _)).
|                       ^ here
[eclipse 2]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 3]: taches(X).

X = [](tache(3, [], m1, _181), tache(8, [], m1, _186), tache(8, [4, 5], m1, _191), tache(6, [], m2, _200), tache(3, [1], m2, _205), tache(4, [1, 7], m1, _212), tache(8, [3, 5], m1, _221), tache(6, [4], m2, _230), tache(6, [6, 7], m2, _237), tache(6, [9, 12], m2, _246), tache(3, [1], m2, _255), tache(6, [7, 8], m2, _262))
Yes (0.00s cpu)
[eclipse 4]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 5]: ["tp03"].
tp03.ecl   compiled 3384 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 6]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 7]: ["tp03"].
tp03.ecl   compiled 3384 bytes in 0.01 seconds

Yes (0.01s cpu)
[eclipse 8]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 9]: ["tp03"].
tp03.ecl   compiled 3200 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 10]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 11]: trace.
Debugger switched on - creep mode
[eclipse 12]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> creep
  (2) 2 CALL  do__4(taches(X))   %> creep
  (2) 2 FAIL  do__4(...)   %> creep
  (1) 1 FAIL  affiche(...)   %> creep

No (0.00s cpu)
[eclipse 13]: trace.
Debugger switched on - creep mode
[eclipse 14]: notrace.
Debugger switched off
[eclipse 15]: trace.
Debugger switched on - creep mode
[eclipse 16]: ["tp03"].
library not found in use_module(library(arrays))
WARNING: Directive failed or aborted in file tp03.ecl, line 10:
:- lib(arrays).
tp03.ecl   compiled 3200 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 17]: notrace.
Debugger switched off
[eclipse 18]: affiche(taches(X)).

No (0.00s cpu)
[eclipse 19]: ["tp03"].
library not found in use_module(library(arrays))
WARNING: Directive failed or aborted in file tp03.ecl, line 10:
:- lib(arrays).
*** Warning: Singleton local variable Taches in do-loop, maybe param(Taches) missing?
*** Warning: Singleton local variable I in do-loop (not used in loop body)
File tp03.ecl, line 35: Singleton variable Taches
tp03.ecl   compiled 3696 bytes in 0.01 seconds

Yes (0.01s cpu)
[eclipse 20]: ["tp03"].
library not found in use_module(library(arrays))
WARNING: Directive failed or aborted in file tp03.ecl, line 10:
:- lib(arrays).
*** Warning: Singleton local variable X in do-loop, maybe param(X) missing?
File tp03.ecl, line 35: Singleton variable X
tp03.ecl   compiled 3720 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 21]: ["tp03"].
library not found in use_module(library(arrays))
WARNING: Directive failed or aborted in file tp03.ecl, line 10:
:- lib(arrays).
tp03.ecl   compiled 3720 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 22]: ["tp03"].
tp03.ecl   compiled 3720 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 23]: affiche(taches(X)).
type error in dim(taches(X), [_168])
Abort
affiche([](tache(3,[], m1, _),
tache(8,[],m1, _),
tache(8,[4,5],m1, _),
tache(6,[],m2, _),
tache(3,[1],m2, _),
tache(4,[1,7],m1, _),
tache(8,[3,5],m1, _),
tache(6,[4],m2, _),
tache(6,[6,7],m2, _),
tache(6,[9,12],m2, _),
tache(3,[1],m2, _),
	tache(6,[7,8],m2, _))).
tache(3, [], m1, _79)
tache(8, [], m1, _94)
tache(8, [4, 5], m1, _113)
tache(6, [], m2, _128)
tache(3, [1], m2, _145)
tache(4, [1, 7], m1, _164)
tache(8, [3, 5], m1, _183)
tache(6, [4], m2, _200)
tache(6, [6, 7], m2, _219)
tache(6, [9, 12], m2, _238)
tache(3, [1], m2, _255)
tache(6, [7, 8], m2, _274)

Yes (0.00s cpu)
[eclipse 25]: affiche(taches(X)).
type error in dim(taches(X), [_168])
Abort
[eclipse 26]: trace.
Debugger switched on - creep mode
[eclipse 27]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> creep
  (2) 2 CALL  dim(taches(X), [_270])   %> creep
type error in dim(taches(X), [_270])
  (2) 2 LEAVE  dim(..., ...)   %> creep
  (1) 1 LEAVE  affiche(...)   %> creep
Abort
[eclipse 28]: ["tp03"].
*** Warning: Singleton local variable Duree in do-loop, maybe param(Duree) missing?
*** Warning: Singleton local variable Nom in do-loop, maybe param(Nom) missing?
*** Warning: Singleton local variable Machine in do-loop, maybe param(Machine) missing?
*** Warning: Singleton local variable X in do-loop, maybe param(X) missing?
File tp03.ecl, line 35: Singleton variable Duree
File tp03.ecl, line 35: Singleton variable Nom
File tp03.ecl, line 35: Singleton variable Machine
File tp03.ecl, line 36: Singleton variable X
tp03.ecl   compiled 3720 bytes in 0.01 seconds

Yes (0.01s cpu)
[eclipse 29]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> creep
  (2) 2 CALL  dim(taches(X), [_270])   %> creep
type error in dim(taches(X), [_270])
  (2) 2 LEAVE  dim(..., ...)   %> creep
  (1) 1 LEAVE  affiche(...)   %> creep
Abort
[eclipse 30]: ["tp03"].
File tp03.ecl, line 32: Singleton variable Dim
tp03.ecl   compiled 3232 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 31]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> 
 *** Command doesn't exist, is not applicable here, or was aborted: 

   %> creep
  (2) 2 CALL  dim(taches(X), [_285])   %> creep
type error in dim(taches(X), [_285])
  (2) 2 LEAVE  dim(..., ...)   %> creep
  (1) 1 LEAVE  affiche(...)   %> creep
Abort
[eclipse 32]: ["tp03"].
*** Warning: Singleton local variable Duree in do-loop, maybe param(Duree) missing?
*** Warning: Singleton local variable Nom in do-loop, maybe param(Nom) missing?
*** Warning: Singleton local variable Machine in do-loop, maybe param(Machine) missing?
*** Warning: Singleton local variable X in do-loop, maybe param(X) missing?
File tp03.ecl, line 35: Singleton variable Duree
File tp03.ecl, line 35: Singleton variable Nom
File tp03.ecl, line 35: Singleton variable Machine
File tp03.ecl, line 36: Singleton variable X
tp03.ecl   compiled 3704 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 33]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> creep
  (2) 2 CALL  dim(taches(X), _270)   %> creep
type error in dim(taches(X), _270)
  (2) 2 LEAVE  dim(..., ...)   %> creep
  (1) 1 LEAVE  affiche(...)   %> creep
Abort
[eclipse 34]: ["tp03"].
tp03.ecl   compiled 3384 bytes in 0.00 seconds

Yes (0.00s cpu)
[eclipse 35]: affiche(taches(X)).
  (1) 1 CALL  affiche(taches(X))   %> creep
  (2) 2 CALL  is_array(taches(X))   %> creep
  (2) 2 FAIL  is_array(...)   %> creep
  (1) 1 FAIL  affiche(...)   %> creep

No (0.00s cpu)

*/











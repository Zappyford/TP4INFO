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
	(foreachelem(X, Taches)
	do
		writeln(X)
	).

%% Question 3.3
%% domaines(+Taches, ?Fin) 
domaines(Taches,Fin) :-
		(foreachelem(tache(Duree,_Noms,_Machine,Debut),Taches), param(Fin)
		do
		(Debut #>= 0, Debut + Duree #< Fin)). 

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

solve2(Taches,Fin) :-
		taches(Taches),
		precedence(Taches),
		domaines(Taches,Fin),
		getVarList(Taches,Fin,Liste),
		labeling(Liste).

%% Question 3.7
%% conflits(+Taches)
conflits(Taches) :-
	dim(Taches,[IndiceMax]),
	(for(Indice,1,IndiceMax),
	param(Taches,IndiceMax)
	do
	(
		tache(Duree,_Noms,Machine,Debut) is Taches[Indice],
		IndiceSuiv is Indice+1,
		(for(Indice2,IndiceSuiv,IndiceMax),
			param(Taches,Duree,Machine,Debut)
			do
			(
				tache(Duree2, _Noms2, Machine2,Debut2) is Taches[Indice2],
				((Debut2 #>= Debut) and (Debut2 #< (Debut + Duree))) => (Machine &\= Machine2),
				((Debut #>= Debut2) and (Debut #< (Debut2 + Duree2))) => (Machine &\= Machine2)
			)
		)
	)
).
%% Résolution du problème
solve3(Taches,Fin) :-
	taches(Taches),
	domaines(Taches,Fin),
	%domaine_machine(Taches),
	precedence(Taches),
	conflits(Taches),
	getVarList(Taches,Fin,Liste),
	labeling(Liste),
	affiche(Taches).

%% Question 3.8
% La première solution donnée n'est pas forcement la meilleure et de nombreuses solutions sont possibles.
% Nous allons donc limiter la solution à celle qui parait la meilleure à première vue : 44.
solve4(Taches,Fin) :-
	taches(Taches),
	domaines(Taches,Fin),
	precedence(Taches),
	conflits(Taches),
	getVarList(Taches,Fin,Liste),
	Fin #=< 44,
	labeling(Liste),
	affiche(Taches).
% Eclipse ne donne pas d'autres solutions, 44 est donc la meilleure
/*
Q 3.1 :

X = [](tache(3, [], m1, _181), tache(8, [], m1, _186), tache(8, [4, 5], m1, _191), tache(6, [], m2, _200), tache(3, [1], m2, _205), tache(4, [1, 7], m1, _212), tache(8, [3, 5], m1, _221), tache(6, [4], m2, _230), tache(6, [6, 7], m2, _237), tache(6, [9, 12], m2, _246), tache(3, [1], m2, _255), tache(6, [7, 8], m2, _262))

Q 3.2 :

[eclipse 10]: taches(X),affiche(X).
tache(3, [], m1, _345)
tache(8, [], m1, _357)
tache(8, [4, 5], m1, _369)
tache(6, [], m2, _381)
tache(3, [1], m2, _393)
tache(4, [1, 7], m1, _405)
tache(8, [3, 5], m1, _417)
tache(6, [4], m2, _429)
tache(6, [6, 7], m2, _441)
tache(6, [9, 12], m2, _453)
tache(3, [1], m2, _465)
tache(6, [7, 8], m2, _477)

X = [](tache(3, [], m1, _243), tache(8, [], m1, _248), tache(8, [4, 5], m1, _253), tache(6, [], m2, _262), tache(3, [1], m2, _267), tache(4, [1, 7], m1, _274), tache(8, [3, 5], m1, _283), tache(6, [4], m2, _292), tache(6, [6, 7], m2, _299), tache(6, [9, 12], m2, _308), tache(3, [1], m2, _317), tache(6, [7, 8], m2, _324))
Yes (0.00s cpu)

Q 3.3 :

[eclipse 11]: taches(X),domaines(X,40),affiche(X).
tache(3, [], m1, _490{1 .. 36})
tache(8, [], m1, _609{1 .. 31})
tache(8, [4, 5], m1, _728{1 .. 31})
tache(6, [], m2, _847{1 .. 33})
tache(3, [1], m2, _966{1 .. 36})
tache(4, [1, 7], m1, _1085{1 .. 35})
tache(8, [3, 5], m1, _1204{1 .. 31})
tache(6, [4], m2, _1323{1 .. 33})
tache(6, [6, 7], m2, _1442{1 .. 33})
tache(6, [9, 12], m2, _1561{1 .. 33})
tache(3, [1], m2, _1680{1 .. 36})
tache(6, [7, 8], m2, _1799{1 .. 33})

X = [](tache(3, [], m1, _421{0 .. 36}), tache(8, [], m1, _514{0 .. 31}), tache(8, [4, 5], m1, _607{0 .. 31}), tache(6, [], m2, _700{0 .. 33}), tache(3, [1], m2, _793{0 .. 36}), tache(4, [1, 7], m1, _886{0 .. 35}), tache(8, [3, 5], m1, _979{0 .. 31}), tache(6, [4], m2, _1072{0 .. 33}), tache(6, [6, 7], m2, _1165{0 .. 33}), tache(6, [9, 12], m2, _1258{0 .. 33}), tache(3, [1], m2, _1351{0 .. 36}), tache(6, [7, 8], m2, _1445{0 .. 33}))
Yes (0.00s cpu)

[eclipse 12]: taches(X),domaines(X,Fin),affiche(X).
tache(3, [], m1, _492{1 .. 1.0Inf})
tache(8, [], m1, _658{1 .. 1.0Inf})
tache(8, [4, 5], m1, _805{1 .. 1.0Inf})
tache(6, [], m2, _950{1 .. 1.0Inf})
tache(3, [1], m2, _1095{1 .. 1.0Inf})
tache(4, [1, 7], m1, _1240{1 .. 1.0Inf})
tache(8, [3, 5], m1, _1385{1 .. 1.0Inf})
tache(6, [4], m2, _1530{1 .. 1.0Inf})
tache(6, [6, 7], m2, _1675{1 .. 1.0Inf})
tache(6, [9, 12], m2, _1820{1 .. 1.0Inf})
tache(3, [1], m2, _1965{1 .. 1.0Inf})
tache(6, [7, 8], m2, _2110{1 .. 1.0Inf})

X = [](tache(3, [], m1, _423{0 .. 1.0Inf}), tache(8, [], m1, _559{0 .. 1.0Inf}), tache(8, [4, 5], m1, _680{0 .. 1.0Inf}), tache(6, [], m2, _801{0 .. 1.0Inf}), tache(3, [1], m2, _922{0 .. 1.0Inf}), tache(4, [1, 7], m1, _1043{0 .. 1.0Inf}), tache(8, [3, 5], m1, _1164{0 .. 1.0Inf}), tache(6, [4], m2, _1285{0 .. 1.0Inf}), tache(6, [6, 7], m2, _1406{0 .. 1.0Inf}), tache(6, [9, 12], m2, _1527{0 .. 1.0Inf}), tache(3, [1], m2, _1648{0 .. 1.0Inf}), tache(6, [7, 8], m2, _1770{0 .. 1.0Inf}))
Fin = Fin{9 .. 1.0Inf}

There are 12 delayed goals. Do you want to see them? (y/n) 

Delayed goals:
	-(_423{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_559{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_680{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_801{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_922{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_1043{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 4
	-(_1164{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_1285{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1406{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1527{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1648{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_1770{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
Yes (0.00s cpu)

Q 3.4 :

[eclipse 17]: taches(X),domaines(X,Fin),getVarList(X,Fin,Liste).

X = [](tache(3, [], m1, _448{0 .. 1.0Inf}), tache(8, [], m1, _584{0 .. 1.0Inf}), tache(8, [4, 5], m1, _705{0 .. 1.0Inf}), tache(6, [], m2, _826{0 .. 1.0Inf}), tache(3, [1], m2, _947{0 .. 1.0Inf}), tache(4, [1, 7], m1, _1068{0 .. 1.0Inf}), tache(8, [3, 5], m1, _1189{0 .. 1.0Inf}), tache(6, [4], m2, _1310{0 .. 1.0Inf}), tache(6, [6, 7], m2, _1431{0 .. 1.0Inf}), tache(6, [9, 12], m2, _1552{0 .. 1.0Inf}), tache(3, [1], m2, _1673{0 .. 1.0Inf}), tache(6, [7, 8], m2, _1795{0 .. 1.0Inf}))
Fin = Fin{9 .. 1.0Inf}
Liste = [_1795{0 .. 1.0Inf}, _1673{0 .. 1.0Inf}, _1552{0 .. 1.0Inf}, _1431{0 .. 1.0Inf}, _1310{0 .. 1.0Inf}, _1189{0 .. 1.0Inf}, _1068{0 .. 1.0Inf}, _947{0 .. 1.0Inf}, _826{0 .. 1.0Inf}, _705{0 .. 1.0Inf}, _584{0 .. 1.0Inf}, _448{0 .. 1.0Inf}, Fin{9 .. 1.0Inf}]

There are 12 delayed goals. Do you want to see them? (y/n) 

Delayed goals:
	-(_448{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_584{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_705{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_826{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_947{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_1068{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 4
	-(_1189{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 8
	-(_1310{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1431{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1552{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
	-(_1673{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 3
	-(_1795{0 .. 1.0Inf}) + Fin{9 .. 1.0Inf} #> 6
Yes (0.00s cpu)

[eclipse 18]: taches(X),domaines(X,40),getVarList(X,40,Liste).

X = [](tache(3, [], m1, _449{0 .. 36}), tache(8, [], m1, _542{0 .. 31}), tache(8, [4, 5], m1, _635{0 .. 31}), tache(6, [], m2, _728{0 .. 33}), tache(3, [1], m2, _821{0 .. 36}), tache(4, [1, 7], m1, _914{0 .. 35}), tache(8, [3, 5], m1, _1007{0 .. 31}), tache(6, [4], m2, _1100{0 .. 33}), tache(6, [6, 7], m2, _1193{0 .. 33}), tache(6, [9, 12], m2, _1286{0 .. 33}), tache(3, [1], m2, _1379{0 .. 36}), tache(6, [7, 8], m2, _1473{0 .. 33}))
Liste = [_1473{0 .. 33}, _1379{0 .. 36}, _1286{0 .. 33}, _1193{0 .. 33}, _1100{0 .. 33}, _1007{0 .. 31}, _914{0 .. 35}, _821{0 .. 36}, _728{0 .. 33}, _635{0 .. 31}, _542{0 .. 31}, _449{0 .. 36}, 40]
Yes (0.00s cpu)

Q 3.5 :

[eclipse 25]: solve(T,Fin).
T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Fin = 9
Yes (0.00s cpu, solution 1, maybe more) ? ,
Type ; for more solutions, otherwise <return> ? ;

T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Fin = 10
Yes (0.00s cpu, solution 2, maybe more) ? ;

[eclipse 26]: solve(T,40).

T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Yes (0.00s cpu, solution 1, maybe more) ? ;

T = [](tache(3, [], m1, 1), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Yes (0.00s cpu, solution 2, maybe more) ? ;

T = [](tache(3, [], m1, 2), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Yes (0.00s cpu, solution 3, maybe more) ? ;

T = [](tache(3, [], m1, 3), tache(8, [], m1, 0), tache(8, [4, 5], m1, 0), tache(6, [], m2, 0), tache(3, [1], m2, 0), tache(4, [1, 7], m1, 0), tache(8, [3, 5], m1, 0), tache(6, [4], m2, 0), tache(6, [6, 7], m2, 0), tache(6, [9, 12], m2, 0), tache(3, [1], m2, 0), tache(6, [7, 8], m2, 0))
Yes (0.00s cpu, solution 4, maybe more) ? 

Q 3.6 :

[eclipse 28]: solve2(T,Fin).

T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 6), tache(6, [], m2, 0), tache(3, [1], m2, 3), tache(4, [1, 7], m1, 22), tache(8, [3, 5], m1, 14), tache(6, [4], m2, 6), tache(6, [6, 7], m2, 26), tache(6, [9, 12], m2, 32), tache(3, [1], m2, 3), tache(6, [7, 8], m2, 22))
Fin = 39
Yes (0.00s cpu, solution 1, maybe more) ? ;

T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 6), tache(6, [], m2, 0), tache(3, [1], m2, 3), tache(4, [1, 7], m1, 22), tache(8, [3, 5], m1, 14), tache(6, [4], m2, 6), tache(6, [6, 7], m2, 26), tache(6, [9, 12], m2, 32), tache(3, [1], m2, 3), tache(6, [7, 8], m2, 22))
Fin = 40
Yes (0.00s cpu, solution 2, maybe more) ? ;

T = [](tache(3, [], m1, 0), tache(8, [], m1, 0), tache(8, [4, 5], m1, 6), tache(6, [], m2, 0), tache(3, [1], m2, 3), tache(4, [1, 7], m1, 22), tache(8, [3, 5], m1, 14), tache(6, [4], m2, 6), tache(6, [6, 7], m2, 26), tache(6, [9, 12], m2, 32), tache(3, [1], m2, 3), tache(6, [7, 8], m2, 22))
Fin = 41
Yes (0.00s cpu, solution 3, maybe more) ? 

Q 3.7 :

[eclipse 33]: solve3(T,Fin).
tache(3, [], m1, 0)
tache(8, [], m1, 29)
tache(8, [4, 5], m1, 9)
tache(6, [], m2, 0)
tache(3, [1], m2, 6)
tache(4, [1, 7], m1, 25)
tache(8, [3, 5], m1, 17)
tache(6, [4], m2, 12)
tache(6, [6, 7], m2, 31)
tache(6, [9, 12], m2, 37)
tache(3, [1], m2, 9)
tache(6, [7, 8], m2, 25)

T = [](tache(3, [], m1, 0), tache(8, [], m1, 29), tache(8, [4, 5], m1, 9), tache(6, [], m2, 0), tache(3, [1], m2, 6), tache(4, [1, 7], m1, 25), tache(8, [3, 5], m1, 17), tache(6, [4], m2, 12), tache(6, [6, 7], m2, 31), tache(6, [9, 12], m2, 37), tache(3, [1], m2, 9), tache(6, [7, 8], m2, 25))
Fin = 44
Yes (0.02s cpu, solution 1, maybe more) ? ;
tache(3, [], m1, 0)
tache(8, [], m1, 29)
tache(8, [4, 5], m1, 9)
tache(6, [], m2, 0)
tache(3, [1], m2, 6)
tache(4, [1, 7], m1, 25)
tache(8, [3, 5], m1, 17)
tache(6, [4], m2, 12)
tache(6, [6, 7], m2, 31)
tache(6, [9, 12], m2, 37)
tache(3, [1], m2, 9)
tache(6, [7, 8], m2, 25)

T = [](tache(3, [], m1, 0), tache(8, [], m1, 29), tache(8, [4, 5], m1, 9), tache(6, [], m2, 0), tache(3, [1], m2, 6), tache(4, [1, 7], m1, 25), tache(8, [3, 5], m1, 17), tache(6, [4], m2, 12), tache(6, [6, 7], m2, 31), tache(6, [9, 12], m2, 37), tache(3, [1], m2, 9), tache(6, [7, 8], m2, 25))
Fin = 45
Yes (0.02s cpu, solution 2, maybe more) ? ;

Q 3.8 :
[eclipse 36]: solve4(T,Fin).
tache(3, [], m1, 0)
tache(8, [], m1, 29)
tache(8, [4, 5], m1, 9)
tache(6, [], m2, 0)
tache(3, [1], m2, 6)
tache(4, [1, 7], m1, 25)
tache(8, [3, 5], m1, 17)
tache(6, [4], m2, 12)
tache(6, [6, 7], m2, 31)
tache(6, [9, 12], m2, 37)
tache(3, [1], m2, 9)
tache(6, [7, 8], m2, 25)

T = [](tache(3, [], m1, 0), tache(8, [], m1, 29), tache(8, [4, 5], m1, 9), tache(6, [], m2, 0), tache(3, [1], m2, 6), tache(4, [1, 7], m1, 25), tache(8, [3, 5], m1, 17), tache(6, [4], m2, 12), tache(6, [6, 7], m2, 31), tache(6, [9, 12], m2, 37), tache(3, [1], m2, 9), tache(6, [7, 8], m2, 25))
Fin = 44
Yes (0.02s cpu, solution 1, maybe more) ? ;
tache(3, [], m1, 1)
tache(8, [], m1, 29)
tache(8, [4, 5], m1, 9)
tache(6, [], m2, 0)
tache(3, [1], m2, 6)
tache(4, [1, 7], m1, 25)
tache(8, [3, 5], m1, 17)
tache(6, [4], m2, 12)
tache(6, [6, 7], m2, 31)
tache(6, [9, 12], m2, 37)
tache(3, [1], m2, 9)
tache(6, [7, 8], m2, 25)

T = [](tache(3, [], m1, 1), tache(8, [], m1, 29), tache(8, [4, 5], m1, 9), tache(6, [], m2, 0), tache(3, [1], m2, 6), tache(4, [1, 7], m1, 25), tache(8, [3, 5], m1, 17), tache(6, [4], m2, 12), tache(6, [6, 7], m2, 31), tache(6, [9, 12], m2, 37), tache(3, [1], m2, 9), tache(6, [7, 8], m2, 25))
Fin = 44
Yes (0.02s cpu, solution 2, maybe more) ? ;
tache(3, [], m1, 2)
tache(8, [], m1, 29)
tache(8, [4, 5], m1, 9)
tache(6, [], m2, 0)
tache(3, [1], m2, 6)
tache(4, [1, 7], m1, 25)
tache(8, [3, 5], m1, 17)
tache(6, [4], m2, 12)
tache(6, [6, 7], m2, 31)
tache(6, [9, 12], m2, 37)
tache(3, [1], m2, 9)
tache(6, [7, 8], m2, 25)

T = [](tache(3, [], m1, 2), tache(8, [], m1, 29), tache(8, [4, 5], m1, 9), tache(6, [], m2, 0), tache(3, [1], m2, 6), tache(4, [1, 7], m1, 25), tache(8, [3, 5], m1, 17), tache(6, [4], m2, 12), tache(6, [6, 7], m2, 31), tache(6, [9, 12], m2, 37), tache(3, [1], m2, 9), tache(6, [7, 8], m2, 25))
Fin = 44
*/











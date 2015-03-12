[%% Contraintes TP04
%% Antoine CHENON & Guillaume ROY

:-lib(ic).
%%:-lib(ic_symbolic).


%% Question 4.1
% getData(?TailleEquipes, ?NbEquipes, ?CapaBateaux, ?NbBateaux, ? NbConf)
getData(TailleEquipes, NbEquipes, CapaBateaux, NbBateaux, NbConf):-
	TailleEquipes = [](5,5,2,1),
	CapaBateaux= [](7,6,5),
	NbConf is 3,
	dim(TailleEquipes, [NbEquipes]),
	dim(CapaBateaux,[NbBateaux]).

%% Question 4.2
% defineVars(?T, +NbEquipes, +NbConf, +NbBateaux)
defineVars(T, NbEquipes, NbConf, NbBateaux):-
	dim(T, [NbEquipes, NbConf]),
	T #:: 1..NbBateaux.

%% Question 4.3
% getVarList(+T, ?L)
getVarList(T, L) :-
	dim(T,[NbEquipes,NbConf]),
	(multifor([I,J],[NbConf,NbEquipes],[1,1],[-1,-1]),
		param(T),
		fromto([], In, Out, L)
		do
			(V is T[J,I],
			Out = [V|In])
	).

%% Question 4.4
% solve(?T)
solve(T):-
	getData(_TailleEquipes,NbEquipes,_CapaBateaux,NbBateaux,NbConf),
	defineVars(T, NbEquipes, NbConf, NbBateaux),
	getVarList(T,L),
	labeling(L).

%% Question 4.5
% pasMemeBateaux(+T, +NbEquipes, +NbConf)
pasMemeBateaux(T,_NbEquipes, _NbConf):-
	foreacharg(Ligne, T) do
	alldifferent(Ligne).

solveBis(T):-
	getData(_TailleEquipes,NbEquipes,_CapaBateaux,NbBateaux,NbConf),
	defineVars(T, NbEquipes, NbConf, NbBateaux),
	getVarList(T,L),
	pasMemeBateaux(T,NbEquipes,NbConf),
	labeling(L).

%% Question 4.6
% pasMemePartenaires(+T, +NbEquipes, +NbConf)
pasMemePartenaires(T, NbEquipes, NbConf):-
	(for(E1,1,NbEquipes), param(T,NbConf, NbEquipes)
	do
		(for(E2,E1+1, NbEquipes), param(T, NbConf, E1)
		do
			(for(C1,1,NbConf), param(T, E1, E2, NbConf)
			do
				(for(C2, C1+1, NbConf), param(T, E1, E2, C1)
				do
				(T[E1,C1] #= T[E2,C1]) => (T[E1,C2] #\= T[E2,C2])
				)
			)
		)
	).

solvePartenaire(T):-
	defineVars(T, NbEquipes, NbConf, NbBateaux),
	getVarList(T,L),
	getData(_TailleEquipes,NbEquipes,_CapaBateaux,NbBateaux,NbConf),
	pasMemeBateaux(T,NbEquipes,NbConf),
	pasMemePartenaires(T, NbEquipes, NbConf),
	labeling(L).

%% Question 4.7
% capaBateaux(+T, +TailleEquipes, +NbEquipes, +CapaBateaux, +NbBateaux, +NbConf)


%% Tests %%
/*

%% Question 4.1

getData(A,B,C,D,E).

A = [](5, 5, 2, 1)
B = 4
C = [](7, 6, 5)
D = 3
E = 3
Yes (0.00s cpu)


%% Question 4.2

getData(A,B,C,D,E),defineVars(X,B,E,D).
lists.eco  loaded in 0.02 seconds

A = [](5, 5, 2, 1)
B = 4
C = [](7, 6, 5)
D = 3
E = 3
X = []([](_12661{1 .. 3}, _12675{1 .. 3}, _12689{1 .. 3}), [](_12703{1 .. 3}, _12717{1 .. 3}, _12731{1 .. 3}), [](_12745{1 .. 3}, _12759{1 .. 3}, _12773{1 .. 3}), [](_12787{1 .. 3}, _12801{1 .. 3}, _12815{1 .. 3}))
Yes (0.02s cpu)


%% Question 4.3

getData(A,B,C,D,E),defineVars(X,B,E,D),getVarList(X,L).

A = [](5, 5, 2, 1)
B = 4
C = [](7, 6, 5)
D = 3
E = 3
X = []([](_562{1 .. 3}, _576{1 .. 3}, _590{1 .. 3}), [](_604{1 .. 3}, _618{1 .. 3}, _632{1 .. 3}), [](_646{1 .. 3}, _660{1 .. 3}, _674{1 .. 3}), [](_688{1 .. 3}, _702{1 .. 3}, _716{1 .. 3}))
L = [_562{1 .. 3}, _604{1 .. 3}, _646{1 .. 3}, _688{1 .. 3}, _576{1 .. 3}, _618{1 .. 3}, _660{1 .. 3}, _702{1 .. 3}, _590{1 .. 3}, _632{1 .. 3}, _674{1 .. 3}, _716{1 .. 3}]
Yes (0.00s cpu)


%% Question 4.4

solve(X).

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 1), [](1, 1, 1))
Yes (0.00s cpu, solution 1, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 1), [](1, 1, 2))
Yes (0.00s cpu, solution 2, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 1), [](1, 1, 3))
Yes (0.00s cpu, solution 3, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 2), [](1, 1, 1))
Yes (0.00s cpu, solution 4, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 2), [](1, 1, 2))
Yes (0.00s cpu, solution 5, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 2), [](1, 1, 3))
Yes (0.01s cpu, solution 6, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 3), [](1, 1, 1))
Yes (0.01s cpu, solution 7, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 3), [](1, 1, 2))
Yes (0.01s cpu, solution 8, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 1), [](1, 1, 3), [](1, 1, 3))
Yes (0.01s cpu, solution 9, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 1), [](1, 1, 1))
Yes (0.01s cpu, solution 10, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 1), [](1, 1, 2))
Yes (0.01s cpu, solution 11, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 1), [](1, 1, 3))
Yes (0.01s cpu, solution 12, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 2), [](1, 1, 1))
Yes (0.01s cpu, solution 13, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 2), [](1, 1, 2))
Yes (0.01s cpu, solution 14, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 2), [](1, 1, 3))
Yes (0.01s cpu, solution 15, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 3), [](1, 1, 1))
Yes (0.01s cpu, solution 16, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 3), [](1, 1, 2))
Yes (0.02s cpu, solution 17, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 2), [](1, 1, 3), [](1, 1, 3))
Yes (0.02s cpu, solution 18, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 3), [](1, 1, 1), [](1, 1, 1))
Yes (0.02s cpu, solution 19, maybe more) ? ;

X = []([](1, 1, 1), [](1, 1, 3), [](1, 1, 1), [](1, 1, 2))
Yes (0.02s cpu, solution 20, maybe more) ? 


%% Question 4.5

[eclipse 53]: solveBis(T).
T = []([](1, 2, 3), [](1, 2, 3), [](1, 2, 3), [](1, 2, 3))
Yes (0.00s cpu, solution 1, maybe more) ? ;
T = []([](1, 2, 3), [](1, 2, 3), [](1, 2, 3), [](1, 3, 2))
Yes (0.00s cpu, solution 2, maybe more) ? ;
T = []([](1, 2, 3), [](1, 2, 3), [](1, 3, 2), [](1, 2, 3))
Yes (0.00s cpu, solution 3, maybe more) ? ;
T = []([](1, 2, 3), [](1, 2, 3), [](1, 3, 2), [](1, 3, 2))
Yes (0.00s cpu, solution 4, maybe more) ? ;

%% Question 4.6
%%%%%%%%%%%%%%%
[eclipse 11]: solvePartenaire(T).
T = []([](1, 2, 3), [](1, 3, 2), [](2, 1, 3), [](2, 3, 1))
Yes (0.00s cpu, solution 1, maybe more) ? ;
T = []([](1, 2, 3), [](1, 3, 2), [](2, 3, 1), [](2, 1, 3))
Yes (0.00s cpu, solution 2, maybe more) ? ;
T = []([](1, 3, 2), [](1, 2, 3), [](2, 1, 3), [](2, 3, 1))
Yes (0.00s cpu, solution 3, maybe more) ? ;

%% TP05 Contraintes
%% Antoine CHENON & Guillaume ROY

:-lib(ic).
:-lib(ic_symbolic).
:-lib(branch_and_bound).


%% Question 5.1

getData(Techniciens,Quantite,Benefice) :-
	Techniciens = [](5,7,2,6,9,3,7,5,3),
	Quantite = [](140,130,60,95,70,85,100,30,45),
	Benefice = [](4,5,8,5,6,4,7,10,11).

/*
getData(A,B,C).

A = [](5, 7, 2, 6, 9, 3, 7, 5, 3)
B = [](140, 130, 60, 95, 70, 85, 100, 30, 45)
C = [](4, 5, 8, 5, 6, 4, 7, 10, 11)
Yes (0.00s cpu)
*/

getFabriquer(Fabriquer) :-
	dim(Fabriquer, [9]),
	Fabriquer #:: 0..1.

/*
F = [](_12441{[0, 1]}, _12456{[0, 1]}, _12471{[0, 1]}, _12486{[0, 1]}, _12501{[0, 1]}, _12516{[0, 1]}, _12531{[0, 1]}, _12546{[0, 1]}, _12561{[0, 1]})
Yes (0.01s cpu)
*/


%% Question 5.2

%% Fonctions sur les vecteurs

%% prodVectoriel(+V1,+V2,-VRes)
prodVectoriel(V1, V2, VRes) :-
	dim(V1, Dim),
	dim(VRes,Dim),
	(foreacharg(X, V1), foreacharg(Y, V2), foreacharg(Z, VRes) do
	Z #= X * Y).

%% sommeVecteur(+V,-VRes)
sommeVecteur(V,Res) :-
	(foreacharg(X,V), fromto(0, In, Out, Res) do
	Out #= X + In
	).

%% produit scalaire
produitScalaire(V1,V2,Res) :-
	prodVectoriel(V1, V2, VRes),
	sommeVecteur(VRes,Res).


nbTotalOuvriers(NbTotalOuv,Fabriquer) :-
	getData(Techniciens,_,_),
	produitScalaire(Techniciens,Fabriquer,NbTotalOuv).

/*
getFabriquer(B),nbTotalOuvriers(A,B).

B = [](_354{[0, 1]}, _369{[0, 1]}, _384{[0, 1]}, _399{[0, 1]}, _414{[0, 1]}, _429{[0, 1]}, _444{[0, 1]}, _459{[0, 1]}, _474{[0, 1]})
A = A{0 .. 47}

There are 17 delayed goals. Do you want to see them? (y/n) 

Delayed goals:
	_773{0 .. 5} - 5 * _354{[0, 1]} #= 0
	_1019{0 .. 7} - 7 * _369{[0, 1]} #= 0
	_1265{0 .. 2} - 2 * _384{[0, 1]} #= 0
	_1511{0 .. 6} - 6 * _399{[0, 1]} #= 0
	_1757{0 .. 9} - 9 * _414{[0, 1]} #= 0
	_2003{0 .. 3} - 3 * _429{[0, 1]} #= 0
	_2249{0 .. 7} - 7 * _444{[0, 1]} #= 0
	_2495{0 .. 5} - 5 * _459{[0, 1]} #= 0
	_2741{0 .. 3} - 3 * _474{[0, 1]} #= 0
	_2930{0 .. 12} - _773{0 .. 5} - _1019{0 .. 7} #= 0
	_3030{0 .. 14} - _2930{0 .. 12} - _1265{0 .. 2} #= 0
	_3130{0 .. 20} - _3030{0 .. 14} - _1511{0 .. 6} #= 0
	_3230{0 .. 29} - _3130{0 .. 20} - _1757{0 .. 9} #= 0
	_3330{0 .. 32} - _3230{0 .. 29} - _2003{0 .. 3} #= 0
	_3430{0 .. 39} - _3330{0 .. 32} - _2249{0 .. 7} #= 0
	_3530{0 .. 44} - _3430{0 .. 39} - _2495{0 .. 5} #= 0
	A{0 .. 47} - _3530{0 .. 44} - _2741{0 .. 3} #= 0
Yes (0.00s cpu)
*/

benefTotalParTelephone(Fabriquer,Resul) :-
	getData(_,Quantite,Benefice),
	prodVectoriel(Quantite,Benefice,X),
	prodVectoriel(X,Fabriquer,Resul).

/*
getFabriquer(F),benefTotalParTelephone(F,Resul).

F = [](_354{[0, 1]}, _369{[0, 1]}, _384{[0, 1]}, _399{[0, 1]}, _414{[0, 1]}, _429{[0, 1]}, _444{[0, 1]}, _459{[0, 1]}, _474{[0, 1]})
Resul = [](_2470{0 .. 560}, _2716{0 .. 650}, _2962{0 .. 480}, _3208{0 .. 475}, _3454{0 .. 420}, _3700{0 .. 340}, _3946{0 .. 700}, _4192{0 .. 300}, _4438{0 .. 495})

There are 9 delayed goals. Do you want to see them? (y/n) 

Delayed goals:
	_2470{0 .. 560} - 560 * _354{[0, 1]} #= 0
	_2716{0 .. 650} - 650 * _369{[0, 1]} #= 0
	_2962{0 .. 480} - 480 * _384{[0, 1]} #= 0
	_3208{0 .. 475} - 475 * _399{[0, 1]} #= 0
	_3454{0 .. 420} - 420 * _414{[0, 1]} #= 0
	_3700{0 .. 340} - 340 * _429{[0, 1]} #= 0
	_3946{0 .. 700} - 700 * _444{[0, 1]} #= 0
	_4192{0 .. 300} - 300 * _459{[0, 1]} #= 0
	_4438{0 .. 495} - 495 * _474{[0, 1]} #= 0
Yes (0.00s cpu)
*/

profitTotal(Fabriquer,Resul) :-
	benefTotalParTelephone(Fabriquer, X),
	sommeVecteur(X,Resul).

/*
getFabriquer(F),profitTotal(F,Resul).

F = [](_354{[0, 1]}, _369{[0, 1]}, _384{[0, 1]}, _399{[0, 1]}, _414{[0, 1]}, _429{[0, 1]}, _444{[0, 1]}, _459{[0, 1]}, _474{[0, 1]})
Resul = Resul{0 .. 4420}

There are 17 delayed goals. Do you want to see them? (y/n) 

Delayed goals:
	_2471{0 .. 560} - 560 * _354{[0, 1]} #= 0
	_2717{0 .. 650} - 650 * _369{[0, 1]} #= 0
	_2963{0 .. 480} - 480 * _384{[0, 1]} #= 0
	_3209{0 .. 475} - 475 * _399{[0, 1]} #= 0
	_3455{0 .. 420} - 420 * _414{[0, 1]} #= 0
	_3701{0 .. 340} - 340 * _429{[0, 1]} #= 0
	_3947{0 .. 700} - 700 * _444{[0, 1]} #= 0
	_4193{0 .. 300} - 300 * _459{[0, 1]} #= 0
	_4439{0 .. 495} - 495 * _474{[0, 1]} #= 0
	_4628{0 .. 1210} - _2471{0 .. 560} - _2717{0 .. 650} #= 0
	_4728{0 .. 1690} - _4628{0 .. 1210} - _2963{0 .. 480} #= 0
	_4828{0 .. 2165} - _4728{0 .. 1690} - _3209{0 .. 475} #= 0
	_4928{0 .. 2585} - _4828{0 .. 2165} - _3455{0 .. 420} #= 0
	_5028{0 .. 2925} - _4928{0 .. 2585} - _3701{0 .. 340} #= 0
	_5128{0 .. 3625} - _5028{0 .. 2925} - _3947{0 .. 700} #= 0
	_5228{0 .. 3925} - _5128{0 .. 3625} - _4193{0 .. 300} #= 0
	Resul{0 .. 4420} - _5228{0 .. 3925} - _4439{0 .. 495} #= 0
Yes (0.00s cpu)
*/

%% Question 5.3
	
% pose_contraintes(?Fabriquer, ?NbTechniciensTotal, ?Profit)
pose_contraintes(_Fabriquer,NbTechniciensTotal) :-
	NbTechniciensTotal #=< 22.

solve(Fabriquer,Profit) :-
	getFabriquer(Fabriquer),
	nbTotalOuvriers(Techniciens,Fabriquer),
	pose_contraintes(Fabriquer,Techniciens),
	profitTotal(Fabriquer,Profit),
	labeling(Fabriquer).

/*
getFabriquer(F),solve(F,X).

F = [](0, 0, 0, 0, 0, 0, 0, 0, 0)
X = 0
Yes (0.01s cpu, solution 1, maybe more) ? ;

F = [](0, 0, 0, 0, 0, 0, 0, 0, 1)
X = 495
Yes (0.01s cpu, solution 2, maybe more) ? ;

F = [](0, 0, 0, 0, 0, 0, 0, 1, 0)
X = 300
Yes (0.01s cpu, solution 3, maybe more) ? 
*/

%% Question 5.4

solve2(X) :-
	[X,Y,Z,W] #:: [0..10],
	X #= Z+Y+2*W,
	X #\= Z+Y+W,
	labeling([X]).

solve3(X) :-
	[X,Y,Z,W] #:: [0..10],
	X #= Z+Y+2*W,
	X #\= Z+Y+W,
	labeling([X,Y,Z,W]).

minim2(X) :-
	minimize(solve2(X),X).

minim3(X) :-
	minimize(solve3(X),X).

/*
minim2(X).
Found a solution with cost 1
Found no solution with cost -1.0Inf .. 0

X = 1
Yes (0.00s cpu)

minim3(X).
Found a solution with cost 2
Found no solution with cost -1.0Inf .. 1

X = 2
Yes (0.00s cpu)

On constate qu'il faut labeler sur toutes les variables sinon le résultat donné par Eclipse est faux.
En effet les delayed goal ne sont pas pris en compte.
*/

%% Question 5.5
/*
[eclipse 33]: Q #= -P ,minimize(solve(F,P), Q).
Found a solution with cost 0
Found a solution with cost -495
Found a solution with cost -795
Found a solution with cost -1195
Found a solution with cost -1495
Found a solution with cost -1535
Found a solution with cost -1835
Found a solution with cost -1955
Found a solution with cost -1970
Found a solution with cost -2010
Found a solution with cost -2015
Found a solution with cost -2315
Found a solution with cost -2490
Found a solution with cost -2665
Found no solution with cost -1.0Inf .. -2666

Q = -2665
P = 2665
F = [](0, 1, 1, 0, 0, 1, 1, 0, 1)
Yes (0.01s cpu)

La solution optimale est donc 2665
*/

%% Question 5.6

pose_contraintes2(_Fabriquer, NbTechniciensTotal,Profit):-
	NbTechniciensTotal #=< 22,
	Profit #>= 1000.

solve4(Fabriquer,Profit,NbTechniciensTotal):-
	getFabriquer(Fabriquer),
	nbTotalOuvriers(NbTechniciensTotal,Fabriquer),
	profitTotal(Fabriquer,Profit),
	pose_contraintes2(Fabriquer,NbTechniciensTotal,Profit),
	labeling(Fabriquer).
/*
[eclipse 42]: minimize(solve4(F,P,N),N).
Found a solution with cost 10
Found a solution with cost 9
Found a solution with cost 8
Found a solution with cost 7
Found no solution with cost -1.0Inf .. 6

F = [](1, 0, 1, 0, 0, 0, 0, 0, 0)
P = 1040
N = 7
Yes (0.00s cpu)
*/

%%%%%%%%%%%%%%%%%%%%%%%
%% Contraintes 4INFO %%
%%       TP 01       %%
%%   Guillaume ROY   %%
%%   Antoine CHENON  %%
%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).

%% Domaine %%

couleurVoiture(rouge).
couleurVoiture(vert(clair)).
couleurVoiture(gris).
couleurVoiture(blanc).

couleurBateau(vert).
couleurBateau(noir).
couleurBateau(blanc).


%% Question 1.1 %%

% choixCouleur(?CouleurBateau, ?CouleurVoiture)

choixCouleur(Couleur,Couleur) :-	
	couleurVoiture(Couleur),
	couleurBateau(Couleur).


%% Question 1.2 %%

% Les succès et échecs sont en feuille de l'arbre de recherche.


%% Question 1.3 %%

% isBetween(?Var,+Min,+Max)

isBetween(Min,Min,_).

isBetween(Var,Min,Max) :-
	X is Min+1,
	X=<Max,
	isBetween(Var,X,Max).


%% Question 1.4 %%

% commande(-NbResistance,-NbConsateur)

commande(NbResistance,NbCondensateur) :-
	isBetween(NbResistance,5000,10000),
	isBetween(NbCondensateur,9000,200000),
	NbResistance>=NbCondensateur.
	
%% Question 1.5 %%

/*
[eclipse 3]: commande(X,Y).

X = 9000
Y = 9000
Yes (32.68s cpu, solution 1, maybe more) ? 
*/


%% Question 1.6 %%

% si on calcule l'inéquation avant d'utiliser isBetween, les valeurs NbResistance et NbCondensateur risquent de ne pas être instanciées.


%% Question 1.7 %%

commande2(NbResistance,NbCondensateur) :-
	NbResistance #:: 5000..10000,
	NbCondensateur #:: 9000..200000,
	NbResistance #>= NbCondensateur.

/*
[eclipse 7]: commande2(X,Y).
  (1) 1 CALL  commande2(X, Y)   %> creep
  (2) 2 CALL  '#::_body'(X, 5000 .. 10000, eclipse)   %> creep
  (2) 2 EXIT  '#::_body'(X{5000 .. 10000}, 5000 .. 10000, eclipse)   %> creep
  (3) 2 CALL  '#::_body'(Y, 9000 .. 200000, eclipse)   %> creep
  (3) 2 EXIT  '#::_body'(Y{9000 .. 200000}, 9000 .. 200000, eclipse)   %> creep
  (4) 2 CALL  Y{9000 .. 200000} - X{5000 .. 10000} #=< 0   %> creep
  (5) 3 DELAY<3>  Y{9000 .. 10000} - X{9000 .. 10000} #=< 0   %> creep
  (4) 2 EXIT  Y{9000 .. 10000} - X{9000 .. 10000} #=< 0   %> creep
  (1) 1 EXIT  commande2(X{9000 .. 10000}, Y{9000 .. 10000})   %> creep

X = X{9000 .. 10000}
Y = Y{9000 .. 10000}


Delayed goals:
	Y{9000 .. 10000} - X{9000 .. 10000} #=< 0
Yes (0.00s cpu)

Le delayed goals nous préviens que cette solution n'est pas sure à 100%
*/


%% Question 1.8 %%

commande3(NbResistance,NbConsateur) :-
	NbResistance #:: 5000..10000,
	NbConsateur #:: 9000..200000,
	NbResistance #>= NbCondensateur,
	labeling([NbResistance,NbCondensateur]).


%% Question 1.9 %%

% chapie(-Chats,-Pies,-Pattes,-Tetes)

chapie(Chats,Pies,Pattes,Tetes):-
        Chats #:: 0..10000,
        Pies #:: 0..10000,
        Pattes #:: 0..100000,
        Tetes #:: 0..10000,
        Pattes #= 4*Chats + 2*Pies,
        Tetes #= Chats + Pies.
		
chapie(2, Pies, Pattes, 5).
/*
Pies = 3
	Pattes = 14
	Yes (0.00s cpu)
*/


%% Question 1.10 %%

% chapie2(-Chats,-Pies,-Pattes,-Tetes)

chapie2(Chats,Pies,Pattes,Tetes):-
		chapie(Chats,Pies,Pattes,Tetes),
		Pattes #= 3*Tetes,
		labeling([Chats,Pies,Pattes,Tetes]).

/*
Chats = 0
	Pies = 0
	Pattes = 0
	Tetes = 0
	Yes (0.00s cpu, solution 1, maybe more)
	Chats = 1
	Pies = 1
	Pattes = 6
	Tetes = 2
	Yes (0.00s cpu, solution 2, maybe more)
	...
*/


%% Question 1.11 %%

% vabs(?Val,?AbsVal)

vabs(Val, AbsVal):-
	AbsVal #> 0,
	(Val #= AbsVal ; Val #= -AbsVal),
	labeling([Val, AbsVal]).
	
vabs2(Val, AbsVal):-
	AbsVal #:: 0..1000,
    Val #:: -1000..1000,
    Val #= AbsVal) or (Val #= -AbsVal),
    labeling([Val,AbsVal]).


%% Question 1.12 %%
	
/*
	X #:: -10..10, vabs(X, Y).
	X = 1
	Y = 1
	Yes (0.01s cpu, solution 1, maybe more)
	X = 2
	Y = 2
	Yes (0.01s cpu, solution 2, maybe more)
	X = 3
	Y = 3
	Yes (0.01s cpu, solution 3, maybe more)
	...
X #:: -10..10, vabsIC(X, Y).
	X = -10
	Y = 10
	Yes (0.00s cpu, solution 1, maybe more)
	X = -9
	Y = 9
	Yes (0.00s cpu, solution 2, maybe more)
	X = -8
	Y = 8
	Yes (0.00s cpu, solution 3, maybe more)
	...
*/


%% Question 1.13 %%

% faitListe(?ListVar,?Taille,+Min,+Max)

faitListe(ListVar,Taille,Min,Max):-
	length(ListVar,Taille),
	ListVar #:: Min..Max.
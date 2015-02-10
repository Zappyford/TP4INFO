%%%%%%%%%%%%%%%%%%%%%%%
%% Contraintes 4INFO %%
%%       TP 02       %%
%%   Guillaume ROY   %%
%%   Antoine CHENON  %%
%%%%%%%%%%%%%%%%%%%%%%%

:-lib(ic).
:-lib(ic_symbolic).

%% Question 2.1 %%

% Domaines

:- local domain(pays(anglais, espagnol, ukrainien, norvegien, japonais)).
:- local domain(couleur(rouge,vert,blanc, jaune,bleu)).
:- local domain(boisson(cafe, the, lait, jusOrange, eau)).
:- local domain(voiture(bmw, ford, toyota, honda, datsun)).
:- local domain(animaux(chien, serpent, renard, cheval, zebre)).


%% Question 2.2 %%

% domaines_maison(m(?Pays,?Couleur,?Boisson,?Voiture,?Animaux,?Numero)

domaines_maison(m(Pays,Couleur,Boisson,Voiture,Animal,Numero)):-
	Pays &:: pays,
	Couleur &:: couleur,
	Boisson &:: boisson,
	Voiture &:: voiture,
	Animal &:: animaux,
	Numero #:: 1..5.


%% Question 2.3 %%

% rue(?Rue)

rue([M1, M2, M3, M4, M5]):-
	M1 = m(P1, C1, B1, V1, A1, 1),
	M2 = m(P2, C2, B2, V2, A2, 2),
	M3 = m(P3, C3, B3, V3, A3, 3),
	M4 = m(P4, C4, B4, V4, A4, 4),
	M5 = m(P5, C5, B5, V5, A5, 5),
	domaines_maison(M1),
	domaines_maison(M2),
	domaines_maison(M3),
	domaines_maison(M4),
	domaines_maison(M5),
	ic_symbolic:alldifferent([P1, P2, P3, P4, P5]),
	ic_symbolic:alldifferent([C1, C2, C3, C4, C5]),
	ic_symbolic:alldifferent([B1, B2, B3, B4, B5]),
	ic_symbolic:alldifferent([V1, V2, V3, V4, V5]),
	ic_symbolic:alldifferent([A1, A2, A3, A4, A5]).
	

%% Question 2.4 %%

% ecrit_maison(?Rue)

ecrit_maison(Rue):-
	(foreach(X,Rue) do writeln(X)).


%% Question 2.5 %%

% getVarList(?Rue,?Liste)

getVarList([], []).
getVarList([m(Pays, Couleur, Boisson, Voiture, Animal, _)|Rue], [Pays, Couleur, Boisson, Voiture, Animal|Liste]):-
	getVarList(Rue, Liste).


% labeling_symbolic(+Liste)

labeling_symbolic([]).
labeling_symbolic([A|Reste]) :-
	ic_symbolic:indomain(A),
	labeling_symbolic(Reste).

	
% Question 2.6
%%%%%%%%%%%%%%%
%%resoude(?Rue) trouve une solution respectant les contraintes 
resoudre(Rue):-
	rue(Rue),
	getVarList(Rue,List),
	contraintesSimples(Rue),
	(foreach(m(_P,C,_B,_V,_A,N),Rue), param(Rue) do
	(
		(foreach(m(_P1,C1,_B1,_V1,_A1,N1),Rue),
			param(N,C) do
			(C1 &= vert) and (C &= blanc) => (N1 #= N+1)
		)
	)
	),
	(foreach(m(_P,_C,_B,V,_A,N),Rue), param(Rue) do
	(
		(foreach(m(_P1,_C1,_B1,_V1,A1,N1),Rue),
			param(N,V) do
			(V &= ford) and (A1 &= renard) => ((N #= N1+1) or( N #= N1-1))
		)
	)
	),
	(foreach(m(_P,_C,_B,V,_A,N),Rue), param(Rue) do
	(
		(foreach(m(_P1,_C1,_B1,_V1,A1,N1),Rue),
			param(N,V) do 
			(V &= toyota) and (A1 &= cheval) => ((N #= N1+1) or( N #= N1-1))
		)
	)
	),
	(foreach(m(P,_C,_B,_V,_A,N),Rue), param(Rue) do
	(
		(foreach(m(_P1,C1,_B1,_V1,_A1,N1),Rue),
			param(P,N) do
			(P &= norvegien) and (C1 &= bleu) => ((N #= N1+1) or( N #= N1-1))
		)
	)
	),
	labeling_symbolic(List),
	ecrit_maison(Rue).

	
%% Question 2.7 %%

contraintesSimples(Rue) :-
	(foreach(m(P,C,B,V,A,N),Rue) do 
    (
	(P &= anglais) #= (C &= rouge),		%Contrainte A
	(P &= espagnol) #=  (A &= chien),       %Contrainte B
	(C &= vert) #= (B &= cafe),		%Contrainte C
	(P &= ukrainien) #= (B &= the),		%Contrainte D
	(V &= bmw) #= (A &= serpent),		%Contrainte F
	(C &= jaune) #= (V &= toyota),		%Contrainte G
	(B &= lait) #= (N #= 3),		%Contrainte H
	(P &= norvegien) #=(N #= 1),		%Contrainte I
	(V &= honda) #=(B &= jusOrange),	%Contrainte L
	(V &= datsun) #=(P &= japonais)	        %Contrainte M
    )
).
	

%% Question 2.8 %%

/*
X = [m(norvegien, jaune, eau, toyota, renard, 1), m(ukrainien, bleu, the, ford, cheval, 2), m(anglais, rouge, lait, bmw, serpent, 3), m(espagnol, blanc, jusOrange, honda, chien, 4), m(japonais, vert, cafe, datsun, zebre, 5)]
m(anglais, rouge, lait, bmw, serpent, 3);
*/

% Le zèbre est possédé par le Japonais, et le Norvégien boit de l'eau.

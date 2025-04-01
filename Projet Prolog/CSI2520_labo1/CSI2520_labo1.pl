professeur(turing, csi2520).
professeur(codd, csi4533).
professeur(backus, csi2511).
professeur(ritchie, csi2772).
professeur(minsky, csi2510).
professeur(codd, csi2530).
etudiant(fred, csi2520).
etudiant(paul, csi4533).
etudiant(jean, csi2510).
etudiant(jean, csi2772).
etudiant(henri, csi2510).
etudiant(henri, csi2530).
annee(fred, 1).
annee(paul, 2).
annee(jean, 2).
annee(henri, 4).



% 1. Quel sera le résultat de la requête suivante : ?- professeur(codd, Cours), etudiant(UnEtudiant, Cours).
% Le cours et le nom des étudiants qui ont le même cours que codd enseigne

% 2. Donner toutes les solutions qui seront obtenues, dans l’ordre ou elles seront trouvées.
% Cours = csi4533,
% UnEtudiant = paul ;
% Cours = csi2530,
% UnEtudiant = henri.

% 3. Ecrire la requête permettant de trouver les étudiants de minsky
etudiant_de(Prof, Etudiant) :- professeur(Prof, Cour), etudiant(Etudiant, Cour).
% 1 ?- etudiant_de(minsky, X).
% X = jean ;
% X = henri.

% 4. Ecrire la requête permettant de trouver les cours suivis par des étudiants de 4ème année
% 1 ?- annee(X, 4).
% X = henri.

% 5. Ecrire la requête permettant de trouver les étudiants qui ont le même professeur
/*
1 ?- etudiant(Etudiant1, Cours1), professeur(Prof, Cours1), etudiant(Etudiant2, Cours2), professeur(Prof, Cours2), Etudiant1\=Etudiant2.
Etudiant1 = paul,
Cours1 = csi4533,
Prof = codd,
Etudiant2 = henri,
Cours2 = csi2530 ;

Etudiant1 = jean,
Cours1 = Cours2, Cours2 = csi2510,
Prof = minsky,
Etudiant2 = henri ;

Etudiant1 = henri,
Cours1 = Cours2, Cours2 = csi2510,
Prof = minsky,
Etudiant2 = jean ;

Etudiant1 = henri,
Cours1 = csi2530,
Prof = codd,
Etudiant2 = paul,
Cours2 = csi4533 ;

false.
*/

% 6. Créer un prédicat 'note' donnant le résultat obtenu par un étudiant dans un cours. Les notes possibles sont a,b,c,d,e, f.
note(fred, csi2520, a).
note(paul, csi4533, b).
note(jean, csi2510, c).
note(jean, csi2772, d).
note(henri, csi2510, e).
note(henri, csi2530, f).

% 7. Ecrire un prédicat 'reussit(etudiant,cours)' vérifiant si un étudiant a passé un cours, ce
% prédicat doit vérifier si :
% a. l'étudiant est inscrit à ce cours
% b. et s'il a obtenu une note autre que e ou f
note_echoue(e).
note_echoue(f).
reussit(Etudiant, Cours) :- etudiant(Etudiant, Cours), note(Etudiant, Cours, X), not(note_echoue(X)).
/*
1 ?- reussit(fred, csi2520).
true.

2 ?- reussit(henri, csi2520).
false.
*/
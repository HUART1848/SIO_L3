/* ******************************************************
 *
 * SIO 2023-2024 - Labo 3 : Répartition équitable
 *
 * Groupe : H
 *
 * Nom et prénom : Hugo Huart
 *
 * Nom et prénom : Farouk Ferchichi
 *
****************************************************** */

/* Nombre de groupes */
param m;

/* Nombre d'objets */
param n;

/* Numérotation des groupes */
set Groupes := 1..m;

/* Numérotation des objets */
set Objets  := 1..n;

/* Valeurs des objets */
param v{i in Objets};

/* Variables de décision: appartenance des objets aux groupes */
var g{(i, j) in Objets cross Groupes}, binary;

/* Variable auxilliaire de linéarisation */
var t;

/* Fonction objectif : 
 * Critère d'équité où l'on maximise la plus petite valeur attribuée à un groupe
 */ 
maximize z: t;

/* Contrainte: Linéarisation pour t */
subject to EstLaPlusPetiteValeurDUnGroupe{j in Groupes}:
	t <= sum{i in Objets} g[i, j] * v[i];

/* Contrainte: Un objet doit être dans un seul groupe */
subject to UnObjetNEstAttribueQUneSeuleFois{i in Objets}:
	sum{j in Groupes} g[i, j] = 1;

solve;

/* Affichage de la solution */
printf{1..40} "*";
printf "\nSolution obtenue (groupes/objets) (valeur minimale d'un groupe: %d; valeur totale: %d):\n", z, sum{i in Objets} v[i];
for {j in Groupes} {
	printf "Groupe %d (valeur: %d): \n", j, sum{i in Objets} g[i, j] * v[i];
	for {i in Objets} {
		printf{0..0: g[i, j] = 1} "%d ", i;
	}
	printf "\n";
}

/* ******************************************************
 *
 * Section Data
 *
 ****************************************************** */

data;

# Jeu de données n° 1

/* Nombre de groupes/personnes/boîtes */
#param m := 4;

/* Nombre d'objets à répartir  */
#param n := 13;

/* Valeur des objets à répartir  */
#param v :=
#	 1	2
#	 2	5
#	 3	8
#	 4	8
#	 5	9
#	 6	11
#	 7	16
#	 8	22
#	 9	28
#	10	31
#	11	32
#	12	34
#	13	35
#;

#################################

# Jeu de données n° 2

# /* Nombre de groupes/personnes/boîtes */
param m := 4;

# /* Nombre d'objets à répartir  */
param n := 14;

# /* Valeur des objets à répartir  */
param v :=
	 1	1
	 2	2
	 3	3
	 4	4
	 5	5
	 6	6
	 7	7
	 8	8
	 9	9
	10	10
	11	 11
	12	 12
	13	 13
	14	 14
;

end;

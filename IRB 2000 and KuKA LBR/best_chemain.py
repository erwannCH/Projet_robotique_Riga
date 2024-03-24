import json
import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial import KDTree
import heapq
import networkx as nx

# Chemins de base pour les fichiers ABB et KUKA
abb_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/kuka/"

# Nom du fichier
name = "TrajectoryAllPointsABB"

# Déterminer le chemin de base en fonction du nom du fichier
if "ABB" in name:
    base_path = abb_base_path
elif "KUKA" in name:
    base_path = kuka_base_path
else:
    print("Nom de fichier invalide")
    exit()

# Construire le chemin complet du fichier
chemin_fichier = base_path + name + ".json"

# Fonction pour extraire les valeurs du fichier JSON
def extraire_valeurs_json(chemin_fichier):
    valeurs_detMC = []
    valeurs_SVD_det = []
    valeurs_pInv_det = []
    valeurs_truncated_det = []
    valeurs_detmean = []
    valeurs_posX = []
    valeurs_posY = []
    valeurs_posZ = []
    with open(chemin_fichier, 'r') as fichier:
        for ligne in fichier:
            try:
                donnees = json.loads(ligne)
                if 'detMC' in donnees:
                    valeurs_detMC.append(donnees['detMC'])
                if 'SVD_det' in donnees:
                    valeurs_SVD_det.append(donnees['SVD_det'])
                if 'pInv_det' in donnees:
                    valeurs_pInv_det.append(donnees['pInv_det'])
                if 'truncated_det' in donnees:
                    valeurs_truncated_det.append(donnees['truncated_det'])
                if 'detmean' in donnees:
                    valeurs_detmean.append(donnees['detmean'])
                if 'posX' in donnees:
                    if isinstance(donnees['posX'], list):
                        valeurs_posX.extend(donnees['posX'])
                    else:
                        valeurs_posX.append(donnees['posX'])
                if 'posY' in donnees:
                    if isinstance(donnees['posY'], list):
                        valeurs_posY.extend(donnees['posY'])
                    else:
                        valeurs_posY.append(donnees['posY'])
                if 'posZ' in donnees:
                    if isinstance(donnees['posZ'], list):
                        valeurs_posZ.extend(donnees['posZ'])
                    else:
                        valeurs_posZ.append(donnees['posZ'])
            except json.JSONDecodeError:
                # Handle invalid JSON
                pass
    return valeurs_detMC, valeurs_SVD_det, valeurs_pInv_det, valeurs_truncated_det, valeurs_detmean, valeurs_posX, valeurs_posY, valeurs_posZ

def aplatir_liste(liste):
    aplatie = []
    for elem in liste:
        if isinstance(elem, (list, tuple)):
            aplatie.extend(aplatir_liste(elem))
        else:
            aplatie.append(elem)
    return aplatie

# Récupération des valeurs
print("Étape 1 : Récupération des valeurs à partir du fichier JSON")
valeurs_detMC, valeurs_SVD_det, valeurs_pInv_det, valeurs_truncated_det, valeurs_detmean, valeurs_posX, valeurs_posY, valeurs_posZ = extraire_valeurs_json(chemin_fichier)

# Aplatissement des listes
print("Étape 2 : Aplatissement des listes")
valeurs_detMC = aplatir_liste(valeurs_detMC)
valeurs_SVD_det = aplatir_liste(valeurs_SVD_det)
valeurs_posX = aplatir_liste(valeurs_posX)
valeurs_posY = aplatir_liste(valeurs_posY)
valeurs_posZ = aplatir_liste(valeurs_posZ)

# Convertir les listes en tableaux numpy
print("Étape 3 : Conversion des listes en tableaux numpy")
valeurs_detMC = np.array(valeurs_detMC)
valeurs_SVD_det = np.array(valeurs_SVD_det)
valeurs_posX = np.array(valeurs_posX)
valeurs_posY = np.array(valeurs_posY)
valeurs_posZ = np.array(valeurs_posZ)

# Créer un tableau de coordonnées
print("Étape 4 : Création d'un tableau de coordonnées")
coordonnees = np.stack((valeurs_posX, valeurs_posY, valeurs_posZ), axis=-1)

# Créer un arbre KD pour accélérer les recherches de plus proches voisins
print("Étape 5 : Création d'un arbre KD pour accélérer les recherches de plus proches voisins")
kdtree = KDTree(coordonnees)

# Définir les positions de départ et d'arrivée
print("Étape 6 : Définition des positions de départ et d'arrivée")
depart = np.array([0, 0, 0])
arrivee = np.array([10, 10, 10])

# Trouver les indices des plus proches voisins pour la position de départ et la position d'arrivée
print("Étape 7 : Recherche des indices des plus proches voisins pour la position de départ et la position d'arrivée")
depart_index = kdtree.query(depart)[1]
arrivee_index = kdtree.query(arrivee)[1]

# Définir une fonction de coût personnalisée pour combiner la distance et la valeur du déterminant
print("Étape 8 : Définition d'une fonction de coût personnalisée")
def cout(distance, detMC, alpha=0.5):
    return alpha * distance + (1 - alpha) * (1 - detMC)

# Définir une fonction heuristique pour estimer la distance entre deux nœuds
print("Étape 9 : Définition d'une fonction heuristique")
def heuristic(n1, n2):
    return np.linalg.norm(coordonnees[n1] - coordonnees[n2])

# Implémenter l'algorithme A*
print("Étape 10 : Implémentation de l'algorithme A*")
def astar(graph, start, goal, heuristic):
    frontier = []
    heapq.heappush(frontier, (0, start))
    came_from = {start: None}
    cost_so_far = {start: 0}

    while frontier:
        _, current = heapq.heappop(frontier)

        if current == goal:
            break

        for next in graph.neighbors(current):
            new_cost = cost_so_far[current] + graph[current][next]['cost']
            if next not in cost_so_far or new_cost < cost_so_far[next]:
                cost_so_far[next] = new_cost
                priority = new_cost + heuristic(goal, next)
                heapq.heappush(frontier, (priority, next))
                came_from[next] = current

    return came_from, cost_so_far

# Calculer le coût pour chaque point
print("Étape 11 : Calcul du coût pour chaque point")
cout_detMC = np.array([cout(0, detMC, alpha=0.5) for detMC in valeurs_detMC])

# Créer un graphe à partir des coordonnées et des coûts
print("Étape 12 : Création d'un graphe à partir des coordonnées et des coûts")
G = nx.DiGraph()
for i, (x, y, z) in enumerate(coordonnees):
    G.add_node(i, pos=(x, y, z), cost=cout_detMC[i])

# Connecter chaque nœud à ses k plus proches voisins
print("Étape 13 : Connexion de chaque nœud à ses k plus proches voisins")
k = 10
for i, (x, y, z) in enumerate(coordonnees):
    distances, indices = kdtree.query(np.array([x, y, z]), k=k + 1)
    indices = indices[1:]  # Exclure le nœud lui-même
    for j in indices:
        distance = np.linalg.norm(coordonnees[i] - coordonnees[j])
        G.add_edge(i, j, cost=cout(distance, valeurs_detMC[j]))

# Trouver le chemin le moins coûteux à l'aide de l'algorithme A*
print("Étape 14 : Recherche du chemin le moins coûteux à l'aide de l'algorithme A*")
came_from, _ = astar(G, depart_index, arrivee_index, heuristic)
chemin = [arrivee_index]
while chemin[-1] in came_from:
    chemin.append(came_from[chemin[-1]])
chemin = chemin[::-1]

# Enregistrer les points du chemin dans un tableau
chemin_coordonnees = [coordonnees[i] for i in chemin]

# Écrire les points du chemin dans un fichier JSON
with open("chemin.json", "w") as fichier:
    json.dump(chemin_coordonnees, fichier)

# Afficher le chemin
print("Étape 15 : Affichage du chemin")
#for i, index in enumerate(chemin):
#    position = coordonnees[index]
#     print(f"Étape {i} : {position}")


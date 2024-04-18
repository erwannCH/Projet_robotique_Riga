import json
import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial import KDTree
import heapq
import networkx as nx

# Chemins de base pour les fichiers ABB et KUKA
abb_base_path = "../Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "../Pronjet_robotique_Riga/data/kuka/"
IRB_base_path = "../Pronjet_robotique_Riga/data/IRB/"

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
coordonnees = np.stack((valeurs_posX, valeurs_posY, valeurs_posZ), axis=-1)

# Définir les positions de départ et d'arrivée
depart = np.array([0, 0, 0])
arrivee = np.array([10, 10, 10])

# Calculer la distance entre chaque point et la position d'arrivée
distances = np.linalg.norm(coordonnees - arrivee, axis=-1)

# Définir une fonction de coût personnalisée pour combiner la distance et la valeur du déterminant
def cout(distance, detMC, alpha=0.5):
    return alpha * distance + (1 - alpha) * (1 - detMC)

# Calculer le coût pour chaque point
cout_detMC = cout(distances, valeurs_detMC)

# Trier les points en fonction de leur coût et sélectionner le meilleur chemin
best_indices = np.argsort(cout_detMC)
best_path = coordonnees[best_indices]

# Trouver l'index de la position de départ dans le meilleur chemin
depart_index = np.argmin(np.linalg.norm(best_path - depart, axis=-1))

# Créer le chemin à partir de la position de départ vers la position d'arrivée
chemin = best_path[depart_index:]

# Afficher le chemin
for i, position in enumerate(chemin):
    print(f"Étape {i} : {position}")

# Tracer le chemin en 3D
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(chemin[:, 0], chemin[:, 1], chemin[:, 2])
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
plt.show()

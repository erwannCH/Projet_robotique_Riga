import json
import matplotlib.pyplot as plt
import numpy as np

# Chemins de base pour les fichiers ABB et KUKA
abb_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/kuka/"

# Nom du fichier
#name = "TrajectoryNr1ABB"
#name = "TrajectoryNr2ABB"
#name = "TrajectoryNr3ABB"
#name = "TrajectoryNrXABB"
#name = "TrajectoryNrYABB"
#name = "TrajectoryNr1KUKA"
#name = "TrajectoryNr2KUKA"
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
valeurs_detMC, valeurs_SVD_det, valeurs_pInv_det, valeurs_truncated_det, valeurs_detmean, valeurs_posX, valeurs_posY, valeurs_posZ = extraire_valeurs_json(chemin_fichier)

# Aplatissement des listes
valeurs_detMC = aplatir_liste(valeurs_detMC)
valeurs_SVD_det = aplatir_liste(valeurs_SVD_det)
valeurs_posX = aplatir_liste(valeurs_posX)
valeurs_posY = aplatir_liste(valeurs_posY)
valeurs_posZ = aplatir_liste(valeurs_posZ)

# Convertir les listes en tableaux numpy
valeurs_detMC = np.array(valeurs_detMC)
valeurs_SVD_det = np.array(valeurs_SVD_det)
valeurs_posX = np.array(valeurs_posX)
valeurs_posY = np.array(valeurs_posY)
valeurs_posZ = np.array(valeurs_posZ)

# Créer un tableau de coordonnées
coordonnees = np.stack((valeurs_posX, valeurs_posY, valeurs_posZ), axis=-1)

# Calculer les valeurs minimales et maximales pour chaque déterminant
detMC_min = np.min(valeurs_detMC)
detMC_max = np.max(valeurs_detMC)
SVD_det_min = np.min(valeurs_SVD_det)
SVD_det_max = np.max(valeurs_SVD_det)

# Afficher les coordonnées correspondant aux valeurs minimales et les valeurs maximales pour chaque déterminant
print("detMC :")
print("Min :", detMC_min)
print("Max :", detMC_max)

print("\nSVD_det :")
print("Min :", SVD_det_min)
print("Coordonnées :")
print("Max :", SVD_det_max)

# Trier les valeurs des déterminants et sélectionner les 100 indices les plus bas
detMC_argsort = np.argsort(valeurs_detMC)
detMC_lowest_indices = detMC_argsort[:100]

SVD_det_argsort = np.argsort(valeurs_SVD_det)
SVD_det_lowest_indices = SVD_det_argsort[:100]

# Extraire les coordonnées correspondantes
detMC_lowest_coordonnees = coordonnees[detMC_lowest_indices]
SVD_det_lowest_coordonnees = coordonnees[SVD_det_lowest_indices]

# Créer les graphiques 3D pour les points de valeur minimale de detMC et SVD_det
fig1 = plt.figure()
ax1 = fig1.add_subplot(111, projection='3d')
ax1.scatter(detMC_lowest_coordonnees[:, 0], detMC_lowest_coordonnees[:, 1], detMC_lowest_coordonnees[:, 2], label='detMC 100 lowest')
ax1.set_xlabel('X')
ax1.set_ylabel('Y')
ax1.set_zlabel('Z')
ax1.legend()

fig2 = plt.figure()
ax2 = fig2.add_subplot(111, projection='3d')
ax2.scatter(SVD_det_lowest_coordonnees[:, 0], SVD_det_lowest_coordonnees[:, 1], SVD_det_lowest_coordonnees[:, 2], label='SVD_det 100 lowest')
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_zlabel('Z')
ax2.legend()

plt.show()
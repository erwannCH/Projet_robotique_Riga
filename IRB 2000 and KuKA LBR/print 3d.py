import json
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# Chemins de base pour les fichiers ABB et KUKA
abb_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/kuka/"

# Nom du fichier
# name = "TrajectoryNr1ABB"
# name = "TrajectoryNr2ABB"
# name = "TrajectoryNr3ABB"
# name = "TrajectoryNrXABB"
# name = "TrajectoryNrYABB"
# name = "TrajectoryNr1KUKA"
name = "TrajectoryNr2KUKA"

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
valeurs_pInv_det = aplatir_liste(valeurs_pInv_det)
valeurs_truncated_det = aplatir_liste(valeurs_truncated_det)
valeurs_detmean = aplatir_liste(valeurs_detmean)
valeurs_posX = aplatir_liste(valeurs_posX)
valeurs_posY = aplatir_liste(valeurs_posY)
valeurs_posZ = aplatir_liste(valeurs_posZ)

# Création du graphique des valeurs de detmean
plt.figure()
plt.plot(valeurs_SVD_det)
plt.title("Graphique des valeurs de" + name)
plt.xlabel("Index")
plt.ylabel("Valeur")
plt.grid(True)

# Création du graphique des positions en 3D
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(valeurs_posX, valeurs_posY, valeurs_posZ, c=valeurs_SVD_det, cmap='Spectral')
ax.set_xlabel('Position X')
ax.set_ylabel('Position Y')
ax.set_zlabel('Position Z')

plt.show()

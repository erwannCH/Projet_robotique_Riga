import json
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# Chemin vers le fichier detX.json
#name = "TrajectoryNr1ABB"
#name = "TrajectoryNr2ABB"
#name = "TrajectoryNr1KUKA"
name = "TrajectoryNr2KUKA"
chemin_fichier = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/IRB 2000 and KuKA LBR/"+name+".json"

# Fonction pour extraire les valeurs du fichier JSON
def extraire_valeurs_json(chemin_fichier):
    valeurs_detX = []
    valeurs_posX = []
    valeurs_posY = []
    valeurs_posZ = []
    with open(chemin_fichier, 'r') as fichier:
        for ligne in fichier:
            try:
                donnees = json.loads(ligne)
                if 'detX' in donnees:
                    valeurs_detX.append(donnees['detX'])
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
    return valeurs_detX, valeurs_posX, valeurs_posY, valeurs_posZ

def aplatir_liste(liste):
    aplatie = []
    for elem in liste:
        if isinstance(elem, (list, tuple)):
            aplatie.extend(aplatir_liste(elem))
        else:
            aplatie.append(elem)
    return aplatie

# Récupération des valeurs
valeurs_detX, valeurs_posX, valeurs_posY, valeurs_posZ = extraire_valeurs_json(chemin_fichier)

# Aplatissement des listes
valeurs_detX = aplatir_liste(valeurs_detX)
valeurs_posX = aplatir_liste(valeurs_posX)
valeurs_posY = aplatir_liste(valeurs_posY)
valeurs_posZ = aplatir_liste(valeurs_posZ)

# Création du graphique des valeurs de detX
plt.figure()
plt.plot(valeurs_detX)
plt.title("Graphique des valeurs de" + name)
plt.xlabel("Index")
plt.ylabel("Valeur")
plt.grid(True)

# Création du graphique des positions en 3D
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(valeurs_posX, valeurs_posY, valeurs_posZ, c=valeurs_detX, cmap='coolwarm')
ax.set_xlabel('Position X')
ax.set_ylabel('Position Y')
ax.set_zlabel('Position Z')

plt.show()

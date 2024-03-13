import glob
import json
import matplotlib.pyplot as plt
import os

# Chemin vers les fichiers
chemin_fichiers = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/*.json"

# Liste pour stocker les valeurs de tous les fichiers
valeurs_detMC_all = []
valeurs_SVD_det_all = []
valeurs_detmean_all = []
noms_fichiers = []

# Fonction pour extraire les valeurs du fichier JSON
def extraire_valeurs_json(chemin_fichier):
    valeurs_detMC = []
    valeurs_SVD_det = []
    valeurs_detmean = []
    with open(chemin_fichier, 'r') as fichier:
        for ligne in fichier:
            try:
                donnees = json.loads(ligne)
                if 'detMC' in donnees:
                    valeurs_detMC.append(donnees['detMC'])
                if 'SVD_det' in donnees:
                    valeurs_SVD_det.append(donnees['SVD_det'])
                if 'detmean' in donnees:
                    valeurs_detmean.append(donnees['detmean'])
            except json.JSONDecodeError:
                # Handle invalid JSON
                pass
    return valeurs_detMC, valeurs_SVD_det, valeurs_detmean

def aplatir_liste(liste):
    aplatie = []
    for elem in liste:
        if isinstance(elem, (list, tuple)):
            aplatie.extend(aplatir_liste(elem))
        else:
            aplatie.append(elem)
    return aplatie

# Récupération des valeurs pour tous les fichiers
for chemin_fichier in glob.glob(chemin_fichiers):
    noms_fichiers.append(os.path.basename(chemin_fichier))
    valeurs_detMC, valeurs_SVD_det, valeurs_detmean = extraire_valeurs_json(chemin_fichier)
    valeurs_detMC_all.append(aplatir_liste(valeurs_detMC))
    valeurs_SVD_det_all.append(aplatir_liste(valeurs_SVD_det))
    valeurs_detmean_all.append(aplatir_liste(valeurs_detmean))

# Tracé des courbes en superposition
plt.figure()
for i, valeurs in enumerate(valeurs_detMC_all):
    plt.plot(valeurs, label=f'detMC - {noms_fichiers[i].split(".")[0]}')
    #plt.plot([v * 10 for v in valeurs], label=f'detMC - {noms_fichiers[i].split(".")[0]}')
plt.title('detMC values')
plt.xlabel('Index')
plt.ylabel('detMC value')
plt.legend()

plt.figure()
for i, valeurs in enumerate(valeurs_SVD_det_all):
    plt.plot(valeurs, label=f'SVD_det - {noms_fichiers[i].split(".")[0]}')
plt.title('SVD_det values')
plt.xlabel('Index')
plt.ylabel('SVD_det value')
plt.legend()


plt.figure()
for i, valeurs in enumerate(valeurs_detmean_all):
    plt.plot(valeurs, label=f'detmean - {noms_fichiers[i].split(".")[0]}')
plt.title('detmean values')
plt.xlabel('Index')
plt.ylabel('detmean value')
plt.legend()
plt.show()


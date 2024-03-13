import json
import matplotlib.pyplot as plt

# Chemin vers le fichier
name = "TrajectoryNr1ABB"
#name = "TrajectoryNr2ABB"
#name = "TrajectoryNr3ABB"
#name = "TrajectoryNrXABB"
#name = "TrajectoryNrYABB"
#name = "TrajectoryNr1KUKA"
#name = "TrajectoryNr2KUKA"
chemin_fichier = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/IRB 2000 and KuKA LBR/"+name+".json"

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

# Plotting the determinants
fig, axs = plt.subplots(2, 2, figsize=(10, 10))
fig.suptitle('Determinants')
axs[0, 0].plot(valeurs_detMC, label='detMC')
axs[0, 0].set_title('detMC')
axs[0, 1].plot(valeurs_SVD_det, label='SVD_det')
axs[0, 1].set_title('SVD_det')
axs[1, 0].plot(valeurs_pInv_det, label='pInv_det')
axs[1, 0].set_title('pInv_det')
axs[1, 1].plot(valeurs_truncated_det, label='truncated_det')
axs[1, 1].set_title('truncated_det')
for ax in axs.flat:
    ax.set(xlabel='Index', ylabel='Value')
plt.show()

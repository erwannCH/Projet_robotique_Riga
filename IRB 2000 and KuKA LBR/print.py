import json
import matplotlib.pyplot as plt

# Chemin vers le fichier detX.json
chemin_fichier = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/IRB 2000 and KuKA LBR/detX.json"

# Fonction pour extraire les valeurs du fichier JSON
def extraire_valeurs_json(chemin_fichier):
    valeurs = []
    with open(chemin_fichier, 'r') as fichier:
        for ligne in fichier:
            try:
                donnees = json.loads(ligne)
                if 'detX' in donnees:
                    if isinstance(donnees['detX'], float):
                        valeurs.append(donnees['detX'])  # If detX is a float, append it directly
                    elif isinstance(donnees['detX'], list):
                        valeurs.extend(donnees['detX'])  # If detX is a list, extend the valeurs list
            except json.JSONDecodeError:
                # Handle invalid JSON
                pass
    return valeurs

# Récupération des valeurs
valeurs = extraire_valeurs_json(chemin_fichier)

# Création du graphique
plt.plot(valeurs)
plt.title("Graphique des valeurs de detX")
plt.xlabel("Index")
plt.ylabel("Valeur")
plt.grid(True)
plt.show()

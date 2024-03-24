import tkinter as tk
import matplotlib.pyplot as plt
import glob
import json
import os
import matplotlib.figure
import numpy as np
from mpl_toolkits.mplot3d import Axes3D
from matplotlib.colors import Normalize
from matplotlib.cm import ScalarMappable

# Chemins de base pour les fichiers ABB et KUKA
abb_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/kuka/"

# Liste des noms de fichiers
noms_fichiers = ["TrajectoryNr1ABB", "TrajectoryNr2ABB", "TrajectoryNr3ABB", "TrajectoryNrXABB", "TrajectoryNrYABB", "TrajectoryNr1KUKA", "TrajectoryNr2KUKA"]

# Liste des options pour les données
options_donnees = ["detMC", "SVD_det", "detmean", "Position X", "Position Y", "Position Z"]

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

class InterfaceGraphique:
    def __init__(self, master):
        self.master = master
        self.master.title("Selecting the data")

        self.var_fichier = tk.StringVar(self.master)
        self.var_fichier.set(noms_fichiers[0])  # Valeur par défaut

        self.var_donnees = tk.StringVar(self.master)
        self.var_donnees.set(options_donnees[0])  # Valeur par défaut

        self.var_type_graphique = tk.StringVar(self.master)
        self.var_type_graphique.set("2D")  # Valeur par défaut

        # Création des menus déroulants
        frame_gauche = tk.Frame(self.master)
        frame_gauche.pack(side=tk.LEFT, padx=10, pady=10)

        tk.Label(frame_gauche, text="Selecting a file :").pack()
        tk.OptionMenu(frame_gauche, self.var_fichier, *noms_fichiers).pack()

        tk.Label(frame_gauche, text="Selecting the data :").pack()
        tk.OptionMenu(frame_gauche, self.var_donnees, *options_donnees).pack()

        tk.Label(frame_gauche, text="Selecting the type of graph :").pack()
        tk.OptionMenu(frame_gauche, self.var_type_graphique, "2D", "3D").pack()

        # Création du bouton pour afficher les données
        self.button_afficher = tk.Button(frame_gauche, text="print the data", command=self.afficher_donnees)
        self.button_afficher.pack()

        # Création du bouton pour quitter l'application
        self.button_exit = tk.Button(frame_gauche, text="Exit", command=self.master.quit)
        self.button_exit.pack()

        # Création de la zone pour les graphiques
        self.figure = plt.figure()
        self.canvas = FigureCanvasTkAgg(self.figure, master=self.master)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

    def afficher_donnees(self):
        # Récupérer le nom du fichier et les données sélectionnées
        nom_fichier = self.var_fichier.get()
        donnees_selectionnees = self.var_donnees.get()
        type_graphique = self.var_type_graphique.get()

        if "ABB" in nom_fichier:
            base_path = abb_base_path
        elif "KUKA" in nom_fichier:
            base_path = kuka_base_path
        else:
            print("Nom de fichier invalide")
            exit()

        # Charger les données à partir du fichier JSON
        chemin_fichier = base_path + nom_fichier + ".json"
        valeurs_detMC, valeurs_SVD_det, valeurs_pInv_det, valeurs_truncated_det, valeurs_detmean, valeurs_posX, valeurs_posY, valeurs_posZ = extraire_valeurs_json(chemin_fichier)

        # Afficher les données sélectionnées
        if donnees_selectionnees == "detMC":
            valeurs_detMC = aplatir_liste(valeurs_detMC)
            self.afficher_graphique(valeurs_posX, valeurs_posY, valeurs_posZ, valeurs_detMC, type_graphique)
        elif donnees_selectionnees == "SVD_det":
            valeurs_SVD_det = aplatir_liste(valeurs_SVD_det)
            self.afficher_graphique(valeurs_posX, valeurs_posY, valeurs_posZ, valeurs_SVD_det, type_graphique)
        elif donnees_selectionnees == "detmean":
            valeurs_detmean = aplatir_liste(valeurs_detmean)
            self.afficher_graphique(valeurs_posX, valeurs_posY, valeurs_posZ, valeurs_detmean, type_graphique)
        elif donnees_selectionnees == "Position X":
            self.afficher_graphique(valeurs_posX, type_graphique)
        elif donnees_selectionnees == "Position Y":
            self.afficher_graphique(valeurs_posY, type_graphique)
        elif donnees_selectionnees == "Position Z":
            self.afficher_graphique(valeurs_posZ, type_graphique)

    def afficher_graphique(self, x, y, z=None, valeurs=None, type_graphique="2D"):
        self.figure.clear()
        if type_graphique == "2D":
            self.figure.add_subplot(111).plot(valeurs)
        elif type_graphique == "3D":
            if z is not None and valeurs is not None:
                ax = self.figure.add_subplot(111, projection='3d')
                norm = Normalize(vmin=np.min(valeurs), vmax=np.max(valeurs))
                scalarmappable = ScalarMappable(norm=norm, cmap='viridis')
                scalarmappable.set_array([])
                ax.scatter(x, y, z, c=valeurs, norm=norm, cmap='viridis')
                self.figure.colorbar(scalarmappable)
            else:
                ax = self.figure.add_subplot(111, projection='3d')
                ax.plot(x, y, z)
        self.figure.suptitle("Graph of values")
        self.canvas.draw()

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

root = tk.Tk()
app = InterfaceGraphique(root)
root.mainloop()

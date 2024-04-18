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

# Base paths for ABB and KUKA files
abb_base_path = "../Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "../Pronjet_robotique_Riga/data/kuka/"
IRB_base_path = "../Pronjet_robotique_Riga/data/IRB/"

# List of file names
file_names = ["TrajectoryNr1ABB", "TrajectoryNr2ABB", "TrajectoryNr3ABB", "TrajectoryNrXABB", "TrajectoryNrYABB", "TrajectoryNr1KUKA", "TrajectoryNr2KUKA", "trayectoria_IRB"]

# List of options for data
data_options = ["detMC", "SVD_det", "detmean", "Position X", "Position Y", "Position Z"]

# Function to extract values from JSON file
def extract_json_values(file_path):
    detMC_values = []
    SVD_det_values = []
    pInv_det_values = []
    truncated_det_values = []
    detmean_values = []
    posX_values = []
    posY_values = []
    posZ_values = []
    with open(file_path, 'r') as file:
        for line in file:
            try:
                data = json.loads(line)
                if 'detMC' in data:
                    detMC_values.append(data['detMC'])
                if 'SVD_det' in data:
                    SVD_det_values.append(data['SVD_det'])
                if 'pInv_det' in data:
                    pInv_det_values.append(data['pInv_det'])
                if 'truncated_det' in data:
                    truncated_det_values.append(data['truncated_det'])
                if 'detmean' in data:
                    detmean_values.append(data['detmean'])
                if 'posX' in data:
                    if isinstance(data['posX'], list):
                        posX_values.extend(data['posX'])
                    else:
                        posX_values.append(data['posX'])
                if 'posY' in data:
                    if isinstance(data['posY'], list):
                        posY_values.extend(data['posY'])
                    else:
                        posY_values.append(data['posY'])
                if 'posZ' in data:
                    if isinstance(data['posZ'], list):
                        posZ_values.extend(data['posZ'])
                    else:
                        posZ_values.append(data['posZ'])
            except json.JSONDecodeError:
                # Handle invalid JSON
                pass
    return detMC_values, SVD_det_values, pInv_det_values, truncated_det_values, detmean_values, posX_values, posY_values, posZ_values

def flatten_list(lst):
    flat = []
    for elem in lst:
        if isinstance(elem, (list, tuple)):
            flat.extend(flatten_list(elem))
        else:
            flat.append(elem)
    return flat

class GraphicalInterface:
    def __init__(self, master):
        self.master = master
        self.master.title("Selecting the data")

        self.var_file = tk.StringVar(self.master)
        self.var_file.set(file_names[0])  # Default value

        self.var_data = tk.StringVar(self.master)
        self.var_data.set(data_options[0])  # Default value

        self.var_graph_type = tk.StringVar(self.master)
        self.var_graph_type.set("2D")  # Default value

        # Create dropdown menus
        frame_left = tk.Frame(self.master)
        frame_left.pack(side=tk.LEFT, padx=10, pady=10)

        tk.Label(frame_left, text="Selecting a file :").pack()
        tk.OptionMenu(frame_left, self.var_file, *file_names).pack()

        tk.Label(frame_left, text="Selecting the data :").pack()
        tk.OptionMenu(frame_left, self.var_data, *data_options).pack()

        tk.Label(frame_left, text="Selecting the type of graph :").pack()
        tk.OptionMenu(frame_left, self.var_graph_type, "2D", "3D").pack()

        # Create button to display data
        self.button_display = tk.Button(frame_left, text="print the data", command=self.display_data)
        self.button_display.pack()

        # Create button to quit the application
        self.button_exit = tk.Button(frame_left, text="Exit", command=self.master.quit)
        self.button_exit.pack()

        # Create area for graphs
        self.figure = plt.figure()
        self.canvas = FigureCanvasTkAgg(self.figure, master=self.master)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

    def display_data(self):
        # Get the file name and selected data
        file_name = self.var_file.get()
        selected_data = self.var_data.get()
        graph_type = self.var_graph_type.get()

        if "ABB" in file_name:
            base_path = abb_base_path
        elif "KUKA" in file_name:
            base_path = kuka_base_path
        elif "IRB" in file_name:
            base_path = IRB_base_path
        else:
            print("Invalid file name")
            exit()

        # Load data from JSON file
        file_path = base_path + file_name + ".json"
        detMC_values, SVD_det_values, pInv_det_values, truncated_det_values, detmean_values, posX_values, posY_values, posZ_values = extract_json_values(file_path)

        # Display selected data
        if selected_data == "detMC":
            detMC_values = flatten_list(detMC_values)
            self.display_graph(posX_values, posY_values, posZ_values, detMC_values, graph_type)
        elif selected_data == "SVD_det":
            SVD_det_values = flatten_list(SVD_det_values)
            self.display_graph(posX_values, posY_values, posZ_values, SVD_det_values, graph_type)
        elif selected_data == "detmean":
            detmean_values = flatten_list(detmean_values)
            self.display_graph(posX_values, posY_values, posZ_values, detmean_values, graph_type)
        elif selected_data == "Position X":
            self.display_graph(posX_values, graph_type)
        elif selected_data == "Position Y":
            self.display_graph(posY_values, graph_type)
        elif selected_data == "Position Z":
            self.display_graph(posZ_values, graph_type)

    def display_graph(self, x, y, z=None, values=None, graph_type="2D"):
        self.figure.clear()
        if graph_type == "2D":
            self.figure.add_subplot(111).plot(values)
        elif graph_type == "3D":
            if z is not None and values is not None:
                ax = self.figure.add_subplot(111, projection='3d')
                norm = Normalize(vmin=np.min(values), vmax=np.max(values))
                scalarmappable = ScalarMappable(norm=norm, cmap='Spectral')
                scalarmappable.set_array([])
                ax.scatter(x, y, z, c=values, norm=norm, cmap='Spectral')
                self.figure.colorbar(scalarmappable)
            else:
                ax = self.figure.add_subplot(111, projection='3d')
                ax.plot(x, y, z)
        self.figure.suptitle("Graph of values")
        self.canvas.draw()

from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg

root = tk.Tk()
app = GraphicalInterface(root)
root.mainloop()

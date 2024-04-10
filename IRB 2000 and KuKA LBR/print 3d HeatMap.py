import json
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np

# Base paths for ABB and KUKA files
abb_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/kuka/"
IRB_base_path = "C:/Users/erwan/OneDrive/Bureau/Pronjet_robotique_Riga/data/IRB/"

# File name
name = "TrajectoryNr1ABB"
#name = "TrajectoryNr2ABB"
#name = "TrajectoryNr3ABB"
#name = "TrajectoryNrXABB"
#name = "TrajectoryNrYABB"
#name = "TrajectoryNr1KUKA"
#name = "TrajectoryNr2KUKA"
#name = "trayectoria_IRB"

# Determine the base path based on the file name
if "ABB" in name:
    base_path = abb_base_path
elif "KUKA" in name:
    base_path = kuka_base_path
elif "IRB" in name:
    base_path = IRB_base_path
else:
    print("Invalid file name")
    exit()

# Build the complete file path
file_path = base_path + name + ".json"

# Function to extract values from the JSON file
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
    for item in lst:
        if isinstance(item, (list, tuple)):
            flat.extend(flatten_list(item))
        else:
            flat.append(item)
    return flat

# Retrieve values
detMC_values, SVD_det_values, pInv_det_values, truncated_det_values, detmean_values, posX_values, posY_values, posZ_values = extract_json_values(file_path)

# Flatten lists
detMC_values = flatten_list(detMC_values)
SVD_det_values = flatten_list(SVD_det_values)
pInv_det_values = flatten_list(pInv_det_values)
truncated_det_values = flatten_list(truncated_det_values)
detmean_values = flatten_list(detmean_values)
posX_values = flatten_list(posX_values)
posY_values = flatten_list(posY_values)
posZ_values = flatten_list(posZ_values)

# Create the graph of detmean values
plt.figure()
plt.plot(detMC_values)
plt.title("Graph of values of " + name)
plt.xlabel("Index")
plt.ylabel("Value")
plt.grid(True)

# Create the 3D graph of positions
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(posX_values, posY_values, posZ_values, c=SVD_det_values, cmap='Spectral')
ax.set_xlabel('Position X')
ax.set_ylabel('Position Y')
ax.set_zlabel('Position Z')

plt.show()

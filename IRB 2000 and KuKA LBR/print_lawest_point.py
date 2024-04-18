import json
import matplotlib.pyplot as plt
import numpy as np

# Base paths for ABB and KUKA files
abb_base_path = "../Pronjet_robotique_Riga/data/abb/"
kuka_base_path = "../Pronjet_robotique_Riga/data/kuka/"
IRB_base_path = "../Pronjet_robotique_Riga/data/IRB/"

# File name
#name = "TrajectoryNr1ABB"
#name = "TrajectoryNr2ABB"
#name = "TrajectoryNr3ABB"
#name = "TrajectoryNrXABB"
#name = "TrajectoryNrYABB"
#name = "TrajectoryNr1KUKA"
name = "TrajectoryNr2KUKA"
#name = "trayectoria_IRB"
#name = "TrajectoryAllPointsABB"

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
posX_values = flatten_list(posX_values)
posY_values = flatten_list(posY_values)
posZ_values = flatten_list(posZ_values)

# Convert lists to numpy arrays
detMC_values = np.array(detMC_values)
SVD_det_values = np.array(SVD_det_values)
posX_values = np.array(posX_values)
posY_values = np.array(posY_values)
posZ_values = np.array(posZ_values)

# Create a coordinate array
coordinates = np.stack((posX_values, posY_values, posZ_values), axis=-1)

# Calculate the minimum and maximum values for each determinant
detMC_min = np.min(detMC_values)
detMC_max = np.max(detMC_values)
SVD_det_min = np.min(SVD_det_values)
SVD_det_max = np.max(SVD_det_values)

# Display the coordinates corresponding to the minimum and maximum values for each determinant
print("detMC:")
print("Min :", detMC_min)
print("Max :", detMC_max)

print("\nSVD_det:")
print("Min :", SVD_det_min)
print("Max :", SVD_det_max)

# Sort the determinant values and select the 100 lowest indices
detMC_argsort = np.argsort(detMC_values)
detMC_lowest_indices = detMC_argsort[:100]

SVD_det_argsort = np.argsort(SVD_det_values)
SVD_det_lowest_indices = SVD_det_argsort[:100]

# Extract the corresponding coordinates
detMC_lowest_coordinates = coordinates[detMC_lowest_indices]
SVD_det_lowest_coordinates = coordinates[SVD_det_lowest_indices]

# Create 3D plots for the minimum value points of detMC and SVD_det
fig1 = plt.figure()
ax1 = fig1.add_subplot(111, projection='3d')
ax1.scatter(detMC_lowest_coordinates[:, 0], detMC_lowest_coordinates[:, 1], detMC_lowest_coordinates[:, 2], label='detMC 100 lowest')
ax1.set_xlabel('X')
ax1.set_ylabel('Y')
ax1.set_zlabel('Z')
ax1.legend()

fig2 = plt.figure()
ax2 = fig2.add_subplot(111, projection='3d')
ax2.scatter(SVD_det_lowest_coordinates[:, 0], SVD_det_lowest_coordinates[:, 1], SVD_det_lowest_coordinates[:, 2], label='SVD_det 100 lowest')
ax2.set_xlabel('X')
ax2.set_ylabel('Y')
ax2.set_zlabel('Z')
ax2.legend()

plt.show()

import glob
import json
import matplotlib.pyplot as plt
import os

# Path to the files
# waring do not have TrajectoryAllPointsABB.json in ../Pronjet_robotique_Riga/data/abb/
file_paths = "../Pronjet_robotique_Riga/data/abb/*.json"

# List to store the values of all files
detMC_values_all = []
SVD_det_values_all = []
detmean_values_all = []
file_names = []

# Function to extract values from the JSON file
def extract_json_values(file_path):
    detMC_values = []
    SVD_det_values = []
    detmean_values = []
    with open(file_path, 'r') as file:
        for line in file:
            try:
                data = json.loads(line)
                if 'detMC' in data:
                    detMC_values.append(data['detMC'])
                if 'SVD_det' in data:
                    SVD_det_values.append(data['SVD_det'])
                if 'detmean' in data:
                    detmean_values.append(data['detmean'])
            except json.JSONDecodeError:
                # Handle invalid JSON
                pass
    return detMC_values, SVD_det_values, detmean_values

def flatten_list(lst):
    flat = []
    for item in lst:
        if isinstance(item, (list, tuple)):
            flat.extend(flatten_list(item))
        else:
            flat.append(item)
    return flat

# Retrieve values for all files
for file_path in glob.glob(file_paths):
    file_names.append(os.path.basename(file_path))
    detMC_values, SVD_det_values, detmean_values = extract_json_values(file_path)
    detMC_values_all.append(flatten_list(detMC_values))
    SVD_det_values_all.append(flatten_list(SVD_det_values))
    detmean_values_all.append(flatten_list(detmean_values))

# Plotting the curves in superposition
plt.figure()
for i, values in enumerate(detMC_values_all):
    plt.plot(values, label=f'detMC - {file_names[i].split(".")[0]}')
    #plt.plot([v * 10 for v in values], label=f'detMC - {file_names[i].split(".")[0]}')
plt.title('detMC values')
plt.xlabel('Index')
plt.ylabel('detMC value')
plt.legend()

plt.figure()
for i, values in enumerate(SVD_det_values_all):
    plt.plot(values, label=f'SVD_det - {file_names[i].split(".")[0]}')
plt.title('SVD_det values')
plt.xlabel('Index')
plt.ylabel('SVD_det value')
plt.legend()

plt.figure()
for i, values in enumerate(detmean_values_all):
    plt.plot(values, label=f'detmean - {file_names[i].split(".")[0]}')
plt.title('detmean values')
plt.xlabel('Index')
plt.ylabel('detmean value')
plt.legend()
plt.show()

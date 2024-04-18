import json
import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial import KDTree
import heapq
import networkx as nx
from sklearn.neighbors import NearestNeighbors

# Define paths for ABB and KUKA files
abb_base_path = "C:/Projet riga/Projet_robotique_Riga/data/abb/TrajectoryAllPointsABBv2"
kuka_base_path = "C:/Projet riga/Projet_robotique_Riga/data/kuka/"

# Determine the file name
name = "TrajectoryAllPointsABBv2"

# Determine the base path based on the file name
base_path = abb_base_path if "ABB" in name else kuka_base_path if "KUKA" in name else None
if base_path is None:
    raise ValueError("Invalid file name")

# Build the full file path
file_path = base_path + name + ".json"

# Function to extract values from JSON file
def extract_values_from_json(file_path):
    # Define all value lists
    values = {
        "detMC": [],
        "SVD_det": [],
        "pInv_det": [],
        "truncated_det": [],
        "detmean": [],
        "posX": [],
        "posY": [],
        "posZ": []
    }
    # Open and read the JSON file
    with open(file_path, 'r') as file:
        for line in file:
            try:
                data = json.loads(line)
                for key in values.keys():
                    if key in data:
                        if isinstance(data[key], list):
                            values[key].extend(data[key])
                        else:
                            values[key].append(data[key])
            except json.JSONDecodeError:
                continue  # Skip invalid JSON lines
    return [np.array(values[key]) for key in sorted(values.keys())]

# Extract values
values_detMC, values_SVD_det, values_pInv_det, values_truncated_det, \
values_detmean, values_posX, values_posY, values_posZ = extract_values_from_json(file_path)

# Check if coordinate arrays are non-empty
if not values_posX.size or not values_posY.size or not values_posZ.size:
    raise ValueError("One or more coordinate arrays are empty. Check the input file and data extraction logic.")

# Validate and ensure that all coordinate arrays are of the same length
if len(values_posX) != len(values_posY) or len(values_posY) != len(values_posZ):
    print("Error: Coordinate arrays do not have the same length.")
    # Implement necessary logic to handle the error appropriately
    # For example, you may truncate arrays to the smallest length (if it makes sense for your data)
    min_length = min(len(values_posX), len(values_posY), len(values_posZ))
    values_posX = values_posX[:min_length]
    values_posY = values_posY[:min_length]
    values_posZ = values_posZ[:min_length]

# Create coordinates array
coordinates = np.stack((values_posX, values_posY, values_posZ), axis=-1)

# Create a KDTree for efficient nearest neighbor searches
kdtree = KDTree(coordinates)

# Define start and end positions
start = np.array([0, 0, 0])
end = np.array([10, 10, 10])

# Find nearest neighbor indices for start and end positions
start_index = kdtree.query(start)[1]
end_index = kdtree.query(end)[1]

# Define a cost function to combine distance and determinant value
def cost_function(distance, detMC, alpha=0.5):
    return alpha * distance + (1 - alpha) * (1 - detMC)

# Define a heuristic function to estimate distance between two nodes
def heuristic(n1, n2):
    return np.linalg.norm(coordinates[n1] - coordinates[n2])

# Implement the A* algorithm
def astar(graph, start, goal, heuristic_func):
    frontier = [(0, start)]
    came_from = {start: None}
    cost_so_far = {start: 0}
    while frontier:
        _, current = heapq.heappop(frontier)
        if current == goal:
            break
        for next_node in graph.neighbors(current):
            new_cost = cost_so_far[current] + graph[current][next_node]['cost']
            if next_node not in cost_so_far or new_cost < cost_so_far[next_node]:
                cost_so_far[next_node] = new_cost
                priority = new_cost + heuristic_func(goal, next_node)
                heapq.heappush(frontier, (priority, next_node))
                came_from[next_node] = current
    return came_from, cost_so_far

# Calculate the cost for each point
cost_detMC = np.array([cost_function(0, det, alpha=0.5) for det in values_detMC])

# Create a graph from coordinates and costs
G = nx.DiGraph()
for i, coord in enumerate(coordinates):
    G.add_node(i, pos=coord, cost=cost_detMC[i])

# Connect each node to its k nearest neighbors
k = 2  # You may adjust k based on your specific requirements
nbrs = NearestNeighbors(n_neighbors=k + 1, algorithm='auto').fit(coordinates)
distances, indices = nbrs.kneighbors(coordinates)
for i, coord in enumerate(coordinates):
    for j in indices[i][1:]:  # Skip the first index since it is the point itself
        if i != j:  # Avoid adding self-loops
            dist = np.linalg.norm(coord - coordinates[j])
            G.add_edge(i, j, cost=cost_function(dist, values_detMC[j]))

# Find the least costly path using the A* algorithm
came_from, cost_so_far = astar(G, start_index, end_index, heuristic)
if end_index not in came_from:
    print("No path found from start to goal.")
else:
    # Reconstruct the path from the end goal
    path = [end_index]
    while path[-1] != start_index:
        path.append(came_from[path[-1]])
    path = path[::-1]  # Reverse the path to start from the beginning

    # Save the path points to an array
    path_coordinates = np.array([coordinates[i] for i in path])

    # Write the path points to a JSON file
    with open("path.json", "w") as file:
        json.dump(path_coordinates.tolist(), file)

    # Plotting the path
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')

    # Plot the path
    ax.plot(path_coordinates[:, 0], path_coordinates[:, 1], path_coordinates[:, 2],
            marker='o', color='b', linestyle='-', markersize=5)

    # Show the plot
    plt.show()

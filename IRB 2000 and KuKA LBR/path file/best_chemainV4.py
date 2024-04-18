import json
import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial import KDTree
import heapq
import networkx as nx
from sklearn.neighbors import NearestNeighbors
import sys  # Import sys for proper exit

def extract_values_from_json(file_path):
    values_detMC = []
    values_posX = []
    values_posY = []
    values_posZ = []

    with open(file_path, 'r') as file:
        total_lines = 0
        processed_lines = 0
        for line in file:
            total_lines += 1
            try:
                data = json.loads(line)
                if 'posX' in data and 'posY' in data and 'posZ' in data and \
                   not (isinstance(data['posX'], list) or isinstance(data['posY'], list) or isinstance(data['posZ'], list)):
                    values_posX.append(data['posX'])
                    values_posY.append(data['posY'])
                    values_posZ.append(data['posZ'])
                    values_detMC.append(data.get('detMC', 0))
                    processed_lines += 1
            except json.JSONDecodeError:
                print(f"Skipping line due to JSONDecodeError: {line.strip()}")

    print(f"Total lines processed: {total_lines}, Valid entries found: {processed_lines}")
    return np.array(values_detMC), np.array(values_posX), np.array(values_posY), np.array(values_posZ)

# Specify the path to your JSON file
file_path = "C:/Projet riga/Projet_robotique_Riga/data/abb/TrajectoryNr1ABB.json"

# Extract values
values_detMC, values_posX, values_posY, values_posZ = extract_values_from_json(file_path)

# Check if any data was successfully extracted
if values_posX.size == 0 or values_posY.size == 0 or values_posZ.size == 0:
    print("No valid coordinate data found. Exiting.")
    sys.exit()

# Create coordinates array
coordinates = np.stack((values_posX, values_posY, values_posZ), axis=-1)

# Create a KDTree for efficient nearest neighbor searches
kdtree = KDTree(coordinates)

# Define start and end positions
start_pos = np.array([0, 0, 0])
end_pos = np.array([1, 1, 1])

# Find the nearest neighbors to the start and end positions
start_index = kdtree.query(start_pos)[1]
end_index = kdtree.query(end_pos)[1]

def cost_function(distance, detMC_value, alpha=0.5):
    return alpha * distance + (1 - alpha) * (1 - detMC_value)

def heuristic(n1, n2):
    return np.linalg.norm(coordinates[n1] - coordinates[n2])

def astar_algorithm(graph, start, goal, heuristic_func):
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

# Create a graph from coordinates and costs
G = nx.Graph()
for i, coord in enumerate(coordinates):
    G.add_node(i, pos=coord, cost=cost_function(0, values_detMC[i]))

k = 2
nbrs = NearestNeighbors(n_neighbors=k+1, algorithm='auto').fit(coordinates)
distances, indices = nbrs.kneighbors(coordinates)

for i in range(len(coordinates)):
    for j in indices[i]:
        if i != j:  # Don't connect a node to itself
            distance = distances[i][np.where(indices[i] == j)][0]
            G.add_edge(i, j, cost=cost_function(distance, values_detMC[j]))

came_from, cost_so_far = astar_algorithm(G, start_index, end_index, heuristic)

# Reconstruct path from A* came_from data
current_node = end_index
path = [current_node]
while current_node != start_index:
    current_node = came_from[current_node]
    path.append(current_node)
path.reverse()

# Extract coordinates along the path
path_coordinates = coordinates[path]

# Plotting
fig = plt.figure(figsize=(12, 6))  # You can adjust the figure size as needed
ax = fig.add_subplot(111, projection='3d')

# Set the limits of the axes based on the min and max of the path coordinates
# plus a margin for better visibility
margin = 1  # adjust the margin to your data scale
ax.set_xlim(min(path_coordinates[:, 0])-margin, max(path_coordinates[:, 0])+margin)
ax.set_ylim(min(path_coordinates[:, 1])-margin, max(path_coordinates[:, 1])+margin)
ax.set_zlim(min(path_coordinates[:, 2])-margin, max(path_coordinates[:, 2])+margin)

# Plot the path
ax.plot(path_coordinates[:, 0], path_coordinates[:, 1], path_coordinates[:, 2], 'b-', label='Path')
ax.scatter(path_coordinates[:, 0], path_coordinates[:, 1], path_coordinates[:, 2], c='r', s=50, label='Waypoints')  # Path nodes
ax.scatter(start_pos[0], start_pos[1], start_pos[2], c='g', marker='o', s=100, label='Start')  # Start position
ax.scatter(end_pos[0], end_pos[1], end_pos[2], c='y', marker='^', s=100, label='End')  # End position

# Labels and Legend
ax.set_xlabel('X-axis')
ax.set_ylabel('Y-axis')
ax.set_zlabel('Z-axis')
ax.legend()

# Show grid
ax.grid(True)

# Show the plot with an equal aspect ratio
ax.set_box_aspect([1,1,1])  # This makes the 3D plot respect the aspect ratio of the data

plt.show()

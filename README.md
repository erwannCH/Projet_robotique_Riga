Project_robotique_Riga README
===========================

This project focuses on robot trajectory calculations using MATLAB and Python. The MATLAB code is responsible for calculating robot trajectories and saving the data into JSON files. The Python code then reads and analyzes these JSON files, providing visualizations and further insights.

Project Structure
-----------------

```
.
├── .gitattributes
├── .gitignore
├── code.txt
├── README.md
├── This MATLAB code defines.txt
├── CI ABB IRB4400
│   ├── ABB.m
│   ├── CD_IRB.m
│   ├── f1.m
│   ├── ...
│   └── trayectoria_IRB.m
├── data
│   ├── abb
│   │   ├── TrajectoryAllPointsABB.json
│   │   ├── TrajectoryNr1ABB.json
│   │   ├── ...
│   │   └── TrajectoryNrYABB.json
│   └── kuka
│       ├── TrajectoryNr1KUKA.json
│       └── TrajectoryNr2KUKA.json
├── figure
│   ├── ineterface.py
│   ├── TrajectoryAllPointsABB  terminal.txt
│   ├── TrajectoryAllPointsABB detMC 100 lowest.png
│   ├── TrajectoryAllPointsABB detSVD 100 lowest.png
│   ├── TrajectoryNr1ABB det.png
│   ├── TrajectoryNr1ABB Heat Map.png
│   ├── TrajectoryNr1ABB det.png
│   ├── TrajectoryNr1ABB x.png
│   ├── TrajectoryNr1ABB y.png
│   ├── TrajectoryNr1ABB z.png
│   ├── TrajectoryNr1ABB.png
│   ├── TrajectoryNr1KUKA.png
│   ├── TrajectoryNr2ABB.png
│   ├── TrajectoryNr2KUKA.png
│   ├── TrajectoryNr3ABB.png
│   ├── TrajectoryNrXABB.png
│   ├── TrajectoryNrYABB.png
│   ├── detmc values.png
│   ├── detmen values.png
│   └── svd_det values.png
├── IRB 2000 and KuKA LBR
│   ├── ABB-IRB-2600ID-8-2-00.robot
│   ├── ABB.m
│   ├── ABBplot.m
│   ├── best_Trajectory copy.py
│   ├── best_Trajectory.py
│   ├── ...
│   └── print_det and compare.py
└── Robot Package
    ├── ABB-CRB-1300-7-1-4.robot
    ├── ABB-CRB-15000.robot
    ├── ...
    └── Siasun-SCR5.robot
```

File Descriptions
-----------------

* `.gitattributes` and `.gitignore`: Git configuration files.
* `code.txt` and `This MATLAB code defines.txt`: Text files containing code snippets or descriptions.
* `CI ABB IRB4400`: Directory containing MATLAB scripts for calculating robot trajectories.
* `data`: Directory containing JSON files with recorded robot trajectory data.
* `figure`: Directory containing example images and output files generated from the Python scripts.
* `IRB 2000 and KuKA LBR`: Directory containing MATLAB and Python scripts for analyzing and visualizing robot trajectory data.
* `Robot Package`: Directory containing robot model files.

Project Workflow
----------------

1. Use the MATLAB scripts in the `IRB 2000 and KuKA LBR` directory to calculate robot trajectories.
2. The calculated trajectories are saved as JSON files in the `data` directory.
3. Use the Python scripts in the `IRB 2000 and KuKA LBR` directory to analyze and visualize the trajectory data from the JSON files.

Getting Started
---------------

1. Clone this repository to your local machine.
2. Download the `TrajectoryAllPointsABB.json` file from this [link](https://drive.google.com/file/d/1mByE6CzKdqv8bsGwyvvT2m6BbIiX9ST1/view?usp=sharing) and place it in the `data/abb` directory.
3. Run the `interface.py` Python script for a general visualization (GUI) to interactively explore and visualize the robot trajectory data stored in JSON files. The GUI allows users to select a file, choose the data type to visualize (e.g., determinant values, position in X, Y, or Z axis), and pick the graph type (2D or 3D).
	To use the `interface.py` script, follow these steps:
	* Make sure you have the required JSON files in the appropriate directories (`data/abb`, `data/kuka`, or `data/IRB`).
	* Run the `interface.py` script. A window will appear with dropdown menus and buttons.
	* Use the "Selecting a file" dropdown menu to choose the desired JSON file containing the trajectory data.
	* Use the "Selecting the data" dropdown menu to select the type of data you want to visualize (detMC, SVD\_det, detmean, Position X, Position Y, or Position Z).
	* Use the "Selecting the type of graph" dropdown menu to choose between a 2D or 3D graph.
	* Click the "print the data" button to generate and display the graph based on your selected options.
	* To exit the application, click the "Exit" button.

The GUI will update the graph based on your selections, allowing you to easily explore different aspects of the robot trajectory data.
4. For more detailed analysis, use the following Python scripts:
	* `print 3d HeatMap.py`: Displays the heatmap of the chosen trajectory. To use this script, open it and set the `name` variable to the desired JSON file name (without the .json extension). The script will automatically determine the base path based on the file name. Run the script to generate a 3D heatmap of the trajectory.
	* `print_lawest_point.py`: Shows the minimum and maximum values of a trajectory and plots the 3D points with the lowest values. To use this script, open it and set the `name` variable to the desired JSON file name (without the .json extension). The script will automatically determine the base path based on the file name. Run the script to see the minimum and maximum values and the corresponding 3D points.
	* `best_Trajectory.py`: Displays the best path between two points. To use this script, open it and set the `name` variable to the desired JSON file name (without the .json extension). The script will automatically determine the base path based on the file name. Run the script to see the best path between two points.
	* `print_all_det.py`: Prints the values of different determinants tested, each using a different calculation method. To use this script, open it and set the `name` variable to the desired JSON file name (without the .json extension). The script will automatically determine the base path based on the file name. Run the script to see the determinant values.
	* `print2d.py`: Displays the movements along the X, Y, and Z axes, as well as the value of the chosen determinant. To use this script, open it and set the `name` variable to the desired JSON file name (without the .json extension). The script will automatically determine the base path based on the file name. Run the script to see the movements and determinant values.
	* `print_det and compare.py`: This script reads data from multiple JSON files and extracts specific values, then plots the values ('detMC', 'SVD_det', and 'detmean') in separate figures with multiple curves, one for each file. The JSON file paths are determined using a wildcard pattern. The script then extracts values such as 'detMC', 'SVD_det', and 'detmean' from each JSON file. It then flattens the lists and plots the values. To use this script, open it and set the `file_paths` variable to the path of the JSON files using a wildcard pattern (e.g., 'C:/path/to/files/*.json'). Run the script to see the plotted values.
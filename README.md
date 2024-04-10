# Project_robotique_Riga README

This project focuses on robot trajectory calculations using MATLAB and Python. The MATLAB code is responsible for calculating robot trajectories and saving the data into JSON files. The Python code then reads and analyzes these JSON files, providing visualizations and further insights.

## Project Structure

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
├── IRB 2000 and KuKA LBR
│   ├── ABB-IRB-2600ID-8-2-00.robot
│   ├── ABB.m
│   ├── ABBplot.m
│   ├── best_chemain copy.py
│   ├── best_chemain.py
│   ├── ...
│   └── print_det and compare.py
└── Robot Package
    ├── ABB-CRB-1300-7-1-4.robot
    ├── ABB-CRB-15000.robot
    ├── ...
    └── Siasun-SCR5.robot
```

## File Descriptions

- `.gitattributes` and `.gitignore`: Git configuration files.
- `code.txt` and `This MATLAB code defines.txt`: Text files containing code snippets or descriptions.
- `CI ABB IRB4400`: Directory containing MATLAB scripts for calculating robot trajectories.
- `data`: Directory containing JSON files with recorded robot trajectory data.
- `IRB 2000 and KuKA LBR`: Directory containing MATLAB and Python scripts for analyzing and visualizing robot trajectory data.
- `Robot Package`: Directory containing robot model files.

## Project Workflow

1. Use the MATLAB scripts in the `CI ABB IRB4400` directory to calculate robot trajectories.
2. The calculated trajectories are saved as JSON files in the `data` directory.
3. Use the Python scripts in the `IRB 2000 and KuKA LBR` directory to analyze and visualize the trajectory data from the JSON files.

## Getting Started

1. Clone this repository to your local machine.
2. Download the `TrajectoryAllPointsABB.json` file from this [link](https://drive.google.com/file/d/1mByE6CzKdqv8bsGwyvvT2m6BbIiX9ST1/view?usp=sharing) and place it in the `data/abb` directory.
3. Run the `interface.py` Python script for a general visualization and exploration of the data.
4. For more detailed analysis, use the following Python scripts:
	* `print_3d.py`: Displays the heatmap of the chosen trajectory.
	* `minMax.py`: Shows the minimum and maximum values of a trajectory and plots the 3D points with the lowest values.
	* `best_chemain.py`: Displays the best path between two points.
	* `print_all_det.py`: Prints the values of different determinants tested, each using a different calculation method.
	* `print.py`: Displays the movements along the X, Y, and Z axes, as well as the value of the chosen determinant.
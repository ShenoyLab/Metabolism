# Model for Cell Metabolic Potential
#### Contained within this repository are two finite element analysis models used to implement the free-energy based approach for calculating the metabolic potential of a cell as outlined in the cited manuscript. The two models are separated based on the environment they recapitulate (2D vs 3D), but are built based upon the same physical implementation and running procedure.
### This repository relates to the research publication "Jaganathan A. et al., Mechano-metabolism of adherent cells in 2D and 3D microenvironments, BioRxiv, 2024" (https: ). Please cite our paper if this code is used or modified for further use.
## System Requirements
### Operating system:
#### This package is supported for macOS and windows. The package has been tested on the following systems:
#### •	macOS Monterey 12.4, Processor: 2.3 GHz 8-Core Intel i9, RAM: 32 GB
#### •	Windows 11 Home, Processor: AMD Ryzen 5 5500U Hexa-Core processor, RAM: 16 GB
### MATLAB dependencies
#### This package requires MATLAB LiveLink for COMOSL Multiphysics. This package has been tested on the following software versions:
#### •	MATLAB_R2023b
#### •	COMSOL Multiphysics 6.0
## Installation guide
### 1.	Install MATLAB (https://www.mathworks.com/products/matlab.html). The installation usually takes approximately 1 hour.
### 2.	Install COMSOL Multiphysics (https://www.comsol.com/) along with the Structural Mechanics Module and LiveLink for MATLAB. During installation, specify the installation directory of MATLAB on your system when prompted with the option to establish the LiveLink connection. 
### 3.	Launch MATLAB using the LiveLink interface.
## Demo
### 1.	Ensure all downloaded files from either the 2D or 3D model in this repository are placed in the same folder. Open “cell_3D.m.”
## Steps for running 3D files
### 2.	Click “Run”. By default, the code is setup to run the model for the full range of cell aspect ratios and ECM density tested in the study, but this list may be adjusted to the desired values. The code will take around 5~10 seconds to finish computing and compiling data for one combination of cell shape and ECM stiffness, and around 1 hour in total for all combinations.
### 3.	Output will be stored in the MATLAB workspace. Open “Post_calculations.m” and click “Run” with the output of “cell_3D.m” opened in the workspace. 
### 4.	All data output from the model will be stored in the workspace variables and displayed in the resulting figures. 
## Steps for running 2D files
### 2. Set ECM stiffness to desired level (by default it is set to 10 kPa). Click "Run" to execute the parametric study that generates the volume-averaged energies, stress and contractility for a range of cell aspect ratio combinations. Default ranges of cell aspect ratios given in the file can be used to generate the contours of metabolic potential at 10 kPa.
### 3. Output is generated in the Probe Table 29. Using the "Export Table" feature in COMSOL, the data can be stored as an Excel datasheet (see sample data file 2d10.xlxs for reference) that can be accessed using a matlab script file to generate the contours of metabolic potential at a given stiffness level.
### 4. Repeat steps 2 and 3 for different ECM stiffness levels to generate the metabolic potential landscape and identify the optimum cell shape, stress and contractility at the corresponding levels. 
## Sample Output (3D)
### 1.	Sample MATLAB workspaces produced by the programs for the 3D model are provided by “cell_3D_output.mat” and “Post_calculations_output.mat.”
### 2.	A sample MATLAB figure showing the calculated metabolic potential and optimum cell shape for various combinations of cell aspect ratio and collagen density is provided in "EnergyLandscape.fig.”
## Sample Output (2D)
### 1. Sample datasheet generated is provided for the 2D model in "2d10.xlxs" and the MATLAB script file used to generate the contours is "contours2D.m".
### 2. A sample MATLAB figure displaying the metabolic potential landscape at ECM stiffness of 10 kPa along with the optimum cell shape is provided in "contour_sample.fig".
## Instruction for use
#### The general structure provided by these scripts and models can be utilized to study a wider or different range of cell aspect ratio or matrix stiffness than analyzed in the corresponding manuscript. The values of interest should be specified in the “AR” and “Density” variables at the beginning of the script. Further, different cell geometries or matrix material models can be specified by modifying the COMSOL files. 

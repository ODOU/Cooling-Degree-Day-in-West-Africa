# Cooling-Degree-Day-in-West-Africa

This repository contains the scripts and files to be able to reproduce the analysis performed in the article **Potential changes in cooling degree day under different global warming levels and shared socioeconomic pathways in West Africa**. 

# CDD and CDDP computation scripts

The jupyter notebook used are provided in the **Scripts** folder.
- CDD_and_CDDP_Analysis_Visualisation_Final.ipynb - CDD netcdf files processed to compute analysis and necessary plots in the article
- Bias_Correction.ipynb - Climate projection bias correction 
- Compute_Cooling_Degee_Day.ipynb - Set of instructions uses to compute the Cooling Degree Day for each climate model files under RCP 4.5 and RCP8.5
- CDD_per_global_warming_level.ipynb - Set of instructions to compute the Cooling Degree Day for each Global Warming Levels (GWLs)
	
Base temperature determination has been done in R software. 
- Base_temperature.R : code for the base temperatue determination for each country considered alongside the different graph
- Seasonal_load_profile_West_Africa.R : code of the Figure 4 of the article with the seasonal variation
	

# Maps

This folder contains the QGIS project created to generate study area map as well as Senegal map overlay by population (Figure 5).

# Post-process files

All the post-process netcdf files in csv are provided in cdd_ouput/cdd folder.	
	

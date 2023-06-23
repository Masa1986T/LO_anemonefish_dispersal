# Data and code share of Sato et al. (2023) Anemoenfish-larval-dispersal
This repository shares the following datasets and code used in Sato et al. (2023) pubulished in Limnolgoy and Oceanography

## Genetic data
- AF_14loci.csv:Genotyping data of 14 microsatellite loci used for estiamting larval dispersal of Amphiprion frenatus in Puerto Galera, the Philippines, using COLONY.
- AP_15loci.csv:Genotyping data of 15 microsatellite loci used for estiamting larval dispersal of Amphiprion perideraion in Puerto Galera, the Philippines, using COLONY.

## Current velocity and laraval dispesal simulation data from hydrodynamic and biophysical models 
- LRSR_flow.csv: Mean magnitude of velocity (m/s) (Mean_mag6d), mean eastward velocity (m/s) (Mean_east6d), mean northward velocity (m/s) (Mean_north6d), local retention (LR) and self-recruitment (SR) in all the grids of Puerto Galera (PG) and Laguindingan (LD) domains for the period from each date of particle releases (day 0) to start of settling (day 6) predicted using simulations of Delft3D-Flow and Delft3D-PART.
- WL_comp_PG_LD.xlsx: Time-series water level at Puerto Galera (PG) and Laguindingan (LD) from May to July in 2012 and 2013, respectively.

## Code share of Sato et al. (2023)
- Flow_comp_bwPG_LD.R: R code for making Fig.3a to compare of Mean magnitude of velocity (m/s) (Mean_mag6d), mean eastward velocity (m/s) (Mean_east6d), mean northward velocity (m/s) (Mean_north6d), local retention (LR) and self-recruitment (SR) between PG and LD
- LR_SR_relation_currents_site.R：R code for making Fig.4 to examine predicted local retention and self-recruitment in relation to mean E-W and N-S velocities based on larval dispersal and hydrodynamic simulations in Puerto Galera (PG) and Laguindingan (LD). 

## Results
The folder "res" includes results of figures obtained by running "Flow_comp_bwPG_LD.R" and LR_SR_relation_currents_site.R".

## Citation
Masaaki Sato, Kentaro Honda, Yohei Nakamura, Lawrence Patrick C. Bernardo, Klenthon O. Bolisay, Takahiro Yamamoto, Eugene C. Herrera, Yuichi Nakajima, Chunlan Lian, Wilfredo H. Uy, Miguel D. Fortes, Kazuo Nadaoka and Masahiro Nakaoka (accepted) Hydrodynamics rather than type of coastline shapes self-recruitment in anemonefishes.  Limnology and Oceanography

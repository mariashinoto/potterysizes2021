# potterysizes2021
[![DOI](https://zenodo.org/badge/899788736.svg)](https://doi.org/10.5281/zenodo.14292070)

Functions, data, drawings or pottery used for analyses with R in 2021 for a Festschrift to be published in 2025.

## Overview

This repo stores data and functions created for a study on the size of prehistoric pottery of Japan. 
This repo stores data and functions created for a study on the size of prehistoric pottery of Japan. It serves reproducibility for data collection and analyses that were performed in 2021 for a book that will not be published before 2025 {@Shinoto_potterysizes2021_2024}. 


### Workflow
## R code from 2021

The functions are uploaded to the folder `R-code-2021` just a they were stored at the end of the study; they are not checked with actual versions of R and the packages used. -- Use and adapt on your own risk; questions via email are welcome. 

The file `functions--create-dfs-from-digitized-data.R` contains the three core functions that create the data sets described above ("Data calculated from the original (digitized) data") from the data in folder `data/01-digitized-scans-and-data` in the respective folders:

- `radius.height()` creates the data files `vessel_radius_height.csv`
- `radius.only()` creates the data files `vessel_radius_only.csv`
- `profile.volume()` creates the data files `vessel_volumes.csv`

These functions should work with identically structured pottery data from other contexts as well. 

### Data


### Functions




## Citations for use with this software

```@software{Shinoto_potterysizes2021_2024,
author = {Shinoto, Maria},
doi = {10.5281/zenodo.14292071},
month = dec,
title = {{potterysizes2021}},
url = {https://github.com/mariashinoto/potterysizes2021},
version = {0.1},
year = {2024}
}
```

When using this software or data or a development from these sources, always cite the related chapter in addition to the software citation (bibliographical data to be completed):

> Shinoto, M. 2025 (in press). Sizes in Pottery of the Same Vessel Form: A Study on Narikawa Pottery from the Matsuno’o Burial Site, South Japan. 

```
@inbook{Shinoto_2025, 
title = {Sizes in Pottery of the Same Vessel Form: A Study on Narikawa Pottery from the Matsuno’o Burial Site, South Japan}, 
booktitle = {?}, 
author = {Shinoto, Maria}, 
editor = {Hudson, Mark}, 
year = {2025}, 
pages = {?}, 
language = {en-US},
note = {Citation Key: Shinoto2025} 
}
```

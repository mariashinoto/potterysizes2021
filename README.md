# potterysizes2021
[![DOI](https://zenodo.org/badge/899788736.svg)](https://doi.org/10.5281/zenodo.14292070)

Functions, data, drawings of pottery used for analyses with R in 2021 for a book chapter to be published in 2025 (Shinoto 2025).

## Overview

This repo stores data and functions created for a study on the size of prehistoric pottery of Japan. It serves reproducibility for data retrieval and analyses that were performed in 2021 for a book that will be published in 2025. 


## Data

The data were created from edited scans of vessels excavated in 1980 in South Japan (Makurazaki City Board of Education (ed.) 1981) with a web based digitizer (Rohatgi 2021), which is available in a newer version at the same adress. 

### Data related to digitization

The scans and digitized data are stored in `data/01-digitized-scans-and-data`. They are divided into three folders: `a-complete-bodies` for vessels preserved in full profile, `b-reconstructible-bodies` for vessels where the profile is not fully preserved but can be reconstructed from the fragments, and finally `c-reconstructible-radius` for vessels, where only the maximal radius of the body can be reconstructed. 

The study can be replicated on different levels of certainty according to which data are chosen: With the first folder, data are most reliable, while data from the second folder add some insecurity -- though in our case the data distribution fits well into the distribution of fully preserved data. The third folder is for the step of volume and height estimation from fragments; since fragments are the most common level of find preservation, this is the most important folder for demonstration of the concepts of size in find contexts. 

#### Scans and digitization

File names for each vessel scan follow the pattern `027p059.jpg`, where "027" is the ID of the vessel in the excavation report (Makurazaki City Board of Education (ed.) 1981), "p059" gives the page number. 

The scan adds a scale from the excavation report and a rectangle added during digitization, covering the body height as far as preserved and the maximum radius. 

The scans were digitized in three steps: 

1. The scale on the scan was adjusted to the scale in the digitizer.
2. Drawing a rectangle from the bottom of the central axis to the maximum body extension and the neck point produced a file with radius and body height data for each vessel.
3. Marking the right profile in the digitizer produced a series of profile point data with its distance from the central axis (radius) at each point and the height from the bottom of the rectangle set in step 2.

Digitization produced two data files which form the basis for volume calculation and subsequent analyses.

> All numbers are stored with the European decimal separator `,` that may be replaced with a `.` in other contexts. 

#### Data files with radius and volume for each vessel

Each vessel produced one file from step 2 above that consists of the ID and two values, radius (called `Dist0`) and body height (called `Dist01`). The pattern of the file name is e.g. `027distances.csv` with the ID from the excavation report and the characterisation of the data as "distances". Fragments are have no height data, therefore the "distances" only consist of `Dist0`, the radius. 

#### Profile data for each vessel

The other file was produced in step 3 and contains the profile data for each vessel. The file name pattern is `027volumes.csv`, it shows the radius at a point in each row of the first column, and the absolute height of the point in the second column. 

The points are ordered according to the radius; they will have to be sorted by absolute height from bottom up or top down in order to reproduce the line of the profile. 

For reproducing the analyses steps for pottery size without going through the step of digitization, these data can be used.

### Data calculated from the original (digitized) data

The files created in 2021 with R (functions in `R-code-2021/functions--create-dfs-from-digitized-data.R`) are stored in the next data folder `02-dataframes-created-in-R-from-digitized-data`, again separated into three subfolders. 

The folders for complete and reconstructible vessels hold two files. 

`vessel-rad-ht.csv` holds the vessel ID, maximum radius and body height in the folders for complete or reconstructible bodies in each row, `vessel-size-data.csv` adds a columns with the total volume for each vessel body, calculated from the volumes of the small cylinders in the vessel profile. Fragments which did not allow for full body reconstruction only store the radius per vessel in a file called `vessel_radius_only.csv`. 

For reproducing the analyses steps for pottery size without going through the step of digitization, these data can be used.

### Comprehensive dataframes

For all bodies that gave height data as well and could produce a volume estimation, the data from `vessel-size-data.csv` are combined in `data/03-dataframe-for-bodies` for convenience. They add no new insights. Data from vessels without reconstructible body height are not included in the file; their volume is estimated according to the statistical model (see below R code from 2021).

## R code from 2021

The functions are uploaded to the folder `R-code-2021` just as they were stored at the end of the study; they are not checked with actual versions of R and the packages used. -- Use and adapt on your own risk; questions via email are welcome. 

The file `functions--create-dfs-from-digitized-data.R` contains the three core functions that create the data sets described above ("Data calculated from the original (digitized) data") from the data in folder `data/01-digitized-scans-and-data` in the respective folders:

- `radius.height()` creates the data files `vessel_radius_height.csv`
- `radius.only()` creates the data files `vessel_radius_only.csv`
- `profile.volume()` creates the data files `vessel_volumes.csv`

These functions should work with identically structured pottery data from other contexts as well. 

Another R code file `code--models-diagrams.R` contains several paths to creating and displaying models that help with the creation of size groups and the estimation of vessel volumes from fragments.


## Citations for use with this software

```
@software{Shinoto_potterysizes2021_2024,
author = {Shinoto, Maria},
doi = {10.5281/zenodo.14292071},
month = dec,
title = {{potterysizes2021}},
url = {https://github.com/mariashinoto/potterysizes2021},
version = {0.1},
year = {2024}
}
```

When using this software or data or a development from these sources, always cite the related chapter in addition to the software citation (bibliographical data to be completed in a later version):

> Shinoto, M. 2025 (in press). Sizes in Pottery of the Same Vessel Form: A Study on Narikawa Pottery from the Matsuno’o Burial Site, South Japan. In: Mark Hudson (ed.) "??".

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

## References

Makurazaki City Board of Education (ed.) 1981. Matsuno'o site. Report of investigations in cultural properties related to the reconstruction works in Matsuno'o 1. Makurazaki City. In Japanese. 

Rohatgi, A. 2021. WebPlotDigitizer (Version 4.5, August 2021) https://automeris.io/WebPlotDigitizer

Shinoto, M. 2025 (in press). Sizes in Pottery of the Same Vessel Form: A Study on Narikawa Pottery from the Matsuno’o Burial Site, South Japan. In: Mark Hudson (ed.) "??".
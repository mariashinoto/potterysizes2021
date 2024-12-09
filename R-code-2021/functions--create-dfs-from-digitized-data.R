# Functions for creating pottery size data sets from single data files
# 2021-10-16
# Maria Shinoto
# 3 Functions: radius.height, radius.only, profile.volume


radius.height <- function() {

#' Collect radius and height from single files in one dataframe
#'
#' @author Maria Shinoto, 2021-10-15
#'
#' @usage Festschrift Gina Barnes
#'
#' @description radius and height of vessel features (mostly max radius
#'   or bodyheight) are taken from single text files, modified and
#'   collected in a dataframe with ID number, radius and height columns.
#'
#' @return dataframe. All volumes for all vessels in the form "ID" "radius",
#'  "height", which are also stored in a comprehensive .csv file.

  file_names <- list.files(pattern="*distances.csv")                        # all related files with this naming!
  vessel_ids <- substring(file_names, 1, 3)                                 # all related files with this naming and ID!

  data_frame_list <- lapply(file_names, read.csv2, header = FALSE)
  data_frame_list <- lapply(data_frame_list, "[", 2)                        # extract 2nd column, which contains data
  data_frame_list <- lapply(data_frame_list, function(x) x[order(x$V2), ])  # sort 2nd column to be sure about which cell is what
  radius <- sapply(data_frame_list, "[[", 1)                                # smaller value is radius
  height <- sapply(data_frame_list, "[[", 2)                                # larger value is height
  df_radht <- data.frame(vessel_ids, radius, height)                        # resulting df with ID, radius, height

  write.csv2(df_radht, file = "vessel_radius_height.csv", row.names=FALSE)

  rm(file_names, vessel_ids)
  return(df_radht)

}




radius.only <- function() {

  #' Collect radius only from single files without height data in one dataframe
  #'
  #' @author Maria Shinoto, 2021-10-28
  #'
  #' @usage Festschrift Gina Barnes
  #'
  #' @description radius are taken from single text files, modified and
  #'   collected in a dataframe with ID number, radius and height columns.
  #'
  #' @return dataframe. All volumes for all vessels in the form "ID"; "radius",
  #' which are also stored in a comprehensive .csv file.

  file_names <- list.files(pattern="*distances.csv")                        # all related files with this naming!
  vessel_ids <- substring(file_names, 1, 3)                                 # all related files with this naming and ID!

  data_frame_list <- lapply(file_names, read.csv2, header = FALSE)
  data_frame_list <- lapply(data_frame_list, "[", 2)                        # extract 2nd column, which contains data
  radius <- sapply(data_frame_list, "[[", 1)                                # only value is column "radius"
  df_radonly <- data.frame(vessel_ids, radius)                              # resulting df with ID, radius, height

  write.csv2(df_radonly, file = "vessel_radius_only.csv", row.names=FALSE)

  rm(file_names, vessel_ids)
  return(df_radonly)

}





profile.volume <- function() {

#' Calculate volume in litres from vessel profile point data and collect in dataframe
#'
#' @author Maria Shinoto, 2021-10-15
#'
#' @usage Festschrift Gina Barnes
#'
#' @description Point data from digitizer with vessel ID from file name and
#'   X values (always radius) and Y values (always height) are transformed to
#'   cylinder volume data and summed up for each vessel (i.e. each file),
#'   bound together in one dataframe with ID, volume.
#'
#' @return dataframe. All volumes for all vessels in the form "ID" "volume",
#'  which are also stored in a comprehensive .csv file.



  file_names <- list.files(pattern = "*volumes.csv")
  vessel_ids <- substring(file_names, 1, 3)

  vessel_volumes <- c()                                                       # initialize to add rows below

  for (i in 1:length(file_names)) {
    dftmp <- read.csv2(file_names[i], header = FALSE)
    names(dftmp) <- c("radius", "height_top")                                # X and Y values are without doubt this sequence
    dftmp <- dftmp[order(-dftmp$height_top),]                                # sort desc by height to get curve / neighouring height
    dftmp$height_bottom <- c(dftmp$height_top[2:length(dftmp$height_top)], 0)  # new column from lower height value (cylinder height)
    dftmp$cyl_height <- dftmp$height_top - dftmp$height_bottom               # get cylinder height
    this_vessel_volume_litre <- sum(dftmp$cyl_height * pi * (dftmp$radius ^ 2) / 1000)
                                                                            # get volume from small cylinder volumes
    vessel_volumes <- c(vessel_volumes, this_vessel_volume_litre)
  }

  df_volumes <- data.frame(vessel_ids, vessel_volumes)

  write.csv2(df_volumes, file = "vessel_volumes.csv", row.names = FALSE)
  rm(file_names, i, vessel_ids, vessel_volumes)
  return(df_volumes)

}


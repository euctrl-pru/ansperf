# -----------------------------------------------------------------------------
# Title: entry_sectors_clustering.R
# Description: Calcula os setores de entrada em área terminal a partir de dados
#              de lat e lon da interseção com C100 e C40.
# Author: CV Jean
# Date: 2024-07
# Version: 0.0

# -----------------------------------------------------------------------------
# Imports
library(dplyr)
library(dbscan)
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Function to calculate the entry sectors clustering based on DBSCAN method
# Args:
#   data: ASMA dataset
#   eps: Distance reference for DBSCAN (epsilon)
#   minPts: Samples reference number for DBSCAN
# Returns:
#   Data with entry sectors column
dbscan_method <- function(data, eps=0.3, minPts=200) {
  # Create index column and empty columns for c100 and c40 cluster
  data <- data %>%
    mutate(index = row_number(),
           cluster_40 = NA_integer_,
           cluster_100 = NA_integer_)
  # select unique airports
  airports_list <- unique(data$ades)
  
  for (airport in airports_list) {
    # Filter data to get C40 lat, lon and bear where lat and lon is not null
    coord_40 <- data %>%
      filter(!is.na(c40lat) & !is.na(c40lon) & ades == airport) %>%
      select(index, ades, c40lat, c40lon, c40_bear)
    
    if (nrow(coord_40) > 0) {
      # Apply standardization operation on lat and lon data
      coord_scaled_40 <- scale(coord_40 %>% select(c40lat, c40lon))
      # Apply DBSCAN method
      dbscan_result_40 <- dbscan(coord_scaled_40, eps = eps, minPts = minPts)
      # Update the original dataframe with cluster results
      data <- data %>%
        mutate(cluster_40 = ifelse(index %in% coord_40$index, dbscan_result_40$cluster[match(index, coord_40$index)], cluster_40))
    }
    
    # Filter data to get C100 lat, lon and bear where lat and lon is not null
    coord_100 <- data %>%
      filter(!is.na(c100lat) & !is.na(c100lon) & ades == airport) %>%
      select(index, ades, c100lat, c100lon, c100_bear)
    
    if (nrow(coord_100) > 0) {
      # Apply standardization operation on lat and lon data
      coord_scaled_100 <- scale(coord_100 %>% select(c100lat, c100lon))
      # Apply DBSCAN method
      dbscan_result_100 <- dbscan(coord_scaled_100, eps = eps, minPts = minPts)
      # Update the original dataframe with cluster results
      data <- data %>%
        mutate(cluster_100 = ifelse(index %in% coord_100$index, dbscan_result_100$cluster[match(index, coord_100$index)], cluster_100))
    }
  }
  
  return(data)
}

# -----------------------------------------------------------------------------
# Function to map to all clustering functions 
# Args:
#   data: ASMA dataset
#   method: Method chosen for clustering
# Returns:
#   Data with entry sectors column
entry_sectors_clustering <- function(data, method){
  if(method=='DBSCAN'){
    clusterized_data <- dbscan_method(data)
    return(clusterized_data)
    
  }else{
    print("Method not implemented")
  }
  return(NULL)
}
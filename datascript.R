library(dplyr)
library(here)
library(sf)
library(tmap)
library(countrycode)

data <- read.csv(here::here(('HDR21-22_Composite_indices_complete_time_series.csv'))) %>%
  dplyr::select(starts_with("hdi_2010"), starts_with("hdi_2019"), contains("country")) %>%
  mutate(hdi_diff = hdi_2019 - hdi_2010)

shapefile <- st_read(here::here('World_Countries_(Generalized)','World_Countries__Generalized_.shp'))

plotdata <- shapefile %>%
  merge(., 
        data,
        by.x = 'COUNTRY',
        by.y = 'country')
tmap_mode('plot')

plotdata %>%
  qtm(.,fill = 'hdi_diff')
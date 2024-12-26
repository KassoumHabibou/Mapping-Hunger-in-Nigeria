

############################################################################
######### Importing and cleaning geographic data ###########################
############################################################################

######################## Importing library and external files ##############
## List of required packages

## List of required packages
required_packages <- c("tidyverse", "dplyr", "readxl","ipumsr")

### Check if packages are installed
missing_packages <- setdiff(required_packages, installed.packages()[,"Package"])

### Install missing packages
if (length(missing_packages) > 0) {install.packages(missing_packages)}


lapply(required_packages, library, character.only = TRUE)

######################## Importing datasets #################################
# Read DDI file and micro data using ipumsr package
ddi <- read_ipums_ddi("./input/data/NDHS/idhs_00010.xml")
df <- read_ipums_micro(ddi)

# Select relevant columns from the dataframe



# List of Nigerian states
lstStates <- c("Sokoto", "Katsina", "Kaduna", "Kano", "Jigawa", "Bauchi", "Gombe", "Yobe", "Borno", "Adamawa", "Taraba", "Kogi", "Niger", "Plateau", "Federal Capital Territory", "FCT", "Abuja", "FCT ABUJA")
lstStates <- toupper(lstStates)

# Clean and process geographic variables in the dataframe
df$GEO_NG2003_2021 <- lbl_clean(df$GEO_NG2003_2021)
df$GEO_NG2003_2021 <- as.character(as_factor(df$GEO_NG2003_2021, levels = "labels"))

df <- df %>%
  mutate(GEO_NG2003_2021 = toupper(GEO_NG2003_2021))

# Clean and process SAMPLESTR variable in the dataframe
df$SAMPLESTR <- lbl_clean(df$SAMPLESTR)
df$SAMPLESTR <- as_factor(df$SAMPLESTR)

# Import the geographic informations from an Excel file
#ngaDhsShapefile <- read_excel("./input/data/NDHS/ngaDhsShapefileRaw.xlsx")


# Merge the main dataframe with the shapefile dataframe
#df <- df %>%
  #left_join(ngaDhsShapefile, by = c("DHSID" = "DHSID"))

# Create a new variable 'Zone' based on certain conditions
df <- df %>%
  mutate(data_source = fct_recode(SAMPLESTR,
                        "DHS 1990" = "Nigeria 1990",
                        "DHS 1999" = "Nigeria 1999",
                        "DHS 2003" = "Nigeria 2003",
                        "DHS 2008" = "Nigeria 2008",
                        "DHS 2013" = "Nigeria 2013",
                        "DHS 2018" = "Nigeria 2018"),
         survey="DHS")


############################################################################
###### Clean and convert some anthropometric variables #####################
############################################################################

# Convert nutrition outcome and kid's age columns to numeric
df$HWHAZWHO <- as.numeric(as.character(df$HWHAZWHO))


# Clean and process certain numeric columns in the dataframe

# For detecting NaN in the outcomes variables
df <- df %>% 
  mutate(is_na_HAZ = ifelse(HWHAZWHO==9998, 1, 0))

df <- df %>%
  mutate(
    # nutrition outcome
    HWHAZWHO = ifelse(HWHAZWHO %in% seq(9995, 9999, 1), NA, HWHAZWHO),
    HWHAZWHO = HWHAZWHO/100)

# Selecting some variables
df <- df %>%
  select(DHSID, YEAR, survey, data_source, HWHAZWHO, is_na_HAZ, KIDWT)

# Rename the variables names

df <- df %>%
  rename(dhsid = DHSID,
         survey_year = YEAR, 
         haz_who = HWHAZWHO, 
         is_na_haz = is_na_HAZ,
         kid_weight = KIDWT)

######################## Saving the final dataset and removing all objects ############

# Saving
write_csv(df, "./output/data/ndhs/df_NDHS1990_2018.csv")

# Remove all objects
rm(list = ls())

# Make sure that you have the “utils” package installed.

#these libraries need to be loaded
library(utils)

# read the Dataset sheet into “R”. The dataset will be called "data".
covid19 = read.csv("https://opendata.ecdc.europa.eu/covid19/casedistribution/csv", na.strings = "", fileEncoding = "UTF-8-BOM")
summary(covid19$deaths)


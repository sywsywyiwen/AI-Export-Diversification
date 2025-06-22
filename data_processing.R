library(readr)
epii <- read_csv("Desktop/msc_thesis/methodology/data/2_panel_data/egalitarian-political-institutions-index.csv")

#customize the period
## eliminate the data before 1970 and after 2023

epii <- epii[epii$Year>=1970 & epii$Year<=2014, ]

epii$`Egalitarian political institutions index (best estimate)`
#change the column names for later merging
colnames(epii)[names(epii) == "Entity"] <- "country"

colnames(epii)[names(epii) == "Year"] <- "year"

colnames(epii)[names(epii) == "Egalitarian political institutions index (best estimate)"] <- "govscore"


### process the EDI dataset
edi <- read_csv("Desktop/msc_thesis/methodology/data/2_panel_data/ED_62_14.csv")

edi <- edi[edi$`Time Period`>=1970,]

colnames(edi)[names(edi) == "Country Name"] <- "country"
colnames(edi)[names(edi) == "EDI"] <- "expordiv"
colnames(edi)[names(edi) == "Time Period"] <- "year"

edi$expordiv[edi$expordiv==0] <- NA

#transform the lattitude dataset to a panel data
lat <- read_csv("Desktop/msc_thesis/methodology/data/2_panel_data/country-coord.csv")
lat <- subset(lat, select = c(Country,`Latitude (average)`))

# rename the columns
colnames(lat)[names(lat) == "Country"] <- "country"
colnames(lat)[names(lat) == "Latitude (average)"] <- "lat"

# turn it into a panel data
years <- 1970:2014

panel_country <- expand.grid(year=years, country= lat$country)

lat <- merge(panel_country,lat, by = "country")

#export the cleaned csv files
write.csv(edi, file = "edi.csv", row.names = FALSE)

write.csv(epii, file = "epii.csv", row.names = FALSE)

write.csv(lat, file = "lat.csv", row.names = FALSE)

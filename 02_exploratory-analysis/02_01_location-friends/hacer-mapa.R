##Javier López Fernández

library(rjson)
library(dplyr)
library(ggplot2)

myLines <- readLines("data/UPCT_friends.json")

friend_data <- lapply(myLines,
                      function(x) fromJSON(json_str = x))

locations <- lapply(friend_data, function(x) x$localizacion)
locations <- data.frame(location = unlist(locations))

##Convertir todos los strings a mayúsculas (para que por ejemplo "España" o "ESPAÑA" se consideren como el mismo String)
locations <- mutate_each(locations, funs(toupper))


##Eliminar hashtags
locations <- as.data.frame(sapply(locations, function(x) gsub("#", "", x)))

##Sustituir "UPCT" por "Cartagena, Región de Murcia"
locations <- as.data.frame(sapply(locations, function(x) gsub("^UPCT$", "CARTAGENA, REGIÓN DE MURCIA", x, ignore.case = TRUE)))

##Sustituir "Murcia, España", "Murcia", "Región de Murcia" por "Murcia, Región de Murcia"
locations <- as.data.frame(sapply(locations, function(x) gsub("^Región de Murcia$", "MURCIA, REGIÓN DE MURCIA", x, ignore.case = TRUE)))
locations <- as.data.frame(sapply(locations, function(x) gsub("^Región de Murcia, España$", "MURCIA, REGIÓN DE MURCIA", x, ignore.case = TRUE)))

##Sustituir todo lo que empiece por "Murcia" por "Murcia, Región de Murcia"
locations <- as.data.frame(sapply(locations, function(x) gsub("^Murcia.*", "MURCIA, REGIÓN DE MURCIA", x, ignore.case = TRUE)))

##Sustituir todo lo que empiece por "Cartagena" por "Cartagena, Región de Murcia"
locations <- as.data.frame(sapply(locations, function(x) gsub("^Cartagena.*", "CARTAGENA, REGIÓN DE MURCIA", x, ignore.case = TRUE)))

##Sustituir todo lo que empiece por "Madrid" por "Madrid, Comunidad de Madrid"
locations <- as.data.frame(sapply(locations, function(x) gsub("^Madrid.*", "MADRID, COMUNIDAD DE MADRID", x, ignore.case = TRUE)))

#Sustituir "Spain" por "España"
locations <- as.data.frame(sapply(locations, function(x) gsub("^Spain$", "ESPAÑA", x, ignore.case = TRUE)))


location_times <- locations %>% 
                  group_by(., location) %>%
                  summarize(., ocurrences = n()) %>%
                  arrange(., desc(ocurrences))

ggplot(location_times[1:10,]) + geom_bar(aes(location, ocurrences), stat="identity") + coord_flip()


library(ggmap)

coordinates <- geocode(as.character(location_times$location))
coordinates_i <- cbind(location_times, coordinates)

error_locations <- coordinates_i[!complete.cases(coordinates_i),]

coordinates_j <- coordinates_i[complete.cases(coordinates),]

library(leaflet)


leaflet(data = coordinates_j) %>% addTiles() %>%
  addCircleMarkers(~lon, ~lat, radius = ~ocurrences/10,
                   popup = ~paste(location,":", ocurrences))


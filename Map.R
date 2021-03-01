library(tigris)
library(dplyr)
library(leaflet)
library(sp)
library(ggmap)
library(maptools)
library(broom)
library(httr)
library(rgdal)

r <- GET('http://data.beta.nyc//dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson')
nyc_neighborhoods <- readOGR(content(r,'text'), 'OGRGeoJSON', verbose = F)
nyc_neighborhoods_df <- tidy(nyc_neighborhoods)
nyc_neighborhoods_df$long <-round(nyc_neighborhoods_df$long,digits=5)
nyc_neighborhoods_df$lat <-round(nyc_neighborhoods_df$lat,digits=5)
nyc_neighborhoods_df$merge <-paste(nyc_neighborhoods_df$long,nyc_neighborhoods_df$lat)
write.csv(points,file="ddiiiif.csv")
fm$merge <-paste(fm$longitude,fm$latitude)
rrr <- merge(nyc_neighborhoods_df,fm,by="merge")
ggplot() + 
  geom_polygon(data=nyc_neighborhoods_df, aes(x=long, y=lat, group=group))+geom_point(data=map_data, aes(x=lng, y=lat), color="red")
ggplot() +  
  geom_polygon(data=nyc_neighborhoods_df, aes(x=long, y=lat, group=group), fill="grey40", 
               colour="grey90", alpha=1)+
  labs(x="", y="", title="311 Calls in NYC")+ #labels
  theme(axis.ticks.y = element_blank(),axis.text.y = element_blank(), # get rid of x ticks/text
        axis.ticks.x = element_blank(),axis.text.x = element_blank(), # get rid of y ticks/text
        plot.title = element_text(lineheight=.8, face="bold", vjust=1))+ # make title bold and add space
  geom_point(aes(x=lng, y=lat, color=X.2), data=map_data, alpha=1, size=3, color="grey20")+# to get outline
  geom_point(aes(x=lng, y=lat, color=X.2), data=map_data, alpha=1, size=2)+
  scale_colour_gradientn("Number of 311 Calls", 
                         colours=c( "#f9f3c2","#660000"))+ # change color scale
  coord_equal(ratio=1)


leaflet(nyc_neighborhoods) %>%
  addTiles() %>% 
  addPolygons(popup = ~neighborhood) %>%
  addProviderTiles("CartoDB.Positron")
ddf <-as.data.frame(nyc_neighborhoods@data)

set.seed(42)
lats <- fm$Latitude
lngs <- fm$Longitude
points <- data.frame(lat=lats, lng=lngs)
points
points_spdf <- points

points_spdf <-na.omit(points_spdf)
coordinates(points_spdf) <- ~lng + lat
proj4string(points_spdf) <- proj4string(nyc_neighborhoods)
matches <- over(points_spdf, nyc_neighborhoods)
points <- cbind(points, matches)
points
points <-read.csv("correct.csv")

map_data <- as.data.frame(geo_join(nyc_neighborhoods, points, "neighborhood", "neighborhood"))

map_data1 <-fortify(map_data)

map_data <-na.omit(map_data1)

ggplot() +  
  geom_polygon(data=nyc_neighborhoods_df, aes(x=long, y=lat, group=group), fill="grey40", 
               colour="grey90", alpha=1)+
  labs(x="", y="", title="311 Calls in NYC")+ #labels
  theme(axis.ticks.y = element_blank(),axis.text.y = element_blank(), # get rid of x ticks/text
        axis.ticks.x = element_blank(),axis.text.x = element_blank(), # get rid of y ticks/text
        plot.title = element_text(lineheight=.8, face="bold", vjust=1))+ # make title bold and add space
  geom_point(aes(x=lng, y=lat, color=X.2), data=map_data, alpha=1, size=3, color="grey20")+# to get outline
  geom_point(aes(x=lng, y=lat, color=X.2), data=map_data, alpha=1, size=2)+
  scale_colour_gradientn("Number of 311 Calls", 
                         colours=c( "#f9f3c2","#660000"))+ # change color scale
  coord_equal(ratio=1)



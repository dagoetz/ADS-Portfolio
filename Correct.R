library(tigris)
library(dplyr)
library(leaflet)
library(sp)
library(ggmap)
library(maptools)
library(broom)
library(httr)
library(rgdal)
plot(nyc_tracts)
lookup_code("New York", "New York")
nyc_tracts <- tracts(state = '36', county = c('061','047','081','005','085'))

summary(nyc_tracts)
plot(nyc_tracts)
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
lats <- fm$latitude
lngs <- fm$longitude
points <- data.frame(lat=lats, lng=lngs)
points
points_spdf <- points
coordinates(points_spdf) <- ~lng + lat
proj4string(points_spdf) <- proj4string(nyc_neighborhoods)
matches <- over(points_spdf, nyc_neighborhoods)
points <- cbind(points, matches)
points
points <-read.csv("correct.csv")
leaflet(nyc_neighborhoods) %>%
  addTiles() %>% 
  addPolygons(popup = ~neighborhood) %>% 
  addMarkers(~lng, ~lat, popup = ~neighborhood, data = points) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-73.98, 40.75, zoom = 13)

points_by_neighborhood <- aggregate(points$X.2, list(points$neighborhood), FUN=sum)

map_data <- as.data.frame(geo_join(nyc_neighborhoods, points, "neighborhood", "neighborhood"))
points_by_neighborhood$
pal <- colorNumeric(palette = "RdBu",
                    domain = range(map_data@data$num_points, na.rm=T))

leaflet(map_data) %>%
  addTiles() %>% 
  addPolygons(fillColor = ~pal(num_points), popup = ~neighborhood) %>% 
  addMarkers(~lng, ~lat, popup = ~neighborhood, data = points) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-73.98, 40.75, zoom = 13)

plot_data <- tidy(nyc_neighborhoods, region="neighborhood") %>%
  left_join(., points_by_neighborhood, by=c("id"="neighborhood")) %>%
  filter(!is.na(num_points))

manhattan_map <- get_map(location = c(lon = -74.00, lat = 40.77), maptype = "terrain", zoom = 12)


leaflet(map_data) %>%
  addTiles() %>% 
  addPolygons(fillColor =points$X.2, popup = ~neighborhood) %>% 
  addMarkers(~lng, ~lat, popup = ~neighborhood, data = points) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-73.98, 40.75, zoom = 13)
map_data$group <-.1
ggplot() + 
  geom_polygon(data=map_data1, aes(x=map_data1$lng, y=map_data1$lat, group=map_data1$group))
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



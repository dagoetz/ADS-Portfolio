library(zipcode)
library(tidyverse)
library(maps)
library(viridis)
library(ggthemes)
devtools::install_github("hrbrmstr/albersusa")
library(albersusa)
fm<-Export <- read_csv("311.csv")#the file we just downloaded
data(zipcode)

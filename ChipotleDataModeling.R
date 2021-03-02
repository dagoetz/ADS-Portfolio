library(lmtest)
library(tidyverse)
library(sandwich)
library(car)
library(dplyr)
library(visreg)
library(caret)

cities <- read.csv("uscities (4).csv")
cities$ratio <-cities$rent_median/cities$income_household_median
cities <-cities %>%
  filter(population>25000)
chipotle <- read.csv("uscities (4).csv")

###data cleaning and preprocessing
summary(chipotle)
str(chipotle)

norm_min_max <-function(x) { 
  ( x - min(x) ) / ( max(x) - min(x) )
}

#getting rid of NA and filtering based on 1st quartile pop
chipotle<-chipotle%>%filter(income_household_median!="NA's",
                            male!="NA's",
                            family_size!="NA's",
                            unemployment_rate!="NA's",
                            home_value!="NA's",
                            rent_median!="NA's",
                            population_proper>=601)

##for KNN later
chipotleKNN<-chipotle
#finding high percentile for population and median income
quantile(chipotleKNN$population_proper,probs=.99)
quantile(chipotleKNN$income_household_median,probs=.90)
chipotleKNN<-chipotleKNN%>%mutate(population_proper=ifelse(population_proper>=146697,146697,population_proper),
                                  income_household_median=ifelse(income_household_median>=95345.2,95245.2,income_household_median))

###demographics regression - City
CityPredict<-lm(count_of_chipotle_city_August ~ age_median+income_household_median+population_proper+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple,data=chipotle)
summary(CityPredict)

correctCitypredictions<-predict.lm(CityPredict,chipotle)
chipotle$PredictedCityLocations <- correctCitypredictions
chipotle$PredictedCityDifference<-chipotle$count_of_chipotle_city_August-chipotle$PredictedCityLocations
chipotle[which.max(chipotle$PredictedCityDifference),]


plot(chipotle$PredictedCityLocations,chipotle$count_of_chipotle_city_August,ylab="Number of Locations",xlab="Number of Predicted Locations",main="All US Cities")
reg<-lm(PredictedCityLocations~count_of_chipotle_city_August,data=chipotle)
abline(reg,col="blue")


ggplot(chipotle, aes(x=population, y=PredictedCityLocations))+geom_point(col="steelblue",size=3)+
  geom_smooth(method="lm",col="firebrick",size=2)+
  ggtitle("Population Vs. Number of Locations",subtitle = "from chipotle dataset")+xlab("population")+ylab("number of locations")



mean(chipotle$PredictedCityDifference[chipotle$PredictedCityDifference>0])
#when difference >0, over guess by .224 locations

mean(chipotle$PredictedCityDifference[chipotle$PredictedCityDifference<0])
#when difference <0, under guess by .126 locations

##only cities with 1 or more predicted locations
chipotleLarge<-chipotle%>%filter(PredictedCityLocations>=1)
plot(chipotleLarge$PredictedCityLocations,chipotleLarge$count_of_chipotle_city_August,ylab="Number of Locations",xlab="Number of Predicted Locations",main="Cities With 1 or More Predicted Locations")
reg<-lm(PredictedCityLocations~count_of_chipotle_city_August,data=chipotleLarge)
abline(reg,col="blue")

mean(chipotleLarge$PredictedCityDifference[chipotleLarge$PredictedCityDifference>0])
#when difference >0, over guess by 2.434 locations

mean(chipotleLarge$PredictedCityDifference[chipotleLarge$PredictedCityDifference<0])
#when difference <0, under guess by 1.104 locations

###logit regression
chipotleKNN$count_of_chipotle_city_August<-ifelse(chipotleKNN$count_of_chipotle_city_August>0,1,0)
CityPredictLogit<-glm(count_of_chipotle_city_August ~ age_median+income_household_median+population_proper+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple,data=chipotleKNN,family="binomial")
summary(CityPredictLogit)

correctCitypredictionsLogit<-predict.glm(CityPredictLogit,chipotleKNN,type="response")
chipotleKNN$PredictedCityLocationsLogit <- correctCitypredictionsLogit
chipotleKNN$PredictedCityDifferenceLogit<-chipotleKNN$count_of_chipotle_city_August-chipotleKNN$PredictedCityLocationsLogit

#cities with a population of around 70k, we expect them to have one
visreg(CityPredictLogit,"population_proper",gg=T,scale="response")
ggplot(chipotleKNN, aes(x=income_household_median, y=PredictedCityLocationsLogit))+geom_point(col="steelblue",size=3)+
  geom_smooth(method="lm",col="firebrick",size=2)+
  ggtitle("Population Vs. Number of Locations",subtitle = "from chipotle dataset")+xlab("population")+ylab("number of locations")


data.frame(chipotleKNN$PredictedCityLocationsLogit[chipotleKNN$PredictedCityLocationsLogit>=.5])
#766 cities are expected to have a 50% chance or greater to have 1 location or more
#1066 cities actually have a location

###exploring wrong predictions
chipotleFalsePos<-chipotleKNN%>%filter(PredictedCityLocationsLogit>=.5 & count_of_chipotle_city_August==0)
chipotleFalseNeg<-chipotleKNN%>%filter(PredictedCityLocationsLogit<=.5 & count_of_chipotle_city_August==1)
chipotleTotalFalse<-rbind(chipotleFalseNeg,chipotleFalsePos)

CityPredictLogitNoPop<-glm(count_of_chipotle_city_August ~ age_median+income_household_median+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple,data=chipotleTotalFalse,family="binomial")
summary(CityPredictLogitNoPop)

correctCitypredictionsLogitNoPop<-predict.glm(CityPredictLogitNoPop,chipotleTotalFalse,type="response")
chipotleTotalFalse$PredictedCityLocationsLogitNoPop <- correctCitypredictionsLogitNoPop
chipotleTotalFalse$PredictedCityDifferenceLogitNoPop<-chipotleTotalFalse$count_of_chipotle_city_August-chipotleTotalFalse$PredictedCityLocationsLogitNoPop

chipotleFalsePosNoPop<-chipotleTotalFalse%>%filter(PredictedCityLocationsLogitNoPop>=.5 & count_of_chipotle_city_August==0)
chipotleFalseNegNoPop<-chipotleTotalFalse%>%filter(PredictedCityLocationsLogitNoPop<=.5 & count_of_chipotle_city_August==1)
chipotleTotalFalseNoPop<-rbind(chipotleFalseNegNoPop,chipotleFalsePosNoPop)
chipotleTotalFalseNoPop

chipotleKNN$Nopop <-predict.glm(CityPredictLogitNoPop,chipotleKNN,type="response")
data.frame(chipotleKNN$Nopop[chipotleKNN$Nopop>=.5])
###KNN


set.seed(44)

chipotleKNN$count_of_chipotle_city_August <- as.factor(chipotleKNN$count_of_chipotle_city_August)


Training <- createDataPartition(chipotleKNN$count_of_chipotle_city_August, p = .90, list = FALSE)
# Extracting the labels from our test and train datasets
train <- chipotleKNN[Training, ]
test  <- chipotleKNN[-Training, ]

train_category <- chipotleKNN[Training, 44]
test_category <- chipotleKNN[-Training, 44]


# Setting our model parameters and creating our model
ctrl <- trainControl(method="repeatedcv",
                     repeats = 3)

knn <- train(count_of_chipotle_city_August ~age_median+income_household_median+population_proper+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple, 
             data = train, 
             method = "knn", 
             trControl = ctrl, 
             tuneLength = 10)
##Took a long time run 

knn

plot(knn)
##From the nearest neighbor plot it looks like about 79 for an accuracy of 79.2% was the best model


# Generating predictions on the test data        
knnPredict <- predict(knn,
                      newdata = test )


#Get the confusion matrix to see accuracy value and other parameter values
confusionMatrix(knnPredict, 
                test_category)

########KNN #2
ctrl <- trainControl(method="cv")

knn2 <- train(count_of_chipotle_city_August ~age_median+income_household_median+population_proper+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple, 
             data = train, 
             method = "knn", 
             trControl = ctrl, 
             tuneLength = 10)
##Took a long time run 

knn2

plot(knn2)
      
knnPredict2 <- predict(knn2,
                      newdata = test )



confusionMatrix(knnPredict2, 
                test_category)

##Accuracy with the cross-validation is a little lower than the one with repeated cross-validation.

#####KNN #3
ctrl <- trainControl(method="cv")

knn3 <- train(count_of_chipotle_city_August ~age_median+income_household_median+population_proper+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_asian+race_native+race_pacific+race_multiple, 
              data = train, 
              method = "knn", 
              trControl = ctrl, 
              tuneLength = 25)
 

knn3

plot(knn3)

knnPredict3 <- predict(knn3,
                       newdata = test )



confusionMatrix(knnPredict3, 
                test_category)
###This accuracy was the worst out of the three that we ran.


#######Clustering

library(factoextra)
library(NbClust)
str(chipotleKNN)
chipotleKNN$count_of_chipotle_city_August <- as.numeric(chipotleKNN$count_of_chipotle_city_August)
chipotleKNN$count_of_chipotle_city_August <- ifelse(chipotleKNN$count_of_chipotle_city_August>1,1,0)

chipotleKMeans <- chipotleKNN %>%
  select(city,state_id,age_median,income_household_median,population_proper,male,family_size,
           education_college_or_above,unemployment_rate,race_white,race_black,race_asian,race_native,race_pacific,race_multiple,
         count_of_chipotle_city_August)%>%
  mutate(count_of_chipotle_city_August=as.numeric(count_of_chipotle_city_August))

rownames(chipotleKMeans)<-paste(chipotleKMeans$city,", ",chipotleKMeans$state_id)
chipotleKMeans<-chipotleKMeans[,3:16]
str(chipotleKMeans)
fviz_nbclust(chipotleKMeans, kmeans,method="wss")
#The amount of clusters that is needed according to the graph.
clusters <-chipotleKMeans%>%
  kmeans(centers = 5, nstart = 25)
clusters

table(clusters$cluster)
Combine <- cbind(chipotleKMeans, cluster = clusters$cluster)
table(Combine$cluster,Combine$count_of_chipotle_city_August)

Combine$c_distance <- (sqrt(rowSums(chipotleKMeans - fitted(clusters)) ^ 2))
Combine$name <- rownames(Combine)
Combine_1<-Combine %>% group_by(cluster) %>% mutate(centroid = ifelse(c_distance==min(c_distance),name,'')) %>% ungroup()

library(ggplot2)
library(ggrepel)
pd <- fviz_cluster(clusters,data=chipotleKMeans,geom="point")
pd$data$name <-Combine_1$centroid
pd+geom_text_repel(aes(x,y,label=name,size=14,color=cluster,fontface="bold"),show.legend=FALSE)+theme_bw()+theme(plot.title=element_blank())



library(DescTools)
chipotleKMeans$age_median <-Winsorize(chipotleKMeans$age_median,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
          na.rm = FALSE)
chipotleKMeans$male <-Winsorize(chipotleKMeans$male,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$family_size <-Winsorize(chipotleKMeans$family_size,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$education_college_or_above <-Winsorize(chipotleKMeans$education_college_or_above,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$unemployment_rate <-Winsorize(chipotleKMeans$unemployment_rate,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_white<-Winsorize(chipotleKMeans$race_white,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_black <-Winsorize(chipotleKMeans$race_black,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_multiple <-Winsorize(chipotleKMeans$race_multiple,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_asian <-Winsorize(chipotleKMeans$race_asian,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_native <-Winsorize(chipotleKMeans$race_native,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                      na.rm = FALSE)
chipotleKMeans$race_pacific <-Winsorize(chipotleKMeans$race_pacific,minval = NULL, maxval = NULL, probs = c(0.05, 0.99),
                                       na.rm = FALSE)
clusters <-chipotleKMeans%>%
  kmeans(centers = 5,nstart=50)
clusters

table(clusters$cluster)
Combine <- cbind(chipotleKMeans, cluster = clusters$cluster)
table(Combine$cluster,Combine$count_of_chipotle_city_August)

Combine$c_distance <- (sqrt(rowSums(chipotleKMeans - fitted(clusters)) ^ 2))
Combine$name <- rownames(Combine)
Combine_1<-Combine %>% group_by(cluster) %>% mutate(centroid = ifelse(c_distance==min(c_distance),name,'')) %>% ungroup()

library(ggplot2)
library(ggrepel)
pd <- fviz_cluster(clusters,data=chipotleKMeans,geom="point")
pd$data$name <-Combine_1$centroid
pd+geom_text_repel(aes(x,y,label=name,size=14,color="black",fontface="bold"),show.legend=FALSE)+theme_bw()+theme(plot.title=element_blank())


#####Decision Tree
chipotle_trained <- train(count_of_chipotle_city_August ~age_median+income_household_median+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_native+race_pacific+race_multiple,
                          data = train,
                          method = "rpart",
                          trControl = trainControl(method = "repeatedcv",
                                                   number = 10,
                                                   repeats = 10))
chipotle_trained


test_v2 <- test %>% select(-c(count_of_chipotle_city_August))

chipotle_predictions <- chipotle_trained %>% predict(test_v2)
pred <- table(chipotle_predictions, test$count_of_chipotle_city_August)
pred

sum(diag(pred))/sum(pred)


library(rpart.plot)
library(rattle)

prp(chipotle_trained$finalModel, 
    faclen = 0, 
    cex = 0.8, 
    extra = 1)

set.seed(139)
library(rpart)
tree_1 <- rpart(count_of_chipotle_city_August~age_median+income_household_median+male+family_size+education_college_or_above+unemployment_rate+race_white+race_black+race_native+race_asian,
                data = train, 
                control = rpart.control(cp = 0.003, minbucket = 350,minsplit = 25))

prp(tree_1, 
    faclen = 0, 
    cex = 0.8, 
    extra = 1) 

conf_matrix_1 <- table(train$count_of_chipotle_city_August,
                       predict(tree_1,
                               type="class"))

sum(diag(conf_matrix_1))/sum(conf_matrix_1)



summary(train)

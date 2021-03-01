library(dplyr)
library(readr)
fm<-Export <- read_csv("311.csv")
data(zipcode)

target <- c("Driveway","Noise","Parking","Derelict Vehicle","Animal","Homeless","Traffic","Vending","Drinking")
fm1 <-fm%>%
  filter(`Complaint Type` %in% target)%>%
  group_by(`Complaint Type`,Borough) %>%
  summarise(ResponseTime=mean(ResponseTime))
fm1
po <- ggplot(fm1, aes(x=ResponseTime, y=`Complaint Type`,fill=Borough)) + 
 geom_bar(stat="identity")+ xlab("Response Time in Minutes")
po

pop <- ggplot(fm1, aes(x=ResponseTime, y=`Complaint Type`)) + 
  geom_bar(stat="identity", col="blue",fill="yellow")
pop


fm<-Export <- read_csv("311.csv")#the file we just downloaded
police <- aggregate(fm$ResponseTime, list(fm$`Complaint Type`), FUN=mean)
police
police <- police[c(8,13,15,5,2,11,18,20,7),]
police
popo <- ggplot(police, aes(x=Group.1, y=x,fill="blue")) + 
  geom_bar(stat="identity")
popo

noise_complaints<-Export <- read_csv("311.csv")#the file we just downloaded
noise_complaints$`Created Date` <- as.POSIXct(strptime(noise_complaints$`Created Date`, "%m/%d/%y %H:%M"))
#noise_complaints$Weekday <- weekdays(noise_complaints$`Created Date`)
noise_complaints$Hour <- format(noise_complaints$`Created Date`, "%H")
$noise_complaints$Weekday <- factor(noise_complaints$Weekday, 
                                   levels = c("Monday", "Tuesday", "Wednesday",
                                              "Thursday", "Friday", "Saturday", "Sunday"))
target <- c("Driveway","Noise","Parking","Derelict Vehicle")
noise_sum1 <- noise_complaints %>% group_by(`Complaint Type`, Hour) %>%
  filter(`Complaint Type` %in% target) %>%
  summarise(Count = n())
noise_sum1
p1 <- ggplot(noise_sum1) +
  geom_freqpoly(aes(x= as.numeric(Hour),y = Count, color = noise_sum1$`Complaint Type`), stat = "identity") +xlab("Hour") + ylab("Number of Complaints") + ggtitle("Number of Noise Complaints vs Hour")  + scale_x_continuous(breaks = c(0:23)) 
p1 


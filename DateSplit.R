install.packages("readr")
install.packages("splitstackshape")
library(readr)
fm<-Export <- read_csv("311.csv")#the file we just downloaded
library(splitstackshape)
fm <-cSplit(fm, "Created Date", sep=" ", type.convert=FALSE)
#month(as.POSIXlt(some_date, format="%d/%m/%y"))
fm$`Created Date_1`<- as.Date(fm$`Created Date_1`, format="%d/%m/%y")
fm$month <- months(fm$Date)
fm$months <- month.abb[fm$`Created Date_1`]


x = c("January", "February", "March", "April","May","June","July","August", "September","October","November","December") 
x_fac = factor(x, levels = month.name)

df <-fm%>%
  group_by(month,Borough) %>%
  summarise(total=n())
df



df$month <- factor(df$month,levels = c("January", "February", "March", "April","May","June","July","August", "September","October","November","December"))
df

popp <- ggplot(df, aes(x=month, y=total,fill=Borough)) + 
  geom_bar(stat="identity") + ggtitle("Number of Complaints Per Month by Borough")
popp



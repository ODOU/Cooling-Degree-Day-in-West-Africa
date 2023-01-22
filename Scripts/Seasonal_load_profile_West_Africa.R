# Load packages
library(fpp2)
library(xts)
library(lubridate)
library(timetk)
library(dplyr)
library(Cairo)
library(lubridate)
library(tidyverse)
library(readxl)
library(writexl)
library(tidyr)
library(imputeTS)# Load packages - Fill missing data
rm(list = ls())

# Import load data by country

Benin=read.csv("../Load_data/BENIN_DATA_COMPLETE_DAILY.csv", row.names=1)
CIV= read.csv("../Load_data/CIV_DATA_COMPLETE_DAILY.csv", row.names=1)
NIG=read.csv("../Load_data/Niger_DATA_COMPLETE_DAILY.csv", row.names=1)
SEN=read.csv("../Load_data/SEN_DATA_COMPLETE_DAILY.csv", row.names=1)
TG=read.csv("../Load_data/TOGO_DATA_COMPLETE_DAILY.csv", row.names=1)
Burkina<- read_excel('../Load_data/Burkina_Faso_SONABEL_demand_era.xlsx',sheet = 'Sheet1')
tim=seq(as.POSIXct('2018-01-01'),as.POSIXct('2018-12-31 23:00:00'), by="hour")
Burkina$Date=tim
Burkina$Month=format(Burkina$Date,"%B")


range(Benin$Load_Benin/1000)
range(CIV$Load/1000)
range(NIG$Load/1000)
range(SEN$Load/1000000)
range(TG$Load_Togo/1000)



## Monthly mean

# Boxplot of load over time series


# ------------------------Multiplot ---------------
CairoPNG(file="../cdd_output/Figures/Figures/Figure4_Mutiplot_load_countries_temperature.png",bg = "transparent",width=700, height =750,res=100)

par(family = "B",par(mfrow=c(6,2)),mar = c(3,4,1.5,3))

boxplot(Benin$Load_Benin/1000~ month(Benin$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal load profile - Benin")
monmean_bn= Benin %>% group_by(Month)%>% 
  summarise(Load=mean(Load_Benin,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_bn$Load/1000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_bn$Load/1000)),las=2)
box()
mtext("GWh", side=2, line=2.5, font=2)


boxplot(Benin$temp ~ month(Benin$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal temperature profile - Benin",ylim=c(15,45))
monmean_bn= Benin %>% group_by(Month)%>% 
  summarise(temp=mean(temp,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_bn$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_bn$temp)),las=2)
box()
mtext("Deg C ", side=4, line=1, font=2)


boxplot(TG$Load_Togo/1000~ month(TG$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal Load profile - Togo")
monmean_tg= TG %>% group_by(Month)%>% 
  summarise(Load=mean(Load_Togo,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_tg$Load/1000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_tg$Load/1000)),las=2)
box()
mtext("GWh ", side=2, line=2.5, font=2)


boxplot(TG$temp~ month(TG$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal temperature profile - Togo",ylim=c(15,45))
monmean_tg= TG %>% group_by(Month)%>% 
  summarise(temp=mean(temp,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_tg$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_tg$temp)),las=2)
box()
mtext("", side=4, line=3, font=2)


boxplot(CIV$Load/1000~ month(CIV$Date),axes=FALSE,ylab="", xlab="Months",
        main="Seasonal load profile - Cote d'Ivoire")
monmean_CIV= CIV %>% group_by(Month)%>% 
  summarise(Load=mean(Load,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_CIV$Load/1000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_CIV$Load/1000)),las=2);
box()
mtext(" GWh ", side=2, line=2.5, font=2)


boxplot(CIV$temp ~ month(CIV$Date),axes=FALSE,ylab="", xlab="Months",
        main="Seasonal temperature profile - Cote d'Ivoire",ylim=c(15,45))
monmean_CIV= CIV %>% group_by(Month)%>% 
  summarise(temp=mean(temp,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_CIV$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_CIV$temp)),las=2);
box()
mtext("", side=4, line=3, font=2)



boxplot(NIG$Load/1000~ month(NIG$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal load profile - Niger")
monmean_nig= NIG %>% group_by(Month)%>% 
  summarise(Load=mean(Load,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_nig$Load/1000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_nig$Load/1000)),las=2)
box()
mtext(" GWh ", side=2, line=2.5, font=2)


boxplot(NIG$temp~ month(NIG$Date),axes=FALSE,ylab="", xlab="Months",
        main="Seasonal temperature profile - Niger",ylim=c(15,45))
monmean_nig= NIG %>% group_by(Month)%>% 
  summarise(temp=mean(temp,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_nig$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_nig$temp)),las=2)
box()
mtext("", side=4, line=3, font=2)


boxplot(Burkina$`Load (MW)`/1000~ month(Burkina$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal load profile - Burkina Faso")
monmean_BF= Burkina %>% group_by(Month)%>% 
  summarise(Load=mean(`Load (MW)`,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_BF$Load/1000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels =rep("",12),las=3.5)
axis(2,t = round(pretty(range(monmean_BF$Load/1000)),1),las=2)
box()
mtext(" GW ", side=2, line=2.5, font=2)

boxplot(Burkina$`Air Temp`~ month(Burkina$Date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal temperature profile - Burkina Faso",ylim=c(15,45))
monmean_BF= Burkina %>% group_by(Month)%>% 
  summarise(temp=mean(`Air Temp`,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_BF$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = rep("",12),las=3.5)
axis(2,t = pretty(range(monmean_BF$temp)),las=2)
box()
mtext("", side=4, line=3, font=2)


boxplot(SEN$Load/1000000~ month(SEN$date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal load profile - Senegal")
monmean_SEN= SEN %>% group_by(Month)%>% 
  summarise(Load=mean(Load,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_SEN$Load/1000000,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = month.abb,las=3.5)
axis(2,t = pretty(range(monmean_SEN$Load/1000000)),las=2)
box()
mtext("GWh", side=2, line=2.5, font=2)

boxplot(SEN$temp~ month(SEN$date),axes=FALSE,ylab=" ", xlab="Months",
        main="Seasonal temperature profile - Senegal",ylim=c(15,45))
monmean_SEN= SEN %>% group_by(Month)%>% 
  summarise(temp=mean(temp,na.rm = TRUE))%>% arrange(match(Month,month.name))
lines(1:12,monmean_SEN$temp,col="#ff7f00",lwd=2)
axis(1,at=c(1:12),labels = month.abb,las=3.5)
axis(2,t = pretty(range(monmean_SEN$temp)),las=2)
box()
mtext("Deg C", side=4, line=1, font=2)

dev.off()


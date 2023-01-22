# Import packages
rm(list = ls())
library(tibble)
library(dplyr)
library(prophet)
library(forecast)
library(stats)
require(graphics)
library(dpseg)
library(segmented)
library(readxl)
library(tidyr)
library(lubridate)
library(xts)
library(readxl)
library(imputeTS)
library(skimr)
library(biwavelet)
library(ggplot2)
library(cowplot)
library(gridGraphics)
library(ggplottimeseries) # devtools:: install_github("brisneve/ggplottimeseries")
library(ggpubr)


# Import consolidated data ---------------------
Niger=as_tibble(read.csv('../Load_data/Niger_DATA_COMPLETE_DAILY.csv',row.names=1))
BTG = as_tibble(read.csv('../Load_data/BENIN_TOGO_DATA_COMPLETE_DAILY.csv'))
Burkina_daily=as_tibble(read.csv('../Load_data/Burkina_DATA_COMPLETE_DAILY.csv',row.names=1))
CIV<-as_tibble(read.csv('../Load_data/CIV_DATA_COMPLETE_DAILY.csv',row.names=1))
SEN<-as_tibble(read.csv('../Load_data/SEN_DATA_COMPLETE_DAILY.csv',row.names=1))

#----------------------------------------------------------------------------#

## Use prophet library to decompose the trend
my_plot.decomposed.ts = function(x, title="", ...) {
  xx <- x$x
  if (is.null(xx)) 
    xx <- with(x, if (type == "additive") 
      random + trend + seasonal
      else random * trend * seasonal)
  plot(cbind(observed = xx, trend = x$trend, seasonal = x$seasonal, random = x$random), 
       main=title, ...)
}


## Niger decomposition and base temperature calculation --------------
## Niger Hourly format case 

fit_ts_daily <- msts(Niger$Load, seasonal.periods=c(7,365),start=2017)
ts_decompose_daily=decompose(fit_ts_daily,type="multiplicative")



## plot the obs ts, trend & seasonal effect
dat_niger_daily=data.frame(load=ts_decompose_daily$seasonal,Temp=Niger$temp)
lm_dt_daily = lm(load ~ Temp, dat_niger_daily)
(seg_lm_daily<- segmented(lm_dt_daily,npsi = 3))


xx <- dat_niger_daily$Temp
yy <- dat_niger_daily$load
dati= data.frame (x = xx, y = yy)
dat2 = data.frame(Temp = xx, load = broken.line(seg_lm_daily)$fit)
p1=ggplot(dat_niger_daily, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() +
  stat_smooth() + labs(title = 'mnnn')+xlab('dd')

my.lines <- seg_lm_daily$psi[, 2][1]

p1=ggplot(dat_niger_daily, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() + labs(title = 'Breakpoint detection')+
  geom_vline(xintercept = my.lines, linetype = "dashed")+
  ylab("Seasonal factor of load")+stat_smooth(linetype=0)

p2=ggplot2::autoplot(ts_decompose_daily, main='Load decomposition Niger') + theme_bw()


figure <- ggarrange(p2, p1,ncol = 2)
png(filename ="../cdd_output/Figures/Niger_decompose_breakpoints.png",width =600, height =300,res =90,
    type = "cairo",bg = "transparent")
figure
dev.off()

#----------------------------------------------------#


#------------------------------------------------------------------

## Benin and Togo base temperature computation ---------------------
fit_ts <- msts(BTG$Elec_conso, seasonal.periods=c(7,365),start=2010)
ts_decompose=decompose(fit_ts,type="multiplicative")
seas_load=ts_decompose$seasonal
dat_BN_TG=data.frame(load=seas_load,Temp=BTG$temp)

# Segmeted approach ----------------------------------------
lm_dt= lm(load ~ Temp, dat_BN_TG)
seg_lm <- segmented(lm_dt)
slope(seg_lm)

xx <- dat_BN_TG$Temp
yy <- dat_BN_TG$load
dati= data.frame (x = xx, y = yy)
dat2 = data.frame(Temp = xx, load = broken.line(seg_lm)$fit)


my.lines <- seg_lm$psi[, 2][1]

p1=ggplot(dat_BN_TG, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() + labs(title = 'Breakpoint detection')+
  geom_vline(xintercept = my.lines, linetype = "dashed")+
  ylab("Seasonal factor of load")+stat_smooth(linetype=0)

p2=ggplot2::autoplot(ts_decompose, main='Load decomposition') + theme_bw()


figure <- ggarrange(p2, p1,ncol = 2)
png(filename ="../cdd_output/Figures/Benin_Togo_decompose_breakpoints.png",width =600, height =300,res =90,
    type = "cairo",bg = "transparent")
figure
dev.off()


#-------------------------------------------------------------------------#

#----------------------------------------------------------------------#

#--------------------------------------------------------------------------

## Burkina Faso -------------------------------------------------------------------
fit_ts <- msts(Burkina_daily$Load,seasonal.periods=c(7))
ts_decompose=decompose(fit_ts,type="multiplicative")

seas_load=ts_decompose$seasonal
dat_bf=data.frame(load=seas_load,Temp=Burkina_daily$Temp)
# Segmeted approach ----------------------------------------
lm_dt= lm(load ~ Temp,dat_bf)
seg_lm <- segmented(lm_dt)
seg_lm
slope(seg_lm)
#----------------------------------------------------#


xx <- dat_bf$Temp
yy <- dat_bf$load
dati= data.frame (x = xx, y = yy)
dat2 = data.frame(Temp = xx, load = broken.line(seg_lm)$fit)


my.lines <- seg_lm$psi[, 2][1]

p1=ggplot(dat_bf, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() + labs(title = 'Breakpoint detection')+
  geom_vline(xintercept = my.lines, linetype = "dashed")+
  ylab("Seasonal factor of load")+stat_smooth(linetype=0)

p2=ggplot2::autoplot(ts_decompose, main='Load decomposition') + theme_bw()


figure <- ggarrange(p2, p1,ncol = 2)
png(filename ="../cdd_output/Figures/Burkina_decompose_breakpoints.png",width =600, height =300,res =90,
    type = "cairo",bg = "transparent")
figure
dev.off()

#----------------------------------------------------------------------#

#-------------------------------------------------------------------------#



## Cote d'Ivoire decompositon and base temperature calculation --------------
fit_ts <- msts(CIV$Load, seasonal.periods=c(7,365),start=2017)
ts_decompose=decompose(fit_ts,type="multiplicative")


seas_load=ts_decompose$seasonal
dat_civ=data.frame(load=seas_load,Temp=CIV$temp)

# Segmeted approach ------------------
lm_dt= lm(load ~ Temp,dat_civ)
seg_lm <- segmented(lm_dt,npsi=5)
seg_lm
slope(seg_lm)

#----------------------------------------------------------------------#
xx <- dat_civ$Temp
yy <- dat_civ$load
dati= data.frame (x = xx, y = yy)
dat2 = data.frame(Temp = xx, load = broken.line(seg_lm)$fit)
my.lines <- seg_lm$psi[, 2][1]

p1=ggplot(dat_civ, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() + labs(title = 'Breakpoint detection')+
  geom_vline(xintercept = my.lines, linetype = "dashed")+
  ylab("Seasonal factor of load")+stat_smooth(linetype=0)

p2=ggplot2::autoplot(ts_decompose, main='Load decomposition') + theme_bw()


figure <- ggarrange(p2, p1,ncol = 2)
png(filename ="../cdd_output/Figures/Ivory_Coast_decompose_breakpoints.png",width =600, height =300,res =90,
    type = "cairo",bg = "transparent")
figure
dev.off()
#------------------------------------------------------------------------------#

#-----------------------------------------------------------------------------


## Senegal decompositon and base temperature calculation -----------------------------------
fit_ts <- msts(SEN$Load, seasonal.periods=c(7,365),start=2017)
ts_decompose=decompose(fit_ts,type="multiplicative")
seas_load=ts_decompose$seasonal
dat_sen=data.frame(load=seas_load,Temp=SEN$temp)

# Segmeted approach ------------------
lm_dt= lm(load ~ Temp,dat_sen)
seg_lm <- segmented(lm_dt,npsi=5)
seg_lm
slope(seg_lm)
summary(seg_lm)

xx <- dat_sen$Temp
yy <- dat_sen$load
dati= data.frame (x = xx, y = yy)
dat2 = data.frame(Temp = xx, load = broken.line(seg_lm)$fit)
my.lines <- seg_lm$psi[, 2][1]

p1=ggplot(dat_sen, aes(x =Temp, y= load)) +
  geom_line(data = dat2, color = 'black',size=0.8)+ theme_bw() + labs(title = 'Breakpoint detection')+
  geom_vline(xintercept = my.lines, linetype = "dashed")+
  ylab("Seasonal factor of load")+stat_smooth(linetype=0)

p2=ggplot2::autoplot(ts_decompose, main='Load decomposition') + theme_bw()


figure <- ggarrange(p2, p1,ncol = 2)
figure
png(filename ="../cdd_output/Figures/Senegal_decompose_breakpoints.png",width =600, height =300,res =90,
    type = "cairo",bg = "transparent")
figure
dev.off()


#-------------------------------------------------------------------------------#


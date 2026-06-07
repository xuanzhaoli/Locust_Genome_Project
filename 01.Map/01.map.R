#setwd("D:/Rbook/locust")
library(raster)
library(ggplot2)

#https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_2.5m_elev.zip
elevation_world <- getData('worldclim', var='alt', res=2.5)
df_asia <- subset(df, x>60 & x<145 & y>15 & y<60)
ggplot(df_asia, aes(x=x, y=y)) + geom_raster(aes(fill=alt)) + scale_fill_gradientn(colours = c("#213D05", "#E6D5AC", "#DBB05A", "#B59E09", "#857319","#523F08","#B58159","#D4B9AE"), values = scales::rescale(c(0, 0.133, 0.266, 0.4, 1)))+xlim(65,145)+ylim(15,60)+theme_bw()+guides(fill=F)+xlab(NULL)+ylab(NULL)

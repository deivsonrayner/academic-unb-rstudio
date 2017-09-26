if(!require(read.dbc)) install.packages("read.dbc")
if(!require(maptools)) install.packages("maptools")
if(!require(ggmap)) install.packages("ggmap")
if(!require(ggplot2)) install.packages("ggplot2")
if(!require(data.table)) install.packages("data.table")
if(!require(RCurl)) library(RCurl)
if(!require(rgdal)) install.packages("rgdal")


library(read.dbc)
library(data.table)
library(dplyr)
library(maptools)
library(ggmap)
library(ggplot2)
library(rgdal)

##################################
# Preparação do Data Frame do CNE#
##################################

estados <- c("AC","AL","AM","AP","BA","CE","DF","ES","GO","MA","MG","MS","MT","PA","PB","PE","PI","PR","RJ","RN","RO","RR","RS","SC","SE","SP","TO")
meses   <- c("12")
anos    <- c("13","15")

data.cne <- data.frame()

for (uf in estados) {
  for (ano in anos) {
    for (mes in meses) {
      dbc_file <- paste("LT",uf,ano,mes,".dbc",sep = "");
      print(dbc_file)
      df <- read.dbc(paste("datasus/",dbc_file, sep = ""));
      
      df <- mutate(df, X_UF = uf)
      df <- mutate(df, X_ANO = ano)
      df <- mutate(df, X_MES = mes)
      
      data.cne <- rbind(data.cne, df)
    }
  } 
}

write.csv(data.cne,file = "CNE.csv", sep = ",", quote = FALSE, fileEncoding = "UTF8")

###############################################
# Preparação do Data Frame do Setor Censitario#
###############################################

data.censitario.df <- readOGR(dsn="setor_censitario/df.kml")
plot(data.censitario.df)





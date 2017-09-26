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


colNames <- c("ID","CNES","CODUFMUN","REGSAUDE","MICR_REG","DISTRSAN","DISTRADM","TPGESTAO","PF_PJ","CPF_CNPJ","NIV_DEP","CNPJ_MAN","ESFERA_A","ATIVIDAD","RETENCAO","NATUREZA","CLIENTEL","TP_UNID","TURNO_AT","NIV_HIER","TERCEIRO","TP_LEITO","CODLEITO","QT_EXIST","QT_CONTR","QT_SUS","QT_NSUS","COMPETEN","NAT_JUR","X_UF","X_ANO","X_MES")

df.cne <- read.csv(file = "CNE.csv", col.names = colNames,  sep = ",", quote = "", fileEncoding = "UTF8")
str(df.cne)
head(df.cne)


df.cne %>% filter(X_ANO == factor("15")) %>% 
  group_by(X_UF)  %>% 
  summarise( QT_EXIST = sum(QT_EXIST), QT_CONTR = sum(QT_CONTR), QT_SUS = sum(QT_SUS), QT_NSUS = sum(QT_NSUS)) -> df.cne.group_uf



ggplot(df.cne.group_uf, aes(x = X_UF, y = QT_EXIST)) + geom_bar(stat="identity", fill = "red", position = "dodge") + 
  geom_bar(aes(y = QT_SUS), stat="identity", fill = "blue") +
  geom_bar(aes(y = QT_NSUS), stat="identity", fill = "yellow")


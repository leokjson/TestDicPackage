library(roxygen2)
library(devtools)
#devtools::create("TestDicPackage")
#document()
print(getwd())
#??hello

#df_dic <- load(file="./inst/NIADic2.Rdata")
#head(df_exam, n=10)
install_github('leokjson/TestDicPackage')
#install_github('leokjson/TestDicPackage', force=TRUE)
library(TestDicPackage)

hello()
square(2)


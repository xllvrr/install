installedPreviously <- read.csv('Rpack.csv')
baseR <- as.data.frame(installed.packages())
toInstall <- setdiff(installedPreviously, baseR)

install.packages(c(toInstall),"languageserver")

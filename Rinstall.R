installedPreviously <- read.csv('Rbackup.csv')
baseR <- as.data.frame(installed.packages())
toInstall <- setdiff(installedPreviously, baseR)

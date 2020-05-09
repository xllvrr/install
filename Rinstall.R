installedPreviously <- read.csv('installed_previously.csv')
baseR <- as.data.frame(installed.packages())
toInstall <- setdiff(installedPreviously, baseR)

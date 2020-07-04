restore <- read.csv('Rbackup.csv')
baseR <- as.data.frame(installed.packages())
toInstall <- setdiff(restore, baseR)
install.packages(pkgs = toInstall)

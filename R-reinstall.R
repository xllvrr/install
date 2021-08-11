#!/bin/R

packagelist <- readLines("./Rpkglist.txt")
install.packages(packagelist, repos = "https://cloud.r-project.org/")

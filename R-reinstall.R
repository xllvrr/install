#!/bin/R

packagelist <- readLines("./Rpkglist.txt")
install.packages(packagelist)

#load packages
library(Seurat)
library(SeuratDisk)

setwd("/Users/jiahuiji/Dropbox/project/t-cell/data")


#input 
input="hca_heart_immune_raw.h5seurat"
hfile=Connect(input)

hca=LoadH5Seurat(input)
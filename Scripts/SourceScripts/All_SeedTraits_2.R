#setwd("~/Desktop/Rscripts_Traits") 
# Please set you working directory

library(plyr)
library(dplyr)
library(tidyr)
library(ape)
library(maps)
library(phytools)
library(readxl)
library(stringr)
library(permute)
library(lattice)
library(vegan)
library(nlme)
library(geiger)
library(mvtnorm)
library(MASS)
library(caper)
library(AICcmodavg)
library(nloptr)
library(OUwie)
library(ggplot2)
library(ggtree)
library(ggrepel)
library(ggpubr)
library(data.table)
library(stringr)

#Generate Phylogenetic Tree
source("Scripts/SourceScripts/BuildingPhylogeny.R")

#Calculate Phylogenetic Position
source("Scripts/SourceScripts/PhyloPosi.R") 

#Caculate phylogenetic signal
source("Scripts/SourceScripts/PhyloSignal.R")

#Generalized Linear Model for Seed Germination Prediction
source("Scripts/SourceScripts/GLM_all.R")



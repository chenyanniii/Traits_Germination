
#setwd("~/Desktop/Traits") 

## Phylogenetic Signal
Dat_scaled <- read.csv("Input/MatrixAll.G.scaled.classify.csv")
Mass.All <- Dat_scaled$Mass_Mean
names(Mass.All) <- Dat_scaled$Species

Height.All <- Dat_scaled$Height_Mean
names(Height.All) <- Dat_scaled$Species

Area.All <- Dat_scaled$Area_Mean
names(Area.All) <- Dat_scaled$Species

Germination.All <- Dat_scaled$Summary_Germination
names(Germination.All) <- Dat_scaled$Species

PhyloSigMass.l <- phylosig(TreeAllMatrix, Mass.All, method="lambda", test=TRUE)
PhyloSigMass.k <- phylosig(TreeAllMatrix, Mass.All, method="K", test=TRUE, nsim=99999)


PhyloSigHeight.l <- phylosig(TreeAllMatrix, Height.All, method="lambda", test=TRUE, nsim=99999)
PhyloSigHeight.k <- phylosig(TreeAllMatrix, Height.All, method="K", test=TRUE, nsim=99999)


phylosigArea.l <- phylosig(TreeAllMatrix, Area.All, method="lambda", test=TRUE, nsim=999)
phylosigArea.k <- phylosig(TreeAllMatrix, Area.All, method="K", test=TRUE, nsim=999)


phylosigGermination.l <- phylosig(TreeAllMatrix, Germination.All, method="lambda", test=TRUE, nsim=999)
phylosigGermination.k <- phylosig(TreeAllMatrix, Germination.All, method="K", test=TRUE, nsim=999)

#PhyloSigMass.l
print("The phylogenetic signal for seed mass is below")
print(PhyloSigMass.k)

#PhyloSigHeight.l
print("The phylogenetic signal for seed height is  below")
print(PhyloSigHeight.k)

#phylosigArea.l
print("The phylogenetic signal for seed surface area is below")
print(phylosigArea.k)

#phylosigGermination.l
print("The phylogenetic signal for seed germination rate is below")
print(phylosigGermination.k)

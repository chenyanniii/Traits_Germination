#setwd("~/Desktop/Traits") 


## Prepare Phylogenetic Tree
treeVascularPlants <- read.tree("Input/Vascular_Plants_rooted.tre")
tips <-treeVascularPlants$tip.label
Genera<-unique(sapply(strsplit(tips,"_"),function(x) x[1]))

#PruneTree Function
PruneTree <- function(x){
  ## x, a list of desired species in "xx_xx" format
  DesiredSpecies <- unique(x)
  ## Desired Genera
  DesiredGenera <- sapply(strsplit(DesiredSpecies, "_"),function(x) x[1])
  
  ## TreeSpecies Data Frame
  SpeciesGeneraSpecies <- data_frame(TreeSpecies = treeVascularPlants$tip.label,
                                     TreeGenera = sapply(strsplit(tips,"_"),function(x) x[1]),
                                     DesiringGenera = TreeGenera %in% intersect(Genera,DesiredGenera) ,
                                     DesiringSpecies = TreeSpecies %in% DesiredSpecies) 
  
  SpeciesListSpecies <- filter(SpeciesGeneraSpecies, DesiringSpecies == "TRUE")
  
  GeneraSpecies <- filter(SpeciesGeneraSpecies, SpeciesGeneraSpecies$TreeGenera %in% 
                            setdiff(DesiredGenera, SpeciesListSpecies$TreeGenera))
  SpeciesListGenera <- group_by(GeneraSpecies, TreeGenera) %>% group_modify(~ head(.x, 1L))
  
  LISTALLSPECIES <- rbind.data.frame(SpeciesListSpecies, SpeciesListGenera)
  
  treeTestedSpecies <- keep.tip(treeVascularPlants, LISTALLSPECIES$TreeSpecies)
  
  ## Replacing tip label
  
  aaa <- data_frame(DesiredSpecies = DesiredSpecies, 
                    TreeGenera = sapply(strsplit(DesiredSpecies,"_"),function(x) x[1]))
  bbb <- merge(aaa, SpeciesListGenera)
  
  treeTestedSpecies$tip.label <- mapvalues(treeTestedSpecies$tip.label, c(bbb$TreeSpecies), c(bbb$DesiredSpecies))
  tree_x <- treeTestedSpecies
  plotTree(tree_x, ftype="i")
  return(tree_x)
}

#InputMatrix <- read_xlsx("Input/AllMatrix_12_19.xlsx")
InputMatrix <- read_xlsx("Input/Ranked_H.A.M.selected.species.xlsm")


## Prune Tree
TreeInputMatrix <- PruneTree(InputMatrix$Species)

## Adding "Callirhoe_leiocarpa"
tip1 <- "Callirhoe_leiocarpa"
sister1 <- "Callirhoe_involucrata"
tree1 <- bind.tip(TreeInputMatrix,tip1,
                  edge.length = 0.5*TreeInputMatrix$edge.length[which(TreeInputMatrix$edge[,2]==
                                                                        which(TreeInputMatrix$tip.label==sister1))],
                  where=which(TreeInputMatrix$tip.label==sister1),
                  position=0.5*TreeInputMatrix$edge.length[which(TreeInputMatrix$edge[,2]==
                                                                   which(TreeInputMatrix$tip.label==sister1))])
## Adding "Digitaria_californic"
tip2 <- "Digitaria_californica"
sister2 <- "Digitaria_ciliaris"
TreeAllMatrix <- bind.tip(tree1,tip2,
                          edge.length = 0.5*tree1$edge.length[which(tree1$edge[,2]==
                                                                      which(tree1$tip.label==sister2))],
                          where = which(tree1$tip.label==sister2),
                          position=0.5*tree1$edge.length[which(tree1$edge[,2]==
                                                                 which(tree1$tip.label==sister2))])

plotTree(TreeAllMatrix, ftype="i")

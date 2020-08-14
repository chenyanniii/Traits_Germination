
#setwd("~/Desktop/Traits") 

# Phylogenetic Position

## Phylogenetic Position
par(mar=c(5,5,5,1))
dist <- cophenetic.phylo(TreeAllMatrix)
phyloposi <-isoMDS(dist) %>% as.data.frame()
st.phyloposi <- phyloposi %>% mutate(st_points.1 = scale(points.1)) %>% 
  mutate(st_points.2 = scale(points.2)) %>% mutate(Species =row.names(phyloposi))

dat_scaled <- read.csv(file = "Input/MatrixAll.G.scaled.classify.csv") %>% 
  merge(st.phyloposi, all=TRUE) %>%
  dplyr::select(Summary_Germination, st_points.1, Area_Mean.1, 
                st_points.2, Height_Mean.1, Mass_Mean.1)

dat_scaled.upto30 <- read.csv(file = "Input/MatrixAll.G.scaled.classify.csv") %>% 
  merge(st.phyloposi, all=TRUE) %>%
  dplyr::select(upto30, Summary_Germination, st_points.1, 
                Area_Mean.1, st_points.2, Height_Mean.1)
dat_scaled.upto30 <- dat_scaled.upto30[!(dat_scaled.upto30$upto30=="0"),] %>%
  mutate(upto30 = NULL)

## phyloposi of family
#phyloposi.family <- merge(phyloposi.species, Germ)%>%
#mutate(Summary_Germination =NULL, stress=NULL)
#phyloposi.family <- phyloposi.family[c("Species", "Family", "points.1", "points.2")]
#write.csv(phyloposi.family, "Input/phyloposit.family.csv")
## phylogposi of dormancy type
#phyloposi.dormancy <- merge(phyloposi.species, dorm.treetip.type, all = TRUE)
#write.csv(phyloposi.dormancy, "Input/phyloposit.dormancy.csv")
## add monocot, dicot, and Asteraceae

phyloposi.family <- read.csv("Input/Phyloposit.family.plot.csv", stringsAsFactors = FALSE)

p <- ggplot(phyloposi.family,aes(x=points.1, y=points.2, color=Classification)) +
  geom_point() + scale_fill_manual("#F8766D", "#00BA38", "#619CFF") +
  labs(x="phy1", y="phy2") + geom_text_repel(aes(label = Family), size =3.5) +
  theme_bw()

print(p) 


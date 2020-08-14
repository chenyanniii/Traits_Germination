#setwd("~/Desktop/Traits") 


#### For All Germination Data
dat_scaled <- read.csv(file = "Input/MatrixAll.G.scaled.classify.csv") %>% 
  merge(st.phyloposi, all=TRUE) %>%
  dplyr::select(Summary_Germination, st_points.1, Area_Mean.1, st_points.2,
                Height_Mean.1, Mass_Mean.1)

germination.glm <- glm(Summary_Germination ~ ., data = dat_scaled)
#germination.step <- stepAIC(germination.glm, trace = TRUE)
germination.step <- stepAIC(germination.glm, trace = FALSE)
#germination.step$anova


Gmod<-list()
Gmod[[1]] <- glm(Summary_Germination ~  Height_Mean.1+st_points.2+Area_Mean.1+
                   st_points.1+Mass_Mean.1, data = dat_scaled)

Gmod[[2]] <- glm(Summary_Germination ~ Height_Mean.1+st_points.2+Area_Mean.1+
                   st_points.1, data = dat_scaled)

Gmod[[3]] <- glm(Summary_Germination ~ Height_Mean.1+st_points.2+Area_Mean.1, 
                 data = dat_scaled)

Gmod[[4]] <- glm(Summary_Germination ~ Height_Mean.1+st_points.2, data = dat_scaled)

Gmod[[5]] <- glm(Summary_Germination ~ Height_Mean.1, data = dat_scaled)

Modnames <- c("Height+phy2+Area+phy1+Mass model", "Height+phy2+Area+phy1 model",
              "Height+phy2+Area model", "Height+phy2 model", "Height model") 

#aictab(Gmod, Modnames)

print(modavg(parm = "Height_Mean.1", cand.set = Gmod,
             modnames = Modnames), digits = 4)
#print(modavg(parm = "st_points.2", cand.set = Gmod,
#             modnames = Modnames), digits = 4)
#print(modavg(parm = "Area_Mean.1", cand.set = Gmod,
#             modnames = Modnames), digits = 4)
#print(modavg(parm = "st_points.1", cand.set = Gmod,
#             modnames = Modnames), digits = 4)
#print(modavg(parm = "Mass_Mean.1", cand.set = Gmod,
#             modnames = Modnames), digits = 4)

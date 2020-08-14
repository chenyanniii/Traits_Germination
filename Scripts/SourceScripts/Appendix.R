data = read_xlsx("Input/Ranked_H.A.M.selected.species.xlsm")

appendix = data %>% group_by(Species) %>% 
  summarise (mean_Area = mean(Area), sd_Area = sd(Area), 
             mean_Height = mean(Height), sd_Height = sd(Height),
             mean_Mass = mean(Mass), sd_Mass = sd(Mass))

#write.csv(appendix,"Output/Appendix_MHA.csv")


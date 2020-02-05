library(plotrix)
library(psycho)

#define function to create a "difference from baseline"
dfb_lag <- function(x){
  x - lag(x, 4)
}

#pass function through raw data, create new dataset 
dat_dfb <- dat %>% 
  group_by(id) %>% 
  mutate_at((9:28), funs(dfb_lag)) %>% 
  filter(session %in% c(6,7,8)) %>% 
  select(- c(decimal,sex,run,date,time,`file name`)) %>% 
  pivot_longer(meanrtcorr:stdevrt, names_to = "variable", values_to = "value")

#Create matrix to pass loop
group_list <- c("Mario","Luigi")
variable_list <- unique(dat_dfb$variable)
anam_matrix <- as.matrix(expand.grid(group_list,variable_list))

#Define graph
dfb_boxplot <- function(wesgroup,anamvariable){
  boxplot(value ~ session, data = dat_dfb %>% 
            filter(variable == anamvariable) %>% 
            filter(group == wesgroup), main = wesgroup, ylab = anamvariable)
  abline(h = 0, lty = 3)
}


#Loop
par(mfrow = c(1,2))
mapply(dfb_boxplot,anam_matrix[,1],anam_matrix[,2])


#Create group means/SEM
dfb_group <- dat_dfb %>% 
  group_by(group, session, variable) %>% 
  summarise(sem = std.error(value), value = mean(value))

#Define graph
dfb_line <- function(anamvariable){
  with(group_dfb %>% filter(variable == anamvariable), 
       interaction.plot(x.factor = session, response = value, trace.factor = group, 
                        type = "b", pch = c(1,19), main = anamvariable, ylab = "Difference from baseline - group mean"))
  
  abline(h=0, lty = 3)
  
  with(group_dfb %>% 
         filter(group == "Luigi") %>% 
         filter(variable == anamvariable), arrows(session,value-sem,session,value+sem, code=3, length=0.01, angle = 90))
  
  with(group_dfb %>% 
         filter(group == "Mario") %>% 
         filter(variable == anamvariable), arrows(session,value-sem,session,value+sem, code=2, length=0.01, angle = 90))
}

#Loop
lapply(variable_list, dfb_line)






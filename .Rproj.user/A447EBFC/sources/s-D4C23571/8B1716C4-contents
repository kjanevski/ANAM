par(mfrow=c(1,2))  
plot(medrtcorr ~ session, data = dat)
boxplot(medrtcorr ~ session, data = dat)

par(mfrow=c(1,2))
for(i in unique(dat$group)){
  boxplot(medrtcorr~session, data = dat %>% filter(group == i), main = i, ylim=c(250,750))
}

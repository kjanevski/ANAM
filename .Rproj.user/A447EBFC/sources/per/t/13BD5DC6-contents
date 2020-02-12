library(readxl)
library(tidyverse)

#import adept data
adept <- read_excel("raw/anam_adept_export.xlsx", sheet = paste0("W57_",test_type)) %>% 
  rename_all(. %>% tolower)

#import subj_db for sex & group assignment
subject_db <- read_excel("raw/wes2_subject_db.xlsx") %>% 
  rename_all(. %>% tolower)

#join data & label "dat"
dat <- subject_db %>% 
  select(subject,group,decimal,sex) %>% 
  rename("id" = "subject") %>% 
  left_join(adept, by = "id")


#remove W88,94,95 
dat <- dat %>% 
  filter(!id %in% c("W88","W94","W95")) #%>% 
  #create inverse variables
#  mutate(inversemed = 1/medrtcorr, inversemean = 1/meanrtcorr) 
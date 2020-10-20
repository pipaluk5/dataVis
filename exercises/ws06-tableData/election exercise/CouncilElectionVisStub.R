# london council election exercise script stub ---------------


library(tidyverse)
library(here)

df<-read.csv(here("exercises","ws06-tableData","election exercise","london_council_election_2014_ward.csv"))

df <- df %>% group_by(Ward_code,party) %>% arrange(candidate) %>% mutate(position_within=1:n()) %>% ungroup()
df <- df %>% group_by(Ward_code) %>% arrange(candidate) %>% mutate(position_overall=1:n()) %>% ungroup()

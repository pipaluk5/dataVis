# london council election exercise script stub ---------------


library(tidyverse)
library(here)
library(modelr)

df <- read.csv(here("exercises", "ws06-tableData", "election exercise", "london_council_election_2014_ward.csv"))

df <- df %>%
  group_by(Ward_code, party) %>%
  arrange(candidate) %>%
  mutate(position_within = 1:n()) %>%
  ungroup()

df <- df %>%
  group_by(Ward_code) %>%
  arrange(candidate) %>%
  mutate(position_overall = 1:n()) %>%
  ungroup()

df <- df %>%
  group_by(Ward_code) %>%
  arrange(candidate) %>%
  mutate(position_overall = 1:n()) %>% 
  ungroup()

db <- df %>%
  filter(party %in% c("CON", "LAB", "LD")) %>%
  group_by(Borough_name, party, position_within) %>%
  summarise(elected = sum(ifelse(elected_flag == "Yes", 1, 0)))

# create a data grid with all borough party combinations
gr <- df %>%
  filter(party %in% c("CON", "LAB", "LD")) %>%
  data_grid(Borough_code, party,position_within=c(1,2,3))

ggplot(db)+geom_col(aes(x=c(party),y = elected, fill=factor(-position_within)), position = "dodge")+coord_flip()+facet_wrap(~Borough_name)

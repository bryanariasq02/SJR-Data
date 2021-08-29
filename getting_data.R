devtools::install_github("ikashnitsky/sjrdata")

library(tidyverse)
library(sjrdata)
library(ggplot2)

journals_scimago <- sjr_journals |>
  separate_rows(issn, sep = ", ") |> 
  filter(year>=2016) |> 
  select(year, issn,sjr_best_quartile)
  
#plot about journal information in scimago since 2016  
ggplot(data = journals_scimago, aes(year, sjr_best_quartile))+
  geom_point(aes(color= year))
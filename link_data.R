library(tidyverse)
library(sjrdata)
library(here)

articulos <- read_csv(here("articulos.csv")) |> 
  mutate(ISSN = str_remove(ISSN, "-")) |> 
  mutate(ano = as.character(ano))

journal_2020 <- read_csv2(here("scimago2020.csv"))|> 
  separate_rows(Issn, sep = ", ")|>
  rename("ISSN" = Issn,
         "SJR_Q"= 7) |> 
  select(ISSN,SJR_Q) |> 
  mutate(ano = 2020)

journals_categorie <- sjr_journals |> 
  filter(year>=2016) |> 
  separate_rows(issn, sep = ", ") |> 
  select(year, issn,sjr_best_quartile) |> 
  rename("ISSN" = issn,
         "ano" = year,
         "SJR_Q"= sjr_best_quartile) |> 
  rbind(journal_2020)

articulos_merge <- left_join(articulos, journals_categorie, by=c("ano","ISSN"))
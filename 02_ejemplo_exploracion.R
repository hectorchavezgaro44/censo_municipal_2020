pacman::p_load(tidyverse, here)

readRDS("out/censo_municipios.rda")
load(here::here("out", "censo_municipios.rda"))

base <- censo_municipios %>% 
  filter(entidad=="19") %>% 
  group_by(nom_mun) %>% 
  summarise(across(pobtot:vph_sintic, ~as.numeric(.x))) %>% 
  ungroup() %>% 
  mutate(porc_pisoti=round((vph_pisoti/tvivparhab)*100,2),
         porc_sinder=round((psinder/pobtot)*100,2),
         porc_inter=round((vph_inter/tvivparhab)*100,2),
         porc_conauto=(1-(vph_ndacmm/tvivparhab)),
         porc_conauto=round(porc_conauto*100,2)) %>% 
  select(nom_mun, porc_pisoti, porc_sinder, porc_inter, porc_conauto, graproes)

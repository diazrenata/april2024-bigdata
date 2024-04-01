colwidths <- "------ ----- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- --------------------------------------------------" |>
  strsplit(" ") |>
  lapply(nchar) |>
  unlist() 

speciesList <- read.fwf(here::here("data", "2022Release_Nor", "SpeciesList.txt"),
                        widths = colwidths + 1,
                        skip = 12, header = F, fileEncoding = "latin1")

speciesList <- speciesList |>
  mutate(across(everything(), trimws))

colnames(speciesList) <- speciesList[1,]

speciesList <- speciesList[-c(1,2), ]

write.csv(speciesList, here::here("data", "parsed_species_list.csv"), row.names = F)

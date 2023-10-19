#sum(is.na(Borrower_Raw$fiscal.code) & is.na(Borrower_Raw$vat.number)) 1713
#sum(!is.na(Borrower_Raw$fiscal.code) & is.na(Borrower_Raw$vat.number)) 2621
#sum(is.na(Borrower_Raw$fiscal.code) & !is.na(Borrower_Raw$vat.number)) 9237


Borrower_Raw$cf.piva <- ifelse(!is.na(Borrower_Raw$fiscal.code),Borrower_Raw$fiscal.code,Borrower_Raw$vat.number)
Borrower_Raw <- Borrower_Raw %>% select(-fiscal.code,-vat.number)
Borrower_Raw$role <- 'borrower'
Co_Owner_Raw$cf.piva <- ifelse(!is.na(Co_Owner_Raw$`co-owner.fiscal.code`),Co_Owner_Raw$`co-owner.fiscal.code`,Co_Owner_Raw$`co-owner.vat.number`)
Co_Owner_Raw <- Co_Owner_Raw %>% select(-`co-owner.fiscal.code`, -`co-owner.vat.number`)
Co_Owner_Raw$role <- 'co_owner'
Guarantor_Raw$cf.piva <- ifelse(!is.na(Guarantor_Raw$guarantor.fiscal.code),Guarantor_Raw$guarantor.fiscal.code,Guarantor_Raw$guarantor.vat.number)
Guarantor_Raw <- Guarantor_Raw %>% select(-guarantor.fiscal.code,-guarantor.vat.number)
Guarantor_Raw <- Guarantor_Raw %>% rename(ndg = guarantor.id)
Guarantor_Raw$role <- 'guarantor'

#Counterparties <- rbind(Guarantor_Raw,Co_Owner_Raw)  
Co_Owner_Raw <- Co_Owner_Raw %>% group_by(ndg) %>% summarize(Ndg = ndg,Cf.piva = paste(cf.piva,collapse = ","),Role = role)
Co_Owner_Raw <- Co_Owner_Raw %>% distinct() %>% select(-Ndg) %>% rename(role = Role,cf.piva = Cf.piva)  
Guarantor_Raw <- Guarantor_Raw %>% mutate(registry.type = NA,cap.borrower.town = NA,borrower.town = NA,borrower.province = NA,
                                            borrower.address = NA,borrower.nation=NA,birth.date=NA,gbv = NA,sae.code = NA,
                                          debtor.status = NA, deceased.debtor = NA) 
Co_Owner_Raw<- Co_Owner_Raw %>% mutate(registry.type = NA,cap.borrower.town = NA,borrower.town = NA,borrower.province = NA,
                                          borrower.address = NA,borrower.nation=NA,birth.date=NA,gbv = NA,sae.code = NA,
                                          debtor.status = NA, deceased.debtor = NA) 

Counterparties <- rbind(Borrower_Raw,Co_Owner_Raw)
Counterparties <- Counterparties %>%
                  group_by(ndg) %>%
                  mutate(cf.piva = ifelse(n() >= 2, paste(cf.piva, collapse = ","), first(cf.piva))) %>%
                  filter(role == 'borrower') %>% ungroup()
Counterparties <- rbind(Counterparties,Guarantor_Raw)

Counterparties_Raw <- Counterparties %>% mutate(id.counterparty = paste0("c",row_number()))

Counterparties <- Counterparties_Raw %>% select(id.counterparty,ndg,role) %>% rename(id.bor =ndg)
Counterparties <- Counterparties %>% mutate(id.group = NA, name=NA,flag.imputed=NA,
                                            n.entities = str_count(Counterparties_Raw$cf.piva,",")+1)






Entities_Raw <- divide_column_by_character(Counterparties_Raw,"cf.piva",",")
Entities_Raw <- Entities_Raw  %>% mutate(id.entity = paste0("e",row_number()))


Link_Entities_Counterparties <- Entities_Raw %>% select(id.counterparty,id.entity)

Entities_Raw <- Entities_Raw %>% select(-id.counterparty)
Entities_Raw <- Entities_Raw %>% mutate(name=NA,flag.imputed=NA,dummy.info = NA,solvency.pf=NA,income.pf=NA,type.pg =NA,
                                        status.pg = NA,date.cessation =NA)


Entity <- Entities_Raw %>% select(id.entity,name,cf.piva,registry.type,dummy.info,
                                  solvency.pf,income.pf,type.pg,status.pg,date.cessation,
                                  borrower.town,borrower.province,flag.imputed) %>%
            rename(type.subject = registry.type,city = borrower.town,province = borrower.province)

Entity <- Entity %>% mutate(age = round(as.numeric((oggi-as.Date(Entities_Raw$birth.date)) /365)))
Entity <- add_age_range_column(Entity)

Entity <- Entity %>% mutate(sex = ifelse(!is.na(cf.piva) & nchar(cf.piva) >= 12,
                        ifelse(as.numeric(substr(cf.piva, 10, 11)) > 40, "F", "M"),NA ))

paths_content <- readLines("File/file_paths.txt")
GeoMetadata_line <- grep("^GeoMetadata", paths_content)
GeoMetadata_value <- sub("^GeoMetadata=\\s*", "", paths_content[GeoMetadata_line])
GeoData <- read_excel(GeoMetadata_value, sheet = "Geo")

Entity <- create_region_city_prov(Entity,Entity$city,Entity$province)
Entity <- create_area_city_prov(Entity,Entity$city,Entity$province)







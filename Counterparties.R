
#sum(is.na(Borrower_Raw$fiscal.code) & is.na(Borrower_Raw$vat.number)) 1713
#sum(!is.na(Borrower_Raw$fiscal.code) & is.na(Borrower_Raw$vat.number)) 2621
#sum(is.na(Borrower_Raw$fiscal.code) & !is.na(Borrower_Raw$vat.number)) 9237

#explore::explore(distinct(Borrower_Raw))

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

Counterparties <- Counterparties_Raw %>% select(id.counterparty,ndg,role,cf.piva) %>% rename(id.bor =ndg)
Counterparties <- Counterparties %>% mutate(id.group = NA, name=NA,flag.imputed=NA,
                                            n.entities = str_count(Counterparties_Raw$cf.piva,",")+1)


#matrice <- Counterparties_Raw %>% filter(is.na(cf.piva))



Entities_Raw <- divide_column_by_character(Counterparties_Raw,"cf.piva",",") %>% distinct()
#Entities_Raw <- Entities_Raw  %>% mutate(id.entity = paste0("e",row_number()))
Link_Entities_Counterparties <- Entities_Raw %>% select(id.counterparty,cf.piva)

#Link_Entities_Counterparties <- Entities_Raw %>% select(id.counterparty,id.entity)

# sum(is.na(Entities_Raw$cf.piva))   2534 na da riaggiungere
Entities_Raw <- Entities_Raw %>% select(cf.piva) %>% distinct()
na_df <- data.frame(matrix(NA,nrow=2534,ncol=ncol(Entities_Raw)))
names(na_df) <- names(Entities_Raw)
Entities_Raw <- rbind(Entities_Raw,na_df)


Entities_Raw <- Entities_Raw %>% mutate(name=NA,flag.imputed=NA,dummy.info = NA,solvency.pf=NA,income.pf=NA,type.pg =NA,
                                        status.pg = NA,date.cessation =NA)
Entities_Raw <- Entities_Raw  %>% mutate(id.entity = paste0("e",row_number()))

label_na <- function(column) { 
  is_na <- is.na(column)  
  labels <- ifelse(is_na, paste0("NA_", cumsum(is_na)), column) 
  return(labels)
}

Entities_Raw[["cf.piva"]] <- label_na(Entities_Raw[["cf.piva"]])
Link_Entities_Counterparties[["cf.piva"]] <- label_na(Link_Entities_Counterparties[["cf.piva"]])


Link_Entities_Counterparties <- left_join(Link_Entities_Counterparties,Entities_Raw, by = "cf.piva",relationship = "many-to-many") %>%
                                select(id.counterparty,id.entity)



Entities_Raw <- left_join(Entities_Raw,Link_Entities_Counterparties,by= "id.entity",relationship = "many-to-many",) %>% 
                left_join(.,Counterparties_Raw,by = "id.counterparty", relationship = "many-to-many") %>%
                select(id.entity,name,cf.piva.x,registry.type,dummy.info,
                       solvency.pf,income.pf,type.pg,status.pg,date.cessation,
                       borrower.town,borrower.province,flag.imputed) %>%
                rename(type.subject = registry.type,city = borrower.town,province = borrower.province)
Entities_Raw$type.subject <- ifelse(nchar(Entities_Raw$cf.piva.x)==16,'individual','legal person')
Entities_Raw <- Entities_Raw %>% distinct()

Entities_Raw <- Entities_Raw %>% group_by(cf.piva.x) %>% slice(1)

Entities_Raw <- Entities_Raw %>% arrange(str_sub(id.entity, 1, 1), as.numeric(str_sub(id.entity, 2)))

Link_Entities_Counterparties <- Link_Entities_Counterparties %>% arrange(str_sub(id.entity, 1, 1), as.numeric(str_sub(id.entity, 2)))




oggi <- as.Date('2021-11-30')
Entity <- left_join(Entities_Raw,Link_Entities_Counterparties,by = "id.entity")%>% 
  left_join(.,Counterparties_Raw,by="id.counterparty") %>% group_by(cf.piva.x) %>% slice(1) %>%
  mutate(age = round(as.numeric((oggi-as.Date(birth.date)) /365))) %>%
  select(id.entity,name,cf.piva.x,type.subject,dummy.info,
         solvency.pf,income.pf,type.pg,status.pg,date.cessation,
         city,province,flag.imputed,age)
Entity <- add_age_range_column(Entity)

Entity <- Entity %>% mutate(sex = ifelse(!is.na(cf.piva.x) & nchar(cf.piva.x) >= 12,
                                         ifelse(as.numeric(substr(cf.piva.x, 10, 11)) > 40, "F", "M"),NA ))


paths_content <- readLines("File/file_paths.txt")
GeoMetadata_line <- grep("^GeoMetadata", paths_content)
GeoMetadata_value <- sub("^GeoMetadata=\\s*", "", paths_content[GeoMetadata_line])
GeoData <- read_excel(GeoMetadata_value, sheet = "Geo")

Entity <- create_region_city(Entity,Entity$city)
Entity <- create_area_city(Entity,Entity$city)



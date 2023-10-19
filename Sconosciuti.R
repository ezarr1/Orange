
check_col1_in_col2(Guarantor_Raw$guarantor.id,Borrower_Raw$ndg)    #false
check_col1_in_col2(Co_Owner_Raw$ndg,Borrower_Raw$ndg)  # co_owner is subtype of Borrower   #true
check_col1_in_col2(Guarantee_Raw$guarantor.id,Borrower_Raw$ndg)  #false

#-------------------------------------------------------------------------------------------

Co <- Borrower_Raw  %>% filter(is.na(cf.piva))

Co_Owner_Raw$cf.piva <- ifelse(!is.na(Co_Owner_Raw$`co-owner.fiscal.code`),Co_Owner_Raw$`co-owner.fiscal.code`,Co_Owner_Raw$`co-owner.vat.number`)
Co_Owner_Raw <- Co_Owner_Raw %>% select(-`co-owner.fiscal.code`, -`co-owner.vat.number`)
Co_Owner_Raw$role <- 'co_owner'
Guarantor_Raw$cf.piva <- ifelse(!is.na(Guarantor_Raw$guarantor.fiscal.code),Guarantor_Raw$guarantor.fiscal.code,Guarantor_Raw$guarantor.vat.number)
Guarantor_Raw <- Guarantor_Raw %>% select(-guarantor.fiscal.code,-guarantor.vat.number)
Guarantor_Raw <- Guarantor_Raw %>% rename(ndg = guarantor.id)
Guarantor_Raw$role <- 'guarantor'
  
COunter <- rbind(Guarantor_Raw,Co_Owner_Raw)  
  
sconosciuti <- Co[!Co$ndg %in% unique(COunter$ndg),]
  


Counterparty_Borrowers <-  Counterparties %>% filter(role == "borrower")
Merged_Counterparty_Loans <-  left_join(Counterparty_Borrowers,Loans, by = "id.bor")
Average_Borrower_Size <- sum(Merged_Counterparty_Loans$gbv.original)/n_distinct(Merged_Counterparty_Loans$id.bor)
Average_Borrower_Size <- as.data.frame(Average_Borrower_Size)



N_Borrowers <- as.data.frame(n_distinct(Merged_Counterparty_Loans$id.bor))
Sum.GBV <- as.data.frame(sum(Merged_Counterparty_Loans$gbv.original))


Totals_Borrowers <- cbind(N_Borrowers,Sum.GBV,Average_Borrower_Size)
names(Totals_Borrowers) <- c("N.Borrowers","Sum.GBV","Average.GBV")


# GBV % by borrores region and % borrower by region:

Borrowers <- Counterparties %>% filter(role=='borrower') %>% distinct()
Borrowers <- left_join(Borrowers,Loans, by = "id.bor",relationship = "many-to-many")
total_gbv <- sum(Borrowers$gbv.original)
total_borrowers <- n_distinct(Borrowers$id.counterparty)
Borrowers <- left_join(Borrowers,Link_Entities_Counterparties,by = "id.counterparty",relationship = "many-to-many")
Borrowers <- left_join(Borrowers,Entity, by = "id.entity")


Borrowers_area <- Borrowers %>% select(id.counterparty,area,gbv.original,province)%>% distinct()


Borrowers_area_table <- Borrowers_area %>% mutate(area = ifelse(area == "ISLANDS", "SOUTH", area)) %>% 
                                          group_by(area)  %>%
                                          summarise(perc_borrowers = n_distinct(id.counterparty)/total_borrowers,
                                          perc_gbv = sum(gbv.original)/total_gbv)
Borrowers_area_table[is.na(Borrowers_area_table)] <- "N/A"
names(Borrowers_area_table) <- c("Area"," % Borrowers"," % GBV")


Borrowers_province_table <- Borrowers_area %>% group_by(province) %>% 
    summarise(sum_gbv = sum(gbv.original), N_borr = n_distinct(id.counterparty), avg_size = sum_gbv/N_borr ) %>% arrange(desc(sum_gbv))
# the top 5 are Roma (rm), Teramo(te), Pescara(pe) ,Milano (mi), Genova (ge)
sum(Borrowers_province_table$sum_gbv)
Top_5_province_by_gbv <- Borrowers_province_table[1:5, ]
names(Top_5_province_by_gbv) <- c("Province","Sum.GBV", "N.Borrowers","Average.GBV")

Top_5_province_by_gbv$Province <- c("Roma","Teramo","Pescara","Milano","Genova")


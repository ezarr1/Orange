#pag 31



#----------------------------------------------------------------------------------------------------------


gbv_perc_by_Guarantee <- Loans %>% mutate(flag.guarantee = ifelse(id.loan %in% Guarantee_Raw$loan.id,'With','Without')) %>% 
                          group_by(flag.guarantee) %>% summarise(Perc = sum(gbv.original)/Totals_Loans$Sum.GBV)



#----------------------------------------------------------------------------------------------------------
#total_gbv_with_Guarantee_type <- Loans %>% mutate(type.guarantee = ifelse(id.loan %in% Guarantee_Raw$loan.id,Guarantee_Raw$guarantee.type,FALSE)) %>%  filter(type.guarantee != 'Without') %>% summarise(s = sum(gbv.original))
#gbv_with_Guarantee_type <- Loans %>% mutate(type.guarantee = ifelse(id.loan %in% Guarantee_Raw$loan.id,Guarantee_Raw$guarantee.type,FALSE)) %>% filter(type.guarantee != 'Without') %>%  group_by(type.guarantee) %>%     summarise(Perc = sum(gbv.original)/total_gbv_with_Guarantee_type$s)

#----------------------------------------------------------------------------------------------------------
## giusto!

total_gbv_with_Guarantee_type <- Loans %>%
  inner_join(Guarantee_Raw, by = c("id.loan" = "loan.id")) %>%
  group_by(id.loan) %>%
  summarise(m = max(gbv.original),type = guarantee.type)%>% distinct() %>% summarise(s = sum(m))
  
Guarantee_Raw$guarantee.type <- as.character(Guarantee_Raw$guarantee.type)
# Calculate the summary statistics for each type.guarantee
Gbv_with_Guarantee_type <- Loans %>%
  inner_join(Guarantee_Raw, by = c("id.loan" = "loan.id")) %>%
  group_by(id.loan) %>%
  summarise(m = max(gbv.original),type = guarantee.type) %>% distinct() %>%
  select(-id.loan) %>% mutate(type = ifelse(type == "pegno", "fondo interbancario di garanzia", type))%>% 
  mutate(type = ifelse(type == "cambiali", "fondo interbancario di garanzia", type))%>%
  group_by(type) %>%
  summarise(Perc = sum(m) / sum(total_gbv_with_Guarantee_type$s))


#----------------------------------------------------------------------------------------------------------


#total_gbv_with_Guarantee_type <- Loans %>%inner_join(Guarantee_Raw, by = c("id.loan" = "loan.id")) %>%summarise(s = sum(gbv.original))

#gbv_with_Guarantee_type <- Loans %>%inner_join(Guarantee_Raw, by = c("id.loan" = "loan.id")) %>%group_by(guarantee.type) %>%summarise(Perc = sum(gbv.original) / total_gbv_with_Guarantee_type$s)

#n_distinct(Guarantee_Raw$loan.id)

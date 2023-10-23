#check_primary_key(Borrower_Raw,'ndg')  #TRUE

#check_primary_key(Loans_Raw,'loan.id')  #TRUE
#(nrow(Loans_Raw)== n_distinct(Loans_Raw$ndg))  #FALSE ndg has duplicates
#sum(is.na(Loans_Raw$ndg))  # non ci sono NAs in ndg

#check_primary_key(Guarantee_Raw,'guarantee.id')  #FALSE

#check_primary_key(Guarantor_Raw,'ndg') #TRUE

Loans <- Loans %>% mutate_at(vars(gbv.original,gbv.residual,principal,interest,penalties,expenses), ~replace_na(.,0))
Loans <- Loans %>% rowwise() %>%
    mutate(diff =gbv.original-principal-interest-penalties-expenses)%>%
    mutate(check_gbv = ifelse(abs(diff)<0.5,1,0)) %>% select(-diff)

#explore::explore(Loans)



# check that every guarantee is associated to a Loan ( so loan.id in Guarantee_table doesn't contain NAs)
#sum(!is.na(Guarantee_Raw$loan.id))== nrow(Guarantee_Raw)   #TRUE

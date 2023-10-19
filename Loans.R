#--------------------------------------#
#------            Loans        ------
#--------------------------------------#
source('functions.R')

#matrice_dipendenze <- find_dependencies_matrix(Loans_Raw)
#matrice_dipendenze <- round(matrice_dipendenze,2)


# status - ndg    status == bad
# type of product :
#Loans_Raw$type.of.product <- str_trim(Loans_Raw$type.of.product)
#poss_type <- Loans_Raw$type.of.product %>% n_distinct()
Loans <- Loans_Raw
Loans <- Loans %>% rename(id.loan = loan.id,
                              id.bor = ndg,
                              type = type.of.product,
                              status = loan.status,
                              gbv.original = gross.book.value,
                              interest = delay.compensation,
                              expenses = collection.expenses,
                              date.origination = intrum.acquisition.date,
                              date.status = date.of.default)
Loans <- Loans %>% mutate(id.group = NA,
                              originator = NA,
                              ptf = NA,
                              cluster.ptf = NA,
                              gbv.residual = NA,
                              penalties = NA,
                              date.last.act = NA,
                              flag.imputed = NA)
Loans <- Loans %>% select(id.loan, id.bor, id.group,originator,ptf,cluster.ptf,
                          type, status, gbv.original,gbv.residual,principal,interest,
                          penalties,expenses,date.origination,date.status,date.last.act,flag.imputed)

Loans <- Loans %>% mutate_at(c("gbv.original","interest","expenses","principal"), as.numeric)
Loans$expenses <- round(Loans$expenses, 2)


types_table <-  read_excel("File/Product Type Clustering.xlsx", sheet = "Foglio1")
types_table <- types_table %>% as.data.frame()
Loans <- map_types_Loans(Loans,types_table)

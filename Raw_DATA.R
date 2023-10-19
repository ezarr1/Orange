
#--------------------------------------#
#------          Borrower        ------
#--------------------------------------#



Borrower_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Borrower Data")

Borrower_Raw <- Borrower_Raw[-c(1,2,3,5),]
Borrower_Raw <- Borrower_Raw %>% row_to_names(1)
colnames(Borrower_Raw) <- tolower(colnames(Borrower_Raw))
Borrower_Raw[] <- lapply(Borrower_Raw,tolower)
#Borrower_Raw <- Borrower_Raw %>% distinct()

names(Borrower_Raw) <- colname_function(names(Borrower_Raw))
Borrower_Raw <- Borrower_Raw %>% rename(gbv = 'gbv.(€)')
Borrower_Raw$birth.date <- excel_numeric_to_date(as.numeric(Borrower_Raw$birth.date))

check_primary_key(Borrower_Raw,'ndg')

#--------------------------------------#
#------            Loans        ------
#--------------------------------------#

Loans_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Loans Data")

Loans_Raw <- Loans_Raw[-c(1,2,3,5),]
Loans_Raw <- Loans_Raw %>% row_to_names(1)
colnames(Loans_Raw) <- tolower(colnames(Loans_Raw))
Loans_Raw[] <- lapply(Loans_Raw,tolower)
#Loans_Raw <- Loans_Raw %>% distinct()

names(Loans_Raw) <- colname_function(names(Loans_Raw))
Loans_Raw <- Loans_Raw %>% rename('loan.id'='loan.id.no.',
                                  "gross.book.value" ="gross.book.value.(a+b+c).(€)",
                                  principal = "principal.(a).(€)",
                                  delay.compensation = "delay.compensation.(b).(€)",
                                  collection.expenses ="collection.expenses.c).(€)")
Loans_Raw$date.of.default <- gsub("(?<![0-9])0(?!\\d)", NA, Loans_Raw$date.of.default, perl = TRUE)

Loans_Raw$date.of.default <- excel_numeric_to_date(as.numeric(Loans_Raw$date.of.default ))
Loans_Raw$intrum.acquisition.date <- excel_numeric_to_date(as.numeric(Loans_Raw$intrum.acquisition.date))

check_primary_key(Loans_Raw,'loan.id')
r <- (nrow(Loans_Raw)== n_distinct(Loans_Raw$ndg))
sum(is.na(Loans_Raw$ndg))  # non ci sono NAs in ndg

#--------------------------------------#
#------         Co-Owner        ------
#--------------------------------------#

Co_Owner_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Co-owners Data")

Co_Owner_Raw <- Co_Owner_Raw[-c(1,2,3,5),]
Co_Owner_Raw <- Co_Owner_Raw %>% row_to_names(1)
colnames(Co_Owner_Raw) <- tolower(colnames(Co_Owner_Raw))
Co_Owner_Raw[] <- lapply(Co_Owner_Raw,tolower)
Co_Owner_Raw <- Co_Owner_Raw %>% distinct()

names(Co_Owner_Raw) <- colname_function(names(Co_Owner_Raw))

#--------------------------------------#
#------        Guarantee        ------
#--------------------------------------#

Guarantee_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Guarantees Data")

Guarantee_Raw <- Guarantee_Raw[-c(1,2,3,5),]
Guarantee_Raw <- Guarantee_Raw %>% row_to_names(1)
colnames(Guarantee_Raw) <- tolower(colnames(Guarantee_Raw))
Guarantee_Raw[] <- lapply(Guarantee_Raw,tolower)
#Guarantee_Raw <- Guarantee_Raw %>% distinct()

names(Guarantee_Raw) <- colname_function(names(Guarantee_Raw))
Guarantee_Raw <- Guarantee_Raw %>% rename(guarantor.id = "guarantor.id.no.",
                                          guarantee.id = "guarantee.id.no." ,
                                          loan.id = "loan.id.no.")
check_primary_key(Guarantee_Raw,'guarantee.id')  
# creare link table con id loan e guarantee id e poi distinct ---> guarantee forse pk

#--------------------------------------#
#------        Guarantor        ------
#--------------------------------------#

Guarantor_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Guarantors data")

Guarantor_Raw <- Guarantor_Raw[-c(1,2,3,5),]
Guarantor_Raw <- Guarantor_Raw %>% row_to_names(1)
colnames(Guarantor_Raw) <- tolower(colnames(Guarantor_Raw))
Guarantor_Raw[] <- lapply(Guarantor_Raw,tolower)
#Guarantor_Raw <- Guarantor_Raw %>% distinct()

names(Guarantor_Raw) <- colname_function(names(Guarantor_Raw))
Guarantor_Raw <- Guarantor_Raw %>% rename(guarantor.id = "guarantor.id.no.")
check_primary_key(Guarantor_Raw,'guarantor.id')  


#--------------------------------------#
#------       Legal DATA        ------
#--------------------------------------#

Legal_Raw <- read_excel("Data_Orange/4.1.1_Pjt_Negroni_-_Portfolio_Orange_-_Loan_Datatape.xlsx", sheet = "Legal data")

Legal_Raw  <- Legal_Raw [-c(1,2,3,5),]
Legal_Raw  <- Legal_Raw  %>% row_to_names(1)
colnames(Legal_Raw ) <- tolower(colnames(Legal_Raw ))
Legal_Raw [] <- lapply(Legal_Raw ,tolower)
names(Legal_Raw) <- colname_function(names(Legal_Raw))    

# number of legal loan 1563 instead of 1734
#check_col1_in_col2(Legal_Raw$loan.id.no.,Loans_Raw$loan.id) #true




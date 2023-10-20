#install.packages("SmartEDA")
library("SmartEDA")


Loans_Raw$loan.status <- factor(Loans_Raw$loan.status, levels = c("bad loan"))
Loans_Raw$type.of.product <- factor(Loans_Raw$type.of.product, 
                                    levels = c("mutui ipotecari","conti correnti","mutui chirografari",
                                               "anticipi su fatture","prestiti a commercianti","insoluti sconto",           
                                               "insoluti s.b.f.","anticipi export su fatture" ,"credito al consumo",
                                               "finanziamenti import","spese concorsuali","crediti di firma",        
                                               "spese","altro","non disponibile","mutui fondiari","finanziamenti industriali","insoluti",              
                                               "prestiti personali","revocatorie","scoperto di conto corrente",
                                               "anticipo fatture","prestio agrario","carte di credito","derivati"))
Loans_Raw$gross.book.value <- as.numeric(Loans_Raw$gross.book.value)
Loans_Raw$principal <- as.numeric(Loans_Raw$principal)
Loans_Raw$delay.compensation <- as.numeric(Loans_Raw$delay.compensation)
Loans_Raw$collection.expenses <- as.numeric(Loans_Raw$collection.expenses)
Overview_table_Loans_Raw <- ExpData(data=Loans_Raw,type=1)
Structure_table_Loans_Raw <- ExpData(data=Loans_Raw,type=2,fun = c("mean","median","var"))
Categorical_Loans_Raw <- ExpCTable(Loans_Raw,Target = NULL,margin = 1,clim = 25, nlim=0,bin = NULL,per=TRUE)



Borrower_Raw$gbv <- as.numeric(Borrower_Raw$gbv)
Borrower_Raw$debtor.status <- factor(Borrower_Raw$debtor.status)
Borrower_Raw$registry.type <- factor(Borrower_Raw$registry.type, levels = c("individual","legal person","co-owners"))
Borrower_Raw$deceased.debtor <- factor(Borrower_Raw$deceased.debtor)
Overview_table_Borrower_Raw <- ExpData(data=Borrower_Raw,type=1)
Structure_table_Borrower_Raw <- ExpData(data=Borrower_Raw,type=2,fun = c("mean","median","var"))
Categorical_Borrower_Raw <- ExpCTable(Borrower_Raw,Target = NULL,margin = 1,clim = 5, nlim=0,bin = NULL,per=TRUE)


Overview_table_Co_Owner_Raw <- ExpData(data=Co_Owner_Raw,type=1)
Structure_table_Co_Owner_Raw <- ExpData(data=Co_Owner_Raw,type=2,fun = c("mean","median","var"))

Guarantee_Raw$guarantee.type <- factor(Guarantee_Raw$guarantee.type)
Guarantee_Raw$guarantee.amount <- as.numeric(Guarantee_Raw$guarantee.amount)
Guarantee_Raw$subscription.date <- excel_numeric_to_date(as.numeric(ifelse(Guarantee_Raw$subscription.date <= 0,NA,Guarantee_Raw$subscription.date)))

Overview_table_Guarantee_Raw <- ExpData(data=Guarantee_Raw,type=1)
Structure_table_Guarantee_Raw <- ExpData(data=Guarantee_Raw,type=2,fun = c("mean","median","var"))
Categorical_Guarantee_Raw <- ExpCTable(Guarantee_Raw,Target = NULL,margin = 1,clim = 25, nlim=0,bin = NULL,per=TRUE)



Overview_table_Guarantor_Raw <- ExpData(data=Guarantor_Raw,type=1)
Structure_table_Guarantor_Raw <- ExpData(data=Guarantor_Raw,type=2,fun = c("mean","median","var"))

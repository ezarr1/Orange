# summary of loans:

#pag 26 only totals:
N_Loans <- n_distinct(Loans$id.loan)  #18617 ok
GBV_sum <- sum(Loans$gbv.original)  #177,3 ok
Average_Loan_size = GBV_sum/N_Loans  # 9,5 ok
Totals_Loans <- data.frame(`N Loans`=N_Loans,`Sum GBV`=GBV_sum,`Average Loan Size`= Average_Loan_size )



#pag 28:


gbv_sum_type <- Loans %>% group_by(type) %>% 
  summarize(sum_gbv = sum(gbv.original),perc = sum(gbv.original)/GBV_sum )
names(gbv_sum_type)<- c("Type","Sum.GBV"," % GBV")


Range_gbv <- c(0,5000,10000,25000,50000,Inf)
Range_gbv_labels <- c('0-5k','5k-10k','10k-25k','25k-50k','50k +')
Loans$range.gbv <- cut(Loans$gbv.original, breaks = Range_gbv, labels = Range_gbv_labels, include.lowest = TRUE)


gbv_by_loan_size <- Loans %>% group_by(range.gbv) %>% 
  summarize(sum_gbv = sum(gbv.original),perc = sum(gbv.original)/GBV_sum )
names(gbv_by_loan_size)<- c("Range.GBV","Sum.GBV"," % GBV")

#pag 29
oggi <- as.Date('2021-11-30')   # Put this date to have similar numbers
Loans <- Loans %>% mutate(vintage = round(as.numeric(oggi - date.status)/365,0))
Loans$vintage[is.na(Loans$vintage)] <- 0

Range_vintage <- c(0,8,11,14,17,20,Inf)
Range_vintage_labels <- c('0-8','9-11','12-14','15-17','18-20','20+')
Loans$range.vintage <- cut(Loans$vintage, breaks = Range_vintage, labels = Range_vintage_labels, include.lowest = TRUE)


gbv_by_vintage <- Loans %>% group_by(range.vintage) %>% 
  summarize(sum_gbv = sum(gbv.original),perc = sum(gbv.original)/GBV_sum )
names(gbv_by_vintage)<- c("Range.Vintage","Sum.GBV"," % GBV")

loan_size_by_vintage <- Loans %>% group_by(range.vintage) %>% 
  summarize(average_size = sum(gbv.original)/n_distinct(id.loan),perc = n_distinct(id.loan)/N_Loans )
# average size (up) and n of loans over total number of loans in %
names(loan_size_by_vintage)<- c("Range.Vintage","Average.Loan.Size"," % Loan")



wb <- createWorkbook()
addWorksheet(wb, sheetName = "Data Profiling Loans")
addWorksheet(wb, sheetName = "Data Profiling Borrowers")
addWorksheet(wb, sheetName = "Data Profiling Co-owners")
addWorksheet(wb, sheetName = "Data Profiling Guarantee")
addWorksheet(wb, sheetName = "Data Profiling Guarantors")

showGridLines(wb, sheet = 1, showGridLines = FALSE)
showGridLines(wb, sheet = 2, showGridLines = FALSE)
showGridLines(wb, sheet = 3, showGridLines = FALSE)
showGridLines(wb, sheet = 4, showGridLines = FALSE)
showGridLines(wb, sheet = 5, showGridLines = FALSE)

setColWidths(wb, sheet=1,cols = 1:7,widths = "auto")
setColWidths(wb, sheet=2,cols = 1:7,widths = "auto")
setColWidths(wb, sheet=3,cols = 1:7,widths = "auto")
setColWidths(wb, sheet=4,cols = 1:7,widths = "auto")
setColWidths(wb, sheet=5,cols = 1:7,widths = "auto")

percentage_rows <- createStyle(numFmt = "0.00%",fontSize = 10,halign = "right",valign = "center",fontColour = "black",wrapText = FALSE)

stringa <- "From the profiling on the Loans table, we see that the primary key is loan.id.\n The total number of loans is 18617, all of these loans have the same status (= bad loan).\n The main type of product is 'conti correnti' e the second is ' mutui fondiari'."
lines <- unlist(strsplit(stringa, "\n"))
df <- data.frame(Text = lines)
for(i in 1:nrow(df)){
  writeData(wb,1,df$Text[i],1,i)
}

writeData(wb, sheet = "Data Profiling Loans", x = "Overview Loans", startCol = 1, startRow = 10)
writeDataTable(wb, 1, x = Overview_table_Loans_Raw , startRow = 11,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Loans", x = "Structure Loans", startCol = 1, startRow = 30)
writeDataTable(wb, 1, x = Structure_table_Loans_Raw , startRow = 31,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Loans", x = "Categorical Loans", startCol = 1, startRow = 45)
writeDataTable(wb, 1, x = Categorical_Loans_Raw , startRow = 46,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")





stringa2 <- "From the profiling on the Borower table, we see that the primary key is ndg.\n The total number of borrowers is 13571.\n The distinct values of the fiscal code doesn't match the total number of borrowers with fiscal code \n Thus, we can conclude that we have some borrowers that belong to more than 1 group.Most of the borrowers belong to the category 'individual'."
lines2 <- unlist(strsplit(stringa2, "\n"))
df2 <- data.frame(Text = lines2)
for(i in 1:nrow(df2)){
  writeData(wb,2,df2$Text[i],1,i)
}

writeData(wb, sheet = "Data Profiling Borrowers", x = "Overview Borrower", startCol = 1, startRow = 10)
writeDataTable(wb, 2, x = Overview_table_Borrower_Raw , startRow = 11,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Borrowers", x = "Structure Borrowers", startCol = 1, startRow = 30)
writeDataTable(wb, 2, x = Structure_table_Borrower_Raw , startRow = 31,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Borrowers", x = "Categorical Borrowers", startCol = 1, startRow = 47)
writeDataTable(wb, 2, x = Categorical_Borrower_Raw , startRow = 48,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")


writeData(wb, sheet = "Data Profiling Co-owners", x = "Overview Co-owners", startCol = 1, startRow = 1)
writeDataTable(wb, 3, x = Overview_table_Co_Owner_Raw , startRow = 2,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Co-owners", x = "Structure Co-owners", startCol = 1, startRow = 20)
writeDataTable(wb, 3, x = Structure_table_Co_Owner_Raw , startRow = 21,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")


stringa3 <- "From the profiling on the Guarantee table, we see that the total number of distinct guarantees is 4086.\n The most frequent guarantee type is 'fidejussione', followed by 'confidi'."
lines3 <- unlist(strsplit(stringa3, "\n"))
df3 <- data.frame(Text = lines3)
for(i in 1:nrow(df3)){
  writeData(wb,4,df3$Text[i],1,i)
}
writeData(wb, sheet = "Data Profiling Guarantee", x = "Overview Guarantee", startCol = 1, startRow = 11)
writeDataTable(wb, 4, x = Overview_table_Guarantee_Raw , startRow = 12,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Guarantee", x = "Structure Guarantee", startCol = 1, startRow = 30)
writeDataTable(wb, 4, x = Structure_table_Guarantee_Raw, startRow = 31,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Guarantee", x = "Categorical Guarantee", startCol = 1, startRow = 45)
writeDataTable(wb, 4, x = Categorical_Guarantee_Raw , startRow = 46,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")


stringa4 <- "From the profiling on the Guarantee table, we see that the primary key is 'guarantor.id' and the are 3155 guarantors."
lines4 <- unlist(strsplit(stringa4, "\n"))
df4 <- data.frame(Text = lines4)
for(i in 1:nrow(df4)){
  writeData(wb,5,df4$Text[i],1,i)
}

writeData(wb, sheet = "Data Profiling Guarantors", x = "Overview Guarantors", startCol = 1, startRow = 6)
writeDataTable(wb, 5, x = Overview_table_Guarantor_Raw , startRow = 7,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
writeData(wb, sheet = "Data Profiling Guarantors", x = "Structure Guarantors", startCol = 1, startRow = 25)
writeDataTable(wb, 5, x = Structure_table_Guarantor_Raw, startRow = 26,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")


saveWorkbook(wb, file = "File/Profiling.xlsx", overwrite = TRUE)
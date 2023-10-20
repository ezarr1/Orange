wb <- createWorkbook()
addWorksheet(wb, sheetName = "Data Loans")
addWorksheet(wb, sheetName = "Data Borrowers")


showGridLines(wb, sheet = 1, showGridLines = FALSE)
showGridLines(wb, sheet = 2, showGridLines = FALSE)


setColWidths(wb, sheet=1,cols = 1:7,widths = "auto")
setColWidths(wb, sheet=2,cols = 1:7,widths = "auto")


percentage_rows <- createStyle(numFmt = "0.00%",fontSize = 10,halign = "right",valign = "center",fontColour = "black",wrapText = FALSE)
Milion_rows <- createStyle(
  numFmt = "0.0,,\"M\"",
  fontSize = 10,
  halign = "right",
  valign = "center",
  fontColour = "black",
  wrapText = FALSE
)
thousands_rows <- createStyle(
  numFmt = "0.0,\"k\"",
  fontSize = 10,
  halign = "right",
  valign = "center",
  fontColour = "black",
  wrapText = FALSE
)


stringa <- "Loans Report \n ciao samet \n "
lines <- unlist(strsplit(stringa, "\n"))
df <- data.frame(Text = lines)
for(i in 1:nrow(df)){
  writeData(wb,1,df$Text[i],1,i)
}

writeData(wb, sheet = "Data Loans", x = "Totals", startCol = 1, startRow = 5)
writeDataTable(wb, 1, x = Totals_Loans , startRow = 6,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
addStyle(wb, sheet = "Data Loans", style = Milion_rows, rows = 7, cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Loans", style = thousands_rows, rows = 7, cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Loans", x = "GBV by Product type", startCol = 1, startRow = 9)
writeDataTable(wb, 1, x = gbv_sum_type , startRow = 10,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
addStyle(wb, sheet = "Data Loans", style = Milion_rows, rows = c(11:17), cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Loans", style = percentage_rows, rows = c(11:17), cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Loans", x = "GBV by loan size", startCol = 1, startRow = 19)
writeDataTable(wb, 1, x = gbv_by_loan_size , startRow = 20,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
addStyle(wb, sheet = "Data Loans", style = Milion_rows, rows = c(21:25), cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Loans", style = percentage_rows, rows = c(21:25), cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Loans", x = "GBV by default vintage", startCol = 1, startRow = 27)
writeDataTable(wb, 1, x = gbv_by_vintage , startRow = 28,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
addStyle(wb, sheet = "Data Loans", style = Milion_rows, rows = c(29:34), cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Loans", style = percentage_rows, rows = c(29:34), cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Loans", x = "Loans by default vintage", startCol = 1, startRow = 36)
writeDataTable(wb, 1, x = loan_size_by_vintage , startRow = 37,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")
addStyle(wb, sheet = "Data Loans", style = thousands_rows, rows = c(38:43), cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Loans", style = percentage_rows, rows = c(38:43), cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Borrowers", x = "Totals", startCol = 1, startRow = 5)
writeDataTable(wb, 2, x = Totals_Borrowers , startRow = 6,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")

addStyle(wb, sheet = "Data Borrowers", style = Milion_rows, rows = 7, cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Borrowers", style = thousands_rows, rows = 7, cols = 3 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Borrowers", x = "Geographical Destribuition", startCol = 1, startRow = 9)
writeDataTable(wb, 2, x = Borrowers_area_table , startRow = 10,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")

addStyle(wb, sheet = "Data Borrowers", style = percentage_rows, rows = c(11:15), cols = 3 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Borrowers", style = percentage_rows, rows = c(11:15), cols = 2 ,stack = TRUE,gridExpand = TRUE)

writeData(wb, sheet = "Data Borrowers", x = "GBV by borrower province", startCol = 1, startRow = 19)
writeDataTable(wb, 2, x = Top_5_province_by_gbv , startRow = 20,
               startCol = 1,  withFilter = FALSE, tableStyle =  "TableStyleMedium2")

addStyle(wb, sheet = "Data Borrowers", style = Milion_rows, rows = c(21:25), cols = 2 ,stack = TRUE,gridExpand = TRUE)
addStyle(wb, sheet = "Data Borrowers", style = thousands_rows, rows = c(21:25), cols = 4 ,stack = TRUE,gridExpand = TRUE)

insertImage(wb,sheet = "Data Borrowers","File/province_plot.png",startCol = 10, startRow = 9, width = 4.5, height = 4.5, dpi = 300)
insertImage(wb,sheet = "Data Borrowers","File/Pie_Chart.png",startCol = 16, startRow = 9, width = 4.5, height = 4.5, dpi = 300)
insertImage(wb,sheet = "Data Loans","File/Product_Type.png",startCol = 9, startRow = 9, width = 4.5, height = 4.5, dpi = 300)
insertImage(wb,sheet = "Data Loans","File/Loan_Size.png",startCol = 9, startRow = 20, width = 4.5, height = 4.5, dpi = 300)
insertImage(wb,sheet = "Data Loans","File/Loan_Size_Vintage.png",startCol = 9, startRow = 41, width = 4.5, height = 4.5, dpi = 300)
insertImage(wb,sheet = "Data Loans","File/GBV_Vintage.png",startCol = 9, startRow = 31, width = 4.5, height = 4.5, dpi = 300)
saveWorkbook(wb, file = "File/Teaser.xlsx", overwrite = TRUE)
wb <- createWorkbook()
addWorksheet(wb, sheetName = "Data Loans")
addWorksheet(wb, sheetName = "Data Borrowers")
addWorksheet(wb, sheetName = "Data Co-owners")
addWorksheet(wb, sheetName = "Data Guarantee")
addWorksheet(wb, sheetName = "Data Guarantors")

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

saveWorkbook(wb, file = "File/Teaser.xlsx", overwrite = TRUE)
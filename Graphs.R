
#### GBV by province GRAPH bar chart (horizontal)

province_plot <- Top_5_province_by_gbv %>% mutate(`Province` = fct_reorder(`Province`,`Sum.GBV`)) %>% 
  ggplot(aes(x = `Sum.GBV` , y = `Province`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6)), hjust = -0.1) +
  xlab("Sum of GBV (Millions)") +
  theme_bw() +
  scale_x_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))

province_plot

ggsave("File/province_plot.png",plot = province_plot,width = 8,height = 6,units = "in")



##### Pie chart for Geographical Distribution of Borrwers BY GBV
myPalette <- c("#FF5733", "#33FF57", "#5733FF", "#FFFF33", "#33FFFF")

# Your pie chart code
pie_chart <- ggplot(data = Borrowers_area_table, aes(x = 1, y = ` % GBV`, fill = Borrowers_area_table$Area)) +
  geom_bar(stat = "identity", width = 1) +
  scale_fill_manual(values = myPalette) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(fill = "Areas") +
  ggtitle("GBV Distribution by Area")

# Adding labels with percentages and removing names
pie_chart <- pie_chart +
  geom_text(data = Borrowers_area_table, aes(label = scales::percent(` % GBV` / sum(` % GBV`)), x = 1.7), position = position_stack(vjust = 0.5))

print(pie_chart)

ggsave("File/Pie_Chart.png",plot = pie_chart)

#gbv_sum_type$` % GBV` <- gbv_sum_type$` % GBV`/100

Product_Type_Plot <- gbv_sum_type %>% mutate(`Type` = fct_reorder(`Type`,desc(` % GBV`))) %>% 
  ggplot(aes(x =factor(`Type`) , y = ` % GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV`),group = `Type`, y = ` % GBV` / 2, vjust = 0.5,hjust = "center")) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6),vjust = -0.8, hjust = 0.4)) +
  xlab("Type Of Product") +
  theme_bw() +
  scale_y_continuous(labels = scales::percent_format(scale = 1,accuracy = 1))
  

Product_Type_Plot

ggsave("File/Product_Type.png",plot = Product_Type_Plot,width = 8,height = 6,units = "in")

#gbv_by_loan_size$` % GBV` <- gbv_by_loan_size$` % GBV`/100

loan_size_plot <- gbv_by_loan_size %>% 
  ggplot(aes(x =factor(`Range.GBV`) , y = ` % GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV`),group = `Range.GBV`, y = ` % GBV` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV`/1e6 ),vjust = -0.8, hjust = 0.4)) +
  xlab("Range of GBV") +
  theme_bw() +
  scale_y_continuous(labels = scales::percent_format(scale = 1, accuracy = 1))


loan_size_plot

ggsave("File/Loan_Size.png",plot = loan_size_plot,width = 8,height = 6,units = "in")

#loan_size_by_vintage$` % Loan` <- loan_size_by_vintage$` % Loan`*100

loan_size_vintage_plot <- loan_size_by_vintage %>%  
  ggplot(aes(x =factor(`Range.Vintage`) , y = ` % Loan`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1f%%", ` % Loan`),group = `Range.Vintage`, y = ` % Loan` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1fK", `Average.Loan.Size`/1000)),vjust = -0.8, hjust = 0.4) +
  xlab("Years") +
  theme_bw() +
  scale_y_continuous(labels = scales::percent_format(scale = 1, accuracy = 1))


loan_size_vintage_plot

ggsave("File/Loan_Size_Vintage.png",plot = loan_size_vintage_plot,width = 8,height = 6,units = "in")

#gbv_by_vintage$` % GBV` <- gbv_by_vintage$` % GBV`*100

gbv_by_vintage_plot <- gbv_by_vintage %>% 
  ggplot(aes(x =factor(`Range.Vintage`) , y = ` % GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV`),group = `Range.Vintage`, y = ` % GBV` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6)),vjust = -0.8, hjust = 0.4) +
  xlab("Years") +
  theme_bw() +
  scale_y_continuous(labels = scales::percent_format(scale = 1, accuracy = 1))


gbv_by_vintage_plot


ggsave("File/GBV_Vintage.png",plot = gbv_by_vintage_plot,width = 8,height = 6,units = "in")


##### Pie chart for Geographical Distribution of Borrwers BY GBV
myPalette <- c( "#5798FF", "#33FFFF")



# Your pie chart code
pie_chart_gbv <- ggplot(data = gbv_perc_by_Guarantee, aes(x = 1, y = Perc, fill = flag.guarantee)) +
  geom_bar(stat = "identity", width = 1) +
  scale_fill_manual(values = myPalette) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(fill = "Guarantee") +
  ggtitle("GBV Distribution by Guarantee Presence")



# Adding labels with percentages and removing names
pie_chart_gbv <- pie_chart_gbv +
  geom_text(data = gbv_perc_by_Guarantee, aes(label = scales::percent(Perc / sum(Perc)), x = 1.7), position = position_stack(vjust = 0.5))



print(pie_chart_gbv)



ggsave("File/Pie_Chart_gbv.png",plot = pie_chart_gbv)







##### Pie chart for Geographical Distribution of Borrwers BY GBV
myPalette <- c(  "orange", "yellow","#CFBB8B","#5B491C")



# Your pie chart code
pie_chart_gbv_type <- ggplot(data = Gbv_with_Guarantee_type, aes(x = 1, y = Perc, fill = type)) +
  geom_bar(stat = "identity", width = 1) +
  scale_fill_manual(values = myPalette) +
  coord_polar(theta = "y") +
  theme_void() +
  labs(fill = "Guarantee") +
  ggtitle("GBV Distribution by Guarantee Presence")



# Adding labels with percentages and removing names
pie_chart_gbv_type <- pie_chart_gbv_type +
  geom_text(data = Gbv_with_Guarantee_type, aes(label = scales::percent(Perc / sum(Perc)), x = 1.7), position = position_stack(vjust = 0.5))



print(pie_chart_gbv_type)



ggsave("File/Pie_Chart_gbv_type.png",plot = pie_chart_gbv_type)


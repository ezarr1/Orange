
#### GBV by province GRAPH bar chart (horizontal)

province_plot <- Top_5_province_by_gbv %>% mutate(`Province` = fct_reorder(`Province`,`Sum.GBV`)) %>% 
  ggplot(aes(x = `Sum.GBV` , y = `Province`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6)), hjust = -0.1) +
  xlab("Sum of GBV (Millions)") +
  theme_bw() +
  scale_x_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))

province_plot

ggsave("File/province_plot.png",plot = province_plot)



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

Product_Type_Plot <- gbv_sum_type %>% mutate(`Type` = fct_reorder(`Type`,desc(`Sum.GBV`))) %>% 
  ggplot(aes(x =factor(`Type`) , y = `Sum.GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6),group = `Type`, y = `Sum.GBV` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV` * 100)),vjust = -0.8, hjust = 0.4) +
  xlab("Type Of Product") +
  theme_bw() +
  scale_y_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))
  

Product_Type_Plot

ggsave("File/Product_Type.png",plot = Product_Type_Plot)

loan_size_plot <- gbv_by_loan_size %>% 
  ggplot(aes(x =factor(`Range.GBV`) , y = `Sum.GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6),group = `Range.GBV`, y = `Sum.GBV` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV` * 100)),vjust = -0.8, hjust = 0.4) +
  xlab("Range of GBV") +
  theme_bw() +
  scale_y_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))


loan_size_plot

ggsave("File/Loan_Size.png",plot = loan_size_plot)

loan_size_vintage_plot <- loan_size_by_vintage %>%  
  ggplot(aes(x =factor(`Range.Vintage`) , y = `Average.Loan.Size`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fK", `Average.Loan.Size` / 1000),group = `Range.Vintage`, y = `Average.Loan.Size` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1f%%", ` % Loan` * 100)),vjust = -0.8, hjust = 0.4) +
  xlab("Years") +
  theme_bw() +
  scale_y_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))


loan_size_vintage_plot

ggsave("File/Loan_Size_Vintage.png",plot = loan_size_vintage_plot)

gbv_by_vintage_plot <- gbv_by_vintage %>% 
  ggplot(aes(x =factor(`Range.Vintage`) , y = `Sum.GBV`)) +
  geom_col(fill = "#57c1ef", alpha = 0.6, width = 0.4) +
  geom_text(aes(label = sprintf("%.1fM", `Sum.GBV` / 1e6),group = `Range.Vintage`, y = `Sum.GBV` / 2), vjust = 0.5,hjust = "center") +
  geom_text(aes(label = sprintf("%.1f%%", ` % GBV` * 100)),vjust = -0.8, hjust = 0.4) +
  xlab("Years") +
  theme_bw() +
  scale_y_continuous(labels = scales::comma_format(scale = 1e-6, big.mark = ","))


gbv_by_vintage_plot

ggsave("File/GBV_Vintage.png",plot = gbv_by_vintage_plot)





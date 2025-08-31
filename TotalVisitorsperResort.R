library(dplyr)
library(tidyr)
library(ggplot2)

# Convert from wide to long format (Resort column + Visitors column)
ski_long <- ski_data %>%
  pivot_longer(
    cols = -c(Year, Week),         # keep Year & Week, make all other cols into 'Resort'
    names_to = "Resort",
    values_to = "Visitors"
  )

# Summarise total visitors per resort (exclude COVID years)
resort_totals <- ski_long %>%
  filter(!Year %in% c(2020, 2021)) %>%
  group_by(Resort) %>%
  summarise(total_visitors = sum(Visitors, na.rm = TRUE), .groups = "drop")

# Plot bar chart
ggplot(resort_totals, aes(x = reorder(Resort, total_visitors), y = total_visitors, fill = total_visitors)) +
  geom_col() +
  geom_text(aes(label = format(total_visitors, big.mark = ",")), 
            hjust = -0.1, color = "black", size = 3.5) +
  coord_flip() +
  labs(
    title = "Total Visitors per Resort (2014–2024, excl. 2020–21)",
    x = "Resort",
    y = "Total Visitors"
  ) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  theme_minimal()


library(dplyr)
library(ggplot2)
library(tidyr)

# Step 0: Reshape ski_data into long format
ski_long <- ski_data %>%
  pivot_longer(
    cols = -c(Year, Week), 
    names_to = "Resort", 
    values_to = "Visitors"
  )

# Step 1: Filter dataset for 2018–2024, excluding 2020 and 2021
visitation_filtered <- ski_long %>%
  filter(Year >= 2018 & Year <= 2024, !Year %in% c(2020, 2021))

# Step 2: Calculate average visitors per resort per week
weekly_avg <- visitation_filtered %>%
  group_by(Resort, Week) %>%
  summarise(avg_visitors = mean(Visitors, na.rm = TRUE), .groups = "drop")

# Step 3: Plot line graph
ggplot(weekly_avg, aes(x = Week, y = avg_visitors, color = Resort)) +
  # shaded region (transparent)
  geom_rect(aes(xmin = 5, xmax = 7, ymin = -Inf, ymax = Inf),
            fill = "grey", alpha = 0.1, inherit.aes = FALSE) +
  # dotted borders
  geom_vline(xintercept = 5, linetype = "dotted", color = "blue", size = 1) +
  geom_vline(xintercept = 7, linetype = "dotted", color = "blue", size = 1) +
  # lines and points
  geom_line(size = 1.2) +
  geom_point(size = 2) +
  labs(
    title = "Average Weekly Visitation (2018–2024, excl. COVID Years)",
    subtitle = "Shaded area = School Holidays (Weeks 5–7)",
    x = "Week (1–15)",
    y = "Average Visitors",
    color = "Resort"
  ) +
  theme_minimal()




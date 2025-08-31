library(dplyr)
library(ggplot2)

ski_data <- read.csv("Book1.csv")

# Removing COVID years 
ski_clean <- ski_data %>%
  filter(!Year %in% c(2020, 2021))

# Get yearly totals per resort 
resort_yearly <- ski_clean %>%
  group_by(Year) %>%
  summarise(across(-Week, sum, na.rm = TRUE), .groups = "drop")

# Converting from wide to long format
library(tidyr)
resort_yearly_long <- resort_yearly %>%
  pivot_longer(
    cols = -Year,
    names_to = "Resort",
    values_to = "Total_Visitors"
  )

# Calculating year-on-year percentage change 
resort_yoy <- resort_yearly_long %>%
  arrange(Resort, Year) %>%
  group_by(Resort) %>%
  mutate(
    yoy_change = (Total_Visitors - lag(Total_Visitors)) / lag(Total_Visitors) * 100
  ) %>%
  ungroup()

# Calculating trend coefficient for each resort
# Fit a linear model: Total_Visitors ~ Year
resort_trends <- resort_yearly_long %>%
  group_by(Resort) %>%
  do({
    model <- lm(Total_Visitors ~ Year, data = .)
    data.frame(trend_coef = coef(model)[["Year"]]) # slope of the line
  }) %>%
  ungroup()

print(resort_yoy)

  # Merging trend back into summary 
resort_summary <- resort_yoy %>%
  group_by(Resort) %>%
  summarise(
    avg_yoy_change = mean(yoy_change, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  left_join(resort_trends, by = "Resort") %>%
  arrange(desc(trend_coef))  # rank by "up and coming"

# Recomputing trends with percentage growth
resort_trends_pct <- resort_yearly_long %>%
  group_by(Resort) %>%
  do({
    model <- lm(Total_Visitors ~ Year, data = .)
    slope <- coef(model)[["Year"]]  # raw slope
    avg_visitors <- mean(.$Total_Visitors, na.rm = TRUE)
    pct_growth <- (slope / avg_visitors) * 100
    data.frame(
      trend_coef = slope,
      avg_visitors = avg_visitors,
      pct_growth_per_year = pct_growth
    )
  }) %>%
  ungroup()

# View results
resort_trends_pct %>%
  arrange(desc(pct_growth_per_year))


library(ggplot2)

# Bar chart of % growth per resort
library(ggplot2)

library(ggplot2)

ggplot(resort_trends_pct, aes(x = reorder(Resort, pct_growth_per_year), 
                              y = pct_growth_per_year, 
                              fill = pct_growth_per_year)) +
  geom_col() +
  geom_text(aes(label = sprintf("%.2f%%", pct_growth_per_year)),
            hjust = ifelse(resort_trends_pct$pct_growth_per_year > 0, -0.1, 1.1),
            color = "black", size = 3.5) +
  coord_flip() +
  labs(
    title = "Average YoY % Growth Rate of Visitors by Resort (Excl. COVID Years)",
    x = "Resort",
    y = "Average % Growth per Year"
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%")) +
  scale_fill_gradient2(low = "firebrick", mid = "gold", high = "forestgreen", midpoint = 0) +
  theme_minimal()


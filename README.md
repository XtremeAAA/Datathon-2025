# Datathon-2025

## Team Members
- Achint Singh
- Anirudh Gupta
- Parva Teli-Shah
- Suhaas Gambhir


## Project Overview

This project analyzes ski resort visitation and climate data from 2010–2024, focusing on the relationship between weather and weekly visitor numbers at various Australian ski locations.

The repository contains R and Python scripts for data analysis, visualization, and reporting.

---

## Folder Structure

```
.
├── Avg YoY growthNEW2.R
├── Book1.csv
├── Book2.csv
├── Book3.csv
├── City proximity chart - Made with Notion.png
├── Climate Data.csv
├── ProximitySpiderChart.R
├── README.md
├── TotalVisitorsperResort.R
├── Visitation Data.csv
├── weather.py
```

---

## Data Sources

- **Climate Data.csv**: Contains daily weather data (temperature, rainfall, etc.) for the ski region.
- **Visitation Data.csv**: Contains weekly visitor numbers for each ski resort/location.
- **enso_ski_season_2010_2024.csv**: ENSO phase (La Niña, El Niño, Neutral) for each week and year.

---

## Main Analyses & Scripts

### Python

- **weather.py**  
  Visualizes rainfall and visitor numbers by week and year for each resort.  
  - Plots rainfall as bars and visitors as a line (with optional log/sqrt transformation).
  - Supports ENSO phase background coloring.
  - Subplots for each year, grouped by resort.
  - X-axis always matches weeks present in visitation data.

### R

- **Avg YoY growthNEW2.R**  
  Calculates and visualizes average year-over-year growth in visitation.
- **ProximitySpiderChart.R**  
  Creates a spider chart for city proximity to resorts.
- **TotalVisitorsperResort.R**  
  Summarizes total visitors per resort.

---

## How to Run

1. **Python Analysis**
   - Install requirements:  
     `pip install pandas matplotlib numpy`
   - Run `weather.py` to generate rainfall and visitation plots for each resort.

2. **R Analysis**
   - Open the `.R` scripts in RStudio or your preferred R environment.
   - Run the scripts for growth, proximity, and summary analyses.

---

import pandas as pd
import matplotlib.pyplot as plt

# pick the two stations
stations_of_interest = [83084, 71075]
cli_df = pd.read_csv("Datathon-2025/Climate Data.csv")
df = cli_df.copy()

# ensure numeric
df["Year"] = pd.to_numeric(df["Year"], errors="coerce").astype("Int64")
df["Rainfall amount (millimetres)"] = pd.to_numeric(df["Rainfall amount (millimetres)"], errors="coerce")

# filter to only our stations
df_sub = df[df["Bureau of Meteorology station number"].isin(stations_of_interest)]

# group by station x year -> sum of rainfall
annual = (
    df_sub.groupby(["Bureau of Meteorology station number", "Year"])["Rainfall amount (millimetres)"]
          .sum()
          .reset_index()
)

# pivot to wide: Year vs each station
annual_wide = annual.pivot(index="Year", columns="Bureau of Meteorology station number", 
                           values="Rainfall amount (millimetres)")

# plot
plt.figure(figsize=(10,6))
for stn in stations_of_interest:
    plt.plot(annual_wide.index, annual_wide[stn], marker="o", linewidth=2, label=f"Station {stn}")

plt.title("Annual Rainfall Comparison: Falls Creek (83084) vs Perisher (71075)")
plt.xlabel("Year")
plt.ylabel("Annual Rainfall (mm)")
plt.grid(True, alpha=0.3)
plt.legend()
plt.tight_layout()
plt.show()

# optional: inspect the data
print(annual_wide.head())

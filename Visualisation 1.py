import pandas as pd
import matplotlib.pyplot as plt

# Load the data
df = pd.read_csv("Visitation Data.csv")

# Clean up: drop rows where Year or Week is missing
df = df.dropna(subset=["Year", "Week"])

# Convert Year and Week to integers
df["Year"] = df["Year"].astype(int)
df["Week"] = df["Week"].astype(int)

# List of parks (skip Year and Week columns)
parks = [col for col in df.columns if col not in ["Year", "Week"]]
years = sorted(df["Year"].unique())

for park in parks:
    park_df = df.dropna(subset=[park])
    plt.figure(figsize=(10, 5))
    for year in years:
        yearly = park_df[park_df["Year"] == year]
        plt.plot(yearly["Week"], yearly[park], marker='o', label=str(year))
    plt.title(f"{park} Visitation by Week (All Years)")
    plt.xlabel("Week")
    plt.ylabel("Visitors")
    plt.grid(True)
    plt.legend(title="Year")
    plt.tight_layout()
    plt.show()
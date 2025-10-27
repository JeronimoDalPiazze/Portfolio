import os
import pandas as pd
import requests
from io import StringIO
from pathlib import Path

# Directory to save the files (data/raw)
RAW_PATH = Path(os.getenv("RAW_DATA_PATH", "./data/raw"))
RAW_PATH.mkdir(parents=True, exist_ok=True)

# URLs of the CSV files
FILES = {
    "crude-oil-exports-by-destination-annual.csv":
        "https://www.cer-rec.gc.ca/open/imports-exports/crude-oil-exports-by-destination-annual.csv",
    "crude-oil-exports-by-destination-monthly.csv":
        "https://www.cer-rec.gc.ca/open/imports-exports/crude-oil-exports-by-destination-monthly.csv",
    "crude-oil-exports-by-type-annual.csv":
        "https://www.cer-rec.gc.ca/open/imports-exports/crude-oil-exports-by-type-annual.csv",
    "crude-oil-exports-by-type-monthly.csv":
        "https://www.cer-rec.gc.ca/open/imports-exports/crude-oil-exports-by-type-monthly.csv",
    "crude-oil-exports-data-dictionary.csv":
        "https://www.cer-rec.gc.ca/open/imports-exports/crude-oil-exports-data-dictionary.csv",
}

def download_csv(name: str, url: str) -> None:
    """Download a CSV file and save it under data/raw"""
    print(f"⬇️  Downloading {name} ...")
    resp = requests.get(url, timeout=30)
    resp.raise_for_status()

    # Validate CSV using pandas
    df = pd.read_csv(StringIO(resp.text))
    print(f"✅ {name}: {len(df)} rows, {len(df.columns)} columns")

    # Save locally
    out_path = RAW_PATH / name
    df.to_csv(out_path, index=False)
    print(f"💾 File saved to {out_path}\n")

def main():
    for name, url in FILES.items():
        try:
            download_csv(name, url)
        except Exception as e:
            print(f"❌ Error downloading {name}: {e}\n")

if __name__ == "__main__":
    main()

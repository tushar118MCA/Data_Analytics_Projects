# 📡 Telecommunication Financial Dashboard

## 📌 Project Overview

The **Telecommunication Financial Dashboard** is a data analytics project that turns raw XBRL-style profit & loss filings for Indian telecom companies into a clean, ratio-driven Power BI dashboard. It covers the full pipeline: extracting company filings from a PostgreSQL database, isolating the Telecommunication sector, deriving standard financial metrics (COGS, EBITDA, EBIT, PBT, PAT, and margin %'s) with SQL, and visualizing year-over-year performance across companies.

This project was built using **PostgreSQL** for data storage, **Python (Jupyter Notebook)** for ETL, **SQL** for financial ratio calculations, and **Power BI** for the final dashboard.

---

## 🚀 Features

### 📊 Analysis Features

* Filter raw filings by Sector and Igroup (e.g., Telecommunication → Telecom - Services)
* Automatic pivoting of raw XBRL line items into per-company, per-year records
* Derived financial metrics: Total Revenue, Gross Margin, EBITDA,Tax Expense, PAT
* Derived ratios: Gross Margin %, Operating Profit %, PBT %, PAT %
* Company-to-company and year-over-year comparison

### 📈 Dashboard Features

* KPI cards for Revenue, EBITDA, Operating Profit %, PAT %, and Total Expenses
* Revenue vs. PAT trend line chart across financial years
* Operating Profit % by company (clustered column chart)
* EBITDA share by company/year (pie chart)
* Total Expenses broken out by line item (bar chart)
* Interactive slicers for Company Symbol and Financial Year
* Full line-item P&L statement table page

---

## 🛠️ Technologies Used

| Technology         | Purpose                          |
| ------------------ | --------------------------------- |
| PostgreSQL         | Source & derived data storage     |
| Python (pandas, psycopg2, SQLAlchemy) | ETL / data extraction |
| Jupyter Notebook    | ETL workflow (`FS_Analysis_Project1.ipynb`) |
| SQL                 | Financial ratio derivation (`Yearly_Data.sql`) |
| Excel (.xlsx / .csv) | Intermediate & exported datasets |
| Power BI            | Final dashboard (`.pbix`)         |

---

## 📂 Project Structure

```text
Telecommunication-Financial-Dashboard/
├── infi_2024.csv                                  # Raw P&L extract, all sectors
├── FS_Analysis_Project1.ipynb                      # ETL notebook (Sector/Igroup extraction)
├── Sector_Igroup.csv                                # Sector → Igroup lookup reference
├── Telecommunication_Telecom_-_Services_data.xlsx   # Same data, alt export name
├── Yearly_Data.sql                                  # Pivots raw data → financial ratios
├── Derived_Yearly_ratio.csv                         # Final ratio table (dashboard source)
└── Telecommunication_Financial_Dashboard.pbix        # Power BI report
```

---

## 💾 Database

* Database: **PostgreSQL** (`FS_Analysis`)
* Key source tables: `"Company"`, `"P&L YTD"`
* Generated tables: `pnl_telecommunication_telecom__services`, `derived_yearly_ratios`
* Exported files: `Derived_Yearly_ratio.csv`, `pnl_telecommunication_telecom__services.xlsx`

The database stores information such as:

* Company master data (Symbol, Name, Sector, Industry, Igroup, MarketCap)
* Raw P&L line items per company/year/quarter (XBRL element values)
* Derived yearly financial ratios per company

---

## ⚙️ Installation Guide

### Step 1: Set Up PostgreSQL

Install PostgreSQL and create a database named `FS_Analysis` (or update the notebook/scripts to match your own database name).

### Step 2: Load the Source Data

Import your `"Company"` and `"P&L YTD"` tables into `FS_Analysis` (these hold the raw filings that `infi_2024.csv` was originally extracted from).

### Step 3: Configure the Notebook Connection

Open `FS_Analysis_Project1.ipynb` and update the connection block with your local credentials:

```python
conn = psycopg2.connect(
    host="localhost",
    database="FS_Analysis",
    user="postgres",
    password="your_password",
    port="5432"
)
```

### Step 4: Run the ETL Notebook

Run all cells in `FS_Analysis_Project1.ipynb`. When prompted, enter:

```text
Sector: Telecommunication
Igroup: Telecom - Services
```

This creates the `pnl_telecommunication_telecom__services` table and exports its matching Excel file.

### Step 5: Derive the Financial Ratios

Run `Yearly_Data.sql` against `FS_Analysis`. This pivots the raw table into the `derived_yearly_ratios` table — export it as `Derived_Yearly_ratio.csv` for the dashboard.

### Step 6: Open the Dashboard

Open `Telecommunication_Financial_Dashboard.pbix` in **Power BI Desktop**, and if needed, point its data source at your local `Derived_Yearly_ratio.csv`.

Then in Power BI:

```text
Home → Refresh
```

to reload the visuals against your local data.

---

## 📸 Screenshots

Add screenshots of your dashboard here.

Example:

* P&L Statement Page
![image alt](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/4d655d2bed4440165f6d0780b63b5bc83d6c92a5/Telecommunication_Dashboard_Project/P%26l%20Statement.png)

* Dashboard Page (KPI cards + charts)
![image alt](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/4d655d2bed4440165f6d0780b63b5bc83d6c92a5/Telecommunication_Dashboard_Project/Telecommunication_Dashboard.png)


---

## 🎯 Learning Outcomes

This project helped in understanding:

* Financial statement analysis (COGS, EBITDA, EBIT, PAT, Operating Profit, Total Expenses)
* SQL pivoting and conditional aggregation
* ETL design with Python, psycopg2, and SQLAlchemy
* Working with XBRL-style taxonomy data
* Power BI report design (cards, charts, slicers)
* End-to-end data pipeline design (raw data → database → BI tool)

---

## 🔮 Future Enhancements

* Parameterize the dashboard to support multiple sectors at once
* Add a data dictionary mapping raw `element_id` codes to readable names
* Automate the notebook → SQL → Power BI refresh with a scheduled pipeline
* Move database credentials to environment variables
* Add quarterly (not just yearly) trend views
* Add peer benchmarking against non-telecom sectors

---

##

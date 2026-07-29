# 👥 HR Analytics Dashboard

## 📌 Project Overview

The **HR Analytics Dashboard** is a data analytics project that turns a raw employee export into a clean, insight-ready workforce dataset and visualizes it in a Power BI dashboard. It covers the full pipeline: cleaning and feature-engineering raw HR records in Python, loading them into PostgreSQL, running SQL analysis on headcount, pay, and diversity, and presenting the results across three interactive dashboard pages.

This project was built using **Python (Jupyter Notebook)** for data cleaning, **PostgreSQL** for storage and analysis, **SQL** for HR metrics, and **Power BI** for the final dashboard.

---

## 🚀 Features

### 🧹 Data Cleaning Features

* Standardize raw column names (spaces, casing, symbols)
* Parse and validate hire dates
* Compute tenure in years for every employee
* Compute bonus amount from salary and bonus %
* Bucket employees into salary bands
* Flag duplicate employee IDs

### 📊 Analytics Features

* Headcount by department and business unit
* Average, minimum, and maximum salary by department
* Gender pay comparison by department
* Salary ranking within each department
* Running total of bonuses paid, ordered by hire date
* Year-over-year hiring trend
* Ethnicity and gender diversity breakdown
* Employees earning above their department's average
* City-level headcount for geographic reporting

### 📈 Dashboard Features

* Department page with headcount, salary range, and business unit breakdown
* Employee page with demographics, salary bands, and hiring trend
* Combined HR Analysis page with bonus, salary, and diversity visuals
* Interactive slicers for Department, Business Unit, Country, City, Gender, and Hire Date

---

## 🛠️ Technologies Used

| Technology         | Purpose                          |
| ------------------ | --------------------------------- |
| Python (pandas, matplotlib, seaborn) | Data cleaning & exploratory analysis |
| Jupyter Notebook    | Cleaning workflow (`HR_Analytics_Data_Preprocessing_and_EDA.ipynb`) |
| PostgreSQL         | Employee data storage & analysis  |
| SQL                 | HR metrics & reusable views (`HR_Analytics.sql`) |
| CSV                 | Raw, cleaned & exported datasets  |
| Power BI            | Final dashboard (`.pbix`)         |

---

## 📂 Project Structure

```text
HR-Analytics-Dashboard/
├── employee_raw_data.csv                     # Original raw HR export
├── HR_Analytics_Data_Preprocessing_and_EDA.ipynb  # Cleaning & EDA notebook
├── employee_clean_data.csv                    # Cleaned, feature-enriched dataset
├── HR_Analytics.sql                           # Analysis queries + reusable views
├── Department_Summary.csv                     # Department-level summary export
├── Employees_Summary.csv                      # Employee-level summary export
└── HR_Analytics_Dashboard.pbix                # Power BI report
```

---

## 💾 Database

* Database: **PostgreSQL** (`HR_Analytics`)
* Main table: `employees`
* Reusable views: `department_summary`, `employees_summary`
* Exported files: `Department_Summary.csv`, `Employees_Summary.csv`

The database stores information such as:

* Employee details (name, job title, department, business unit)
* Demographics (gender, ethnicity, age)
* Employment info (hire date, tenure, salary, salary band, bonus)
* Location (country, city)

---

## ⚙️ Installation Guide

### Step 1: Set Up PostgreSQL

Install PostgreSQL and create a database named `HR_Analytics` (or update the notebook/scripts to match your own database name).

### Step 2: Prepare the Raw Data

Place `employee_raw_data.csv` in the same folder as the notebook.

### Step 3: Configure the Notebook Connection

Open `HR_Analytics_Data_Preprocessing_and_EDA.ipynb` and update the connection string with your local credentials:

```python
engine = create_engine("postgresql+psycopg2://postgres:your_password@localhost:5432/HR_Analytics")
```

### Step 4: Run the Cleaning Notebook

Run all cells in `HR_Analytics_Data_Preprocessing_and_EDA.ipynb`. This will:

* Clean and standardize the raw data
* Add tenure, bonus amount, salary band, and duplicate flags
* Load the result into the `employees` table
* Export the cleaned data to `employee_clean_data.csv`

### Step 5: Run the Analysis Queries

Run `HR_Analytics.sql` against `HR_Analytics`. This creates the `department_summary` and `employees_summary` views — export them as `Department_Summary.csv` and `Employees_Summary.csv` for the dashboard.

### Step 6: Open the Dashboard

Open `HR_Analytics_Dashboard.pbix` in **Power BI Desktop**, and if needed, point its data source at your local `Department_Summary.csv` and `Employees_Summary.csv`.

Then in Power BI:

```text
Home → Refresh
```

to reload the visuals against your local data.

---

## 📸 Screenshots 

* Department Page (headcount + salary charts)

![image alt](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/fddbaccd2afeefb7a79575eb45c9b8f7ca502353/HR_Analytics_Project/Department_Analytics_Dashboard.png)


* Employee Page (demographics + hiring trend)

![image alt](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/fddbaccd2afeefb7a79575eb45c9b8f7ca502353/HR_Analytics_Project/Employee_Analytics_Dashboard.png)


* HR Analytics Page (bonus + diversity charts)

![image alt](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/fddbaccd2afeefb7a79575eb45c9b8f7ca502353/HR_Analytics_Project/HR_Analytics_Dashboard.png)

---

## 🎯 Learning Outcomes

This project helped in understanding:

* Data cleaning and feature engineering with pandas
* Exploratory data analysis and visualization
* SQL aggregation, window functions, and reusable views
* HR metrics: pay equity, headcount, tenure, and diversity
* Power BI report design (cards, charts, slicers)
* End-to-end data pipeline design (raw data → database → BI tool)

---


## 🔮 Future Enhancements

* Fix the salary band labeling and refresh all downstream files
* Add a Pay Equity page using the gender/ethnicity queries already written in SQL
* Add a clear dedupe step for duplicate employee IDs
* Move database credentials to environment variables
* Automate the notebook → SQL → Power BI refresh with a scheduled pipeline

---

##

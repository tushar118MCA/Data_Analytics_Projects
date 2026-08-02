# 🍽️ Zomato Analytics Dashboard

## 📌 Project Overview

The **Zomato Analytics Dashboard** is an end-to-end data analytics project that analyzes restaurant data from Zomato across multiple cities. The project demonstrates a complete analytics workflow, including **data cleaning with Python, SQL analysis using PostgreSQL, and interactive dashboard development in Power BI**.

The dashboard helps users explore restaurant performance, customer ratings, pricing, outlet distribution, online ordering trends, and table booking availability through interactive visualizations.

---

# 🚀 Project Objectives

- Analyze restaurant distribution across different cities.
- Understand customer ratings and voting patterns.
- Compare restaurant pricing across outlet types.
- Measure online ordering and table booking adoption.
- Identify top-performing restaurant locations.
- Build an interactive dashboard for business insights.

---

# 📊 Dashboard Overview

The dashboard consists of **2 interactive pages**.

## 📄 Page 1 - Restaurant Overview

### KPI Cards

- 🍽️ Total Restaurants
- 🏢 Total Outlets
- 💰 Average Price for Two
- ⭐ Average Rating
- 🪑 Booking Table %
- 🌍 Number of Cities
- 📱 Online Order %

### Visualizations

- Top 10 Restaurant Types by Average Votes
- Outlet Type Distribution
- Top 10 Locations by Average Rating
- Book Table Facility Distribution
- Online Order Facility Distribution
- Total Outlets by Facility Type

### Interactive Filters

- Restaurant Type
- Outlet Type
- City
- Price Range Slider

---

## 📄 Page 2 - Restaurant Insights

### Visualizations

- Top 10 Outlets by City
- Top 10 Online Order % by City
- Average Price for Two People by Outlet Type
- Total Outlets by Rating Band
- Restaurant Count by Rating Band

---

# 🛠️ Technologies Used

| Technology | Purpose |
|------------|---------|
| Python | Data Cleaning & EDA |
| Pandas | Data Manipulation |
| NumPy | Numerical Operations |
| Matplotlib | Data Visualization |
| PostgreSQL | Database |
| pgAdmin | SQL Execution |
| Power BI | Dashboard Development |
| Git & GitHub | Version Control |

---

# 📂 Project Structure

```text
Zomato_Dashboard/
│
├── Dataset/
│   ├── zomato_raw_data.csv
│   ├── zomato_clean_data.csv
│
├── Python/
│   └── Zomato_Data_Cleaning_EDA.ipynb
│
├── SQL/
│   ├── restaurants.sql
│
├── Power BI/
│   └── Zomato_Analytics_Dashboard.pbix
│
│── Dashboard_Page1.png
│── Dashboard_Page2.png
│
└── README.md
```

---

# 💾 Database

**Database:** PostgreSQL

### Main Table

- restaurants

### Important Columns

- Restaurant Name
- Restaurant Type
- Outlet Type
- City
- Location
- Cost for Two
- Rating
- Votes
- Online Order
- Book Table

---

# 📸 Screenshots

## Dashboard Page 1

![Dashboard Page 1](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/e44d45319385ef2c9e3013b7577bb7b181506a3f/Zomato_Dashboard/Dashboard_Page_1.png)

---

## Dashboard Page 2

![Dashboard Page 2](https://github.com/tushar118MCA/Data_Analytics_Projects/blob/e44d45319385ef2c9e3013b7577bb7b181506a3f/Zomato_Dashboard/Dashboard_Page_2.png)

---

# 📈 Key Insights

- Delivery outlets account for the highest number of restaurants.
- Online ordering is available for more than **58%** of restaurants.
- Around **12%** of restaurants provide table booking.
- Average customer rating across all restaurants is **3.70**.
- Koramangala and nearby locations consistently achieve higher average ratings.
- Drinks & Nightlife outlets have the highest average price for two.
- The majority of restaurants fall into the **Good** and **Average** rating bands.

---

# ⚙️ Installation

## Clone Repository

```bash
git clone https://github.com/tushar118MCA/Data_Analytics_Projects.git
```

---

## Install Python Libraries

```bash
pip install pandas numpy matplotlib seaborn jupyter
```

---

## Open Notebook

```bash
jupyter notebook
```

---

## Import Data into PostgreSQL

- Create Database
- Import CSV
- Execute SQL Scripts

---

## Open Power BI Dashboard

Open

```
Power BI/Zomato_Analytics_Dashboard.pbix
```

Refresh the data source.

---

# 🎯 Skills Demonstrated

- Data Cleaning
- Exploratory Data Analysis
- Feature Engineering
- PostgreSQL
- SQL Window Functions
- Data Modeling
- Power BI
- DAX
- Dashboard Design
- Data Storytelling
- Git & GitHub

---

# 🔮 Future Improvements

- Real-time Dashboard Refresh
- Customer Review Sentiment Analysis
- Restaurant Recommendation Model
- Geographic Mapping
- Forecasting Restaurant Ratings

---

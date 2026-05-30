

# COVID-19 Data Exploration | SQL (BigQuery)

## Overview
Exploratory data analysis of global COVID-19 data using SQL. The project analyzes death rates, infection rates, vaccination progress, and continental breakdowns across countries worldwide, with a specific focus on India.

## Tools & Technologies
- SQL
- Dataset: CovidDeaths & CovidVaccinations tables

## Key Analysis Performed

| Analysis | Description |
|---|---|
| Death Percentage | Total cases vs total deaths to find mortality rate by country |
| Infection Rate | Total cases vs population to find % of population infected |
| Highest Infection Countries | Countries ranked by infection rate relative to population |
| Death Count by Country | Countries with highest total death counts |
| Continental Breakdown | Death counts aggregated by continent |
| Global Numbers | Worldwide total cases, deaths and death percentage |
| Population vs Vaccinations | Cumulative vaccination rollout tracked over time per country |

## Key Insights
- Calculated India's **death percentage** and **infection rate** over time
- Identified countries with the **highest infection rates** relative to population
- Tracked **cumulative vaccinations** using window functions (SUM OVER PARTITION BY)
- Created a **VIEW** (`PercentPopulationVaccinated`) for reusable downstream analysis

## SQL Concepts Used
- Joins (INNER JOIN across two large tables)
- Aggregate functions (SUM, MAX)
- Window functions (SUM OVER PARTITION BY)
- CTEs and Temp Tables
- Creating Views

---

Just copy this into a file called `README.md` and commit it to your repo tomorrow — that's your Day 2 commit done! Want me to also write one for the Nashville Housing project?

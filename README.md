# Layoffs Data Analysis
This project provides a comprehensive data analysis on the layoffs_clean2 dataset, focusing on cleaning the data and exploring insights into layoff trends across companies, industries, and locations. This README outlines each phase of the project, summarizing the data cleaning steps and analysis goals.

## Table of Contents 
    1. Overview
    2. Data Cleaning Goals
    3. Data Analysis Goals
    4. Detailed Breakdown
    5. Usage
    6. File Structure

## Overview
The **layoffs_clean2** dataset captures information on company layoffs by location, date, industry, layoff percentage, and total funds raised. This analysis includes both data cleaning and exploration to ensure the dataset is reliable and provides meaningful insights into layoff patterns.

## Data Cleaning Goals
Before beginning the analysis, several data cleaning tasks were carried out to standardize the dataset and remove inconsistencies. 
### The goals for cleaning the data were as follows:
**1. Removing Duplicate Records**

Duplicate entries were removed by creating a unique row identifier based on multiple fields. This ensures that each row in the dataset is unique and represents a single layoff event.

**2. Standardizing Data Formats**

* **Whitespace Trimming:**
 Any unnecessary whitespace in fields, especially the company and country columns, was removed.

* **Date Formatting:** The date field was converted to a standardized date format for easier time-based analysis.

**3. Handling Null and Blank Values**

* **Industry Column:** Null and blank values in the industry column were identified and updated based on existing company data where possible.
* **Removing Invalid Rows:** Records with both total_laid_off and percentage_laid_off as null were deleted, as they provided no meaningful layoff data.

**4. Dropping Unnecessary Columns**
After cleaning, any columns added solely for data-cleaning purposes, such as row identifiers, were removed to maintain a streamlined dataset.

## Data Analysis Goals
With a cleaned dataset, the analysis focused on answering questions around layoff trends. Specific objectives include:

**1. Identify Maximum Layoffs:** Finding the highest values for total layoffs and layoff percentages.

**2. Identify Complete Layoffs:** Highlighting companies with 100% layoffs.

**3. Explore Layoffs by Company, Location, and Industry:** Understanding which companies, locations, and industries were most affected by layoffs.

**4. Track Yearly and Monthly Trends:** Analyzing how layoffs have fluctuated over time.

# Detailed Breakdown
## Data Cleaning
* **Removing Duplicates:** Created a unique row identifier and removed duplicate entries to ensure data integrity.
  
* **Whitespace and Formatting:** Standardized company and country names by trimming unnecessary spaces, and standardized date formats.
  
* **Handling Nulls:** Addressed missing industry data by updating values based on related company data, and removed rows lacking essential total_laid_off and percentage_laid_off values.
  
* **Column Cleanup:** Removed columns used temporarily for data cleaning, leaving only relevant fields.
## Data Analysis
  1. Maximum Layoffs and Layoff Percentages
Identified maximum values in total_laid_off and percentage_laid_off columns to find the largest layoffs by both number and company percentage.
  2. Companies with 100% Layoffs
Isolated companies with a layoff rate of 100%, sorted by funds_raised_millions to see which larger companies were most affected.
  3. Biggest Single-Day Layoffs
Listed the top companies by single-day layoffs to identify the highest layoff events.
  4. Total Layoffs by Company
Aggregated layoffs for each company to rank companies by total layoffs.
  5. Layoffs by Location and Country
Location-Based Layoffs: Ranked locations with the most significant layoff events.
Country-Level Layoffs: Summarized layoffs by country to show international impact.
  6. Layoffs by Industry
Analyzed which industries were most affected by layoffs, allowing us to see sector-specific trends.
  7. Layoffs by Company Stage
Examined layoffs based on company growth stages (e.g., startup, growth, established) to understand if particular stages were more susceptible to layoffs.
  8. Annual and Monthly Layoff Trends
Yearly Trends: Aggregated layoffs by year to observe yearly variations in layoffs.
Rolling Monthly Layoff Totals: Calculated a rolling total of layoffs by month to track layoff trends over time.
  9. Top Companies by Layoffs Each Year
Using CTEs, listed top companies for each year by total layoffs to provide an annual ranking of layoff impact.

# Flight Delay and Cancellation Analysis  
**Airline Operations Data Analysis Using SQL**

## Project Overview  
This project explores flight performance data to uncover patterns in delays and cancellations across major airlines. The objective is to transform raw operational data into actionable insights that could inform decisions on scheduling optimization and process improvement.  

The analysis demonstrates proficiency in SQL for data cleaning, aggregation, and analytical reporting—showing how structured query logic can reveal performance trends and reliability gaps across flight operations.  

---

## Objectives  
- Identify the airlines with the highest average delays.  
- Analyze delay patterns by time of day to identify operational inefficiencies.  
- Calculate cancellation rates to evaluate carrier reliability.  
- Demonstrate SQL fluency through conditional logic, aggregation, and time-based analysis.  

---

## Dataset Overview  
**Table:** `flights`

| Column | Type | Description |
|---------|------|-------------|
| flight_id | TEXT | Unique flight record ID |
| airline | TEXT | Airline name |
| origin | TEXT | Origin airport |
| destination | TEXT | Destination airport |
| scheduled_departure | TEXT | Scheduled departure time |
| actual_departure | TEXT | Actual departure time |
| departure_delay | INTEGER | Delay duration in minutes |
| cancelled | INTEGER | 1 = Canceled, 0 = Completed flight |

---

## Methodology  
The analysis was performed in SQLite using structured queries to explore flight data from multiple perspectives:  

1. **Data Cleaning** – Identified null and inconsistent records in departure and delay fields.  
2. **Average Delay Analysis** – Aggregated and ranked airlines by mean delay time for completed flights.  
3. **Time-of-Day Categorization** – Segmented flights into morning, afternoon, and evening windows to reveal time-based delay patterns.  
4. **Cancellation Evaluation** – Calculated airline-level cancellation rates and overall reliability scores.  

These steps were executed using **Common Table Expressions (CTEs)**, conditional logic (`CASE` statements), and aggregation functions such as `AVG()` and `COUNT()`.

---

## Key Insights  
- Afternoon and evening flights consistently experienced longer average delays than morning flights.  
- A small subset of airlines accounted for most cancellations, indicating potential operational or scheduling inefficiencies.  
- Delay and cancellation trends suggest bottlenecks in specific routes and times, highlighting areas for optimization.  

---

## Tools and Skills Demonstrated  
- SQL (SQLite) for query logic, data aggregation, and transformation  
- Analytical problem-solving with time-series and categorical data  
- Operational insight generation for performance management  
- Data storytelling through structured, reproducible logic  

---

## Future Enhancements  
- Integrate additional datasets (weather, airport traffic) for correlation analysis.  
- Visualize results using Power BI or Tableau to provide interactive dashboards.  
- Automate recurring reports using SQL scripts or Python connectors.  

---

**Author:** [Tiana Durant](https://www.linkedin.com/in/tiana-mayfield-6a2784231)  
**Repository:** [Flight Delay and Cancellation Analysis](https://github.com/TianaBrittany/SQL)

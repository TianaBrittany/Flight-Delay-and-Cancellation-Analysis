# Flight Delay and Cancellation Analysis  
Airline Operations Analytics Using SQL  

## Project Overview  
This project analyzes flight performance data to identify patterns in delays and cancellations across major airlines. Using SQL, the analysis explores how time of day, carrier, and scheduling contribute to operational inefficiencies.  

The objective is to demonstrate the use of SQL in performing real-world data analysis—transforming raw operational data into actionable insights that could support scheduling optimization and performance improvement strategies.  

---

## Objectives  
- Examine average delay durations by airline and time of day.  
- Calculate cancellation rates to assess carrier reliability.  
- Identify operational trends contributing to higher delays.  
- Demonstrate SQL proficiency in data cleaning, aggregation, and reporting.  

---

## Dataset Description  
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

## SQL Methodology  

### 1. Data Validation and Cleaning  
Ensured data integrity by identifying missing or invalid departure and delay values.  

SELECT * 
FROM flights
WHERE actual_departure IS NULL OR departure_delay IS NULL;

### 2. Average Delay by Airline
SELECT airline, 
       ROUND(AVG(departure_delay), 2) AS avg_delay
FROM flights
WHERE cancelled = 0
GROUP BY airline
ORDER BY avg_delay DESC;

### 3. Delay Patterns by Time of Day
SELECT 
  CASE 
    WHEN CAST(strftime('%H', scheduled_departure) AS INTEGER) BETWEEN 5 AND 11 THEN 'Morning'
    WHEN CAST(strftime('%H', scheduled_departure) AS INTEGER) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening' 
  END AS time_of_day,
  ROUND(AVG(departure_delay), 2) AS avg_delay
FROM flights
WHERE cancelled = 0
GROUP BY time_of_day
ORDER BY avg_delay DESC;

### 4. Cancellations by Airline
SELECT airline, 
       COUNT(*) AS total_flights,
       SUM(cancelled) AS cancelled_flights,
       ROUND(SUM(cancelled) * 100.0 / COUNT(*), 2) AS cancellation_rate
FROM flights
GROUP BY airline
ORDER BY cancellation_rate DESC;


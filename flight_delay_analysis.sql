-- Create CTE with core data and extract hour of departure --
WITH base AS (
  SELECT
    airline,
    cancelled,
    departure_delay,
    CAST(
      substr(
        scheduled_departure,
        instr(scheduled_departure, ' ') + 1,
        instr(scheduled_departure, ':') - instr(scheduled_departure, ' ') - 1
      ) AS INTEGER
    ) AS hr
  FROM flights
  WHERE departure_delay IS NOT NULL
),

-- Filter to completed flights only
completed AS (
  SELECT airline, departure_delay, hr
  FROM base
  WHERE cancelled = 0
),

-- Categorize each flight by time of day
time_bucket AS (
  SELECT
    airline,
    CASE
      WHEN hr BETWEEN 5 AND 11 THEN 'Morning'
      WHEN hr BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS time_of_day,
    departure_delay
  FROM completed
),

-- Average delay by time of day
avg_by_tod AS (
  SELECT airline, time_of_day, AVG(departure_delay) AS avg_delay_tod
  FROM time_bucket
  GROUP BY airline, time_of_day
),

-- Identify the worst-performing time of day per airline
worst_tod AS (
  SELECT t1.airline, t1.time_of_day AS worst_time_of_day
  FROM avg_by_tod t1
  WHERE t1.avg_delay_tod = (
    SELECT MAX(t2.avg_delay_tod)
    FROM avg_by_tod t2
    WHERE t2.airline = t1.airline
  )
),

-- Summarize flight counts and cancellations
agg AS (
  SELECT
    airline,
    COUNT(*) AS total_flights,
    SUM(CASE WHEN cancelled = 1 THEN 1 ELSE 0 END) AS cancelled_flights
  FROM base
  GROUP BY airline
),

-- Average delay for completed flights
avg_completed AS (
  SELECT airline, AVG(departure_delay) AS avg_departure_delay
  FROM completed
  GROUP BY airline
)

-- Final dashboard combining all key metrics
SELECT
  a.airline,
  ROUND(c.avg_departure_delay, 2) AS avg_delay_minutes,
  a.total_flights,
  a.cancelled_flights,
  ROUND(a.cancelled_flights * 100.0 / a.total_flights, 2) AS cancel_rate_percent,
  w.worst_time_of_day
FROM agg a
JOIN avg_completed c ON a.airline = c.airline
LEFT JOIN worst_tod w ON a.airline = w.airline
ORDER BY avg_delay_minutes DESC;

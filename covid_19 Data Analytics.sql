-- Standardize Country Names
UPDATE covid_19
SET country = UPPER(TRIM(country))
WHERE country IS NOT NULL;

-- Check Rows with NULL Values in a Column
SELECT* from covid_19
WHERE country is null;

-- Check Rows Where Column is NOT NULL
SELECT *
FROM covid_19
WHERE population IS NOT NULL;

-- Check NULLs in Multiple Columns
SELECT *
FROM covid_19
WHERE Recovered IS NULL OR Tests IS NULL;

-- Check NULLs in Multiple Columns
SELECT COUNT(*) AS NullCount
FROM covid_19
WHERE 
    Deaths IS NULL OR
    Country IS NULL OR
    Population IS NULL OR
    Day IS NULL OR
    Time IS NULL OR
    Cases IS NULL OR
    Recovered IS NULL OR
    Tests IS NULL;

--  Count NULLs Per Column
SELECT 
  SUM(CASE WHEN Deaths IS NULL THEN 1 ELSE 0 END) AS Deaths_Nulls,
  SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_Nulls,
  SUM(CASE WHEN Population IS NULL THEN 1 ELSE 0 END) AS Population_Nulls,
  SUM(CASE WHEN Day IS NULL THEN 1 ELSE 0 END) AS Day_Nulls,
  SUM(CASE WHEN Time IS NULL THEN 1 ELSE 0 END) AS Time_Nulls,
  SUM(CASE WHEN Cases IS NULL THEN 1 ELSE 0 END) AS Cases_Nulls,
  SUM(CASE WHEN Recovered IS NULL THEN 1 ELSE 0 END) AS Recovered_Nulls,
  SUM(CASE WHEN Tests IS NULL THEN 1 ELSE 0 END) AS Tests_Nulls
FROM covid_19;

-- Delete Rows Where Any Column is NULL
DELETE FROM covid_19
WHERE 
  country IS NULL OR
  population IS NULL OR
  day IS NULL OR
  time IS NULL OR
  cases IS NULL OR
  recovered IS NULL OR
  deaths IS NULL OR
  tests IS NULL;

--Check if NULLs Are Removed
SELECT COUNT(*) AS NullRows
FROM covid_19
WHERE 
  country IS NULL OR
  population IS NULL OR
  day IS NULL OR
  time IS NULL OR
  cases IS NULL OR
  recovered IS NULL OR
  deaths IS NULL OR
  tests IS NULL;

-- 1. Total number of COVID-19 cases globally
SELECT SUM(Cases) AS Total_Cases
FROM covid_19;

-- 2. Total deaths per country (Top 10 countries)
SELECT Country, SUM(Deaths) AS Total_Deaths
FROM covid_19
GROUP BY Country
ORDER BY Total_Deaths DESC
LIMIT 10;

-- 3. Highest number of new cases reported in a single day
SELECT Country, Day, MAX(Cases) AS Max_Cases
FROM covid_19
GROUP BY Country
ORDER BY Max_Cases DESC
LIMIT 1;
-- 4. Countries with more than 1 million cases

SELECT Country, SUM(Cases) AS Total_Cases
FROM covid_19
GROUP BY Country
HAVING Total_Cases > 1000000
ORDER BY Total_Cases DESC;
-- 5. Countries with highest recovery rate

SELECT Country,
       SUM(Recovered) AS Total_Recovered,
       SUM(Cases) AS Total_Cases,
       ROUND(SUM(Recovered) * 100.0 / SUM(Cases), 2) AS Recovery_Rate
FROM covid_19
GROUP BY Country
HAVING Total_Cases > 0
ORDER BY Recovery_Rate DESC
LIMIT 10;

-- 6. Countries with highest death rate
SELECT Country,
       SUM(Deaths) AS Total_Deaths,
       SUM(Cases) AS Total_Cases,
       ROUND(SUM(Deaths) * 100.0 / SUM(Cases), 2) AS Death_Rate
FROM covid_19
GROUP BY Country
HAVING Total_Cases > 0
ORDER BY Death_Rate DESC
LIMIT 10;

-- 7. Daily global summary (cases, deaths, recoveries)
SELECT Day,
       SUM(Cases) AS Daily_Cases,
       SUM(Deaths) AS Daily_Deaths,
       SUM(Recovered) AS Daily_Recovered
FROM covid_19
GROUP BY Day
ORDER BY Day;

-- 8. Top 5 most affected countries per population (cases per 100k people)
SELECT Country,
       SUM(Cases) AS Total_Cases,
       MAX(Population) AS Population,
       ROUND(SUM(Cases) * 100000.0 / MAX(Population), 2) AS Cases_Per_100k
FROM covid_19
GROUP BY Country
HAVING Population > 0
ORDER BY Cases_Per_100k DESC
LIMIT 5;

-- 9. Most recent update per country
SELECT Country, MAX(Day) AS Latest_Date
FROM covid_19
GROUP BY Country
ORDER BY Latest_Date DESC;

SELECT * FROM covid_19 LIMIT 10;

-- 10.What is the total number of cases per country, and the percentage each day contributes
SELECT 
  country,
  day,
  cases,
  SUM(cases) OVER (PARTITION BY country) AS total_cases,
  ROUND(100.0 * cases / SUM(cases) OVER (PARTITION BY country), 2) AS percent_contribution
FROM covid_19
WHERE cases IS NOT NULL;

-- 11.What is the running total of cases per country over time?
SELECT 
  country,
  day,
  cases,
  SUM(cases) OVER (PARTITION BY country ORDER BY day) AS running_total_cases
FROM covid_19;

-- 12.What is the daily difference in new cases (delta) per country?
SELECT 
  country,
  day,
  cases,
  cases - LAG(cases) OVER (PARTITION BY country ORDER BY day) AS new_cases_today
FROM covid_19;

-- 13.Rank countries by total tests conducted
SELECT 
  country,
  SUM(tests) AS total_tests,
  RANK() OVER (ORDER BY SUM(tests) DESC) AS test_rank
FROM covid_19
GROUP BY country;

-- 14.Find the top 1 day (highest cases) per country
SELECT *
FROM (
  SELECT 
    country,
    day,
    cases,
    RANK() OVER (PARTITION BY country ORDER BY cases DESC) AS day_rank
  FROM covid_19
) ranked_cases
WHERE day_rank = 1;

-- Retrieve all DATA
select*FROM covid_19

-- that's all
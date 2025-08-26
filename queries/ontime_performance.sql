
--4. Zamanýnda Kalkýþ Oraný (On-Time Performance)

WITH CTE_FlightStats AS (
    SELECT 
        Status,
        COUNT(*) AS TotalFlights
    FROM Flights
    GROUP BY Status
),
CTE_Total AS (
    SELECT SUM(TotalFlights) AS AllFlights FROM CTE_FlightStats
)
SELECT 
    f.Status,
    f.TotalFlights,
    CAST(CAST(ROUND(f.TotalFlights * 100.0 / t.AllFlights, 0) AS INT) AS VARCHAR(10)) + '%' AS Percentage
FROM CTE_FlightStats f
CROSS JOIN CTE_Total t;
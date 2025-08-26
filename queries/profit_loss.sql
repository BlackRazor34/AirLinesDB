
--7. Kâr / Zarar Analizi

WITH CTE_FlightFinancials AS (
    SELECT 
        f.FlightID,
        f.FlightNumber,
        SUM(s.SaleAmount) AS Revenue,
        AVG(5000) AS OperatingCost 
    FROM Flights f
    INNER JOIN Tickets t ON f.FlightID = t.FlightID
    INNER JOIN Sales s ON t.TicketID = s.TicketID
    GROUP BY f.FlightID, f.FlightNumber
)
SELECT 
    FlightNumber,
    Revenue,
    OperatingCost,
    Revenue - OperatingCost AS ProfitOrLoss
FROM CTE_FlightFinancials
ORDER BY ProfitOrLoss DESC;

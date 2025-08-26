
--3. En Çok Getirisi Olan Uçuþlar

WITH CTE_FlightRevenue AS (
    SELECT 
        f.FlightID,
        f.FlightNumber,
        f.DepartureAirport,
        f.ArrivalAirport,
        SUM(s.SaleAmount) AS TotalRevenue,
        COUNT(t.TicketID) AS TotalTickets
    FROM Flights f
    INNER JOIN Tickets t ON f.FlightID = t.FlightID
    INNER JOIN Sales s ON t.TicketID = s.TicketID
    GROUP BY f.FlightID, f.FlightNumber, f.DepartureAirport, f.ArrivalAirport
)
SELECT *,
       RANK() OVER(ORDER BY TotalRevenue DESC) AS RevenueRank
FROM CTE_FlightRevenue
ORDER BY RevenueRank;
--1. Çalýþan Performansý: En Çok Satýþ Yapan Çalýþanlar

WITH CTE_EmployeeSales AS (
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        SUM(s.SaleAmount) AS TotalSales,
        COUNT(s.SaleID) AS TotalTransactions
    FROM Sales s
    INNER JOIN Employees e ON s.EmployeeID = e.EmployeeID
    GROUP BY e.EmployeeID, e.FirstName, e.LastName
)
SELECT 
    EmployeeID, FirstName, LastName, 
    TotalSales, TotalTransactions,
    RANK() OVER(ORDER BY TotalSales DESC) AS PerformanceRank
FROM CTE_EmployeeSales
ORDER BY PerformanceRank;


--2. Müþteri Segmentasyonu (High / Medium / Low)

WITH CTE_CustomerSales AS (
    SELECT 
        c.CustomerID,
        c.FirstName,
        c.LastName,
        SUM(s.SaleAmount) AS TotalSpent
    FROM Customers c
    LEFT JOIN Tickets t ON c.CustomerID = t.CustomerID
    LEFT JOIN Sales s ON t.TicketID = s.TicketID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
),
CTE_CustomerSegment AS (
    SELECT 
        CustomerID, FirstName, LastName, TotalSpent,
        CASE 
            WHEN TotalSpent >= 2000 THEN 'High Value'
            WHEN TotalSpent >= 1000 THEN 'Medium Value'
            ELSE 'Low Value'
        END AS Segment
    FROM CTE_CustomerSales
)
SELECT * FROM CTE_CustomerSegment
ORDER BY TotalSpent DESC;

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
    CAST(f.TotalFlights * 100.0 / t.AllFlights AS DECIMAL(5,2)) AS Percentage
FROM CTE_FlightStats f
CROSS JOIN CTE_Total t;


--5. Departman Bazlý Satýþ Performansý

WITH CTE_DepartmentSales AS (
    SELECT 
        d.DepartmentName,
        SUM(s.SaleAmount) AS TotalSales
    FROM Sales s
    INNER JOIN Employees e ON s.EmployeeID = e.EmployeeID
    INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)
SELECT DepartmentName, TotalSales,
       RANK() OVER(ORDER BY TotalSales DESC) AS DepartmentRank
FROM CTE_DepartmentSales
ORDER BY DepartmentRank;

--6. En Çok Bilet Satýn alan Müþteriler (Sadakat Analizi)

WITH CTE_TopCustomers AS (
    SELECT 
        c.CustomerID,
        c.FirstName,
        c.LastName,
        COUNT(t.TicketID) AS TotalTickets,
        SUM(s.SaleAmount) AS TotalSpent
    FROM Customers c
    INNER JOIN Tickets t ON c.CustomerID = t.CustomerID
    INNER JOIN Sales s ON t.TicketID = s.TicketID
    GROUP BY c.CustomerID, c.FirstName, c.LastName
)
SELECT *,
       RANK() OVER(ORDER BY TotalTickets DESC) AS LoyaltyRank
FROM CTE_TopCustomers
ORDER BY LoyaltyRank;


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






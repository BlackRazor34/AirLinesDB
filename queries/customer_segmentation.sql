
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
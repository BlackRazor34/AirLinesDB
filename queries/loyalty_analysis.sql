
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
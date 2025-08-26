
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
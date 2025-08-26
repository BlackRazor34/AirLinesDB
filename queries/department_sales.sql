
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
SELECT 
    DepartmentName,
    CONCAT('$', CAST(TotalSales AS INT)) AS FormattedTotalSales,
    RANK() OVER(ORDER BY TotalSales DESC) AS DepartmentRank
FROM CTE_DepartmentSales
ORDER BY DepartmentRank;
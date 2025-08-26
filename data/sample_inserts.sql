/*
Departments → 7 kayıt

Employees → 200 kayıt

Customers → 1000 kayıt

Flights → 300 kayıt

Tickets → 3000 kayıt

Sales → 5000 kayıt
*/



INSERT INTO Departments (DepartmentName, Location)
VALUES 
('Sales', 'Istanbul'),
('HR', 'Ankara'),
('Operations', 'Istanbul'),
('Customer Service', 'Izmir'),
('IT', 'Ankara'),
('Finance', 'Istanbul'),
('Marketing', 'Antalya');



DECLARE @i INT = 1;
WHILE @i <= 200
BEGIN
    INSERT INTO Employees (FirstName, LastName, DepartmentID, ManagerID, HireDate, Salary)
    VALUES (
        CONCAT('Emp', @i),
        CONCAT('Surname', @i),
        (ABS(CHECKSUM(NEWID())) % 7) + 1,
        NULL,
        DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 2000), GETDATE()),
        (ABS(CHECKSUM(NEWID())) % 10000) + 2000 
    );
    SET @i = @i + 1;
END


DECLARE @c INT = 1;
WHILE @c <= 1000
BEGIN
    INSERT INTO Customers (FirstName, LastName, Email, Phone, LoyaltyPoints)
    VALUES (
        CONCAT('Cust', @c),
        CONCAT('Surname', @c),
        CONCAT('cust', @c, '@airline.com'),
        CONCAT('+90', ABS(CHECKSUM(NEWID())) % 1000000000),
        ABS(CHECKSUM(NEWID())) % 5000  -- puan 0–5000 arası
    );
    SET @c = @c + 1;
END

DECLARE @f INT = 1;
WHILE @f <= 300
BEGIN
    INSERT INTO Flights (FlightNumber, DepartureAirport, ArrivalAirport, DepartureTime, ArrivalTime, AircraftType, Status)
    VALUES (
        CONCAT('TK', 1000 + @f),
        CASE WHEN @f % 2 = 0 THEN 'Istanbul' ELSE 'Ankara' END,
        CASE WHEN @f % 2 = 0 THEN 'Izmir' ELSE 'Antalya' END,
        DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, GETDATE()),
        DATEADD(HOUR, 2, DATEADD(DAY, ABS(CHECKSUM(NEWID())) % 30, GETDATE())),
        'Airbus A320',
        CASE WHEN @f % 10 = 0 THEN 'Delayed' ELSE 'Scheduled' END
    );
    SET @f = @f + 1;
END

DECLARE @t INT = 1;
WHILE @t <= 3000
BEGIN
    INSERT INTO Tickets (CustomerID, FlightID, PurchaseDate, Price, SeatClass)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 1000) + 1,  
        (ABS(CHECKSUM(NEWID())) % 300) + 1,   
        DATEADD(DAY, -1 * (ABS(CHECKSUM(NEWID())) % 365), GETDATE()),
        (ABS(CHECKSUM(NEWID())) % 1500) + 100,  
        CASE (ABS(CHECKSUM(NEWID())) % 3)
            WHEN 0 THEN 'Economy'
            WHEN 1 THEN 'Business'
            ELSE 'First'
        END
    );
    SET @t = @t + 1;
END


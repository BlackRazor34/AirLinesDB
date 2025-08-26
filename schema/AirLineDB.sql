------------------------------------------------
-- 1. Database Oluşturma
------------------------------------------------
CREATE DATABASE AirlineDB;
GO

USE AirlineDB;
GO

------------------------------------------------
-- 2. Departments Tablosu
------------------------------------------------
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(100)
);

------------------------------------------------
-- 3. Employees Tablosu
------------------------------------------------
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    ManagerID INT NULL,
    HireDate DATE NOT NULL,
    Salary DECIMAL(12,2) NOT NULL,
    CONSTRAINT FK_Employees_Departments FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID),
    CONSTRAINT FK_Employees_Manager FOREIGN KEY (ManagerID)
        REFERENCES Employees(EmployeeID)
);

------------------------------------------------
-- 4. Flights Tablosu
------------------------------------------------
CREATE TABLE Flights (
    FlightID INT PRIMARY KEY IDENTITY(1,1),
    FlightNumber NVARCHAR(20) NOT NULL UNIQUE,
    DepartureAirport NVARCHAR(100) NOT NULL,
    ArrivalAirport NVARCHAR(100) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    ArrivalTime DATETIME NOT NULL,
    AircraftType NVARCHAR(50),
    Status NVARCHAR(20) CHECK (Status IN ('Scheduled','Delayed','Completed','Cancelled'))
);

------------------------------------------------
-- 5. Customers Tablosu
------------------------------------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(20),
    LoyaltyPoints INT DEFAULT 0
);

------------------------------------------------
-- 6. Tickets Tablosu
------------------------------------------------
CREATE TABLE Tickets (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    FlightID INT NOT NULL,
    PurchaseDate DATETIME NOT NULL DEFAULT GETDATE(),
    Price DECIMAL(10,2) NOT NULL,
    SeatClass NVARCHAR(20) CHECK (SeatClass IN ('Economy','Business','First')),
    CONSTRAINT FK_Tickets_Customers FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Tickets_Flights FOREIGN KEY (FlightID)
        REFERENCES Flights(FlightID)
);

------------------------------------------------
-- 7. Sales Tablosu
------------------------------------------------
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    TicketID INT NOT NULL,
    EmployeeID INT NOT NULL,
    SaleAmount DECIMAL(10,2) NOT NULL,
    PaymentMethod NVARCHAR(20) CHECK (PaymentMethod IN ('CreditCard','Cash','Online')),
    CONSTRAINT FK_Sales_Tickets FOREIGN KEY (TicketID)
        REFERENCES Tickets(TicketID),
    CONSTRAINT FK_Sales_Employees FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);

/*

Özet İlişkiler

- Departments → Employees (her çalışan bir departmana bağlı)

- Employees → Employees (her çalışanın müdürü olabilir)

- Flights → Tickets → Sales (biletler uçuşa bağlı, satışlar bilete bağlı)

- Customers → Tickets (müşteri bilet alır)

- Employees → Sales (çalışan bileti satar)

*/
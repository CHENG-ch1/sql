CREATE DATABASE HotelManagement;
USE HotelManagement;


CREATE TABLE Hotel (
    HotelID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone VARCHAR(50),
    Country VARCHAR(100),
    Description TEXT
);

CREATE TABLE FacilityType (
    FacilityTypeID INT NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Capacity INT(11)
);

CREATE TABLE Facility (
    FacilityID INT(11) NOT NULL PRIMARY KEY,
    FacilityTypeID INT(11) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Status VARCHAR(10) NOT NULL DEFAULT 'active',
    HotelID INT(11) NOT NULL,
    FOREIGN KEY (FacilityTypeID) REFERENCES FacilityType(FacilityTypeID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE Service (
    ServiceID INT(11) NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    FacilityTypeID INT(11) NOT NULL,
    Description TEXT,
    FOREIGN KEY (FacilityTypeID) REFERENCES FacilityType(FacilityTypeID)
);

CREATE TABLE ServiceItem (
    ServiceItemID INT(11) NOT NULL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Restriction TEXT,
    Description TEXT,
    Notes TEXT,
    Comments TEXT,
    Status VARCHAR(10) NOT NULL DEFAULT 'available', 
    AvailableTimes VARCHAR(255),
    BaseCost DECIMAL(10,2),
    BaseCurrency VARCHAR(10),
    Capacity INT(11)
);

CREATE TABLE Package (
    PackageID INT(11) NOT NULL PRIMARY KEY,
    Description TEXT,
    Status VARCHAR(10) NOT NULL DEFAULT 'active', 
    EmployeeID INT(11),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

CREATE TABLE Advertisement (
    AdvertisementID INT(11) NOT NULL PRIMARY KEY,
    PackageID INT(11) NOT NULL,
    AdvertisedPrice DECIMAL(10,2),
    AdvertiseCurrency VARCHAR(10),
    StartDate DATE,
    EndDate DATE,
    GracePeriod INT,
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID)
);

CREATE TABLE Customer (
    CustomerID INT(11) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255),
    Phone VARCHAR(50),
    Address VARCHAR(255),
    StreetCountry VARCHAR(100),
    State VARCHAR(100),
    Suburb VARCHAR(100),
    Postcode VARCHAR(10)
);

CREATE TABLE Reservation (
    ReservationID INT(11) NOT NULL PRIMARY KEY,
    PackageID INT(11) NOT NULL,
    CustomerID INT(11) NOT NULL,
    HotelID INT(11) NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    Status VARCHAR(15) NOT NULL,
    FOREIGN KEY (PackageID) REFERENCES Package(PackageID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

CREATE TABLE Booking (
    BookingID INT(11) NOT NULL PRIMARY KEY,
    ReservationID INT(11) NOT NULL,
    ServiceID INT(11) NOT NULL,
    BookingDate DATE NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID),
    FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID)
);

CREATE TABLE Payment (
    PaymentID INT(11) NOT NULL PRIMARY KEY,
    ReservationID INT(11) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PaymentDate DATE NOT NULL,
    Status VARCHAR(10) NOT NULL, -- Replacing ENUM with VARCHAR
    FOREIGN KEY (ReservationID) REFERENCES Reservation(ReservationID)
);

CREATE TABLE Employee (
    EmployeeID INT(11) NOT NULL PRIMARY KEY,
    HotelID INT(11) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Position VARCHAR(255) NOT NULL,
    Salary DECIMAL(10,2),
    FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID)
);

​
-- Insert data into Hotel table
INSERT INTO Hotel (HotelID, Name, Address, Phone, Country, Description)
VALUES 
(1, 'Sydney Harbour Hotel', '123 Circular Quay', '02-1234-5678', 'Australia', 'A luxurious hotel with stunning views of the Sydney Harbour'),
(2, 'Gold Coast Resort', '456 Surfers Paradise Blvd', '07-9876-5432', 'Australia', 'A beautiful resort located on the Gold Coast');

-- Insert data into FacilityType table
INSERT INTO FacilityType (FacilityTypeID, Name, Description, Capacity)
VALUES 
(1, 'Conference Room', 'A room for meetings and conferences', 100),
(2, 'Swimming Pool', 'An outdoor swimming pool', 50);

-- Insert data into Facility table
INSERT INTO Facility (FacilityID, FacilityTypeID, Name, Description, Status, HotelID)
VALUES 
(1, 1, 'Main Conference Room', 'The main conference room with all amenities', 'active', 1),
(2, 2, 'Outdoor Pool', 'A large outdoor swimming pool', 'active', 2);

-- Insert data into Service table
INSERT INTO Service (ServiceID, Name, FacilityTypeID, Description)
VALUES 
(1, 'Room Service', 1, '24/7 room service'),
(2, 'Poolside Bar', 2, 'Bar service by the pool');

-- Insert data into ServiceItem table
INSERT INTO ServiceItem (ServiceItemID, Name, Restriction, Description, Notes, Comments, Status, AvailableTimes, BaseCost, BaseCurrency, Capacity)
VALUES 
(1, 'Breakfast', 'None', 'Continental breakfast', 'Served daily', 'Customer favorite', 'available', '7:00 AM - 10:00 AM', 20.00, 'AUD', 100),
(2, 'Cocktail', '18+', 'Signature cocktails', 'Served at the bar', 'Happy hour specials', 'available', '5:00 PM - 11:00 PM', 15.00, 'AUD', 50);

-- Insert data into Employee table
INSERT INTO Employee (EmployeeID, HotelID, FirstName, LastName, Position, Salary)
VALUES 
(1, 1, 'John', 'Doe', 'Manager', 80000.00),
(2, 2, 'Jane', 'Smith', 'Receptionist', 50000.00);

-- Insert data into Package table
INSERT INTO Package (PackageID, Description, Status, EmployeeID)
VALUES 
(1, 'Weekend Getaway', 'active', 1),
(2, 'Family Fun', 'active', 2);

-- Insert data into Advertisement table
INSERT INTO Advertisement (AdvertisementID, PackageID, AdvertisedPrice, AdvertiseCurrency, StartDate, EndDate, GracePeriod)
VALUES 
(1, 1, 399.99, 'AUD', '2025-04-01', '2025-04-30', 7),
(2, 2, 599.99, 'AUD', '2025-05-01', '2025-05-31', 7);

-- Insert data into Customer table
INSERT INTO Customer (CustomerID, FirstName, LastName, Email, Phone, Address, StreetCountry, State, Suburb, Postcode)
VALUES 
(1, 'Alice', 'Johnson', 'alice@example.com', '0412-345-678', '789 George St', 'Australia', 'NSW', 'Sydney', '2000'),
(2, 'Bob', 'Williams', 'bob@example.com', '0412-987-654', '101 Queen St', 'Australia', 'QLD', 'Brisbane', '4000');

-- Insert data into Reservation table
INSERT INTO Reservation (ReservationID, PackageID, CustomerID, HotelID, CheckInDate, CheckOutDate, Status)
VALUES 
(1, 1, 1, 1, '2025-04-10', '2025-04-12', 'Confirmed'),
(2, 2, 2, 2, '2025-05-15', '2025-05-20', 'Confirmed');

-- Insert data into Booking table
INSERT INTO Booking (BookingID, ReservationID, ServiceID, BookingDate, Quantity)
VALUES 
(1, 1, 1, '2025-04-10', 2),
(2, 2, 2, '2025-05-15', 4);

-- Insert data into Payment table
INSERT INTO Payment (PaymentID, ReservationID, Amount, PaymentMethod, PaymentDate, Status)
VALUES 
(1, 1, 399.99, 'Credit Card', '2025-04-01', 'Paid'),
(2, 2, 599.99, 'Credit Card', '2025-05-01', 'Paid');
create database Airline_Reservation_System
use Airline_Reservation_System
-- Schema Design

         -- Flights Table
CREATE TABLE Flights (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(20) UNIQUE,
    origin VARCHAR(50),
    destination VARCHAR(50),
    departure_time DATETIME,
    arrival_time DATETIME,
    total_seats INT
);

       -- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

     -- Bookings Table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    flight_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'CONFIRMED',   -- CONFIRMED / CANCELED
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);
       -- Seats Table
CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    seat_number VARCHAR(10),
    is_booked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

-- Insert Sample Data

INSERT INTO Flights (flight_id, flight_number, origin, destination, departure_time, arrival_time, total_seats)
VALUES
(2, 'AI102', 'Delhi', 'Bangalore', '2025-07-15 12:00:00', '2025-07-15 15:00:00', 200),
(3, 'AI103', 'Delhi', 'Chennai', '2025-07-15 16:00:00', '2025-07-15 18:30:00', 220),
(4, 'AI104', 'Mumbai', 'Delhi', '2025-07-16 08:00:00', '2025-07-16 10:00:00', 180),
(5, 'AI105', 'Mumbai', 'Bangalore', '2025-07-16 11:00:00', '2025-07-16 13:00:00', 200),
(6, 'AI106', 'Mumbai', 'Chennai', '2025-07-16 14:00:00', '2025-07-16 16:00:00', 220),
(7, 'AI107', 'Bangalore', 'Delhi', '2025-07-17 09:30:00', '2025-07-17 12:30:00', 200),
(8, 'AI108', 'Bangalore', 'Mumbai', '2025-07-17 13:00:00', '2025-07-17 15:00:00', 180),
(9, 'AI109', 'Bangalore', 'Chennai', '2025-07-17 16:00:00', '2025-07-17 17:00:00', 160),
(10, 'AI110', 'Chennai', 'Delhi', '2025-07-18 07:00:00', '2025-07-18 10:00:00', 200),
(11, 'AI111', 'Chennai', 'Mumbai', '2025-07-18 11:00:00', '2025-07-18 13:30:00', 180),
(12, 'AI112', 'Chennai', 'Bangalore', '2025-07-18 14:00:00', '2025-07-18 15:30:00', 160),
(13, 'AI113', 'Delhi', 'Kolkata', '2025-07-19 09:00:00', '2025-07-19 11:30:00', 190),
(14, 'AI114', 'Kolkata', 'Delhi', '2025-07-19 12:30:00', '2025-07-19 15:00:00', 190),
(15, 'AI115', 'Mumbai', 'Kolkata', '2025-07-20 08:00:00', '2025-07-20 11:00:00', 200),
(16, 'AI116', 'Kolkata', 'Mumbai', '2025-07-20 12:00:00', '2025-07-20 15:00:00', 200),
(17, 'AI117', 'Bangalore', 'Kolkata', '2025-07-21 07:30:00', '2025-07-21 10:30:00', 180),
(18, 'AI118', 'Kolkata', 'Bangalore', '2025-07-21 11:30:00', '2025-07-21 14:30:00', 180),
(19, 'AI119', 'Chennai', 'Kolkata', '2025-07-22 09:00:00', '2025-07-22 12:00:00', 170),
(20, 'AI120', 'Kolkata', 'Chennai', '2025-07-22 13:00:00', '2025-07-22 16:00:00', 170);

INSERT INTO Customers (name, email, phone)
VALUES
('Aman Sharma', 'aman.sharma@example.com', '9876543210'),
('Priya Mehta', 'priya.mehta@example.com', '9123456780'),
('Ravi Kumar', 'ravi.kumar@example.com', '9012345678'),
('Sneha Patel', 'sneha.patel@example.com', '9988776655'),
('Ankit Singh', 'ankit.singh@example.com', '9090909090'),
('Deepika Joshi', 'deepika.joshi@example.com', '9871234567'),
('Rahul Verma', 'rahul.verma@example.com', '7896541230'),
('Simran Kaur', 'simran.kaur@example.com', '8765432109'),
('Vikram Rana', 'vikram.rana@example.com', '9874563210'),
('Neha Jain', 'neha.jain@example.com', '9191919191'),
('Arjun Yadav', 'arjun.yadav@example.com', '8888888888'),
('Pooja Sinha', 'pooja.sinha@example.com', '9009009009'),
('Mohit Bansal', 'mohit.bansal@example.com', '7897897897'),
('Kiran Desai', 'kiran.desai@example.com', '9999999999'),
('Ritika Roy', 'ritika.roy@example.com', '8908908908'),
('Suresh Gupta', 'suresh.gupta@example.com', '8108108108'),
('Manoj Das', 'manoj.das@example.com', '8078078078'),
('Preeti Nair', 'preeti.nair@example.com', '8080808080'),
('Tarun Khanna', 'tarun.khanna@example.com', '9192939495'),
('Lavanya Reddy', 'lavanya.reddy@example.com', '9870123456');

INSERT INTO Bookings (customer_id, flight_id, booking_date, status)
VALUES
(1, 1, '2025-07-14 10:00:00', 'CONFIRMED'),
(2, 1, '2025-07-14 10:05:00', 'CONFIRMED'),
(3, 1, '2025-07-14 10:10:00', 'CONFIRMED'),
(4, 2, '2025-07-14 10:15:00', 'CONFIRMED'),
(5, 2, '2025-07-14 10:20:00', 'CONFIRMED'),
(6, 2, '2025-07-14 10:25:00', 'CANCELED'),
(7, 3, '2025-07-14 10:30:00', 'CONFIRMED'),
(8, 3, '2025-07-14 10:35:00', 'CONFIRMED'),
(9, 3, '2025-07-14 10:40:00', 'CONFIRMED'),
(10, 4, '2025-07-14 10:45:00', 'CONFIRMED'),
(11, 4, '2025-07-14 10:50:00', 'CONFIRMED'),
(12, 5, '2025-07-14 10:55:00', 'CANCELED'),
(13, 5, '2025-07-14 11:00:00', 'CONFIRMED'),
(14, 6, '2025-07-14 11:05:00', 'CONFIRMED'),
(15, 6, '2025-07-14 11:10:00', 'CONFIRMED'),
(16, 7, '2025-07-14 11:15:00', 'CONFIRMED'),
(17, 7, '2025-07-14 11:20:00', 'CONFIRMED'),
(18, 8, '2025-07-14 11:25:00', 'CONFIRMED'),
(19, 8, '2025-07-14 11:30:00', 'CANCELED'),
(20, 9, '2025-07-14 11:35:00', 'CONFIRMED');

INSERT INTO Seats (flight_id, seat_number, is_booked)
VALUES
(1, 'A1', FALSE),
(1, 'A2', FALSE),
(1, 'A3', FALSE),
(1, 'A4', FALSE),
(1, 'A5', FALSE),
(1, 'A6', FALSE),
(1, 'B1', FALSE),
(1, 'B2', FALSE),
(1, 'B3', FALSE),
(1, 'B4', FALSE),
(1, 'B5', FALSE),
(2, 'A1', FALSE),
(2, 'A2', FALSE),
(2, 'A3', FALSE),
(2, 'A4', FALSE),
(2, 'A5', FALSE),
(2, 'B1', FALSE),
(2, 'B2', FALSE),
(2, 'B3', FALSE),
(2, 'B4', FALSE);

SELECT * FROM airline_reservation_system.seats;

-- Queries
-- 1. Available Seats for a Flight
SELECT seat_number
FROM Seats
WHERE flight_id = 1 AND is_booked = FALSE;

-- 2. Flight Search by Origin & Destination
SELECT *
FROM Flights
WHERE origin = 'Delhi' AND destination = 'Mumbai'
ORDER BY departure_time;

-- Triggers
-- 1. Booking Trigger: Auto-Mark Seat as Booked

DELIMITER //

CREATE TRIGGER after_booking_insert
AFTER INSERT ON Bookings
FOR EACH ROW
UPDATE Seats
SET is_booked = TRUE
WHERE flight_id = NEW.flight_id AND is_booked = FALSE
LIMIT 1;
//
DELIMITER ;

-- 2. Cancellation Trigger: Release Seat

DELIMITER //

CREATE TRIGGER after_booking_cancel
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.status = 'CANCELED' THEN
        UPDATE Seats
        SET is_booked = FALSE
        WHERE flight_id = NEW.flight_id
        LIMIT 1;
    END IF;
END;
//
DELIMITER ;

-- AFTER DELETE – Release Seat

DELIMITER //

CREATE TRIGGER after_booking_delete
AFTER DELETE ON Bookings
FOR EACH ROW
BEGIN
    -- Release the booked seat (mark it as available)
    UPDATE Seats
    SET is_booked = FALSE
    WHERE seat_id = OLD.booked_seat_id;
END //

DELIMITER ;

-- Booking Summary Report

SELECT 
    f.flight_number,
    COUNT(b.booking_id) AS total_bookings,
    SUM(CASE WHEN b.status = 'CONFIRMED' THEN 1 ELSE 0 END) AS confirmed_bookings,
    SUM(CASE WHEN b.status = 'CANCELED' THEN 1 ELSE 0 END) AS canceled_bookings
FROM Flights f
LEFT JOIN Bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id;



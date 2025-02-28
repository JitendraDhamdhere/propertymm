-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 28, 2025 at 09:31 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `propertydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `id` int(11) NOT NULL,
  `property_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Pending','Confirmed','Cancelled') DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `property_id`, `user_id`, `booking_date`, `status`) VALUES
(1, 1, 5, '2025-02-28 20:07:48', 'Pending'),
(2, 3, 6, '2025-02-28 20:08:04', 'Confirmed'),
(3, 6, 7, '2025-02-28 20:08:14', 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `message` text NOT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`id`, `name`, `email`, `phone`, `message`, `submitted_at`) VALUES
(1, 'Rahul Sharma', 'rahul.sharma@example.com', '9876543210', 'I am interested in the 2BHK apartment. Please share more details.', '2025-02-28 20:02:55'),
(2, 'Priya Verma', 'priya.verma@example.com', '9823456789', 'Can you provide the final price for the villa in Kothrud, Pune?', '2025-02-28 20:02:55'),
(3, 'Amit Khanna', 'amit.khanna@example.com', '9898989898', 'Is the commercial office space still available? I want to schedule a visit.', '2025-02-28 20:02:55'),
(4, 'Neha Desai', 'neha.desai@example.com', '9765432101', 'I would like to know if there are any discounts available on the penthouse.', '2025-02-28 20:02:55'),
(5, 'Rohan Patil', 'rohan.patil@example.com', '9856473829', 'What are the loan options available for purchasing this property?', '2025-02-28 20:02:55');

-- --------------------------------------------------------

--
-- Table structure for table `gallery`
--

CREATE TABLE `gallery` (
  `id` int(11) NOT NULL,
  `image_url` longtext NOT NULL,
  `alt_text` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `properties`
--

CREATE TABLE `properties` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `type` enum('Apartment','House','Office','Land') NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `location` varchar(255) NOT NULL,
  `size` int(11) NOT NULL,
  `bedrooms` int(11) NOT NULL,
  `bathrooms` int(11) NOT NULL,
  `status` enum('Available','Sold','Rented') DEFAULT 'Available',
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `properties`
--

INSERT INTO `properties` (`id`, `title`, `description`, `type`, `price`, `location`, `size`, `bedrooms`, `bathrooms`, `status`, `image`, `created_at`) VALUES
(1, 'Luxury Apartment in Downtown', 'A high-rise apartment with modern amenities and city views.', 'Apartment', 8500000.00, 'Kothrud, Pune', 1500, 3, 2, 'Available', 'image/property1.jpg', '2025-02-28 19:45:55'),
(2, 'Spacious Family Home', 'A perfect home for families with a large backyard.', 'House', 12000000.00, 'Baner, Pune', 3000, 4, 3, 'Available', 'image/property2.jpg', '2025-02-28 19:45:55'),
(3, 'Prime Office Space', 'An ideal office space for startups and enterprises.', 'Office', 5000000.00, 'Hinjewadi, Pune', 2000, 0, 2, 'Sold', 'image/property3.jpg', '2025-02-28 19:45:55'),
(4, 'Modern Penthouse', 'A luxurious penthouse with a private terrace and skyline views.', 'Apartment', 18000000.00, 'Wakad, Pune', 2200, 3, 3, 'Available', 'image/property4.jpg', '2025-02-28 19:45:55'),
(5, 'Cozy Suburban House', 'A beautiful home in a quiet neighborhood.', 'House', 9500000.00, 'Viman Nagar, Pune', 2500, 3, 2, 'Available', 'image/property5.jpg', '2025-02-28 19:45:55'),
(6, 'Commercial Land for Development', 'An excellent opportunity for developers.', 'Land', 30000000.00, 'Kharadi, Pune', 15000, 0, 0, 'Available', 'image/property6.jpg', '2025-02-28 19:45:55'),
(7, 'Downtown Condo', 'A stylish condo in the heart of the city.', 'Apartment', 7500000.00, 'Hadapsar, Pune', 1200, 2, 2, 'Available', 'image/property7.jpg', '2025-02-28 19:45:55'),
(8, 'Luxury Office Tower Suite', 'A premium office space in a prestigious tower.', 'Office', 7000000.00, 'Magarpatta, Pune', 3500, 0, 3, 'Available', 'image/property8.jpg', '2025-02-28 19:45:55'),
(9, 'Beachfront Villa', 'A stunning villa with direct beach access.', 'House', 25000000.00, 'Shivaji Nagar, Pune', 5000, 5, 4, 'Available', 'image/property9.jpg', '2025-02-28 19:45:55'),
(10, 'Investment Land Plot', 'A strategically located land for future development.', 'Land', 45000000.00, 'Koregaon Park, Pune', 20000, 0, 0, 'Available', 'image/property10.jpg', '2025-02-28 19:45:55');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `phone`, `username`, `password`, `created_at`) VALUES
(5, 'Tejasvini A', 'Tejasvini@gmail.com', '+91 89835 90589', 'Tejasvini', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '2025-02-28 19:55:14'),
(6, 'ram patil', 'ram@gmail.com', '9876565454', 'ram', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '2025-02-28 19:57:19'),
(7, 'shyam', 'shyam@gmail.com', '8765676768', 'shyam', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '2025-02-28 19:57:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `property_id` (`property_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gallery`
--
ALTER TABLE `gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `properties`
--
ALTER TABLE `properties`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `gallery`
--
ALTER TABLE `gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `properties`
--
ALTER TABLE `properties`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

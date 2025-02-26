-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 26, 2025 at 01:05 PM
-- Server version: 8.0.41-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `image_processor`
--

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int NOT NULL,
  `product_id` int DEFAULT NULL,
  `input_url` varchar(255) DEFAULT NULL,
  `output_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `product_id`, `input_url`, `output_url`) VALUES
(1, 1, 'https://4kwallpapers.com/images/walls/thumbs_2t/19881.jpg', 'http://localhost:3000/uploads/06e5ca72-cc20-4757-9280-3fc5bec7c1bf/1/1.jpg'),
(2, 2, 'https://images.wallpapersden.com/image/download/anime-girl-hd-alone-art_bW5la2uUmZqaraWkpJRmbmdlrWZlbWU.jpg', 'http://localhost:3000/uploads/06e5ca72-cc20-4757-9280-3fc5bec7c1bf/2/2.jpg'),
(3, 3, 'https://lh3.googleusercontent.com/RUg9YJuY2cPjh5znR5ZLqLJIBrm1CM2JuwCS1XP6g31ZDPa_NR--jR0JAum5qDbl2g5UKgBwM4SHSuyiWqjyd7VhBUI=s1280-w1280-h800', 'http://localhost:3000/uploads/06e5ca72-cc20-4757-9280-3fc5bec7c1bf/3/3.jpg'),
(4, 4, 'https://lh3.googleusercontent.com/RUg9YJuY2cPjh5znR5ZLqLJIBrm1CM2JuwCS1XP6g31ZDPa_NR--jR0JAum5qDbl2g5UKgBwM4SHSuyiWqjyd7VhBUI=s1280-w1280-h800', 'http://localhost:3000/uploads/06e5ca72-cc20-4757-9280-3fc5bec7c1bf/4/4.jpg'),
(5, 5, 'https://4kwallpapers.com/images/walls/thumbs_2t/19881.jpg', 'http://localhost:3000/uploads/669bfea5-cd9c-4614-ac00-d370c7b31996/5/5.jpg'),
(6, 6, 'https://images.wallpapersden.com/image/download/anime-girl-hd-alone-art_bW5la2uUmZqaraWkpJRmbmdlrWZlbWU.jpg', 'http://localhost:3000/uploads/669bfea5-cd9c-4614-ac00-d370c7b31996/6/6.jpg'),
(7, 7, 'https://lh3.googleusercontent.com/RUg9YJuY2cPjh5znR5ZLqLJIBrm1CM2JuwCS1XP6g31ZDPa_NR--jR0JAum5qDbl2g5UKgBwM4SHSuyiWqjyd7VhBUI=s1280-w1280-h800', 'http://localhost:3000/uploads/669bfea5-cd9c-4614-ac00-d370c7b31996/7/7.jpg'),
(8, 8, 'https://lh3.googleusercontent.com/RUg9YJuY2cPjh5znR5ZLqLJIBrm1CM2JuwCS1XP6g31ZDPa_NR--jR0JAum5qDbl2g5UKgBwM4SHSuyiWqjyd7VhBUI=s1280-w1280-h800', 'http://localhost:3000/uploads/669bfea5-cd9c-4614-ac00-d370c7b31996/8/8.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `request_id` varchar(36) DEFAULT NULL,
  `serial_number` int DEFAULT NULL,
  `product_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `request_id`, `serial_number`, `product_name`) VALUES
(1, '06e5ca72-cc20-4757-9280-3fc5bec7c1bf', 1, 'SKU1'),
(2, '06e5ca72-cc20-4757-9280-3fc5bec7c1bf', 2, 'SKU2'),
(3, '06e5ca72-cc20-4757-9280-3fc5bec7c1bf', 3, 'SKU3'),
(4, '06e5ca72-cc20-4757-9280-3fc5bec7c1bf', 4, 'SKU6'),
(5, '669bfea5-cd9c-4614-ac00-d370c7b31996', 1, 'SKU1'),
(6, '669bfea5-cd9c-4614-ac00-d370c7b31996', 2, 'SKU2'),
(7, '669bfea5-cd9c-4614-ac00-d370c7b31996', 3, 'SKU3'),
(8, '669bfea5-cd9c-4614-ac00-d370c7b31996', 4, 'SKU6');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `request_id` varchar(36) NOT NULL,
  `status` enum('pending','processing','completed','failed') DEFAULT 'pending',
  `webhook_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `completed_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `requests`
--

INSERT INTO `requests` (`request_id`, `status`, `webhook_url`, `created_at`, `completed_at`) VALUES
('06e5ca72-cc20-4757-9280-3fc5bec7c1bf', 'completed', NULL, '2025-02-26 11:32:59', '2025-02-26 11:33:06'),
('669bfea5-cd9c-4614-ac00-d370c7b31996', 'completed', NULL, '2025-02-26 11:43:36', '2025-02-26 11:43:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `request_id` (`request_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`request_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`request_id`) REFERENCES `requests` (`request_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

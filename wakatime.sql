-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2022 at 07:19 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wakatime`
--

-- --------------------------------------------------------

--
-- Table structure for table `guestsdata`
--

CREATE TABLE `guestsdata` (
  `id` int(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `guestId` int(100) NOT NULL,
  `entryDate` text NOT NULL,
  `entryTime` time NOT NULL,
  `exitDate` text NOT NULL,
  `exitTime` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `guestsdata`
--

INSERT INTO `guestsdata` (`id`, `name`, `guestId`, `entryDate`, `entryTime`, `exitDate`, `exitTime`) VALUES
(1, 'Austine Okoth', 37818783, '0000-00-00', '05:21:34', '11/20/2022', '5:25:01 PM'),
(2, 'Austine Okoth', 37818783, '0000-00-00', '05:21:50', '11/20/2022', '5:25:01 PM'),
(3, 'Austine Okoth Okongo', 37818783, '11/20/2022', '05:23:37', '11/20/2022', '5:25:01 PM'),
(4, 'Roy Kibet', 123456, '11/20/2022', '05:35:59', '11/20/2022', '5:36:42 PM'),
(5, 'Chris Onyango', 456789, '11/21/2022', '07:51:50', '11/21/2022', '7:52:42 AM');

-- --------------------------------------------------------

--
-- Table structure for table `logindata`
--

CREATE TABLE `logindata` (
  `id` int(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `workerId` int(100) NOT NULL,
  `date` text NOT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logindata`
--

INSERT INTO `logindata` (`id`, `name`, `department`, `workerId`, `date`, `time`) VALUES
(1, 'Roddy Ricch', 'Pure and Applied Happiness', 87654321, '11/21/2022', '8:15:04 AM'),
(2, 'Roddy Ricch', 'Pure and Applied Happiness', 87654321, '11/21/2022', '8:25:09 AM'),
(3, 'James Bond', 'Entertainment', 123456, '11/21/2022', '8:29:04 AM'),
(4, 'Elon Musk', 'Pure Dollars', 1, '11/21/2022', '8:45:28 AM'),
(5, 'Elon Musk', 'Pure Dollars', 1, '11/21/2022', '8:45:57 AM');

-- --------------------------------------------------------

--
-- Table structure for table `logoutdata`
--

CREATE TABLE `logoutdata` (
  `id` int(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `workerId` int(100) NOT NULL,
  `date` text NOT NULL,
  `time` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `logoutdata`
--

INSERT INTO `logoutdata` (`id`, `name`, `department`, `workerId`, `date`, `time`) VALUES
(1, 'Roddy Ricch', 'Pure and A', 87654321, '11/21/2022', '8:33:56 AM'),
(2, 'Roddy Ricch', 'Pure and Applied Happiness', 87654321, '11/21/2022', '8:36:35 AM'),
(3, 'James Bond', 'Entertainment', 123456, '11/21/2022', '8:41:03 AM'),
(4, 'James Bond', 'Entertainment', 123456, '11/21/2022', '8:55:07 AM');

-- --------------------------------------------------------

--
-- Table structure for table `workerreg`
--

CREATE TABLE `workerreg` (
  `id` int(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `department` varchar(50) NOT NULL,
  `workerId` int(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `workerreg`
--

INSERT INTO `workerreg` (`id`, `name`, `email`, `department`, `workerId`, `password`) VALUES
(1, 'James Bond', 'abc@gmail.com', 'Entertainment', 123456, '$2a$10$gya/ebkFXnWSLMHUtQz52eD097DoxpsoXjQljypLl9Hq8xFzIEt4a'),
(2, 'Roddy Ricch', 'roddy@gmail.com', 'Pure and Applied Happiness', 87654321, '$2a$10$jpoGGPg00Y5H34EaseFC8O4lGfbJpycTcphLM6HCCZus5e3xT9Q0G'),
(3, 'Elon Musk', 'billions@gmail.com', 'Pure Dollars', 1, '$2a$10$AdN5J8sr1R4Sk.mTPVKWr.8NU6Klf87xQlqJede0DboIRkEhXbpv2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `guestsdata`
--
ALTER TABLE `guestsdata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logindata`
--
ALTER TABLE `logindata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logoutdata`
--
ALTER TABLE `logoutdata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `workerreg`
--
ALTER TABLE `workerreg`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `guestsdata`
--
ALTER TABLE `guestsdata`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logindata`
--
ALTER TABLE `logindata`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logoutdata`
--
ALTER TABLE `logoutdata`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `workerreg`
--
ALTER TABLE `workerreg`
  MODIFY `id` int(100) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

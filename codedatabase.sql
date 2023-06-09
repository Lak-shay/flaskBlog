-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2023 at 03:52 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codedatabase`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `message` varchar(100) NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `message`, `date`) VALUES
(1, 'firstPost', 'firstPost@gmail.com', '1234567890', 'FirstPost', '2023-06-01 12:45:32'),
(12, 'tester', 'tesginsg@gmail.com', '9237234234', 'testermama', '2023-06-01 15:35:25'),
(22, 'Pawan', 'pawan@nic.in', '123', 'sss', '2023-06-01 16:07:06'),
(23, 'newTester', 'pawan@nic.in', '123', 'sss', '2023-06-01 16:08:18'),
(27, 'newTester', 'new@nic.in', '123', 'sss', '2023-06-01 16:18:34'),
(33, 'Lakshay', 'tesginsg@gmail.com', '9237234234', 'asdf', '2023-06-01 16:28:12'),
(35, 'tester', 'heloooooo@gmail.com', '9723432493', 'lasdfiwq qwgasdf', '2023-06-01 16:29:39'),
(39, 'pranti', 'pranti@gmail.com', '9234723423', 'l0jasdf234', '2023-06-01 16:31:51');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(500) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `content`, `slug`, `date`, `img_file`) VALUES
(0, 'new', 'new', 'new', '2023-06-09 17:55:28', NULL),
(1, 'First Post', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut eros lectus. Nam ac ipsum nec nisi lacinia elementum. Integer maximus pretium molestie. Donec odio tortor, malesuada et ante id, ornare lacinia tortor. In hac habitasse platea dictumst. Sed et nisi eu magna maximus egestas. Praesent a eleifend diam. Donec consectetur eleifend dolor eget mollis. Pellentesque mollis porta neque, sed suscipit leo. Aliquam a diam libero.', 'first-post', '2023-06-02 15:47:17', ''),
(2, 'Second Post updated', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut eros lectus. Nam ac ipsum nec nisi lacinia elementum. Integer maximus pretium molestie. Donec odio tortor, malesuada et ante id, ornare lacinia tortor. In hac habitasse platea dictumst. Sed et nisi eu magna maximus egestas. Praesent a eleifend diam. Donec consectetur eleifend dolor eget mollis. Pellentesque mollis porta neque, sed suscipit leo. Aliquam a diam libero.', 'second-post', '2023-06-06 15:42:44', ''),
(3, 'Third post updated', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut eros lectus. Nam ac ipsum nec nisi lacinia elementum. Integer maximus pretium molestie. Donec odio tortor, malesuada et ante id, ornare lacinia tortor. In hac habitasse platea dictumst. Sed et nisi eu magna maximus egestas. Praesent a eleifend diam. Donec consectetur eleifend dolor eget mollis. Pellentesque mollis porta neque, sed suscipit leo. Aliquam a diam libero.', 'third-post', '2023-06-06 17:13:09', ''),
(6, 'Sixth post updated', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ut eros lectus. Nam ac ipsum nec nisi lacinia elementum. Integer maximus pretium molestie. Donec odio tortor, malesuada et ante id, ornare lacinia tortor. In hac habitasse platea dictumst. Sed et nisi eu magna maximus egestas. Praesent a eleifend diam. Donec consectetur eleifend dolor eget mollis. Pellentesque mollis porta neque, sed suscipit leo. Aliquam a diam libero.', 'sixth-post', '2023-06-09 17:25:06', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

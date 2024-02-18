-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 07, 2016 at 11:40 AM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `jsp_ipdiexam`
--
CREATE DATABASE IF NOT EXISTS `jsp_ipdiexam` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `jsp_ipdiexam`;

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE IF NOT EXISTS `candidates` (
  `cname` varchar(100) NOT NULL,
  `addr` varchar(200) NOT NULL,
  `city` varchar(50) NOT NULL,
  `degree` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `mobile` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`cname`, `addr`, `city`, `degree`, `gender`, `mobile`, `email`, `pwd`) VALUES
('Anand Kumar', '34,South Street,', 'Chennai', 'B.E. CS', 'Male', '9084849494', 'anand@gmail.com', 'anand'),
('Balaji', '859,South Street,', 'Madurai', 'B.E. CS', 'Male', '9980505959', 'balaji@gmail.com', 'balaji'),
('Ganesh', '98,South Street,', 'Chennai', 'B.E. CS', 'Male', '9850059595', 'ganesh@gmail.com', 'ganesh');

-- --------------------------------------------------------

--
-- Table structure for table `examresult`
--

CREATE TABLE IF NOT EXISTS `examresult` (
  `userid` varchar(100) NOT NULL,
  `dt` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `markpercent` varchar(10) NOT NULL,
  PRIMARY KEY (`userid`,`dt`,`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `examresult`
--

INSERT INTO `examresult` (`userid`, `dt`, `subject`, `markpercent`) VALUES
('anand@gmail.com', '2016-09-07 3:47:55 PM', 'computer science', '50.0'),
('ganesh@gmail.com', '2016-03-19 4:56:24 PM', 'computer science', '75.0');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `sname` varchar(100) NOT NULL,
  `gname` varchar(100) NOT NULL,
  PRIMARY KEY (`gname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`sname`, `gname`) VALUES
('computer science', 'array'),
('gk', 'current affairs'),
('gk', 'india'),
('computer science', 'operator'),
('computer science', 'pointer'),
('gk', 'politics');

-- --------------------------------------------------------

--
-- Table structure for table `qrtab`
--

CREATE TABLE IF NOT EXISTS `qrtab` (
  `email` varchar(150) NOT NULL,
  `qrpath` varchar(300) NOT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `qrtab`
--

INSERT INTO `qrtab` (`email`, `qrpath`) VALUES
('anand@gmail.com', '1473244760228file.png'),
('balaji@gmail.com', '1473248357832file.png'),
('ganesh@gmail.com', '1473246314586file.png');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ques` varchar(600) NOT NULL,
  `ans1` varchar(100) NOT NULL,
  `ans2` varchar(100) NOT NULL,
  `ans3` varchar(100) NOT NULL,
  `ans4` varchar(100) NOT NULL,
  `ans5` varchar(100) NOT NULL,
  `cans` varchar(100) NOT NULL,
  `subject` varchar(100) NOT NULL,
  `gname` varchar(100) NOT NULL,
  `descr` varchar(800) NOT NULL,
  PRIMARY KEY (`ques`,`subject`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `ques`, `ans1`, `ans2`, `ans3`, `ans4`, `ans5`, `cans`, `subject`, `gname`, `descr`) VALUES
(3, '+ is which type of operator', 'unary', 'binary', 'ternary', 'special', 'user defined', 'binary', 'computer science', 'operator', '+ needs two operands so it is binary operator'),
(6, 'Address of variable can be stored in', 'variable', 'pointers', 'memory', 'structure', 'cannot store', 'pointers', 'computer science', 'pointer', 'normal variables cannot store address so pointers are needed'),
(1, 'Array index starts with...', 'one', 'two', 'zero', 'digit', 'alphabet', 'zero', 'computer science', 'array', 'it is a rule so that zero'),
(2, 'Arrays can be of', 'one dimension', 'two dimension', 'three dimension', 'zero dimension', 'n dimension', 'n dimension', 'computer science', 'array', 'dimensions of array is not a constant'),
(9, 'Dynamic memory allocation is done by', 'create', 'memcopy', 'malloc', 'alloc', 'none', 'malloc', 'computer science', 'pointer', 'memory is stored in pointer and is allocated using function malloc'),
(4, 'Operator ++ increments value by', 'one', 'two', 'zero', 'three', 'none', 'one', 'computer science', 'operator', 'since it is unary it needs one operand and increments value by one'),
(5, 'Size of pointer', '1byte', '2byte', '4byte', '10byte', 'nil', '2byte', 'computer science', 'operator', 'any pointer type is of size 2 bytes'),
(8, 'To test expression ___ operator is used', 'arithmetic', 'logical', 'increment', 'decrement', 'binary', 'logical', 'computer science', 'operator', 'logical operators are used to test expressions');

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE IF NOT EXISTS `subjects` (
  `subject` varchar(100) NOT NULL,
  PRIMARY KEY (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject`) VALUES
('computer science'),
('gk');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

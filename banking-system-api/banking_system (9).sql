-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2025 at 09:47 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `banking_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_no` varchar(34) NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_type_id` bigint(20) UNSIGNED NOT NULL,
  `currency` char(3) NOT NULL DEFAULT 'BDT',
  `balance` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `available_balance` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `status` enum('active','blocked','closed') NOT NULL DEFAULT 'active',
  `metadata` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`metadata`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `account_no`, `customer_id`, `branch_id`, `account_type_id`, `currency`, `balance`, `available_balance`, `status`, `metadata`, `created_at`, `updated_at`) VALUES
(1, 'SB-10000001', 4, 1, 1, 'BDT', 50000.0000, 50000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"personal\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(2, 'SB-10000002', 5, 1, 1, 'BDT', 25000.0000, 25000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"personal\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(3, 'SB-10000003', 6, 2, 4, 'BDT', 10000.0000, 10000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"student\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(4, 'SB-10000004', 7, 2, 5, 'BDT', 75000.0000, 75000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"senior\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(5, 'SB-10000005', 8, 3, 2, 'BDT', 150000.0000, 150000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"business\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(6, 'SB-10000006', 9, 3, 7, 'BDT', 45000.0000, 45000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"salary\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(7, 'SB-10000007', 10, 4, 8, 'BDT', 60000.0000, 60000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"joint\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(8, 'SB-10000008', 4, 4, 3, 'BDT', 120000.0000, 120000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"fixed\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(9, 'SB-10000009', 5, 5, 9, 'BDT', 200000.0000, 200000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"business\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(10, 'SB-10000010', 6, 5, 10, 'BDT', 5000.0000, 5000.0000, 'active', '{\"opened_by\":\"teller\",\"purpose\":\"minor\"}', '2025-12-15 17:19:35', '2025-12-15 17:19:35'),
(11, 'ACC-2025137178', 11, 2, 3, 'BDT', 28000.0000, 0.0000, 'active', NULL, '2025-12-18 13:35:17', '2025-12-22 12:23:23'),
(12, 'ACC-2025173454', 12, 5, 9, 'BDT', 0.0000, 0.0000, 'active', NULL, '2025-12-19 08:58:36', '2025-12-19 08:58:36'),
(13, 'ACC-2025348377', 13, 5, 8, 'BDT', 0.0000, 0.0000, 'active', NULL, '2025-12-19 09:09:09', '2025-12-19 09:09:09'),
(14, 'ACC-2025711688', 14, 5, 4, 'BDT', 0.0000, 0.0000, 'active', NULL, '2025-12-19 09:20:43', '2025-12-19 09:20:43'),
(15, 'ACC-2025577891', 15, 5, 3, 'BDT', 177250.0000, 0.0000, 'active', NULL, '2025-12-19 09:37:39', '2025-12-23 03:57:22'),
(16, 'ACC-2025202737', 16, 2, 1, 'BDT', 14750.0000, 0.0000, 'active', NULL, '2025-12-22 12:04:41', '2025-12-23 03:57:22');

-- --------------------------------------------------------

--
-- Table structure for table `account_types`
--

CREATE TABLE `account_types` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `interest_rate` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `min_balance` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `withdrawal_limit` int(11) DEFAULT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`config`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `account_types`
--

INSERT INTO `account_types` (`id`, `type_name`, `description`, `interest_rate`, `min_balance`, `withdrawal_limit`, `config`, `created_at`, `updated_at`) VALUES
(1, 'Savings', 'Personal savings account', 4.5000, 500.0000, 5, '{\"atm\":true,\"online_transfer\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(2, 'Current', 'Business current account', 0.0000, 0.0000, NULL, '{\"overdraft\":true,\"online_transfer\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(3, 'Fixed Deposit', 'Fixed deposit account', 5.0000, 10000.0000, 0, '{\"term_months\":[6,12,24]}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(4, 'Student Savings', 'Student account', 3.5000, 100.0000, 3, '{\"atm\":true,\"online_transfer\":false}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(5, 'Senior Citizen', 'Senior citizens savings', 4.7500, 500.0000, 5, '{\"atm\":true,\"online_transfer\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(6, 'Premium Current', 'High-value current', 0.0000, 0.0000, NULL, '{\"overdraft\":true,\"priority_service\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(7, 'Salary Account', 'Employee salary account', 4.2500, 500.0000, 5, '{\"atm\":true,\"direct_deposit\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(8, 'Joint Savings', 'Joint account for two or more', 4.5000, 500.0000, 5, '{\"atm\":true,\"online_transfer\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(9, 'Business Current', 'SME/business account', 0.0000, 0.0000, NULL, '{\"overdraft\":true,\"online_transfer\":true}', '2025-12-15 17:19:23', '2025-12-15 17:19:23'),
(10, 'Minor Savings', 'Account for minors', 3.0000, 50.0000, 3, '{\"atm\":true,\"online_transfer\":false}', '2025-12-15 17:19:23', '2025-12-15 17:19:23');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `model` varchar(100) DEFAULT NULL,
  `model_id` varchar(50) DEFAULT NULL,
  `before_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`before_data`)),
  `after_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`after_data`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `model`, `model_id`, `before_data`, `after_data`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'create', 'users', '4', NULL, '{\"name\":\"Customer 1\",\"email\":\"customer1@example.com\"}', '192.168.1.10', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(2, 2, 'update', 'accounts', '1', '{\"balance\":0}', '{\"balance\":50000}', '192.168.1.11', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(3, 1, 'delete', 'kyc_documents', '7', NULL, NULL, '192.168.1.10', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(4, 3, 'create', 'transactions', '1', NULL, '{\"amount\":50000,\"type\":\"deposit\"}', '192.168.1.12', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(5, 2, 'update', 'loan_payments', '1', '{\"amount_paid\":0}', '{\"amount_paid\":4166.67}', '192.168.1.11', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(6, 1, 'create', 'charges', '1', NULL, '{\"amount\":50,\"type\":\"fixed\"}', '192.168.1.10', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(7, 3, 'update', 'accounts', '2', '{\"balance\":0}', '{\"balance\":25000}', '192.168.1.12', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(8, 2, 'delete', 'notifications', '6', NULL, NULL, '192.168.1.11', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(9, 1, 'create', 'system_settings', '1', NULL, '{\"setting_key\":\"site_name\",\"setting_value\":\"MyBank\"}', '192.168.1.10', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(10, 3, 'update', 'loans', '3', '{\"status\":\"applied\"}', '{\"status\":\"disbursed\"}', '192.168.1.12', 'Mozilla/5.0', '2025-12-15 18:59:29'),
(11, 13, 'teller_created', 'Teller', '24', '{}', '{\"user_id\":36,\"branch_id\":5,\"teller_code\":\"TLR000036\",\"designation\":\"Cashier\",\"daily_cash_limit\":\"200000.00\",\"updated_at\":\"2025-12-16T16:36:47.000000Z\",\"created_at\":\"2025-12-16T16:36:47.000000Z\",\"id\":24}', '127.0.0.1', 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Mobile Safari/537.36', '2025-12-16 16:36:47'),
(12, 13, 'teller_created', 'Teller', '25', '[]', '{\"user\":{\"id\":42,\"name\":\"Rupon Sorkar\",\"email\":\"rupon@gmail.com\"},\"teller_details\":{\"user_id\":42,\"branch_id\":2,\"teller_code\":\"TLR000042\",\"designation\":\"Cashier\",\"daily_cash_limit\":\"600000.00\",\"updated_at\":\"2025-12-21T19:57:04.000000Z\",\"created_at\":\"2025-12-21T19:57:04.000000Z\",\"id\":25}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-21 13:57:04'),
(13, 13, 'teller_created', 'Teller', '26', '[]', '{\"user\":{\"id\":44,\"name\":\"roxi islam\",\"email\":\"roxi123@gmail.com\"},\"teller_details\":{\"user_id\":44,\"branch_id\":2,\"teller_code\":\"TLR000044\",\"designation\":\"Cashier\",\"daily_cash_limit\":\"0.00\",\"current_balance\":0,\"updated_at\":\"2025-12-23T09:54:47.000000Z\",\"created_at\":\"2025-12-23T09:54:47.000000Z\",\"id\":26}}', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '2025-12-23 03:54:47');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_code` varchar(20) NOT NULL,
  `name` varchar(150) NOT NULL,
  `address` text DEFAULT NULL,
  `manager_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `branch_code`, `name`, `address`, `manager_id`, `phone`, `status`, `created_at`, `updated_at`) VALUES
(1, 'DHK-001', 'Dhaka Main', 'Motijheel', 1, '02-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(2, 'DHK-002', 'Dhaka North', 'Uttara', 1, '02-112', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(3, 'CTG-001', 'Chittagong', 'Agrabad', 1, '031-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(4, 'SYL-001', 'Sylhet', 'Zindabazar', 1, '0821-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(5, 'RAJ-001', 'Rajshahi', 'Shaheb Bazar', 1, '0721-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(6, 'KHL-001', 'Khulna', 'Shibbari', 1, '041-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(7, 'BAR-001', 'Barisal', 'Nattullabad', 1, '0431-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(8, 'RNG-001', 'Rangpur', 'Station Road', 1, '0521-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(9, 'MYM-001', 'Mymensingh', 'Ganginarpar', 1, '091-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15'),
(10, 'COM-001', 'Comilla', 'Kandirpar', 1, '081-111', 'active', '2025-12-15 17:14:15', '2025-12-15 17:14:15');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `charge_code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `amount` decimal(18,4) NOT NULL,
  `type` enum('fixed','percentage') NOT NULL DEFAULT 'fixed',
  `account_type_id` bigint(20) UNSIGNED DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `charges`
--

INSERT INTO `charges` (`id`, `charge_code`, `name`, `amount`, `type`, `account_type_id`, `description`, `created_at`, `updated_at`) VALUES
(1, 'CHG-001', 'ATM Withdrawal Fee', 50.0000, 'fixed', 1, 'Fee for ATM cash withdrawal', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(2, 'CHG-002', 'Online Transfer Fee', 10.0000, 'fixed', 1, 'Fee for online transfer', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(3, 'CHG-003', 'Monthly Maintenance', 100.0000, 'fixed', 1, 'Monthly account maintenance', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(4, 'CHG-004', 'Late Payment Fee', 500.0000, 'fixed', 1, 'Late loan payment charge', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(5, 'CHG-005', 'Overdraft Fee', 200.0000, 'fixed', 2, 'Overdraft usage fee', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(6, 'CHG-006', 'Cheque Bounce Fee', 300.0000, 'fixed', 2, 'Cheque dishonor charge', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(7, 'CHG-007', 'Account Closure Fee', 150.0000, 'fixed', 1, 'Fee to close account', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(8, 'CHG-008', 'International Transfer Fee', 1000.0000, 'fixed', 2, 'Fee for international transfer', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(9, 'CHG-009', 'SMS Alert Fee', 20.0000, 'fixed', 1, 'Fee for SMS notifications', '2025-12-15 18:48:49', '2025-12-15 18:48:49'),
(10, 'CHG-010', 'Minimum Balance Penalty', 250.0000, 'fixed', 1, 'Penalty for below minimum balance', '2025-12-15 18:48:49', '2025-12-15 18:48:49');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_code` varchar(30) NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `kyc_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`kyc_data`)),
  `dob` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `status` enum('active','inactive','closed') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `user_id`, `customer_code`, `branch_id`, `kyc_data`, `dob`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 27, 'CUST-1001', 1, '{\"nid\":\"111\",\"source\":\"salary\"}', '1995-01-01', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(2, 5, 'CUST-1002', 2, '{\"nid\":\"112\",\"source\":\"business\"}', '1992-02-02', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(3, 6, 'CUST-1003', 5, '{\"nid\":\"113\",\"source\":\"salary\"}', '1998-03-03', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(4, 7, 'CUST-1004', 3, '{\"nid\":\"114\",\"source\":\"salary\"}', '1996-04-04', 'Dhaka', 'inactive', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(5, 8, 'CUST-1005', 2, '{\"nid\":\"115\",\"source\":\"business\"}', '1991-05-05', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(6, 9, 'CUST-1006', 4, '{\"nid\":\"116\",\"source\":\"salary\"}', '1994-06-06', 'Dhaka', 'closed', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(7, 10, 'CUST-1007', 7, '{\"nid\":\"117\",\"source\":\"salary\"}', '1993-07-07', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(8, 29, 'CUST-1008', 1, '{\"nid\":\"118\",\"source\":\"business\"}', '1990-08-08', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(9, 16, 'CUST-1009', 2, '{\"nid\":\"119\",\"source\":\"salary\"}', '1997-09-09', 'Dhaka', 'closed', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(10, 6, 'CUST-1010', 5, '{\"nid\":\"120\",\"source\":\"salary\"}', '1999-10-10', 'Dhaka', 'active', '2025-12-15 17:16:56', '2025-12-15 17:16:56'),
(11, 37, 'CUST-CQUUIT', 2, NULL, '2000-08-22', 'Malibagh,Dhaka', 'active', '2025-12-18 13:35:16', '2025-12-18 13:35:16'),
(12, 38, 'CUST-O9JNIN', 5, NULL, '2000-02-22', 'Mirpur ,Dhaka', 'active', '2025-12-19 08:58:36', '2025-12-19 08:58:36'),
(13, 39, 'CUST-ZUA7MJ', 5, NULL, '1999-11-22', 'Malibagh', 'active', '2025-12-19 09:09:09', '2025-12-19 09:09:09'),
(14, 40, 'CUST-QJORFU', 5, NULL, '1998-02-22', 'Rajshahi', 'active', '2025-12-19 09:20:43', '2025-12-19 09:20:43'),
(15, 41, 'CUST-XPBQJN', 5, NULL, '1998-02-22', 'Rajshahi', 'active', '2025-12-19 09:37:39', '2025-12-19 09:37:39'),
(16, 43, 'CUST-DCXJAD', 2, NULL, '1999-02-22', 'Karanigonj,Dhaka', 'active', '2025-12-22 12:04:41', '2025-12-22 12:04:41');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `interest_rules`
--

CREATE TABLE `interest_rules` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `account_type_id` bigint(20) UNSIGNED NOT NULL,
  `rate` decimal(8,4) NOT NULL,
  `calculation_method` enum('daily','monthly','yearly') NOT NULL DEFAULT 'monthly',
  `compounding` enum('yes','no') NOT NULL DEFAULT 'no',
  `effective_from` date NOT NULL,
  `effective_to` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `interest_rules`
--

INSERT INTO `interest_rules` (`id`, `account_type_id`, `rate`, `calculation_method`, `compounding`, `effective_from`, `effective_to`, `created_at`, `updated_at`) VALUES
(1, 1, 4.5000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(2, 2, 0.0000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(3, 3, 5.0000, 'yearly', 'yes', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(4, 4, 3.5000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(5, 5, 4.7500, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(6, 6, 0.0000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(7, 7, 4.2500, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(8, 8, 4.5000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(9, 9, 0.0000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05'),
(10, 10, 3.0000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-15 18:49:05', '2025-12-15 18:49:05');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_documents`
--

CREATE TABLE `kyc_documents` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `document_type` enum('nid','passport','birth_certificate','utility_bill','photo','signature') NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `verified_by` bigint(20) UNSIGNED DEFAULT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','verified','rejected') NOT NULL DEFAULT 'pending',
  `remarks` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kyc_documents`
--

INSERT INTO `kyc_documents` (`id`, `customer_id`, `document_type`, `file_path`, `verified_by`, `verified_at`, `status`, `remarks`, `created_at`, `updated_at`) VALUES
(1, 4, 'nid', 'uploads/kyc/nid_cust1.pdf', 1, '2025-01-05 04:00:00', 'verified', 'Verified by admin', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(2, 5, 'passport', 'uploads/kyc/passport_cust2.pdf', 1, '2025-01-06 05:00:00', 'verified', 'Verified by admin', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(3, 6, 'birth_certificate', 'uploads/kyc/bc_cust3.pdf', 2, '2025-01-07 03:30:00', 'verified', 'Verified by teller', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(4, 7, 'utility_bill', 'uploads/kyc/ub_cust4.pdf', 2, '2025-01-08 06:15:00', 'pending', 'Pending verification', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(5, 8, 'photo', 'uploads/kyc/photo_cust5.jpg', NULL, NULL, 'pending', 'Awaiting verification', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(6, 9, 'signature', 'uploads/kyc/sign_cust6.jpg', 1, '2025-01-09 08:00:00', 'verified', 'Verified by admin', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(7, 10, 'nid', 'uploads/kyc/nid_cust7.pdf', 2, '2025-01-10 09:30:00', 'rejected', 'Invalid document', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(8, 4, 'passport', 'uploads/kyc/passport_cust1.pdf', 1, '2025-01-11 04:20:00', 'verified', 'Verified', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(9, 5, 'photo', 'uploads/kyc/photo_cust2.jpg', NULL, NULL, 'pending', 'Awaiting verification', '2025-12-15 18:50:22', '2025-12-15 18:50:22'),
(10, 6, 'signature', 'uploads/kyc/sign_cust3.jpg', 1, '2025-01-12 10:45:00', 'verified', 'Verified by admin', '2025-12-15 18:50:22', '2025-12-15 18:50:22');

-- --------------------------------------------------------

--
-- Table structure for table `ledgers`
--

CREATE TABLE `ledgers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaction_id` bigint(20) UNSIGNED NOT NULL,
  `ledger_code` varchar(64) NOT NULL,
  `debit_account` varchar(64) DEFAULT NULL,
  `credit_account` varchar(64) DEFAULT NULL,
  `amount` decimal(18,4) NOT NULL,
  `narration` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ledgers`
--

INSERT INTO `ledgers` (`id`, `transaction_id`, `ledger_code`, `debit_account`, `credit_account`, `amount`, `narration`, `created_at`) VALUES
(1, 1, 'LED-DEP-001', 'Cash', 'SB-10000001', 50000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(2, 2, 'LED-DEP-002', 'Cash', 'SB-10000002', 25000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(3, 3, 'LED-DEP-003', 'Cash', 'SB-10000003', 10000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(4, 4, 'LED-DEP-004', 'Cash', 'SB-10000004', 75000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(5, 5, 'LED-DEP-005', 'Cash', 'SB-10000005', 150000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(6, 6, 'LED-DEP-006', 'Cash', 'SB-10000006', 45000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(7, 7, 'LED-DEP-007', 'Cash', 'SB-10000007', 60000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(8, 8, 'LED-DEP-008', 'Cash', 'SB-10000008', 120000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(9, 9, 'LED-DEP-009', 'Cash', 'SB-10000009', 200000.0000, 'Deposit posting', '2025-12-15 17:20:02'),
(10, 10, 'LED-DEP-010', 'Cash', 'SB-10000010', 5000.0000, 'Deposit posting', '2025-12-15 17:20:02');

-- --------------------------------------------------------

--
-- Table structure for table `loans`
--

CREATE TABLE `loans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loan_no` varchar(50) NOT NULL,
  `customer_id` bigint(20) UNSIGNED NOT NULL,
  `product_code` varchar(50) DEFAULT NULL,
  `principal_amount` decimal(18,4) NOT NULL,
  `outstanding_amount` decimal(18,4) NOT NULL,
  `interest_rate` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `term_months` int(11) NOT NULL DEFAULT 0,
  `disbursed_at` timestamp NULL DEFAULT NULL,
  `status` enum('applied','approved','disbursed','closed','defaulted','rejected') NOT NULL DEFAULT 'applied',
  `schedule` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`schedule`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loans`
--

INSERT INTO `loans` (`id`, `loan_no`, `customer_id`, `product_code`, `principal_amount`, `outstanding_amount`, `interest_rate`, `term_months`, `disbursed_at`, `status`, `schedule`, `created_at`, `updated_at`) VALUES
(1, 'LN-1001', 4, 'PRD-001', 50000.0000, 50000.0000, 12.5000, 12, '2025-01-01 04:00:00', 'applied', '{\"installments\":[{\"month\":1,\"due\":4166.67}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(2, 'LN-1002', 5, 'PRD-002', 100000.0000, 100000.0000, 10.0000, 24, '2025-02-01 05:00:00', 'approved', '{\"installments\":[{\"month\":1,\"due\":4166.67}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(3, 'LN-1003', 6, 'PRD-001', 75000.0000, 35000.0000, 11.5000, 18, '2025-03-01 03:00:00', 'disbursed', '{\"installments\":[{\"month\":1,\"due\":4166.67}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(4, 'LN-1004', 7, 'PRD-003', 200000.0000, 200000.0000, 13.0000, 36, '2025-04-01 08:00:00', 'applied', '{\"installments\":[{\"month\":1,\"due\":5555.56}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(5, 'LN-1005', 8, 'PRD-002', 150000.0000, 150000.0000, 10.5000, 24, '2025-05-01 06:00:00', 'disbursed', '{\"installments\":[{\"month\":1,\"due\":6250.00}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(6, 'LN-1006', 9, 'PRD-001', 50000.0000, 50000.0000, 12.0000, 12, '2025-06-01 09:00:00', 'approved', '{\"installments\":[{\"month\":1,\"due\":4166.67}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(7, 'LN-1007', 10, 'PRD-003', 300000.0000, 300000.0000, 13.5000, 36, '2025-07-01 10:00:00', 'disbursed', '{\"installments\":[{\"month\":1,\"due\":8333.33}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(8, 'LN-1008', 4, 'PRD-002', 80000.0000, 80000.0000, 11.0000, 24, '2025-08-01 04:00:00', 'applied', '{\"installments\":[{\"month\":1,\"due\":3333.33}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(9, 'LN-1009', 5, 'PRD-003', 120000.0000, 120000.0000, 12.7500, 36, '2025-09-01 05:30:00', 'disbursed', '{\"installments\":[{\"month\":1,\"due\":3333.33}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17'),
(10, 'LN-1010', 6, 'PRD-001', 60000.0000, 60000.0000, 11.2500, 18, '2025-10-01 03:45:00', 'approved', '{\"installments\":[{\"month\":1,\"due\":3333.33}]}', '2025-12-15 18:48:17', '2025-12-15 18:48:17');

-- --------------------------------------------------------

--
-- Table structure for table `loan_payments`
--

CREATE TABLE `loan_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `loan_id` bigint(20) UNSIGNED NOT NULL,
  `due_date` date NOT NULL,
  `amount_due` decimal(18,4) NOT NULL,
  `amount_paid` decimal(18,4) NOT NULL DEFAULT 0.0000,
  `paid_at` timestamp NULL DEFAULT NULL,
  `status` enum('pending','paid','overdue') NOT NULL DEFAULT 'pending',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `loan_payments`
--

INSERT INTO `loan_payments` (`id`, `loan_id`, `due_date`, `amount_due`, `amount_paid`, `paid_at`, `status`, `meta`, `created_at`, `updated_at`) VALUES
(1, 1, '2025-02-01', 4166.6700, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(2, 2, '2025-03-01', 4166.6700, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(3, 3, '2025-04-01', 4166.6700, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(4, 4, '2025-05-01', 5555.5600, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(5, 5, '2025-06-01', 6250.0000, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(6, 6, '2025-07-01', 4166.6700, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(7, 7, '2025-08-01', 8333.3300, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(8, 8, '2025-09-01', 3333.3300, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(9, 9, '2025-10-01', 3333.3300, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32'),
(10, 10, '2025-11-01', 3333.3300, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-15 18:48:32', '2025-12-15 18:48:32');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_12_10_044225_create_personal_access_tokens_table', 1),
(5, '2025_12_10_181328_create_roles_table', 1),
(6, '2025_12_10_181349_create_customers_table', 1),
(7, '2025_12_10_181354_create_branches_table', 1),
(8, '2025_12_10_181402_create_account_types_table', 1),
(9, '2025_12_10_181410_create_accounts_table', 1),
(10, '2025_12_10_181439_create_transactions_table', 1),
(11, '2025_12_10_181453_create_loans_table', 1),
(12, '2025_12_10_181511_create_audit_logs_table', 1),
(13, '2025_12_10_181518_create_notifications_table', 1),
(14, '2025_12_10_181526_create_payment_gateways_table', 1),
(15, '2025_12_10_181534_create_system_settings_table', 1),
(16, '2025_12_10_181559_create_indexes_table', 1),
(17, '2025_12_10_182713_create_ledgers_table', 1),
(18, '2025_12_10_183138_create_charges_table', 1),
(19, '2025_12_10_183202_create_interest_rules_table', 1),
(20, '2025_12_10_183412_create_kyc_documents_table', 1),
(21, '2025_12_10_183742_create_loan_payments_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `title` varchar(150) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`data`)),
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `type`, `title`, `message`, `data`, `is_read`, `read_at`, `created_at`, `updated_at`) VALUES
('7e156181-d9e8-11f0-a4c7-6018952d99a7', 4, 'system', 'Welcome', 'Your account has been created', '{\"priority\":\"high\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e19e2bd-d9e8-11f0-a4c7-6018952d99a7', 5, 'transaction', 'Deposit Success', 'Your deposit of 25000 BDT was successful', '{\"amount\":25000,\"account_no\":\"SB-10000002\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c6edf-d9e8-11f0-a4c7-6018952d99a7', 6, 'loan', 'Loan Approved', 'Your loan LN-1003 has been approved', '{\"loan_no\":\"LN-1003\",\"amount\":75000}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c71ba-d9e8-11f0-a4c7-6018952d99a7', 7, 'kyc', 'KYC Pending', 'Please submit your KYC documents', '{\"due_date\":\"2025-01-20\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c726c-d9e8-11f0-a4c7-6018952d99a7', 8, 'system', 'Account Blocked', 'Your account is temporarily blocked', '{\"reason\":\"suspicious activity\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c72f6-d9e8-11f0-a4c7-6018952d99a7', 9, 'transaction', 'Interest Credited', 'Interest has been credited to your account', '{\"amount\":500,\"account_no\":\"SB-10000006\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c73a7-d9e8-11f0-a4c7-6018952d99a7', 10, 'loan', 'Payment Reminder', 'Your loan payment of 4166.67 BDT is due', '{\"loan_no\":\"LN-1007\",\"amount\":8333.33}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c742f-d9e8-11f0-a4c7-6018952d99a7', 4, 'system', 'System Update', 'System will be down for maintenance', '{\"start_time\":\"2025-01-15\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c74fa-d9e8-11f0-a4c7-6018952d99a7', 5, 'security', 'Password Change', 'Your password has been changed', '{\"method\":\"self\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37'),
('7e1c7586-d9e8-11f0-a4c7-6018952d99a7', 6, 'system', 'New Feature', 'Mobile banking app updated', '{\"version\":\"v2.0\"}', 0, NULL, '2025-12-15 19:01:37', '2025-12-15 19:01:37');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_gateways`
--

CREATE TABLE `payment_gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `gateway_name` varchar(100) NOT NULL,
  `api_key` varchar(255) DEFAULT NULL,
  `secret` varchar(255) DEFAULT NULL,
  `merchant_id` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`config`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(97, 'App\\Models\\User', 13, 'web-token', '789df7105fc4d45d69cf5f3011bbb6d4695e8ec5b5df92bb90841ec92fc60afc', '[\"*\"]', '2025-12-23 03:56:30', NULL, '2025-12-23 03:52:35', '2025-12-23 03:56:30');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `guard_name` varchar(50) NOT NULL DEFAULT 'web',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2025-12-15 19:08:06', '2025-12-15 19:08:06'),
(2, 'teller', 'web', '2025-12-15 19:08:06', '2025-12-15 19:08:06'),
(3, 'customer', 'web', '2025-12-15 19:08:06', '2025-12-15 19:08:06');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('JYnPhCZ1GLRk0OkWRejHVpVbheWtKrJd6HcdLNhJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibE96YTBYaktzNTA1bzJzY0VyT3NlSDd5c0ZtbUZyZEQ4MWw1T1pUTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1765983118),
('vX67D4knP26MJZAs3I8btqW3aiYFVtFAZdDycY8Q', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic0hsTnFvMGVoWnhtWlhGMW5lNENoaXE2bzYyN1hUaGZOUzgxR2JRcyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7czo1OiJyb3V0ZSI7Tjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1765866639);

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(150) NOT NULL,
  `value` text DEFAULT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'string',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tellers`
--

CREATE TABLE `tellers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `teller_code` varchar(30) DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `designation` varchar(50) DEFAULT 'Cashier',
  `daily_cash_limit` decimal(18,2) DEFAULT 0.00,
  `current_balance` decimal(15,2) DEFAULT 0.00,
  `status` enum('active','suspended') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tellers`
--

INSERT INTO `tellers` (`id`, `user_id`, `teller_code`, `branch_id`, `designation`, `daily_cash_limit`, `current_balance`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 'TLR-001', 1, 'Senior Teller', 500000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(2, 3, 'TLR-002', 1, 'Junior Teller', 300000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(3, 4, 'TLR-003', 2, 'Senior Teller', 500000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(4, 5, 'TLR-004', 2, 'Junior Teller', 300000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(5, 6, 'TLR-005', 3, 'Senior Teller', 500000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(6, 3, 'TLR-006', 3, 'Junior Teller', 300000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(7, 7, 'TLR-007', 4, 'Senior Teller', 500000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(8, 8, 'TLR-008', 4, 'Junior Teller', 300000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(9, 9, 'TLR-009', 5, 'Senior Teller', 500000.00, 0.00, 'active', '2025-12-15 17:16:11', '2025-12-15 17:16:11'),
(10, 12, 'TLR-010', 5, 'Junior Teller', 300000.00, -10000.00, 'active', '2025-12-15 17:16:11', '2025-12-22 09:46:26'),
(11, 23, NULL, 1, 'Cashier', 500000.00, 0.00, 'active', '2025-12-16 06:35:07', '2025-12-16 06:35:07'),
(12, 24, NULL, 1, 'Cashier', 500000.00, 0.00, 'active', '2025-12-16 06:37:33', '2025-12-16 06:37:33'),
(13, 25, NULL, 1, 'Cashier', 50000.00, 0.00, 'active', '2025-12-16 06:41:37', '2025-12-16 06:41:37'),
(14, 26, NULL, 1, 'Cashier', 50000.00, 0.00, 'active', '2025-12-16 06:41:56', '2025-12-16 06:41:56'),
(15, 27, NULL, 1, 'Cashier', 50000.00, 0.00, 'active', '2025-12-16 06:44:50', '2025-12-16 06:44:50'),
(24, 36, 'TLR000036', 5, 'Cashier', 200000.00, 50000.00, 'active', '2025-12-16 10:36:47', '2025-12-21 15:59:33'),
(25, 42, 'TLR000042', 2, 'Cashier', 600000.00, 129900.00, 'active', '2025-12-21 13:57:04', '2025-12-22 10:46:08'),
(26, 44, 'TLR000044', 2, 'Cashier', 0.00, 100000.00, 'active', '2025-12-23 03:54:47', '2025-12-23 03:55:35');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tx_uuid` char(36) NOT NULL,
  `account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `teller_id` bigint(20) UNSIGNED DEFAULT NULL,
  `account_relation_id` varchar(36) DEFAULT NULL,
  `type` enum('deposit','withdrawal','transfer','fee','interest','cash_load','adjustment','cash_return','transfer_out','transfer_in') NOT NULL,
  `amount` decimal(18,4) NOT NULL,
  `balance_before` decimal(18,4) NOT NULL,
  `balance_after` decimal(18,4) NOT NULL,
  `status` enum('pending','completed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `reference` varchar(255) DEFAULT NULL,
  `narration` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `tx_uuid`, `account_id`, `branch_id`, `teller_id`, `account_relation_id`, `type`, `amount`, `balance_before`, `balance_after`, `status`, `reference`, `narration`, `meta`, `created_at`, `updated_at`) VALUES
(1, '448dd29b-d9da-11f0-a4c7-6018952d99a7', 15, 5, 10, NULL, 'deposit', 50000.0000, 0.0000, 50000.0000, 'completed', NULL, 'Initial deposit', '{\"channel\":\"cash\",\"posted_by\":2}', '2025-12-19 17:19:47', '2025-12-15 17:19:47'),
(2, '449170b5-d9da-11f0-a4c7-6018952d99a7', 2, 5, 10, NULL, 'withdrawal', 25000.0000, 0.0000, 25000.0000, 'completed', NULL, 'Initial deposit', '{\"channel\":\"cash\",\"posted_by\":2}', '2025-12-19 17:19:47', '2025-12-15 17:19:47'),
(3, '4491a4ee-d9da-11f0-a4c7-6018952d99a7', 3, 5, 10, NULL, 'deposit', 10000.0000, 0.0000, 10000.0000, 'completed', NULL, 'Student account deposit', '{\"channel\":\"cash\",\"posted_by\":3}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(4, '4491a66e-d9da-11f0-a4c7-6018952d99a7', 4, 0, NULL, NULL, 'deposit', 75000.0000, 0.0000, 75000.0000, 'completed', NULL, 'Senior citizen deposit', '{\"channel\":\"cash\",\"posted_by\":3}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(5, '4491b8be-d9da-11f0-a4c7-6018952d99a7', 5, 0, NULL, NULL, 'deposit', 150000.0000, 0.0000, 150000.0000, 'completed', NULL, 'Business deposit', '{\"channel\":\"cash\",\"posted_by\":5}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(6, '4491b9f7-d9da-11f0-a4c7-6018952d99a7', 6, 0, NULL, NULL, 'deposit', 45000.0000, 0.0000, 45000.0000, 'completed', NULL, 'Salary account deposit', '{\"channel\":\"cash\",\"posted_by\":5}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(7, '4491ba66-d9da-11f0-a4c7-6018952d99a7', 7, 0, NULL, NULL, 'deposit', 60000.0000, 0.0000, 60000.0000, 'completed', NULL, 'Joint savings deposit', '{\"channel\":\"cash\",\"posted_by\":6}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(8, '4491bac4-d9da-11f0-a4c7-6018952d99a7', 8, 0, NULL, NULL, 'deposit', 120000.0000, 0.0000, 120000.0000, 'completed', NULL, 'Fixed deposit', '{\"channel\":\"cash\",\"posted_by\":6}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(9, '4491bb47-d9da-11f0-a4c7-6018952d99a7', 9, 0, NULL, NULL, 'deposit', 200000.0000, 0.0000, 200000.0000, 'completed', NULL, 'Business account deposit', '{\"channel\":\"cash\",\"posted_by\":7}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(10, '4491bbcd-d9da-11f0-a4c7-6018952d99a7', 10, 0, NULL, NULL, 'deposit', 5000.0000, 0.0000, 5000.0000, 'completed', NULL, 'Minor account deposit', '{\"channel\":\"cash\",\"posted_by\":7}', '2025-12-15 17:19:47', '2025-12-15 17:19:47'),
(11, '3077d599-c4fa-4380-9c17-b07b85ff203b', 15, 5, 10, NULL, 'deposit', 20000.0000, 0.0000, 20000.0000, 'completed', NULL, 'Cash deposit by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-19 21:36:59\"}', '2025-12-19 15:36:59', '2025-12-19 15:36:59'),
(12, '06a60861-6fc1-459b-b015-8a3974bd5fbe', 15, 5, 10, NULL, 'withdrawal', 10000.0000, 20000.0000, 10000.0000, 'completed', NULL, 'Cash withdrawal by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-20 18:16:37\"}', '2025-12-20 12:16:37', '2025-12-20 12:16:37'),
(13, '9a0296c6-bcf8-4a5b-afc7-c8852b0347c2', 15, 5, 10, NULL, 'withdrawal', 10000.0000, 10000.0000, 0.0000, 'completed', NULL, 'Cash withdrawal by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-20 18:18:31\"}', '2025-12-20 12:18:31', '2025-12-20 12:18:31'),
(14, '560cdec7-0057-4369-9949-1c8e96348daf', 15, 5, 10, NULL, 'deposit', 200000.0000, 0.0000, 200000.0000, 'completed', NULL, 'Cash deposit by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-20 18:19:28\"}', '2025-12-20 12:19:28', '2025-12-20 12:19:28'),
(15, '4c2b5e3f-958f-472d-8000-cb6c0a91dd28', 15, 5, 10, NULL, 'deposit', 1000.0000, 200000.0000, 201000.0000, 'completed', NULL, 'Cash deposit by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-20 18:21:07\"}', '2025-12-20 12:21:07', '2025-12-20 12:21:07'),
(16, '9fdec837-4e77-4faa-8e60-47828f959b89', 15, 5, 10, NULL, 'withdrawal', 1000.0000, 201000.0000, 200000.0000, 'completed', NULL, 'Cash withdrawal by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Linux; Android 6.0; Nexus 5 Build\\/MRA58N) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Mobile Safari\\/537.36\",\"timestamp\":\"2025-12-20 18:21:32\"}', '2025-12-20 12:21:32', '2025-12-20 12:21:32'),
(17, 'a99e2101-a560-49dd-83f1-af0732698f8d', NULL, 5, 24, NULL, 'cash_load', 50000.0000, 50000.0000, 100000.0000, 'completed', 'Vault to Teller Cash Loading', 'Cash loaded by Admin', '{\"loaded_by_admin\":\"Sohel Rana\",\"admin_user_id\":13,\"ip_address\":\"127.0.0.1\",\"timestamp\":\"2025-12-21 21:59:34\"}', '2025-12-21 15:59:34', '2025-12-21 15:59:34'),
(18, '585705ed-9c20-489b-83b7-93c1b0eb25bf', NULL, 2, 25, NULL, 'cash_load', 50000.0000, 50100.0000, 100100.0000, 'completed', 'Vault to Teller Cash Loading', 'Cash loaded by Admin', '{\"loaded_by_admin\":\"Sohel Rana\",\"admin_user_id\":13,\"ip_address\":\"127.0.0.1\",\"timestamp\":\"2025-12-21 22:00:02\"}', '2025-12-21 16:00:02', '2025-12-21 16:00:02'),
(19, '010b0108-ec9f-47e6-bff1-18312502130c', 11, 2, 25, NULL, 'deposit', 1000.0000, 0.0000, 1000.0000, 'completed', 'Cash Deposit via Teller', 'Cash deposit by teller', '{\"processed_by\":\"Rupon Sorkar\",\"teller_user_id\":42,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36\",\"timestamp\":\"2025-12-21 22:02:03\"}', '2025-12-21 16:02:03', '2025-12-21 16:02:03'),
(20, '8fc9bf1c-b19f-4e3e-a737-308610976097', 11, 2, 25, NULL, 'withdrawal', 1000.0000, 1000.0000, 0.0000, 'completed', 'Cash Deposit via Teller', 'Cash withdrawal by teller', '{\"processed_by\":\"Rupon Sorkar\",\"teller_user_id\":42,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36\",\"timestamp\":\"2025-12-21 22:02:32\"}', '2025-12-21 16:02:32', '2025-12-21 16:02:32'),
(21, 'ecdfecaa-117a-4629-acfb-0fb4ebae406a', 15, 5, 10, NULL, 'withdrawal', 10000.0000, 200000.0000, 190000.0000, 'completed', 'Cash Deposit via Teller', 'Cash withdrawal by teller', '{\"processed_by\":\"Madani\",\"teller_user_id\":12,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36\",\"timestamp\":\"2025-12-22 15:46:28\"}', '2025-12-22 09:46:28', '2025-12-22 09:46:28'),
(22, '173b01a0-75ca-47ef-81b6-4e558cd748f5', NULL, NULL, 25, NULL, 'cash_return', 50100.0000, 50100.0000, 0.0000, 'completed', 'Cash returned to vault at end of day', NULL, NULL, '2025-12-22 10:30:52', NULL),
(23, '60e297e0-8d95-478d-bc8e-ff235aec2062', NULL, 2, 25, NULL, 'cash_load', 50000.0000, 50000.0000, 100000.0000, 'completed', 'Vault to Teller Cash Loading', 'Cash loaded by Admin', '{\"loaded_by_admin\":\"Sohel Rana\",\"admin_user_id\":13,\"ip_address\":\"127.0.0.1\",\"timestamp\":\"2025-12-22 16:36:45\"}', '2025-12-22 10:36:45', '2025-12-22 10:36:45'),
(24, 'daff67ab-1c71-4d3d-b4ba-f66d61fe5dce', NULL, NULL, 25, NULL, 'cash_return', 50000.0000, 50000.0000, 0.0000, 'completed', 'Cash returned to vault at end of day', NULL, NULL, '2025-12-22 10:37:12', NULL),
(25, 'c8f41cf1-f1fe-4b21-a52c-dd80175d3b9c', NULL, 2, 25, NULL, 'cash_load', 100000.0000, 100000.0000, 200000.0000, 'completed', 'Vault to Teller Cash Loading', 'Cash loaded by Admin', '{\"loaded_by_admin\":\"Sohel Rana\",\"admin_user_id\":13,\"ip_address\":\"127.0.0.1\",\"timestamp\":\"2025-12-22 16:45:28\"}', '2025-12-22 10:45:28', '2025-12-22 10:45:28'),
(26, '08a1274d-4d80-4c7a-94ad-df917e7891a9', 11, 2, 25, NULL, 'deposit', 30000.0000, 0.0000, 30000.0000, 'completed', 'Cash Deposit via Teller', 'Cash deposit by teller', '{\"processed_by\":\"Rupon Sorkar\",\"teller_user_id\":42,\"terminal_id\":\"T-01\",\"ip_address\":\"127.0.0.1\",\"device\":\"Mozilla\\/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit\\/537.36 (KHTML, like Gecko) Chrome\\/143.0.0.0 Safari\\/537.36\",\"timestamp\":\"2025-12-22 16:46:08\"}', '2025-12-22 10:46:08', '2025-12-22 10:46:08'),
(29, '093fe739-a9c0-48c4-a42f-d582cb4a8b20', 11, NULL, NULL, NULL, 'transfer_out', 2000.0000, 30000.0000, 28000.0000, 'completed', 'TRF to ACC-2025202737', 'gift', NULL, '2025-12-22 12:23:23', '2025-12-22 12:23:23'),
(30, '7ec6df95-a90a-4ccb-a59b-2963408dd431', 16, NULL, NULL, NULL, 'transfer_in', 2000.0000, 0.0000, 2000.0000, 'completed', 'TRF from ACC-2025137178', 'gift', NULL, '2025-12-22 12:23:23', '2025-12-22 12:23:23'),
(31, 'c78fe6ce-2945-44a9-a8d7-b908409106d7', 16, NULL, NULL, NULL, 'transfer_out', 100.0000, 2000.0000, 1900.0000, 'completed', 'TRF to ACC-2025577891', 'gitt', NULL, '2025-12-22 12:54:44', '2025-12-22 12:54:44'),
(32, '7eb7499e-e752-4de6-90a8-d9c1d2260aaf', 15, NULL, NULL, NULL, 'transfer_in', 100.0000, 190000.0000, 190100.0000, 'completed', 'TRF from ACC-2025202737', 'gitt', NULL, '2025-12-22 12:54:44', '2025-12-22 12:54:44'),
(33, '65791a75-ca08-44ab-9454-e86f9f0196c9', 15, NULL, NULL, NULL, 'transfer_out', 150.0000, 190100.0000, 189950.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-22 13:00:58', '2025-12-22 13:00:58'),
(34, 'f3251634-a0db-4acc-ac07-d612cbbdd6b0', 16, NULL, NULL, NULL, 'transfer_in', 150.0000, 1900.0000, 2050.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-22 13:00:58', '2025-12-22 13:00:58'),
(35, '22c7c7ca-2c12-43f3-9812-f47595fe0258', 15, NULL, NULL, NULL, 'transfer_out', 100.0000, 189950.0000, 189850.0000, 'completed', 'TRF to ACC-2025202737', 'gift', NULL, '2025-12-23 01:13:11', '2025-12-23 01:13:11'),
(36, 'c6928513-8b9e-4514-b4c6-1167869e48f2', 16, NULL, NULL, NULL, 'transfer_in', 100.0000, 2050.0000, 2150.0000, 'completed', 'TRF from ACC-2025577891', 'gift', NULL, '2025-12-23 01:13:11', '2025-12-23 01:13:11'),
(37, 'ad9e25dd-8300-47d9-9d22-52601167b0be', 15, NULL, NULL, NULL, 'transfer_out', 100.0000, 189850.0000, 189750.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 01:17:58', '2025-12-23 01:17:58'),
(38, 'f1d0e8a2-fd3d-434e-bc67-03ea0cf3a62d', 16, NULL, NULL, NULL, 'transfer_in', 100.0000, 2150.0000, 2250.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 01:17:58', '2025-12-23 01:17:58'),
(39, '3fdbc706-787d-4cc6-a8aa-bef6b366b3c0', 15, NULL, NULL, NULL, 'transfer_out', 100.0000, 189750.0000, 189650.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 01:21:36', '2025-12-23 01:21:36'),
(40, 'fc7799b6-2ec6-4dc5-bc1d-7efa831315e5', 16, NULL, NULL, NULL, 'transfer_in', 100.0000, 2250.0000, 2350.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 01:21:36', '2025-12-23 01:21:36'),
(41, '8cfa34f0-90b4-4653-9607-d5ef88f0587e', 15, NULL, NULL, NULL, 'transfer_out', 100.0000, 189650.0000, 189550.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 01:29:45', '2025-12-23 01:29:45'),
(42, '71be4710-a016-415e-ba38-44a4eaf76c8f', 16, NULL, NULL, NULL, 'transfer_in', 100.0000, 2350.0000, 2450.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 01:29:45', '2025-12-23 01:29:45'),
(43, '6be1b55e-149e-4ca2-a53d-cba9a5bef320', 15, NULL, NULL, 'a81769a3-c476-4a1b-bff9-34957366593f', 'transfer_out', 100.0000, 189550.0000, 189450.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 01:32:55', '2025-12-23 01:32:55'),
(44, '8588fe3e-e2fb-4d7b-87ea-c20c3d26664a', 16, NULL, NULL, 'a81769a3-c476-4a1b-bff9-34957366593f', 'transfer_in', 100.0000, 2450.0000, 2550.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 01:32:55', '2025-12-23 01:32:55'),
(45, '5452adc1-4579-4d12-b12a-2215a286adf3', NULL, NULL, 25, NULL, 'cash_return', 100.0000, 130000.0000, 129900.0000, 'completed', 'Cash returned to vault at end of day', NULL, NULL, '2025-12-23 02:16:25', NULL),
(46, '36ed0164-e716-4e4e-bf2a-d84266d93245', 15, NULL, NULL, '4c58c452-ee11-42a2-840a-e4348902fbe3', 'transfer_out', 200.0000, 189450.0000, 189250.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 02:31:14', '2025-12-23 02:31:14'),
(47, '101355df-4a09-418b-bdbe-2361da5a78eb', 16, NULL, NULL, '4c58c452-ee11-42a2-840a-e4348902fbe3', 'transfer_in', 200.0000, 2550.0000, 2750.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 02:31:14', '2025-12-23 02:31:14'),
(48, 'b5efe695-c547-45b5-a886-2c8d2fa20b44', NULL, 2, 26, NULL, 'cash_load', 100000.0000, 100000.0000, 200000.0000, 'completed', 'Vault to Teller Cash Loading', 'Cash loaded by Admin', '{\"loaded_by_admin\":\"Sohel Rana\",\"admin_user_id\":13,\"ip_address\":\"127.0.0.1\",\"timestamp\":\"2025-12-23 09:55:39\"}', '2025-12-23 03:55:39', '2025-12-23 03:55:39'),
(49, '974f411b-5a54-4b53-bc64-7c1ef49df87f', 15, NULL, NULL, '66fbb54a-6ecd-40b0-9729-7895fe40285e', 'transfer_out', 12000.0000, 189250.0000, 177250.0000, 'completed', 'TRF to ACC-2025202737', 'Fund Transfer', NULL, '2025-12-23 03:57:22', '2025-12-23 03:57:22'),
(50, 'ad81ab50-2249-41a2-86e9-382b45625c0b', 16, NULL, NULL, '66fbb54a-6ecd-40b0-9729-7895fe40285e', 'transfer_in', 12000.0000, 2750.0000, 14750.0000, 'completed', 'TRF from ACC-2025577891', 'Fund Transfer', NULL, '2025-12-23 03:57:22', '2025-12-23 03:57:22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `kyc_status` enum('pending','verified','rejected') NOT NULL DEFAULT 'pending',
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role_id`, `phone`, `kyc_status`, `meta`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@bank.com', NULL, 'password', 1, '01710000001', 'verified', '{\"department\": \"Head Office\", \"access\": \"full\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(2, 'Branch Admin', 'branch.admin@bank.com', NULL, 'password', 1, '01710000002', 'verified', '{\"branch\": \"Mirpur Branch\", \"access\": \"branch_admin\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(3, 'Teller One', 'teller1@bank.com', NULL, 'password', 2, '01710000003', 'verified', '{\"branch\": \"Mirpur Branch\", \"counter_no\": \"C1\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(4, 'Teller Two', 'teller2@bank.com', NULL, 'password', 2, '01710000004', 'pending', '{\"branch\": \"Uttara Branch\", \"counter_no\": \"C7\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(5, 'Nobab', 'teller3@bank.com', NULL, 'password', 2, '01710000005', 'verified', '{\"branch\": \"Banani Branch\", \"counter_no\": \"C2\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(6, 'Customer One', 'customer1@bank.com', NULL, 'password', 3, '01710000006', 'verified', '{\"account_no\": \"1002003001\", \"branch\": \"Mirpur Branch\", \"balance\": 85000}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(7, 'Customer Two', 'customer2@bank.com', NULL, 'password', 3, '01710000007', 'pending', '{\"account_no\": \"1002003002\", \"branch\": \"Uttara Branch\", \"balance\": 12000}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(8, 'Customer Three', 'customer3@bank.com', NULL, 'password', 3, '01710000008', 'verified', '{\"account_no\": \"1002003003\", \"branch\": \"Banani Branch\", \"balance\": 43000}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(9, 'Customer Four', 'customer4@bank.com', NULL, 'password', 3, '01710000009', 'rejected', '{\"account_no\": \"1002003004\", \"branch\": \"Gulshan Branch\", \"balance\": 0, \"reason\": \"Invalid NID\"}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(10, 'Customer Five', 'customer5@bank.com', NULL, 'password', 3, '01710000010', 'verified', '{\"account_no\": \"1002003005\", \"branch\": \"Mirpur Branch\", \"balance\": 250000}', NULL, '2025-12-10 20:41:40', '2025-12-10 20:41:40'),
(11, 'Sohel Rana', 'admin1@gmail.com', NULL, '$2y$12$k6bhVFHPgzBaOVqDKd8plOPnfrDGJtyuxqTxhFeEQhWERXdtjOEre', 1, NULL, 'pending', NULL, NULL, '2025-12-12 06:36:02', '2025-12-12 06:36:02'),
(12, 'Madani', 'teller@gmail.com', NULL, '$2y$12$uHR.Tfy/d9DrrNV9LWewHOHhvR0eGgXXHaV2lQLVXPWETbasrtDdG', 2, NULL, 'pending', NULL, NULL, '2025-12-12 06:36:27', '2025-12-12 06:36:27'),
(13, 'Sohel Rana', 'admin@gmail.com', NULL, '$2y$12$qfTNGK1yIMVaNELHqCPJBuS4cKMmAZkb.5OroesQvYzVtzdhUTOLK', 1, NULL, 'pending', NULL, NULL, '2025-12-12 06:38:25', '2025-12-12 06:38:25'),
(14, 'akbor ali', 'akbor@gmail.com', NULL, '$2y$12$Ampv/9QMv0owEKKNbmExKus2d9kQq24E1mj99PiAoDaifX2Oh/wm.', 1, NULL, 'pending', NULL, NULL, '2025-12-12 06:43:30', '2025-12-12 06:43:30'),
(15, 'sha', 'sha@gmail.com', NULL, '$2y$12$kHFgW1sFz3joseXQDGCatep5e5Qn4cmWhFc8KLXG6tWS4XLueGRiu', 1, NULL, 'pending', NULL, NULL, '2025-12-12 06:44:30', '2025-12-12 06:44:30'),
(16, 'Rakib', 'customer@gmail.com', NULL, '$2y$12$4K0mqtUhXEuj7/lgPDeLOOeWusew1ZSWmDskXejlhmh1hjWeHJgIa', 3, NULL, 'pending', NULL, NULL, '2025-12-12 06:46:46', '2025-12-12 06:46:46'),
(17, 'Hakim', 'hakim@gmail.com', NULL, '$2y$12$wciPyHte96AV9PJ5SBkJpu56FqatLpxAjiWttNh56JexUyZDpGtOe', 1, NULL, 'pending', NULL, NULL, '2025-12-12 06:48:51', '2025-12-12 06:48:51'),
(18, 'Teller 7', 'teller7@bank.com', NULL, '$2y$10$hash', 2, '01700000003', 'verified', '{\"branch\":\"DHK-001\",\"shift\":\"evening\"}', NULL, '2025-12-16 10:12:43', '2025-12-16 10:12:43'),
(19, 'Teller 8', 'teller8@bank.com', NULL, '$2y$10$hash', 2, '01700000004', 'verified', '{\"branch\":\"CTG-002\",\"shift\":\"morning\"}', NULL, '2025-12-16 10:12:43', '2025-12-16 10:12:43'),
(20, 'Teller 9', 'teller9@bank.com', NULL, '$2y$10$hash', 2, '01700000005', 'verified', '{\"branch\":\"CTG-002\",\"shift\":\"evening\"}', NULL, '2025-12-16 10:12:43', '2025-12-16 10:12:43'),
(21, 'Teller 10', 'teller10@bank.com', NULL, '$2y$10$hash', 2, '01700000006', 'verified', '{\"branch\":\"SYL-003\",\"shift\":\"morning\"}', NULL, '2025-12-16 10:12:43', '2025-12-16 10:12:43'),
(22, 'Teller 11', 'teller11@bank.com', NULL, '$2y$10$hash', 2, '01700000007', 'verified', '{\"branch\":\"SYL-003\",\"shift\":\"evening\"}', NULL, '2025-12-16 10:12:43', '2025-12-16 10:12:43'),
(23, 'Rahat Islam', 'rahat@gmail.com', NULL, '$2y$12$GFLejTLKmMyjmHOyfyFzpeHNqjR3ys3orIvERjOKcalNvpgxWL/SC', 2, '0158746658', 'pending', NULL, NULL, '2025-12-16 06:35:06', '2025-12-16 06:35:06'),
(24, 'Rahat Islam', 'rahat1@gmail.com', NULL, '$2y$12$6w/m9/QkZtuCUJYN3OvmIeb4blM68VgnBhPqb1qSe/4Nr4WOmLVfa', 2, '0158746658', 'pending', NULL, NULL, '2025-12-16 06:37:32', '2025-12-16 06:37:32'),
(25, 'Rahat Islam', 'rahat2@gmail.com', NULL, '$2y$12$TPOSz3KsVo1773hE/wE2SOGc3pO6Dx2Y4KTFy9vgQeAKTHIh/InnK', 2, '01578485475', 'pending', NULL, NULL, '2025-12-16 06:41:37', '2025-12-16 06:41:37'),
(26, 'Rahat Islam', 'rahat5@gmail.com', NULL, '$2y$12$oBkxld6y8K2oVLktawJ3IeKMTvAymlg8RIVNuL1ITVK8r01anOViq', 2, '01578485475', 'pending', NULL, NULL, '2025-12-16 06:41:56', '2025-12-16 06:41:56'),
(27, 'Rahat Islam', 'rahat6@gmail.com', NULL, '$2y$12$jEP8aluBN1LSpXSad3Z.c.47kQekGoGXBzawcw35gpZJjEVN3qAiC', 3, '01578485475', 'pending', NULL, NULL, '2025-12-16 06:44:50', '2025-12-16 06:44:50'),
(29, 'Ali Rahman', 'ali1@gmail.com', NULL, '$2y$12$enl.kTpXs2dO5b0P6Mjy6ecrDIv0VsCYZe/4dqrNUjt.Yw2FNxIVy', 3, '01425115015', 'pending', NULL, NULL, '2025-12-16 06:55:30', '2025-12-16 06:55:30'),
(36, 'Sagor islam', 'sagor@gmail.com', NULL, '$2y$12$M0l3ZW8H0NwE2snSqGnkBuBGIA4y5xCwSVQDYlc1DBCTfCtTfy59i', 2, '0124587585854', 'pending', NULL, NULL, '2025-12-16 10:36:47', '2025-12-16 10:36:47'),
(37, 'Shanto Islam', 'shanto1@gmail.com', NULL, '$2y$12$n3UF4YiM3Gucx5IpzwMe9eUIuu7vavi3EG/TcFiF5VoCpUuiTZxvu', 3, '0125454575', 'pending', NULL, NULL, '2025-12-18 13:35:16', '2025-12-18 13:35:16'),
(38, 'Alom Islam', 'alom@gmail.com', NULL, '$2y$12$zVIJcaKhIhmJZk8gNMwC3eSqj8EuzXwgyaOGuIHRDTBmq.gvSiona', 3, '01775485485', 'pending', NULL, NULL, '2025-12-19 08:58:35', '2025-12-19 08:58:35'),
(39, 'Sofiqur Rahman', 'sofikur@gmail.com', NULL, '$2y$12$HTq8mn5cRHkQd3ubt9GX3uUq7DEFtiBzRiPxisAUStXnO8ikMhaTC', 3, '0158754655', 'pending', NULL, NULL, '2025-12-19 09:09:09', '2025-12-19 09:09:09'),
(40, 'John Khan', 'jon@gmail.com', NULL, '$2y$12$gdQb47lEErWeondMyaUkbeRGqoO9SY43F.rP8ghkx9kAXV6wc2myW', 3, '01458758456', 'pending', NULL, NULL, '2025-12-19 09:20:43', '2025-12-19 09:20:43'),
(41, 'Habibur Rahman', 'habibur@gmail.com', NULL, '$2y$12$ypzLLrgjX2kPG9XCcS5.but7ca5alzH/k9VxkxCjfBCOz.yVQ5/5W', 3, '01584875845', 'pending', NULL, NULL, '2025-12-19 09:37:39', '2025-12-19 09:37:39'),
(42, 'Rupon Sorkar', 'rupon@gmail.com', NULL, '$2y$12$6nCT1rrL7Nh5ZtRnjfA73OwTAwcEttnOWPVIBeDI8etKzMH2c.f3.', 2, '01358458754', 'pending', NULL, NULL, '2025-12-21 13:57:04', '2025-12-21 13:57:04'),
(43, 'Mehedi Khan', 'mahedi@gmail.com', NULL, '$2y$12$wKg.2f6QurTSjdeEn18Qf.5541WY4xo3pQTKvHzssa.FueeTHxFcO', 3, '0123564458', 'pending', NULL, NULL, '2025-12-22 12:04:41', '2025-12-22 12:04:41'),
(44, 'roxi islam', 'roxi123@gmail.com', NULL, '$2y$12$UC/2ZeR0.jfViRx3lmHZ7OlHYFu96EtX1WfEnt2HlW0ic6ryhSH/2', 2, '0125485554', 'pending', NULL, NULL, '2025-12-23 03:54:47', '2025-12-23 03:54:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `accounts_account_no_unique` (`account_no`),
  ADD KEY `accounts_customer_id_index` (`customer_id`),
  ADD KEY `accounts_account_no_index` (`account_no`);

--
-- Indexes for table `account_types`
--
ALTER TABLE `account_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `account_types_type_name_unique` (`type_name`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `audit_logs_user_id_index` (`user_id`),
  ADD KEY `audit_logs_created_at_index` (`created_at`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `branches_branch_code_unique` (`branch_code`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `charges_charge_code_unique` (`charge_code`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customers_customer_code_unique` (`customer_code`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `interest_rules`
--
ALTER TABLE `interest_rules`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kyc_documents`
--
ALTER TABLE `kyc_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ledgers`
--
ALTER TABLE `ledgers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `loans_loan_no_unique` (`loan_no`),
  ADD KEY `loans_customer_id_index` (`customer_id`);

--
-- Indexes for table `loan_payments`
--
ALTER TABLE `loan_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `system_settings_key_unique` (`key`);

--
-- Indexes for table `tellers`
--
ALTER TABLE `tellers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `teller_code` (`teller_code`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_tx_uuid_unique` (`tx_uuid`),
  ADD KEY `transactions_account_id_index` (`account_id`),
  ADD KEY `transactions_created_at_index` (`created_at`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interest_rules`
--
ALTER TABLE `interest_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_documents`
--
ALTER TABLE `kyc_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ledgers`
--
ALTER TABLE `ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loan_payments`
--
ALTER TABLE `loan_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `payment_gateways`
--
ALTER TABLE `payment_gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tellers`
--
ALTER TABLE `tellers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

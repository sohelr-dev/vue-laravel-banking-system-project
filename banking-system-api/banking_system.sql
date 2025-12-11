-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2025 at 08:34 AM
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
(1, 'ACC10000001', 1, 1, 1, 'BDT', 15000.0000, 15000.0000, 'active', '{\"notes\":\"Primary savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(2, 'ACC10000002', 2, 2, 2, 'BDT', 50000.0000, 50000.0000, 'active', '{\"notes\":\"Business current\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(3, 'ACC10000003', 3, 3, 3, 'BDT', 100000.0000, 100000.0000, 'active', '{\"notes\":\"Fixed deposit\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(4, 'ACC10000004', 4, 4, 4, 'BDT', 12000.0000, 12000.0000, 'active', '{\"notes\":\"Recurring deposit\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(5, 'ACC10000005', 5, 5, 5, 'BDT', 30000.0000, 30000.0000, 'active', '{\"notes\":\"Premium savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(6, 'ACC10000006', 6, 6, 6, 'BDT', 8000.0000, 8000.0000, 'active', '{\"notes\":\"Student savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(7, 'ACC10000007', 7, 7, 7, 'BDT', 25000.0000, 25000.0000, 'active', '{\"notes\":\"Senior citizen savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(8, 'ACC10000008', 8, 8, 8, 'BDT', 40000.0000, 40000.0000, 'active', '{\"notes\":\"Business savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(9, 'ACC10000009', 9, 9, 9, 'BDT', 20000.0000, 20000.0000, 'active', '{\"notes\":\"NRI savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(10, 'ACC10000010', 10, 10, 10, 'BDT', 15000.0000, 15000.0000, 'active', '{\"notes\":\"Joint savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(11, 'ACC10000011', 11, 11, 11, 'BDT', 10000.0000, 10000.0000, 'active', '{\"notes\":\"Salary account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(12, 'ACC10000012', 12, 12, 12, 'BDT', 200000.0000, 200000.0000, 'active', '{\"notes\":\"Corporate current\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(13, 'ACC10000013', 13, 13, 13, 'BDT', 5000.0000, 5000.0000, 'active', '{\"notes\":\"Trust account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(14, 'ACC10000014', 14, 14, 14, 'BDT', 800.0000, 800.0000, 'active', '{\"notes\":\"Microfinance account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(15, 'ACC10000015', 15, 15, 15, 'BDT', 120000.0000, 120000.0000, 'active', '{\"notes\":\"Gold account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(16, 'ACC10000016', 16, 16, 16, 'BDT', 150000.0000, 150000.0000, 'active', '{\"notes\":\"Platinum account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(17, 'ACC10000017', 17, 17, 17, 'BDT', 5000.0000, 5000.0000, 'active', '{\"notes\":\"Healthcare savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(18, 'ACC10000018', 18, 18, 18, 'BDT', 7000.0000, 7000.0000, 'active', '{\"notes\":\"Education savings\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(19, 'ACC10000019', 19, 19, 19, 'BDT', 9000.0000, 9000.0000, 'active', '{\"notes\":\"Travel account\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32'),
(20, 'ACC10000020', 20, 20, 20, 'BDT', 12000.0000, 12000.0000, 'active', '{\"notes\":\"Emergency fund\"}', '2025-12-11 07:20:32', '2025-12-11 07:20:32');

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
(1, 'Savings Account', 'Standard savings account with moderate interest.', 3.5000, 1000.0000, 5, '{\"daily_interest\":true,\"auto_renew\":false}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(2, 'Current Account', 'Business current account with unlimited transactions.', 0.0000, 5000.0000, NULL, '{\"overdraft_allowed\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(3, 'Fixed Deposit', 'Fixed deposit account with higher interest rate.', 6.0000, 10000.0000, 0, '{\"tenure_months\":12}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(4, 'Recurring Deposit', 'Recurring deposit account with monthly deposits.', 5.5000, 500.0000, 1, '{\"monthly_deposit_required\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(5, 'Premium Savings', 'High-yield savings account for premium customers.', 4.5000, 5000.0000, 3, '{\"exclusive_benefits\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(6, 'Student Savings', 'Low-balance account for students.', 2.0000, 100.0000, 2, '{\"student_benefit\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(7, 'Senior Citizen Savings', 'Savings account with extra benefits for seniors.', 4.0000, 2000.0000, 4, '{\"senior_bonus\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(8, 'Business Savings', 'Savings account for small businesses.', 3.0000, 10000.0000, 5, '{\"tax_benefit\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(9, 'NRI Savings', 'Account for Non-Resident Bangladeshis.', 3.8000, 1500.0000, 3, '{\"nri_benefits\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(10, 'Joint Savings', 'Account shared by two or more individuals.', 3.2000, 2000.0000, 3, '{\"joint_holder\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(11, 'Salary Account', 'Account for receiving salary payments.', 2.5000, 500.0000, 5, '{\"auto_salary_credit\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(12, 'Corporate Current', 'Current account for corporations.', 0.0000, 20000.0000, NULL, '{\"corporate_features\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(13, 'Trust Account', 'Account for trusts and charitable organizations.', 1.5000, 1000.0000, 3, '{\"trust_fund\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(14, 'Microfinance Account', 'For microfinance beneficiaries.', 2.5000, 100.0000, 1, '{\"micro_loan_linked\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(15, 'Gold Account', 'Account for high-net-worth individuals with gold benefits.', 5.0000, 10000.0000, 3, '{\"gold_bonus\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(16, 'Platinum Account', 'Premium account with exclusive benefits.', 4.8000, 15000.0000, 3, '{\"platinum_rewards\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(17, 'Healthcare Savings', 'Account for medical savings.', 3.2000, 500.0000, 2, '{\"healthcare_bonus\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(18, 'Education Savings', 'Account for saving for education.', 3.0000, 1000.0000, 2, '{\"education_bonus\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(19, 'Travel Account', 'Account for travel savings.', 2.8000, 500.0000, 2, '{\"travel_rewards\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07'),
(20, 'Emergency Fund', 'Account for emergency funds.', 2.5000, 500.0000, 1, '{\"emergency_access\":true}', '2025-12-11 07:16:07', '2025-12-11 07:16:07');

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `module` varchar(100) DEFAULT NULL,
  `record_id` varchar(50) DEFAULT NULL,
  `before_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`before_data`)),
  `after_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`after_data`)),
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `action`, `module`, `record_id`, `before_data`, `after_data`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, 1, 'create', 'customers', '1', NULL, '{\"name\":\"John Doe\",\"email\":\"john@example.com\"}', '192.168.1.1', 'Mozilla/5.0', '2025-12-11 07:33:25'),
(2, 2, 'update', 'accounts', '2', '{\"balance\":5000}', '{\"balance\":7000}', '192.168.1.2', 'Mozilla/5.0', '2025-12-11 07:33:25'),
(3, 3, 'delete', 'transactions', '3', '{\"amount\":1000}', NULL, '192.168.1.3', 'Chrome/108.0', '2025-12-11 07:33:25'),
(4, 4, 'create', 'loans', '4', NULL, '{\"principal_amount\":500000}', '192.168.1.4', 'Chrome/108.0', '2025-12-11 07:33:25'),
(5, 5, 'update', 'customers', '5', '{\"status\":\"pending\"}', '{\"status\":\"active\"}', '192.168.1.5', 'Firefox/116.0', '2025-12-11 07:33:25'),
(6, 6, 'login', NULL, NULL, NULL, NULL, '192.168.1.6', 'Edge/110.0', '2025-12-11 07:33:25'),
(7, 7, 'logout', NULL, NULL, NULL, NULL, '192.168.1.7', 'Edge/110.0', '2025-12-11 07:33:25'),
(8, 8, 'create', 'transactions', '8', NULL, '{\"amount\":2000,\"type\":\"deposit\"}', '192.168.1.8', 'Safari/16.0', '2025-12-11 07:33:25'),
(9, 9, 'update', 'accounts', '9', '{\"status\":\"active\"}', '{\"status\":\"blocked\"}', '192.168.1.9', 'Safari/16.0', '2025-12-11 07:33:25'),
(10, 10, 'delete', 'loans', '10', '{\"principal_amount\":1000000}', NULL, '192.168.1.10', 'Mozilla/5.0', '2025-12-11 07:33:25'),
(11, 11, 'create', 'customers', '11', NULL, '{\"name\":\"Alice Smith\",\"email\":\"alice@example.com\"}', '192.168.1.11', 'Chrome/108.0', '2025-12-11 07:33:25'),
(12, 12, 'update', 'transactions', '12', '{\"amount\":5000}', '{\"amount\":5500}', '192.168.1.12', 'Chrome/108.0', '2025-12-11 07:33:25'),
(13, 13, 'delete', 'accounts', '13', '{\"balance\":3000}', NULL, '192.168.1.13', 'Firefox/116.0', '2025-12-11 07:33:25'),
(14, 14, 'create', 'loans', '14', NULL, '{\"principal_amount\":250000}', '192.168.1.14', 'Firefox/116.0', '2025-12-11 07:33:25'),
(15, 15, 'update', 'customers', '15', '{\"kyc_status\":\"pending\"}', '{\"kyc_status\":\"verified\"}', '192.168.1.15', 'Edge/110.0', '2025-12-11 07:33:25'),
(16, 16, 'login', NULL, NULL, NULL, NULL, '192.168.1.16', 'Edge/110.0', '2025-12-11 07:33:25'),
(17, 17, 'logout', NULL, NULL, NULL, NULL, '192.168.1.17', 'Safari/16.0', '2025-12-11 07:33:25'),
(18, 18, 'create', 'transactions', '18', NULL, '{\"amount\":10000,\"type\":\"withdrawal\"}', '192.168.1.18', 'Safari/16.0', '2025-12-11 07:33:25'),
(19, 19, 'update', 'accounts', '19', '{\"status\":\"blocked\"}', '{\"status\":\"active\"}', '192.168.1.19', 'Mozilla/5.0', '2025-12-11 07:33:25'),
(20, 20, 'delete', 'loans', '20', '{\"principal_amount\":500000}', NULL, '192.168.1.20', 'Mozilla/5.0', '2025-12-11 07:33:25');

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
(1, 'CHG001', 'Monthly Maintenance Fee', 500.0000, 'fixed', 1, 'Monthly account maintenance fee', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(2, 'CHG002', 'ATM Withdrawal Fee', 2.5000, 'percentage', 2, 'Fee for ATM withdrawal', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(3, 'CHG003', 'Overdraft Fee', 1000.0000, 'fixed', 3, 'Fee for overdraft usage', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(4, 'CHG004', 'Cheque Book Charge', 200.0000, 'fixed', 4, 'Fee per cheque book issued', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(5, 'CHG005', 'Internet Banking Fee', 100.0000, 'fixed', 5, 'Annual internet banking fee', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(6, 'CHG006', 'SMS Alert Fee', 50.0000, 'fixed', 6, 'Monthly SMS alert fee', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(7, 'CHG007', 'Late Payment Fee', 1500.0000, 'fixed', 7, 'Fee for late loan payment', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(8, 'CHG008', 'Fund Transfer Fee', 1.0000, 'percentage', 8, 'Fee for online fund transfer', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(9, 'CHG009', 'Account Closure Fee', 300.0000, 'fixed', 9, 'Fee for closing account', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(10, 'CHG010', 'Card Replacement Fee', 250.0000, 'fixed', 10, 'Fee for lost card replacement', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(11, 'CHG011', 'Deposit Fee', 0.5000, 'percentage', 11, 'Fee per deposit transaction', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(12, 'CHG012', 'Withdrawal Fee', 0.7500, 'percentage', 12, 'Fee per withdrawal transaction', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(13, 'CHG013', 'Minimum Balance Penalty', 200.0000, 'fixed', 13, 'Penalty for falling below minimum balance', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(14, 'CHG014', 'Wire Transfer Fee', 1000.0000, 'fixed', 14, 'Fee for international wire transfer', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(15, 'CHG015', 'Stop Payment Fee', 300.0000, 'fixed', 15, 'Fee to stop a cheque payment', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(16, 'CHG016', 'Loan Processing Fee', 5000.0000, 'fixed', 16, 'Fee for processing loan application', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(17, 'CHG017', 'Cash Deposit Fee', 0.5000, 'percentage', 17, 'Fee on cash deposits over limit', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(18, 'CHG018', 'Card Annual Fee', 1500.0000, 'fixed', 18, 'Annual card fee', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(19, 'CHG019', 'Foreign Exchange Fee', 2.0000, 'percentage', 19, 'Fee on foreign currency transactions', '2025-12-11 07:30:14', '2025-12-11 07:30:14'),
(20, 'CHG020', 'Inactive Account Fee', 300.0000, 'fixed', 20, 'Monthly fee for inactive accounts', '2025-12-11 07:30:14', '2025-12-11 07:30:14');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `customer_code` varchar(30) NOT NULL,
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

INSERT INTO `customers` (`id`, `user_id`, `customer_code`, `kyc_data`, `dob`, `address`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'CUST001', '{\"nid\":\"1234567890123\",\"passport\":\"B1234567\",\"photo\":\"/uploads/customers/1/photo.jpg\",\"signature\":\"/uploads/customers/1/signature.jpg\"}', '1990-01-15', '123 Dhaka Street, Dhaka', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(2, 2, 'CUST002', '{\"nid\":\"9876543210987\",\"passport\":\"C9876543\",\"photo\":\"/uploads/customers/2/photo.jpg\",\"signature\":\"/uploads/customers/2/signature.jpg\"}', '1985-06-22', '45 Chittagong Ave, Chittagong', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(3, 3, 'CUST003', '{\"nid\":\"4567891234567\",\"passport\":\"D4567890\",\"photo\":\"/uploads/customers/3/photo.jpg\",\"signature\":\"/uploads/customers/3/signature.jpg\"}', '1992-03-10', '77 Sylhet Road, Sylhet', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(4, 4, 'CUST004', '{\"nid\":\"2345678901234\",\"passport\":\"E2345678\",\"photo\":\"/uploads/customers/4/photo.jpg\",\"signature\":\"/uploads/customers/4/signature.jpg\"}', '1988-07-05', '21 Khulna Lane, Khulna', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(5, 5, 'CUST005', '{\"nid\":\"3456789012345\",\"passport\":\"F3456789\",\"photo\":\"/uploads/customers/5/photo.jpg\",\"signature\":\"/uploads/customers/5/signature.jpg\"}', '1991-11-20', '66 Barishal Blvd, Barishal', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(6, 6, 'CUST006', '{\"nid\":\"4567890123456\",\"passport\":\"G4567890\",\"photo\":\"/uploads/customers/6/photo.jpg\",\"signature\":\"/uploads/customers/6/signature.jpg\"}', '1993-02-28', '88 Rajshahi St, Rajshahi', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(7, 7, 'CUST007', '{\"nid\":\"5678901234567\",\"passport\":\"H5678901\",\"photo\":\"/uploads/customers/7/photo.jpg\",\"signature\":\"/uploads/customers/7/signature.jpg\"}', '1987-09-12', '12 Rangpur Ave, Rangpur', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(8, 8, 'CUST008', '{\"nid\":\"6789012345678\",\"passport\":\"I6789012\",\"photo\":\"/uploads/customers/8/photo.jpg\",\"signature\":\"/uploads/customers/8/signature.jpg\"}', '1994-04-18', '34 Mymensingh Rd, Mymensingh', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(9, 9, 'CUST009', '{\"nid\":\"7890123456789\",\"passport\":\"J7890123\",\"photo\":\"/uploads/customers/9/photo.jpg\",\"signature\":\"/uploads/customers/9/signature.jpg\"}', '1990-12-05', '56 Comilla St, Comilla', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(10, 10, 'CUST010', '{\"nid\":\"8901234567890\",\"passport\":\"K8901234\",\"photo\":\"/uploads/customers/10/photo.jpg\",\"signature\":\"/uploads/customers/10/signature.jpg\"}', '1989-05-30', '78 Jessore Ave, Jessore', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(11, 11, 'CUST011', '{\"nid\":\"9012345678901\",\"passport\":\"L9012345\",\"photo\":\"/uploads/customers/11/photo.jpg\",\"signature\":\"/uploads/customers/11/signature.jpg\"}', '1986-08-17', '90 Coxs St, Coxs Bazar', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(12, 12, 'CUST012', '{\"nid\":\"0123456789012\",\"passport\":\"M0123456\",\"photo\":\"/uploads/customers/12/photo.jpg\",\"signature\":\"/uploads/customers/12/signature.jpg\"}', '1992-10-21', '23 Tangail Rd, Tangail', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(13, 13, 'CUST013', '{\"nid\":\"1234509876543\",\"passport\":\"N1234509\",\"photo\":\"/uploads/customers/13/photo.jpg\",\"signature\":\"/uploads/customers/13/signature.jpg\"}', '1988-03-11', '45 Bogra St, Bogra', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(14, 14, 'CUST014', '{\"nid\":\"2345610987654\",\"passport\":\"O2345610\",\"photo\":\"/uploads/customers/14/photo.jpg\",\"signature\":\"/uploads/customers/14/signature.jpg\"}', '1991-07-29', '67 Pabna Ave, Pabna', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(15, 15, 'CUST015', '{\"nid\":\"3456721098765\",\"passport\":\"P3456721\",\"photo\":\"/uploads/customers/15/photo.jpg\",\"signature\":\"/uploads/customers/15/signature.jpg\"}', '1993-01-05', '89 Madaripur Rd, Madaripur', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(16, 16, 'CUST016', '{\"nid\":\"4567832109876\",\"passport\":\"Q4567832\",\"photo\":\"/uploads/customers/16/photo.jpg\",\"signature\":\"/uploads/customers/16/signature.jpg\"}', '1987-06-14', '12 Netrokona St, Netrokona', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(17, 17, 'CUST017', '{\"nid\":\"5678943210987\",\"passport\":\"R5678943\",\"photo\":\"/uploads/customers/17/photo.jpg\",\"signature\":\"/uploads/customers/17/signature.jpg\"}', '1989-09-22', '34 Jamalpur Ave, Jamalpur', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(18, 18, 'CUST018', '{\"nid\":\"6789054321098\",\"passport\":\"S6789054\",\"photo\":\"/uploads/customers/18/photo.jpg\",\"signature\":\"/uploads/customers/18/signature.jpg\"}', '1990-11-02', '56 Noakhali Rd, Noakhali', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(19, 19, 'CUST019', '{\"nid\":\"7890165432109\",\"passport\":\"T7890165\",\"photo\":\"/uploads/customers/19/photo.jpg\",\"signature\":\"/uploads/customers/19/signature.jpg\"}', '1994-02-13', '78 Patuakhali St, Patuakhali', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18'),
(20, 20, 'CUST020', '{\"nid\":\"8901276543210\",\"passport\":\"U8901276\",\"photo\":\"/uploads/customers/20/photo.jpg\",\"signature\":\"/uploads/customers/20/signature.jpg\"}', '1995-11-05', '90 Feni Ave, Feni', 'active', '2025-12-11 07:15:18', '2025-12-11 07:15:18');

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
(1, 1, 5.0000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(2, 2, 3.5000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(3, 3, 4.0000, 'daily', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(4, 4, 6.0000, 'yearly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(5, 5, 3.7500, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(6, 6, 4.2500, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(7, 7, 5.5000, 'daily', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(8, 8, 3.2500, 'yearly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(9, 9, 4.5000, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(10, 10, 5.0000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(11, 11, 3.7500, 'daily', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(12, 12, 4.5000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(13, 13, 5.2500, 'yearly', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(14, 14, 4.0000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(15, 15, 3.5000, 'daily', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(16, 16, 6.0000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(17, 17, 4.2500, 'monthly', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(18, 18, 5.5000, 'yearly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(19, 19, 3.7500, 'daily', 'no', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41'),
(20, 20, 4.5000, 'monthly', 'yes', '2025-01-01', '2025-12-31', '2025-12-11 07:31:41', '2025-12-11 07:31:41');

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
(1, 1, 'nid', '/kyc/1/nid.pdf', 1, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(2, 2, 'passport', '/kyc/2/passport.pdf', 2, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(3, 3, 'birth_certificate', '/kyc/3/birth_certificate.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(4, 4, 'utility_bill', '/kyc/4/utility_bill.pdf', 3, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(5, 5, 'photo', '/kyc/5/photo.jpg', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(6, 6, 'signature', '/kyc/6/signature.jpg', 4, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(7, 7, 'nid', '/kyc/7/nid.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(8, 8, 'passport', '/kyc/8/passport.pdf', 5, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(9, 9, 'birth_certificate', '/kyc/9/birth_certificate.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(10, 10, 'utility_bill', '/kyc/10/utility_bill.pdf', 6, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(11, 11, 'photo', '/kyc/11/photo.jpg', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(12, 12, 'signature', '/kyc/12/signature.jpg', 7, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(13, 13, 'nid', '/kyc/13/nid.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(14, 14, 'passport', '/kyc/14/passport.pdf', 8, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(15, 15, 'birth_certificate', '/kyc/15/birth_certificate.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(16, 16, 'utility_bill', '/kyc/16/utility_bill.pdf', 9, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(17, 17, 'photo', '/kyc/17/photo.jpg', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(18, 18, 'signature', '/kyc/18/signature.jpg', 10, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(19, 19, 'nid', '/kyc/19/nid.pdf', NULL, NULL, 'pending', '', '2025-12-11 07:32:32', '2025-12-11 07:32:32'),
(20, 20, 'passport', '/kyc/20/passport.pdf', 11, '2025-12-11 07:32:32', 'verified', 'Verified successfully', '2025-12-11 07:32:32', '2025-12-11 07:32:32');

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
(1, 1, 'LEDG0001', 'CASH', 'USER_ACC_1', 5000.0000, 'Deposit to account ACC10000001', '2025-12-11 07:28:55'),
(2, 2, 'LEDG0002', 'BANK', 'USER_ACC_2', 20000.0000, 'Business capital deposit to ACC10000002', '2025-12-11 07:28:55'),
(3, 3, 'LEDG0003', 'BANK', 'USER_ACC_3', 100000.0000, 'Fixed deposit top-up ACC10000003', '2025-12-11 07:28:55'),
(4, 4, 'LEDG0004', 'CASH', 'USER_ACC_4', 5000.0000, 'Recurring deposit installment ACC10000004', '2025-12-11 07:28:55'),
(5, 5, 'LEDG0005', 'USER_ACC_5', 'CASH', 10000.0000, 'ATM withdrawal from ACC10000005', '2025-12-11 07:28:55'),
(6, 6, 'LEDG0006', 'CASH', 'USER_ACC_6', 2000.0000, 'Student savings deposit ACC10000006', '2025-12-11 07:28:55'),
(7, 7, 'LEDG0007', 'BANK', 'USER_ACC_7', 5000.0000, 'Senior citizen bonus ACC10000007', '2025-12-11 07:28:55'),
(8, 8, 'LEDG0008', 'BANK', 'USER_ACC_8', 10000.0000, 'Business savings deposit ACC10000008', '2025-12-11 07:28:55'),
(9, 9, 'LEDG0009', 'USER_ACC_9', 'BANK', 5000.0000, 'NRI withdrawal ACC10000009', '2025-12-11 07:28:55'),
(10, 10, 'LEDG0010', 'USER_ACC_10', 'USER_ACC_11', 5000.0000, 'Transfer from ACC10000010 to ACC10000011', '2025-12-11 07:28:55'),
(11, 11, 'LEDG0011', 'BANK', 'USER_ACC_11', 5000.0000, 'Salary credited ACC10000011', '2025-12-11 07:28:55'),
(12, 12, 'LEDG0012', 'BANK', 'USER_ACC_12', 50000.0000, 'Corporate deposit ACC10000012', '2025-12-11 07:28:55'),
(13, 13, 'LEDG0013', 'USER_ACC_13', 'BANK', 2000.0000, 'Trust account payment ACC10000013', '2025-12-11 07:28:55'),
(14, 14, 'LEDG0014', 'CASH', 'USER_ACC_14', 500.0000, 'Microfinance installment ACC10000014', '2025-12-11 07:28:55'),
(15, 15, 'LEDG0015', 'BANK', 'USER_ACC_15', 20000.0000, 'Gold account deposit ACC10000015', '2025-12-11 07:28:55'),
(16, 16, 'LEDG0016', 'BANK', 'USER_ACC_16', 30000.0000, 'Platinum account deposit ACC10000016', '2025-12-11 07:28:55'),
(17, 17, 'LEDG0017', 'USER_ACC_17', 'CASH', 1000.0000, 'Healthcare payment ACC10000017', '2025-12-11 07:28:55'),
(18, 18, 'LEDG0018', 'BANK', 'USER_ACC_18', 2000.0000, 'Education savings deposit ACC10000018', '2025-12-11 07:28:55'),
(19, 19, 'LEDG0019', 'BANK', 'USER_ACC_19', 3000.0000, 'Travel account deposit ACC10000019', '2025-12-11 07:28:55'),
(20, 20, 'LEDG0020', 'BANK', 'USER_ACC_20', 5000.0000, 'Emergency fund deposit ACC10000020', '2025-12-11 07:28:55');

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
(1, 'LN00001', 1, 'LN-PROD001', 500000.0000, 500000.0000, 12.5000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-15\",\"amount\":22083.33}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(2, 'LN00002', 2, 'LN-PROD002', 1000000.0000, 1000000.0000, 10.0000, 36, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-22\",\"amount\":27777.78}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(3, 'LN00003', 3, 'LN-PROD003', 250000.0000, 250000.0000, 14.0000, 12, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-10\",\"amount\":20833.33}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(4, 'LN00004', 4, 'LN-PROD001', 750000.0000, 750000.0000, 11.5000, 30, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-05\",\"amount\":25000.00}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(5, 'LN00005', 5, 'LN-PROD002', 500000.0000, 500000.0000, 13.0000, 24, '2025-12-11 07:24:50', 'approved', '{\"installments\":[{\"due_date\":\"2025-01-20\",\"amount\":20833.33}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(6, 'LN00006', 6, 'LN-PROD003', 300000.0000, 300000.0000, 15.0000, 18, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-28\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(7, 'LN00007', 7, 'LN-PROD001', 450000.0000, 450000.0000, 12.0000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-12\",\"amount\":18750.00}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(8, 'LN00008', 8, 'LN-PROD002', 600000.0000, 600000.0000, 11.0000, 36, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-18\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(9, 'LN00009', 9, 'LN-PROD003', 200000.0000, 200000.0000, 14.5000, 12, '2025-12-11 07:24:50', 'applied', '{\"installments\":[{\"due_date\":\"2025-01-05\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(10, 'LN00010', 10, 'LN-PROD001', 550000.0000, 550000.0000, 12.5000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-25\",\"amount\":22916.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(11, 'LN00011', 11, 'LN-PROD002', 800000.0000, 800000.0000, 10.5000, 36, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-30\",\"amount\":22222.22}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(12, 'LN00012', 12, 'LN-PROD003', 350000.0000, 350000.0000, 13.5000, 18, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-15\",\"amount\":19444.44}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(13, 'LN00013', 13, 'LN-PROD001', 400000.0000, 400000.0000, 12.0000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-20\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(14, 'LN00014', 14, 'LN-PROD002', 150000.0000, 150000.0000, 14.0000, 12, '2025-12-11 07:24:50', 'approved', '{\"installments\":[{\"due_date\":\"2025-01-25\",\"amount\":12500.00}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(15, 'LN00015', 15, 'LN-PROD003', 250000.0000, 250000.0000, 13.0000, 18, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-10\",\"amount\":13888.89}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(16, 'LN00016', 16, 'LN-PROD001', 500000.0000, 500000.0000, 12.5000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-18\",\"amount\":20833.33}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(17, 'LN00017', 17, 'LN-PROD002', 600000.0000, 600000.0000, 11.5000, 36, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-12\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(18, 'LN00018', 18, 'LN-PROD003', 300000.0000, 300000.0000, 14.0000, 18, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-28\",\"amount\":16666.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(19, 'LN00019', 19, 'LN-PROD001', 450000.0000, 450000.0000, 12.5000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-22\",\"amount\":18750.00}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50'),
(20, 'LN00020', 20, 'LN-PROD002', 550000.0000, 550000.0000, 13.0000, 24, '2025-12-11 07:24:50', 'disbursed', '{\"installments\":[{\"due_date\":\"2025-01-05\",\"amount\":22916.67}]}', '2025-12-11 07:24:50', '2025-12-11 07:24:50');

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
(1, 1, '2025-12-15', 22083.3300, 22083.3300, '2025-12-14 18:00:00', 'paid', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(2, 2, '2025-12-22', 27777.7800, 0.0000, NULL, 'pending', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(3, 3, '2025-12-10', 20833.3300, 20833.3300, '2025-12-09 18:00:00', 'paid', '{\"method\":\"cash\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(4, 4, '2025-12-05', 25000.0000, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(5, 5, '2025-12-20', 20833.3300, 0.0000, NULL, 'pending', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(6, 6, '2025-12-28', 16666.6700, 16666.6700, '2025-12-27 18:00:00', 'paid', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(7, 7, '2025-12-12', 18750.0000, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(8, 8, '2025-12-18', 16666.6700, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(9, 9, '2025-12-05', 16666.6700, 0.0000, NULL, 'pending', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(10, 10, '2025-12-25', 22916.6700, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(11, 11, '2025-12-30', 22222.2200, 22222.2200, '2025-12-29 18:00:00', 'paid', '{\"method\":\"cash\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(12, 12, '2025-12-15', 19444.4400, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(13, 13, '2025-12-20', 16666.6700, 16666.6700, '2025-12-19 18:00:00', 'paid', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(14, 14, '2025-12-25', 12500.0000, 0.0000, NULL, 'pending', '{\"method\":\"cash\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(15, 15, '2025-12-10', 13888.8900, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(16, 16, '2025-12-18', 20833.3300, 20833.3300, '2025-12-17 18:00:00', 'paid', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(17, 17, '2025-12-12', 16666.6700, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(18, 18, '2025-12-28', 16666.6700, 16666.6700, '2025-12-27 18:00:00', 'paid', '{\"method\":\"cash\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(19, 19, '2025-12-22', 18750.0000, 0.0000, NULL, 'pending', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56'),
(20, 20, '2025-12-05', 22916.6700, 0.0000, NULL, 'pending', '{\"method\":\"cheque\"}', '2025-12-11 07:26:56', '2025-12-11 07:26:56');

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
(1, 'Admin', 'web', NULL, NULL),
(2, 'Cashier', 'web', NULL, NULL),
(3, 'Customer', 'web', NULL, NULL);

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
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tx_uuid` char(36) NOT NULL,
  `account_id` bigint(20) UNSIGNED NOT NULL,
  `related_account_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('deposit','withdrawal','transfer','fee','interest','adjustment') NOT NULL,
  `amount` decimal(18,4) NOT NULL,
  `balance_before` decimal(18,4) NOT NULL,
  `balance_after` decimal(18,4) NOT NULL,
  `status` enum('pending','completed','failed','cancelled') NOT NULL DEFAULT 'pending',
  `narration` varchar(255) DEFAULT NULL,
  `meta` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`meta`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `tx_uuid`, `account_id`, `related_account_id`, `type`, `amount`, `balance_before`, `balance_after`, `status`, `narration`, `meta`, `created_at`, `updated_at`) VALUES
(1, 'TXUUID000000000000000000000000001', 1, NULL, 'deposit', 5000.0000, 15000.0000, 20000.0000, 'completed', 'Initial deposit', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(2, 'TXUUID000000000000000000000000002', 2, NULL, 'deposit', 20000.0000, 50000.0000, 70000.0000, 'completed', 'Business capital', '{\"method\":\"cheque\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(3, 'TXUUID000000000000000000000000003', 3, NULL, 'deposit', 100000.0000, 100000.0000, 200000.0000, 'completed', 'Fixed deposit top-up', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(4, 'TXUUID000000000000000000000000004', 4, NULL, 'deposit', 5000.0000, 12000.0000, 17000.0000, 'completed', 'Recurring deposit installment', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(5, 'TXUUID000000000000000000000000005', 5, NULL, 'withdrawal', 10000.0000, 30000.0000, 20000.0000, 'completed', 'ATM withdrawal', '{\"atm_id\":\"ATM001\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(6, 'TXUUID000000000000000000000000006', 6, NULL, 'deposit', 2000.0000, 8000.0000, 10000.0000, 'completed', 'Student savings deposit', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(7, 'TXUUID000000000000000000000000007', 7, NULL, 'deposit', 5000.0000, 25000.0000, 30000.0000, 'completed', 'Senior citizen bonus', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(8, 'TXUUID000000000000000000000000008', 8, NULL, 'deposit', 10000.0000, 40000.0000, 50000.0000, 'completed', 'Business savings deposit', '{\"method\":\"cheque\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(9, 'TXUUID000000000000000000000000009', 9, NULL, 'withdrawal', 5000.0000, 20000.0000, 15000.0000, 'completed', 'NRI withdrawal', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(10, 'TXUUID000000000000000000000000010', 10, 11, 'transfer', 5000.0000, 15000.0000, 10000.0000, 'completed', 'Joint savings transfer to Kevin', '{\"method\":\"online\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(11, 'TXUUID000000000000000000000000011', 11, NULL, 'deposit', 5000.0000, 10000.0000, 15000.0000, 'completed', 'Salary credited', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(12, 'TXUUID000000000000000000000000012', 12, NULL, 'deposit', 50000.0000, 200000.0000, 250000.0000, 'completed', 'Corporate deposit', '{\"method\":\"cheque\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(13, 'TXUUID000000000000000000000000013', 13, NULL, 'withdrawal', 2000.0000, 5000.0000, 3000.0000, 'completed', 'Trust account payment', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(14, 'TXUUID000000000000000000000000014', 14, NULL, 'deposit', 500.0000, 800.0000, 1300.0000, 'completed', 'Microfinance installment', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(15, 'TXUUID000000000000000000000000015', 15, NULL, 'deposit', 20000.0000, 120000.0000, 140000.0000, 'completed', 'Gold account deposit', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(16, 'TXUUID000000000000000000000000016', 16, NULL, 'deposit', 30000.0000, 150000.0000, 180000.0000, 'completed', 'Platinum account deposit', '{\"method\":\"cheque\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(17, 'TXUUID000000000000000000000000017', 17, NULL, 'withdrawal', 1000.0000, 5000.0000, 4000.0000, 'completed', 'Healthcare payment', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(18, 'TXUUID000000000000000000000000018', 18, NULL, 'deposit', 2000.0000, 7000.0000, 9000.0000, 'completed', 'Education savings deposit', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(19, 'TXUUID000000000000000000000000019', 19, NULL, 'deposit', 3000.0000, 9000.0000, 12000.0000, 'completed', 'Travel account deposit', '{\"method\":\"cash\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04'),
(20, 'TXUUID000000000000000000000000020', 20, NULL, 'deposit', 5000.0000, 12000.0000, 17000.0000, 'completed', 'Emergency fund deposit', '{\"method\":\"bank_transfer\"}', '2025-12-11 07:23:04', '2025-12-11 07:23:04');

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
(1, 'Alice Johnson', 'alice@example.com', '2025-12-11 07:11:15', 'password123', 1, '01710000001', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token1', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(2, 'Bob Smith', 'bob@example.com', '2025-12-11 07:11:15', 'password123', 2, '01710000002', 'pending', '{\"preferences\":{\"newsletter\":false}}', 'token2', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(3, 'Charlie Brown', 'charlie@example.com', NULL, 'password123', 2, '01710000003', 'rejected', '{\"preferences\":{\"newsletter\":true}}', 'token3', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(4, 'Diana Prince', 'diana@example.com', '2025-12-11 07:11:15', 'password123', 3, '01710000004', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token4', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(5, 'Ethan Hunt', 'ethan@example.com', NULL, 'password123', 1, '01710000005', 'pending', '{\"preferences\":{\"newsletter\":false}}', 'token5', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(6, 'Fiona Gallagher', 'fiona@example.com', '2025-12-11 07:11:15', 'password123', 2, '01710000006', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token6', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(7, 'George Martin', 'george@example.com', '2025-12-11 07:11:15', 'password123', 3, '01710000007', 'pending', '{\"preferences\":{\"newsletter\":true}}', 'token7', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(8, 'Hannah Baker', 'hannah@example.com', NULL, 'password123', 1, '01710000008', 'rejected', '{\"preferences\":{\"newsletter\":false}}', 'token8', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(9, 'Ian Malcolm', 'ian@example.com', '2025-12-11 07:11:15', 'password123', 2, '01710000009', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token9', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(10, 'Julia Roberts', 'julia@example.com', NULL, 'password123', 3, '01710000010', 'pending', '{\"preferences\":{\"newsletter\":true}}', 'token10', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(11, 'Kevin Durant', 'kevin@example.com', '2025-12-11 07:11:15', 'password123', 1, '01710000011', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token11', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(12, 'Laura Croft', 'laura@example.com', NULL, 'password123', 2, '01710000012', 'pending', '{\"preferences\":{\"newsletter\":false}}', 'token12', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(13, 'Michael Scott', 'michael@example.com', '2025-12-11 07:11:15', 'password123', 3, '01710000013', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token13', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(14, 'Nina Dobrev', 'nina@example.com', NULL, 'password123', 1, '01710000014', 'rejected', '{\"preferences\":{\"newsletter\":false}}', 'token14', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(15, 'Oscar Wilde', 'oscar@example.com', '2025-12-11 07:11:15', 'password123', 2, '01710000015', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token15', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(16, 'Pam Beesly', 'pam@example.com', NULL, 'password123', 3, '01710000016', 'pending', '{\"preferences\":{\"newsletter\":true}}', 'token16', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(17, 'Quentin Tarantino', 'quentin@example.com', '2025-12-11 07:11:15', 'password123', 1, '01710000017', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token17', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(18, 'Rachel Green', 'rachel@example.com', NULL, 'password123', 2, '01710000018', 'pending', '{\"preferences\":{\"newsletter\":false}}', 'token18', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(19, 'Steve Rogers', 'steve@example.com', '2025-12-11 07:11:15', 'password123', 3, '01710000019', 'verified', '{\"preferences\":{\"newsletter\":true}}', 'token19', '2025-12-11 07:11:15', '2025-12-11 07:11:15'),
(20, 'Tony Stark', 'tony@example.com', NULL, 'password123', 1, '01710000020', 'rejected', '{\"preferences\":{\"newsletter\":true}}', 'token20', '2025-12-11 07:11:15', '2025-12-11 07:11:15');

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `account_types`
--
ALTER TABLE `account_types`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `interest_rules`
--
ALTER TABLE `interest_rules`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_documents`
--
ALTER TABLE `kyc_documents`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `ledgers`
--
ALTER TABLE `ledgers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `loan_payments`
--
ALTER TABLE `loan_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

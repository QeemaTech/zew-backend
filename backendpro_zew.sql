-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 22, 2026 at 10:25 AM
-- Server version: 11.4.10-MariaDB
-- PHP Version: 8.4.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `backendpro_zew`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `address` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `address`, `latitude`, `longitude`, `name`, `phone`, `city`, `state`, `is_default`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 18, '3 abbas st. Nasr City, Cairo, Egypt', '30.06857688631472', '31.336199295502478', 'Home', '0123456789', 'Cairo', 'Nasr City', 1, 1, '2026-01-18 13:29:20', '2026-01-18 13:29:20'),
(2, 18, '16 مصطفى كامل، عزبة سعد، قسم سيدى جابر، محافظة الإسكندرية 5432066', '31.21569594336404', '29.942441403550276', 'Home', '0123456789', 'Alex', 'Sidi Gaber', 1, 1, '2026-01-18 13:35:07', '2026-01-18 13:35:46'),
(3, 24, '3 abbas st. Nasr City, Cairo, Egypt', '30.06857688631472', '31.336199295502478', 'Home', '0123456789', 'Cairo', 'Nasr City', 1, 1, '2026-03-23 10:28:58', '2026-03-23 10:28:58');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `address` varchar(255) NOT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `vendor_id`, `name`, `address`, `latitude`, `longitude`, `phone`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 3, '{\"ar\": \"فرع مدينة نصر\", \"en\": \"Nasr City Branch\"}', '3 Makram St, Cairo, Egypt', '30.055042487809665', '31.34618611072683', '+201201201200', 1, '2026-01-13 14:14:29', '2026-01-13 14:14:29'),
(2, 3, '{\"ar\": \"فرع المعادي\", \"en\": \"Maadie Branch\"}', '3 El Zouhour St, Cairo, Egypt', '29.971355197986814', '31.256119981158342', '+201201201201', 1, '2026-01-13 14:15:38', '2026-01-13 14:15:38'),
(3, 2, '{\"ar\": \"فرع شبرا\", \"en\": \"Shoubra Branch\"}', '3 Shoubra St, Cairo, Egypt', '30.079717469227067', '31.245198043761018', '+201231231231', 1, '2026-01-13 14:17:05', '2026-01-13 14:17:05'),
(4, 12, '{\"ar\": \"حدائق القبة\", \"en\": \"Hadayek El Kouba\"}', '15 walli el aahd st, Cairo, Egypt', '30.091851589259132', '31.28748148112548', '+2012001120120', 1, '2026-01-14 12:20:26', '2026-01-14 12:20:26'),
(5, 13, '{\"ar\": \"فرع مدينة نصر\", \"en\": \"Nasr City Branch\"}', '3 Makram St, Cairo, Egypt', '30.055042487809665', '31.34618611072683', '+201201201211', 1, '2026-01-15 10:45:42', '2026-03-23 11:22:17'),
(6, 13, '{\"ar\": \"فرع نيو جيزا\", \"en\": \"New Giza Branch\"}', 'قسم أول 6 أكتوبر، محافظة الجيزة', '30.022166044738704', '31.054311714840942', '+201022033012', 1, '2026-01-18 09:42:21', '2026-01-18 09:42:21');

-- --------------------------------------------------------

--
-- Table structure for table `branch_product_stocks`
--

CREATE TABLE `branch_product_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch_product_stocks`
--

INSERT INTO `branch_product_stocks` (`id`, `branch_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(3, 3, 1, 20, '2026-01-13 15:24:06', '2026-03-23 13:16:26'),
(4, 4, 8, 4, '2026-01-14 12:21:31', '2026-02-22 10:42:39'),
(5, 4, 9, 50, '2026-01-14 12:38:43', '2026-01-14 12:38:43'),
(12, 5, 14, 20, '2026-01-22 12:15:36', '2026-01-22 12:15:36'),
(13, 6, 14, 15, '2026-01-22 12:15:36', '2026-01-22 12:15:36'),
(14, 5, 10, 10, '2026-03-23 11:14:26', '2026-03-23 13:16:26'),
(15, 6, 10, 10, '2026-03-23 11:14:26', '2026-03-23 11:14:26');

-- --------------------------------------------------------

--
-- Table structure for table `branch_product_variant_stocks`
--

CREATE TABLE `branch_product_variant_stocks` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `product_variant_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branch_product_variant_stocks`
--

INSERT INTO `branch_product_variant_stocks` (`id`, `branch_id`, `product_variant_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 3, 4, 15, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(2, 3, 5, 6, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(3, 3, 6, 20, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(4, 3, 7, 13, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(5, 1, 8, 4, '2026-01-13 16:02:37', '2026-02-22 10:42:39'),
(6, 2, 8, 7, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(7, 1, 9, 8, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(8, 2, 9, 11, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(9, 1, 10, 17, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(10, 2, 10, 3, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(11, 1, 11, 5, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(12, 2, 11, 0, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(73, 5, 12, 5, '2026-01-22 11:38:48', '2026-03-23 13:16:26'),
(74, 6, 12, 4, '2026-01-22 11:38:48', '2026-03-23 11:11:55'),
(75, 5, 13, 10, '2026-01-22 11:38:48', '2026-01-22 11:38:48'),
(76, 6, 13, 9, '2026-01-22 11:38:48', '2026-01-22 11:38:48'),
(77, 5, 14, 5, '2026-01-22 11:38:48', '2026-01-22 11:38:48'),
(78, 6, 14, 5, '2026-01-22 11:38:48', '2026-01-22 11:38:48'),
(103, 5, 28, 5, '2026-01-22 15:25:11', '2026-03-23 13:16:26'),
(104, 6, 28, 4, '2026-01-22 15:25:11', '2026-03-23 11:11:55'),
(105, 5, 29, 4, '2026-01-22 15:25:11', '2026-01-22 15:25:11'),
(106, 6, 29, 7, '2026-01-22 15:25:11', '2026-01-22 15:25:11');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-boost.roster.scan', 'a:2:{s:6:\"roster\";O:21:\"Laravel\\Roster\\Roster\":3:{s:13:\"\0*\0approaches\";O:29:\"Illuminate\\Support\\Collection\":2:{s:8:\"\0*\0items\";a:0:{}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}s:11:\"\0*\0packages\";O:32:\"Laravel\\Roster\\PackageCollection\":2:{s:8:\"\0*\0items\";a:9:{i:0;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:1;s:13:\"\0*\0constraint\";s:5:\"^12.0\";s:10:\"\0*\0package\";E:37:\"Laravel\\Roster\\Enums\\Packages:LARAVEL\";s:14:\"\0*\0packageName\";s:17:\"laravel/framework\";s:10:\"\0*\0version\";s:7:\"12.46.0\";s:6:\"\0*\0dev\";b:0;}i:1;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:0;s:13:\"\0*\0constraint\";s:6:\"v0.3.8\";s:10:\"\0*\0package\";E:37:\"Laravel\\Roster\\Enums\\Packages:PROMPTS\";s:14:\"\0*\0packageName\";s:15:\"laravel/prompts\";s:10:\"\0*\0version\";s:5:\"0.3.8\";s:6:\"\0*\0dev\";b:0;}i:2;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:1;s:13:\"\0*\0constraint\";s:4:\"^4.0\";s:10:\"\0*\0package\";E:37:\"Laravel\\Roster\\Enums\\Packages:SANCTUM\";s:14:\"\0*\0packageName\";s:15:\"laravel/sanctum\";s:10:\"\0*\0version\";s:5:\"4.2.2\";s:6:\"\0*\0dev\";b:0;}i:3;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:0;s:13:\"\0*\0constraint\";s:6:\"v0.5.2\";s:10:\"\0*\0package\";E:33:\"Laravel\\Roster\\Enums\\Packages:MCP\";s:14:\"\0*\0packageName\";s:11:\"laravel/mcp\";s:10:\"\0*\0version\";s:5:\"0.5.2\";s:6:\"\0*\0dev\";b:1;}i:4;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:1;s:13:\"\0*\0constraint\";s:5:\"^1.24\";s:10:\"\0*\0package\";E:34:\"Laravel\\Roster\\Enums\\Packages:PINT\";s:14:\"\0*\0packageName\";s:12:\"laravel/pint\";s:10:\"\0*\0version\";s:6:\"1.27.0\";s:6:\"\0*\0dev\";b:1;}i:5;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:1;s:13:\"\0*\0constraint\";s:5:\"^1.41\";s:10:\"\0*\0package\";E:34:\"Laravel\\Roster\\Enums\\Packages:SAIL\";s:14:\"\0*\0packageName\";s:12:\"laravel/sail\";s:10:\"\0*\0version\";s:6:\"1.52.0\";s:6:\"\0*\0dev\";b:1;}i:6;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:1;s:13:\"\0*\0constraint\";s:7:\"^11.5.3\";s:10:\"\0*\0package\";E:37:\"Laravel\\Roster\\Enums\\Packages:PHPUNIT\";s:14:\"\0*\0packageName\";s:15:\"phpunit/phpunit\";s:10:\"\0*\0version\";s:7:\"11.5.46\";s:6:\"\0*\0dev\";b:1;}i:7;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:0;s:13:\"\0*\0constraint\";s:0:\"\";s:10:\"\0*\0package\";E:38:\"Laravel\\Roster\\Enums\\Packages:ALPINEJS\";s:14:\"\0*\0packageName\";s:8:\"alpinejs\";s:10:\"\0*\0version\";s:6:\"3.15.3\";s:6:\"\0*\0dev\";b:0;}i:8;O:22:\"Laravel\\Roster\\Package\":6:{s:9:\"\0*\0direct\";b:0;s:13:\"\0*\0constraint\";s:0:\"\";s:10:\"\0*\0package\";E:41:\"Laravel\\Roster\\Enums\\Packages:TAILWINDCSS\";s:14:\"\0*\0packageName\";s:11:\"tailwindcss\";s:10:\"\0*\0version\";s:6:\"4.1.18\";s:6:\"\0*\0dev\";b:1;}}s:28:\"\0*\0escapeWhenCastingToString\";b:0;}s:21:\"\0*\0nodePackageManager\";E:43:\"Laravel\\Roster\\Enums\\NodePackageManager:NPM\";}s:9:\"timestamp\";i:1768149091;}', 1768235491),
('laravel-cache-setting:app_icon', 's:53:\"settings/BXPoHAUDV7tHZzlJIJRx7u5jsBSPzwp2EhvsQKz9.jpg\";', 1768152315),
('laravel-cache-setting:app_logo', 's:53:\"settings/FtzkBtvL5StDe8LhqFVOmkJG8VPDQ57GhYrCwK6D.jpg\";', 1768152315),
('laravel-cache-setting:app_name', 's:18:\"Multi Vendor Store\";', 1768152315),
('laravel-cache-setting:profit_type', 's:12:\"subscription\";', 1768152315),
('laravel-cache-setting:profit_value', 'N;', 1768152466);

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
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `variant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `is_active`, `is_featured`, `parent_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '{\"ar\": \"خضروات\", \"en\": \"Vegetables\"}', 'vegetables', 'categories/cIsORXZGwiG8IbARr8mnD69Q7obRuQtWP7IOAnW1.png', 1, 1, NULL, '2026-01-11 14:50:10', '2026-01-12 11:57:38', NULL),
(2, '{\"ar\": \"فواكة\", \"en\": \"Fruits\"}', 'fruits', 'categories/8GV8HvvSL5VlaxhGIYGiFFwYimI5nB5toTuC4f2o.png', 1, 1, NULL, '2026-01-11 15:14:59', '2026-01-12 11:57:38', NULL),
(3, '{\"ar\": \"مخبوزات\", \"en\": \"Breads\"}', 'breads', 'categories/1Cuo9gWIAY38jAqpVzgMt7zHaykLCJdAInouXd1V.png', 1, 0, NULL, '2026-01-11 15:17:26', '2026-01-12 11:57:38', NULL),
(4, '{\"ar\": \"فواكة استوائية\", \"en\": \"tropical fruits\"}', 'tropical-fruits', 'categories/Nc1vyz1ow52ep4XB0T6jG8HqOuwQCMKvqj5v33Nf.png', 1, 0, 2, '2026-01-11 15:18:54', '2026-01-12 11:57:38', NULL),
(5, '{\"ar\": \"test\", \"en\": \"test\"}', 'test', NULL, 1, 0, NULL, '2026-01-12 08:19:35', '2026-01-12 08:23:59', '2026-01-12 08:23:59'),
(7, '{\"ar\": \"p\", \"en\": \"p\"}', 'p', NULL, 1, 0, NULL, '2026-01-12 08:19:51', '2026-01-12 08:28:00', '2026-01-12 08:28:00'),
(8, '{\"ar\": \"سندويتشات\", \"en\": \"Sandwiches\"}', NULL, 'categories/ynwOP9JYxQ34KwLT6CzcnQRRiesmGa2i5UruLdsa.png', 1, 0, 3, '2026-01-13 11:34:51', '2026-01-13 11:34:51', NULL),
(9, '{\"ar\": \"حلويات\", \"en\": \"Sweets\"}', NULL, 'categories/wp81c2qduftlqKlrBmoInj0PQbUqqB73P9lRtsNr.jpg', 1, 0, NULL, '2026-01-13 15:06:14', '2026-01-13 15:06:14', NULL),
(10, '{\"ar\": \"مشروبات ساخنة\", \"en\": \"Hot Drinks\"}', NULL, 'categories/GEidezjdA2HyVcA36YzhFWKJ47dIuIlF28nLDsO5.webp', 1, 0, NULL, '2026-01-15 11:40:07', '2026-01-15 11:40:07', NULL),
(11, '{\"ar\": \"الألبان، البيض والجبنة\", \"en\": \"Dairy, Eggs & Cheese\"}', NULL, 'categories/e0eT7mFt5ZH4MJPO33Resc2Bz7c94mNmArKym89d.webp', 1, 0, NULL, '2026-01-18 11:26:45', '2026-01-18 11:26:45', NULL),
(12, '{\"ar\": \"العناية بالطفل\", \"en\": \"Baby Care\"}', NULL, 'categories/kL7GdupdbhhiEUi032qdkleCDsPC54KBvNR8JQ0M.png', 1, 0, NULL, '2026-01-22 11:00:33', '2026-01-22 11:00:33', NULL),
(13, '{\"ar\": \"البسكويت والكعك\", \"en\": \"Biscuits & Cookies\"}', NULL, 'categories/iRUYPTKAltqXswJzS3IvGTIStO4hQWZoSrxQXzJh.png', 1, 1, 3, '2026-01-22 11:00:33', '2026-01-22 11:00:33', NULL),
(14, '{\"ar\": \"الآيس كريم والحلويات\", \"en\": \"Ice cream & Desserts\"}', NULL, 'categories/BNwGA6jjDpEkLZqD4TuEDgEwDZ0J0nyeZgYY8JrD.png', 1, 0, 9, '2026-01-22 11:13:56', '2026-01-22 11:13:56', NULL),
(15, '{\"ar\": \"شيبس والوجبات الخفيفة\", \"en\": \"Chips, Dips & Snacks\"}', NULL, 'categories/xNWPoX6yVXriQb24XEnAGh0Zf8aEIdDa2WpZCULZ.png', 1, 0, 9, '2026-01-22 11:13:56', '2026-01-22 11:13:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_product`
--

CREATE TABLE `category_product` (
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_product`
--

INSERT INTO `category_product` (`product_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 9, NULL, NULL),
(6, 9, NULL, NULL),
(7, 9, NULL, NULL),
(8, 9, NULL, NULL),
(9, 9, NULL, NULL),
(10, 10, NULL, NULL),
(11, 11, NULL, NULL),
(11, 12, NULL, NULL),
(14, 3, NULL, NULL),
(14, 9, NULL, NULL),
(14, 13, NULL, NULL),
(15, 3, NULL, NULL),
(15, 9, NULL, NULL),
(15, 13, NULL, NULL),
(16, 9, NULL, NULL),
(16, 14, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `category_requests`
--

CREATE TABLE `category_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_requests`
--

INSERT INTO `category_requests` (`id`, `vendor_id`, `name`, `description`, `status`, `admin_notes`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, '{\"ar\": \"11 سندويتشات\", \"en\": \"Sandwiches 11\"}', 'أريد اضافة فئة للسندويتشات تكون متفرعة من فئة المخبوزات', 'rejected', 'the category name is not correct', 1, '2026-01-13 11:21:48', '2026-01-13 11:18:49', '2026-01-13 11:21:48', NULL),
(2, 3, '{\"ar\": \"سندويتشات\", \"en\": \"Sandwiches\"}', 'أريد اضافة فئة للسندويتشات تكون متفرعة من فئة المخبوزات', 'approved', 'we will create it', 1, '2026-01-13 11:33:52', '2026-01-13 11:18:49', '2026-01-13 11:33:52', NULL),
(3, 3, '{\"ar\": \"test\", \"en\": \"test\"}', NULL, 'rejected', 'no', 1, '2026-01-13 11:27:27', '2026-01-13 11:27:16', '2026-01-13 11:27:27', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `type` enum('percentage','fixed') NOT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `min_cart_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `usage_limit_per_user` int(11) DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `type`, `discount_value`, `min_cart_amount`, `usage_limit_per_user`, `start_date`, `end_date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'HELLO25', 'percentage', 25.00, 500.00, 1, NULL, NULL, 1, '2026-01-19 14:52:16', '2026-01-19 14:52:16'),
(2, 'ASDSADA', 'percentage', 10.00, 200.00, 1, '2026-03-23 13:11:00', '2026-03-31 13:11:00', 1, '2026-03-23 11:11:47', '2026-03-23 11:11:47');

-- --------------------------------------------------------

--
-- Table structure for table `deliveries`
--

CREATE TABLE `deliveries` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vehicle_type` varchar(255) NOT NULL,
  `vehicle_number` varchar(255) NOT NULL,
  `vehicle_color` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `wallet` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deliveries`
--

INSERT INTO `deliveries` (`id`, `vehicle_type`, `vehicle_number`, `vehicle_color`, `user_id`, `wallet`, `is_active`, `attachments`, `created_at`, `updated_at`) VALUES
(1, 'motorcycle', 'ABC-123', 'red', 20, 59.45, 1, NULL, '2026-02-22 09:25:51', '2026-03-23 12:01:24'),
(2, 'motorcycle', 'ACB-332', 'black', 21, 2.00, 1, NULL, '2026-02-22 10:16:32', '2026-02-25 14:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_assignments`
--

CREATE TABLE `delivery_assignments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'assigned',
  `total_km` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `assigned_at` timestamp NULL DEFAULT NULL,
  `delivered_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_assignments`
--

INSERT INTO `delivery_assignments` (`id`, `order_id`, `delivery_id`, `status`, `total_km`, `shipping_cost`, `assigned_at`, `delivered_at`, `created_at`, `updated_at`) VALUES
(1, 10, 1, 'delivered', 11.89, 59.45, '2026-03-23 11:20:28', '2026-03-23 12:01:24', '2026-03-23 11:20:28', '2026-03-23 12:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_assignment_pickups`
--

CREATE TABLE `delivery_assignment_pickups` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_assignment_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_order_id` bigint(20) UNSIGNED NOT NULL,
  `sequence` tinyint(3) UNSIGNED NOT NULL,
  `picked_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_assignment_pickups`
--

INSERT INTO `delivery_assignment_pickups` (`id`, `delivery_assignment_id`, `vendor_order_id`, `sequence`, `picked_at`, `created_at`, `updated_at`) VALUES
(1, 1, 19, 1, '2026-03-23 12:01:02', '2026-03-23 11:20:28', '2026-03-23 12:01:02'),
(2, 1, 20, 2, '2026-03-23 12:00:46', '2026-03-23 11:20:28', '2026-03-23 12:00:46');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_requests`
--

CREATE TABLE `delivery_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `vehicle_type` varchar(255) NOT NULL,
  `vehicle_number` varchar(255) NOT NULL,
  `vehicle_color` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `rejection_reason` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_requests`
--

INSERT INTO `delivery_requests` (`id`, `user_id`, `name`, `phone`, `email`, `vehicle_type`, `vehicle_number`, `vehicle_color`, `message`, `status`, `reviewed_by`, `reviewed_at`, `rejection_reason`, `created_at`, `updated_at`) VALUES
(1, 21, 'Test Delivery 2', '+2012255510', 'testdel@zew.com', 'motorcycle', 'ACB-332', 'black', 'Hi.', 'accepted', 1, '2026-02-22 10:16:32', NULL, '2026-02-22 10:16:11', '2026-02-22 10:16:32'),
(2, NULL, 'Test Delivery 3', '+20122555101', 'testdelreq@zew.com', 'motorcycle', 'ACB-331', 'black', 'Hi.', 'pending', NULL, NULL, NULL, '2026-02-22 10:16:11', '2026-02-22 10:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_shift`
--

CREATE TABLE `delivery_shift` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `shift_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_shift`
--

INSERT INTO `delivery_shift` (`id`, `delivery_id`, `shift_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2026-02-22 09:30:24', '2026-02-22 09:30:24');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_wallet_transactions`
--

CREATE TABLE `delivery_wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `balance_after` decimal(12,2) NOT NULL,
  `reference_type` varchar(255) DEFAULT NULL,
  `reference_id` bigint(20) UNSIGNED DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_wallet_transactions`
--

INSERT INTO `delivery_wallet_transactions` (`id`, `delivery_id`, `type`, `amount`, `balance_after`, `reference_type`, `reference_id`, `notes`, `created_at`, `updated_at`) VALUES
(1, 2, 'admin_adjustment', 5.00, 5.00, NULL, NULL, 'Admin wallet adjustment', '2026-02-22 14:47:00', '2026-02-22 14:47:00'),
(2, 2, 'admin_adjustment', -3.00, 2.00, NULL, NULL, 'Admin wallet adjustment', '2026-02-25 14:31:14', '2026-02-25 14:31:14'),
(3, 1, 'delivery_completed', 59.45, 59.45, 'App\\Models\\DeliveryAssignment', 1, 'Order #10 delivery completed', '2026-03-23 12:01:24', '2026-03-23 12:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_zone`
--

CREATE TABLE `delivery_zone` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `delivery_id` bigint(20) UNSIGNED NOT NULL,
  `zone_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_zone`
--

INSERT INTO `delivery_zone` (`id`, `delivery_id`, `zone_id`, `created_at`, `updated_at`) VALUES
(1, 1, 7, '2026-02-22 09:25:51', '2026-02-22 09:25:51'),
(2, 1, 5, '2026-02-22 09:25:51', '2026-02-22 09:25:51'),
(3, 2, 7, '2026-02-22 10:17:28', '2026-02-22 10:17:28'),
(4, 2, 2, '2026-02-22 10:17:28', '2026-02-22 10:17:28'),
(5, 2, 5, '2026-02-22 10:17:28', '2026-02-22 10:17:28'),
(6, 2, 10, '2026-02-25 14:32:25', '2026-02-25 14:32:25'),
(7, 2, 9, '2026-02-25 14:32:25', '2026-02-25 14:32:25');

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

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '70fdbc5c-1785-4683-a7bf-a387f9e24866', 'database', 'default', '{\"uuid\":\"70fdbc5c-1785-4683-a7bf-a387f9e24866\",\"displayName\":\"App\\\\Mail\\\\OrderStatusUpdatedMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:31:\\\"App\\\\Mail\\\\OrderStatusUpdatedMail\\\":5:{s:5:\\\"order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:6:\\\"status\\\";s:10:\\\"processing\\\";s:11:\\\"vendorOrder\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\VendorOrder\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:8:{i:0;s:5:\\\"order\\\";i:1;s:10:\\\"order.user\\\";i:2;s:13:\\\"order.address\\\";i:3;s:6:\\\"vendor\\\";i:4;s:6:\\\"branch\\\";i:5;s:5:\\\"items\\\";i:6;s:13:\\\"items.product\\\";i:7;s:13:\\\"items.variant\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:13:\\\"test@user.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1768915701,\"delay\":null}', 'Symfony\\Component\\Mailer\\Exception\\UnexpectedResponseException: Expected response code \"354\" but got code \"550\", with message \"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\". in C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php:331\nStack trace:\n#0 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(187): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->assertResponseCode(\'550 5.7.0 Too m...\', Array)\n#1 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\EsmtpTransport.php(150): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#2 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(209): Symfony\\Component\\Mailer\\Transport\\Smtp\\EsmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#3 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\AbstractTransport.php(69): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->doSend(Object(Symfony\\Component\\Mailer\\SentMessage))\n#4 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(138): Symfony\\Component\\Mailer\\Transport\\AbstractTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#5 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(584): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#6 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(331): Illuminate\\Mail\\Mailer->sendSymfonyMessage(Object(Symfony\\Component\\Mime\\Email))\n#7 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(207): Illuminate\\Mail\\Mailer->send(\'emails.orders.s...\', Array, Object(Closure))\n#8 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(19): Illuminate\\Mail\\Mailable->Illuminate\\Mail\\{closure}()\n#9 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(200): Illuminate\\Mail\\Mailable->withLocale(NULL, Object(Closure))\n#10 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\SendQueuedMailable.php(82): Illuminate\\Mail\\Mailable->send(Object(Illuminate\\Mail\\MailManager))\n#11 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Mail\\SendQueuedMailable->handle(Object(Illuminate\\Mail\\MailManager))\n#12 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#13 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#14 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#15 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#16 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#17 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#18 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#19 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Mail\\SendQueuedMailable), false)\n#21 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#22 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#23 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#24 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Mail\\SendQueuedMailable))\n#25 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#26 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(485): Illuminate\\Queue\\Jobs\\Job->fire()\n#27 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#28 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(201): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#30 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#31 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#32 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#33 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#34 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#35 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#36 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#37 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#38 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#39 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 C:\\laragon\\www\\multi-vendor-e-commerce\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#45 {main}', '2026-01-22 11:09:42'),
(2, '11157a2d-0871-4acf-a02e-4b66b56abee7', 'database', 'default', '{\"uuid\":\"11157a2d-0871-4acf-a02e-4b66b56abee7\",\"displayName\":\"App\\\\Mail\\\\OrderStatusUpdatedMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:31:\\\"App\\\\Mail\\\\OrderStatusUpdatedMail\\\":5:{s:5:\\\"order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:6:\\\"status\\\";s:10:\\\"processing\\\";s:11:\\\"vendorOrder\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\VendorOrder\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:8:{i:0;s:5:\\\"order\\\";i:1;s:10:\\\"order.user\\\";i:2;s:13:\\\"order.address\\\";i:3;s:6:\\\"vendor\\\";i:4;s:6:\\\"branch\\\";i:5;s:5:\\\"items\\\";i:6;s:13:\\\"items.product\\\";i:7;s:13:\\\"items.variant\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:13:\\\"test@user.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1768915884,\"delay\":null}', 'Symfony\\Component\\Mailer\\Exception\\UnexpectedResponseException: Expected response code \"354\" but got code \"550\", with message \"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\". in C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php:331\nStack trace:\n#0 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(187): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->assertResponseCode(\'550 5.7.0 Too m...\', Array)\n#1 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\EsmtpTransport.php(150): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#2 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(209): Symfony\\Component\\Mailer\\Transport\\Smtp\\EsmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#3 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\AbstractTransport.php(69): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->doSend(Object(Symfony\\Component\\Mailer\\SentMessage))\n#4 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(138): Symfony\\Component\\Mailer\\Transport\\AbstractTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#5 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(584): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#6 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(331): Illuminate\\Mail\\Mailer->sendSymfonyMessage(Object(Symfony\\Component\\Mime\\Email))\n#7 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(207): Illuminate\\Mail\\Mailer->send(\'emails.orders.s...\', Array, Object(Closure))\n#8 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(19): Illuminate\\Mail\\Mailable->Illuminate\\Mail\\{closure}()\n#9 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(200): Illuminate\\Mail\\Mailable->withLocale(NULL, Object(Closure))\n#10 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\SendQueuedMailable.php(82): Illuminate\\Mail\\Mailable->send(Object(Illuminate\\Mail\\MailManager))\n#11 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Mail\\SendQueuedMailable->handle(Object(Illuminate\\Mail\\MailManager))\n#12 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#13 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#14 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#15 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#16 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#17 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#18 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#19 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Mail\\SendQueuedMailable), false)\n#21 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#22 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#23 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#24 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Mail\\SendQueuedMailable))\n#25 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#26 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(485): Illuminate\\Queue\\Jobs\\Job->fire()\n#27 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#28 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(201): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#30 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#31 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#32 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#33 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#34 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#35 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#36 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#37 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#38 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#39 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 C:\\laragon\\www\\multi-vendor-e-commerce\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#45 {main}', '2026-01-22 11:09:43'),
(3, '67976a64-a642-43f5-84c7-61618e9d5fd9', 'database', 'default', '{\"uuid\":\"67976a64-a642-43f5-84c7-61618e9d5fd9\",\"displayName\":\"App\\\\Mail\\\\OrderStatusUpdatedMail\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Mail\\\\SendQueuedMailable\",\"command\":\"O:34:\\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\\":17:{s:8:\\\"mailable\\\";O:31:\\\"App\\\\Mail\\\\OrderStatusUpdatedMail\\\":5:{s:5:\\\"order\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:16:\\\"App\\\\Models\\\\Order\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:1:{i:0;s:4:\\\"user\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:6:\\\"status\\\";s:10:\\\"processing\\\";s:11:\\\"vendorOrder\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:22:\\\"App\\\\Models\\\\VendorOrder\\\";s:2:\\\"id\\\";i:10;s:9:\\\"relations\\\";a:8:{i:0;s:5:\\\"order\\\";i:1;s:10:\\\"order.user\\\";i:2;s:13:\\\"order.address\\\";i:3;s:6:\\\"vendor\\\";i:4;s:6:\\\"branch\\\";i:5;s:5:\\\"items\\\";i:6;s:13:\\\"items.product\\\";i:7;s:13:\\\"items.variant\\\";}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"to\\\";a:1:{i:0;a:2:{s:4:\\\"name\\\";N;s:7:\\\"address\\\";s:13:\\\"test@user.com\\\";}}s:6:\\\"mailer\\\";s:4:\\\"smtp\\\";}s:5:\\\"tries\\\";N;s:7:\\\"timeout\\\";N;s:13:\\\"maxExceptions\\\";N;s:17:\\\"shouldBeEncrypted\\\";b:0;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:3:\\\"job\\\";N;}\"},\"createdAt\":1768916054,\"delay\":null}', 'Symfony\\Component\\Mailer\\Exception\\UnexpectedResponseException: Expected response code \"354\" but got code \"550\", with message \"550 5.7.0 Too many emails per second. Please upgrade your plan https://mailtrap.io/billing/plans/testing\". in C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php:331\nStack trace:\n#0 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(187): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->assertResponseCode(\'550 5.7.0 Too m...\', Array)\n#1 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\EsmtpTransport.php(150): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#2 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(209): Symfony\\Component\\Mailer\\Transport\\Smtp\\EsmtpTransport->executeCommand(\'DATA\\r\\n\', Array)\n#3 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\AbstractTransport.php(69): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->doSend(Object(Symfony\\Component\\Mailer\\SentMessage))\n#4 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\mailer\\Transport\\Smtp\\SmtpTransport.php(138): Symfony\\Component\\Mailer\\Transport\\AbstractTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#5 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(584): Symfony\\Component\\Mailer\\Transport\\Smtp\\SmtpTransport->send(Object(Symfony\\Component\\Mime\\Email), Object(Symfony\\Component\\Mailer\\DelayedEnvelope))\n#6 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(331): Illuminate\\Mail\\Mailer->sendSymfonyMessage(Object(Symfony\\Component\\Mime\\Email))\n#7 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(207): Illuminate\\Mail\\Mailer->send(\'emails.orders.s...\', Array, Object(Closure))\n#8 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(19): Illuminate\\Mail\\Mailable->Illuminate\\Mail\\{closure}()\n#9 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailable.php(200): Illuminate\\Mail\\Mailable->withLocale(NULL, Object(Closure))\n#10 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\SendQueuedMailable.php(82): Illuminate\\Mail\\Mailable->send(Object(Illuminate\\Mail\\MailManager))\n#11 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Mail\\SendQueuedMailable->handle(Object(Illuminate\\Mail\\MailManager))\n#12 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#13 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#14 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#15 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#16 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#17 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#18 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#19 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#20 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Mail\\SendQueuedMailable), false)\n#21 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#22 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Illuminate\\Mail\\SendQueuedMailable))\n#23 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#24 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Mail\\SendQueuedMailable))\n#25 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#26 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(485): Illuminate\\Queue\\Jobs\\Job->fire()\n#27 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#28 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(201): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#29 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#30 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#31 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#32 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#33 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#34 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#35 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#36 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#37 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#38 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#39 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#40 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#41 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#42 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#43 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 C:\\laragon\\www\\multi-vendor-e-commerce\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#45 {main}', '2026-01-22 11:09:44');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(4, '5cf7ef28-5f7d-46ba-b0ee-00c3bc022678', 'database', 'default', '{\"uuid\":\"5cf7ef28-5f7d-46ba-b0ee-00c3bc022678\",\"displayName\":\"Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\",\"command\":\"O:32:\\\"Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\\":25:{s:7:\\\"timeout\\\";N;s:5:\\\"tries\\\";N;s:13:\\\"maxExceptions\\\";N;s:7:\\\"backoff\\\";N;s:5:\\\"queue\\\";N;s:10:\\\"connection\\\";N;s:40:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000import\\\";O:26:\\\"App\\\\Imports\\\\ProductsImport\\\":7:{s:14:\\\"\\u0000*\\u0000vendorsById\\\";a:4:{i:2;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:2;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"ماركت باندا\\\", \\\"en\\\": \\\"Banda Vendor\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:2;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"ماركت باندا\\\", \\\"en\\\": \\\"Banda Vendor\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:3;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:3;s:4:\\\"name\\\";s:54:\\\"{\\\"ar\\\": \\\"ماركت هايبر\\\", \\\"en\\\": \\\"Hayper Vendor\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:3;s:4:\\\"name\\\";s:54:\\\"{\\\"ar\\\": \\\"ماركت هايبر\\\", \\\"en\\\": \\\"Hayper Vendor\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:12;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:12;s:4:\\\"name\\\";s:61:\\\"{\\\"ar\\\": \\\"فتح الله ماركت\\\", \\\"en\\\": \\\"Fathalla Market\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:12;s:4:\\\"name\\\";s:61:\\\"{\\\"ar\\\": \\\"فتح الله ماركت\\\", \\\"en\\\": \\\"Fathalla Market\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:13;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:13;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"سعودي ماركت\\\", \\\"en\\\": \\\"Saudi Market\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:13;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"سعودي ماركت\\\", \\\"en\\\": \\\"Saudi Market\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}}s:16:\\\"\\u0000*\\u0000vendorsByName\\\";a:0:{}s:11:\\\"\\u0000*\\u0000rowCount\\\";i:0;s:9:\\\"\\u0000*\\u0000userId\\\";i:1;s:9:\\\"\\u0000*\\u0000output\\\";N;s:9:\\\"\\u0000*\\u0000errors\\\";a:0:{}s:11:\\\"\\u0000*\\u0000failures\\\";a:0:{}}s:40:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000reader\\\";O:36:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\\":13:{s:15:\\\"\\u0000*\\u0000readDataOnly\\\";b:1;s:17:\\\"\\u0000*\\u0000readEmptyCells\\\";b:1;s:16:\\\"\\u0000*\\u0000includeCharts\\\";b:0;s:17:\\\"\\u0000*\\u0000loadSheetsOnly\\\";N;s:22:\\\"\\u0000*\\u0000allowExternalImages\\\";b:0;s:13:\\\"\\u0000*\\u0000readFilter\\\";O:49:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\DefaultReadFilter\\\":0:{}s:13:\\\"\\u0000*\\u0000fileHandle\\\";N;s:18:\\\"\\u0000*\\u0000securityScanner\\\";O:51:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\\":2:{s:60:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\u0000pattern\\\";s:9:\\\"<!DOCTYPE\\\";s:61:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\u0000callback\\\";N;}s:53:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000referenceHelper\\\";O:40:\\\"PhpOffice\\\\PhpSpreadsheet\\\\ReferenceHelper\\\":1:{s:61:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\ReferenceHelper\\u0000cellReferenceHelper\\\";N;}s:41:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000zip\\\";O:10:\\\"ZipArchive\\\":6:{s:6:\\\"lastId\\\";i:-1;s:6:\\\"status\\\";i:0;s:9:\\\"statusSys\\\";i:0;s:8:\\\"numFiles\\\";i:0;s:8:\\\"filename\\\";s:0:\\\"\\\";s:7:\\\"comment\\\";s:0:\\\"\\\";}s:49:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000styleReader\\\";N;s:52:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000sharedFormulae\\\";a:0:{}s:47:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000parseHuge\\\";b:0;}s:47:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000temporaryFile\\\";O:42:\\\"Maatwebsite\\\\Excel\\\\Files\\\\LocalTemporaryFile\\\":1:{s:52:\\\"\\u0000Maatwebsite\\\\Excel\\\\Files\\\\LocalTemporaryFile\\u0000filePath\\\";s:128:\\\"C:\\\\laragon\\\\www\\\\multi-vendor-e-commerce\\\\storage\\\\framework\\\\cache\\\\laravel-excel\\\\laravel-excel-MUxwgSoOs8ceH0hdGnFQ9T7U5jTzPaRZ.xlsx\\\";}s:43:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000sheetName\\\";s:9:\\\"Worksheet\\\";s:45:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000sheetImport\\\";r:8;s:42:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000startRow\\\";i:2;s:43:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000chunkSize\\\";i:250;s:42:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\ReadChunk\\u0000uniqueId\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:1:{i:0;s:8943:\\\"O:37:\\\"Maatwebsite\\\\Excel\\\\Jobs\\\\AfterImportJob\\\":17:{s:45:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\AfterImportJob\\u0000import\\\";O:26:\\\"App\\\\Imports\\\\ProductsImport\\\":7:{s:14:\\\"\\u0000*\\u0000vendorsById\\\";a:4:{i:2;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:2;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"ماركت باندا\\\", \\\"en\\\": \\\"Banda Vendor\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:2;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"ماركت باندا\\\", \\\"en\\\": \\\"Banda Vendor\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:3;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:3;s:4:\\\"name\\\";s:54:\\\"{\\\"ar\\\": \\\"ماركت هايبر\\\", \\\"en\\\": \\\"Hayper Vendor\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:3;s:4:\\\"name\\\";s:54:\\\"{\\\"ar\\\": \\\"ماركت هايبر\\\", \\\"en\\\": \\\"Hayper Vendor\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:12;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:12;s:4:\\\"name\\\";s:61:\\\"{\\\"ar\\\": \\\"فتح الله ماركت\\\", \\\"en\\\": \\\"Fathalla Market\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:12;s:4:\\\"name\\\";s:61:\\\"{\\\"ar\\\": \\\"فتح الله ماركت\\\", \\\"en\\\": \\\"Fathalla Market\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}i:13;O:17:\\\"App\\\\Models\\\\Vendor\\\":36:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";s:7:\\\"vendors\\\";s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:0;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:2:{s:2:\\\"id\\\";i:13;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"سعودي ماركت\\\", \\\"en\\\": \\\"Saudi Market\\\"}\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:2:{s:2:\\\"id\\\";i:13;s:4:\\\"name\\\";s:53:\\\"{\\\"ar\\\": \\\"سعودي ماركت\\\", \\\"en\\\": \\\"Saudi Market\\\"}\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:0:{}s:11:\\\"\\u0000*\\u0000previous\\\";a:0:{}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:4:\\\"name\\\";s:5:\\\"array\\\";s:9:\\\"is_active\\\";s:7:\\\"boolean\\\";s:11:\\\"is_featured\\\";s:7:\\\"boolean\\\";s:10:\\\"deleted_at\\\";s:8:\\\"datetime\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:26:\\\"\\u0000*\\u0000relationAutoloadContext\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:13:{i:0;s:4:\\\"slug\\\";i:1;s:4:\\\"name\\\";i:2;s:8:\\\"owner_id\\\";i:3;s:5:\\\"phone\\\";i:4;s:7:\\\"address\\\";i:5;s:5:\\\"image\\\";i:6;s:9:\\\"is_active\\\";i:7;s:11:\\\"is_featured\\\";i:8;s:7:\\\"balance\\\";i:9;s:15:\\\"commission_rate\\\";i:10;s:7:\\\"plan_id\\\";i:11;s:18:\\\"subscription_start\\\";i:12;s:16:\\\"subscription_end\\\";}s:10:\\\"\\u0000*\\u0000guarded\\\";a:1:{i:0;s:1:\\\"*\\\";}s:15:\\\"\\u0000*\\u0000translatable\\\";a:1:{i:0;s:4:\\\"name\\\";}s:20:\\\"\\u0000*\\u0000translationLocale\\\";N;s:16:\\\"\\u0000*\\u0000forceDeleting\\\";b:0;}}s:16:\\\"\\u0000*\\u0000vendorsByName\\\";a:0:{}s:11:\\\"\\u0000*\\u0000rowCount\\\";i:0;s:9:\\\"\\u0000*\\u0000userId\\\";i:1;s:9:\\\"\\u0000*\\u0000output\\\";N;s:9:\\\"\\u0000*\\u0000errors\\\";a:0:{}s:11:\\\"\\u0000*\\u0000failures\\\";a:0:{}}s:45:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\AfterImportJob\\u0000reader\\\";O:24:\\\"Maatwebsite\\\\Excel\\\\Reader\\\":5:{s:14:\\\"\\u0000*\\u0000spreadsheet\\\";N;s:15:\\\"\\u0000*\\u0000sheetImports\\\";a:0:{}s:14:\\\"\\u0000*\\u0000currentFile\\\";O:42:\\\"Maatwebsite\\\\Excel\\\\Files\\\\LocalTemporaryFile\\\":1:{s:52:\\\"\\u0000Maatwebsite\\\\Excel\\\\Files\\\\LocalTemporaryFile\\u0000filePath\\\";s:128:\\\"C:\\\\laragon\\\\www\\\\multi-vendor-e-commerce\\\\storage\\\\framework\\\\cache\\\\laravel-excel\\\\laravel-excel-MUxwgSoOs8ceH0hdGnFQ9T7U5jTzPaRZ.xlsx\\\";}s:23:\\\"\\u0000*\\u0000temporaryFileFactory\\\";O:44:\\\"Maatwebsite\\\\Excel\\\\Files\\\\TemporaryFileFactory\\\":2:{s:59:\\\"\\u0000Maatwebsite\\\\Excel\\\\Files\\\\TemporaryFileFactory\\u0000temporaryPath\\\";s:76:\\\"C:\\\\laragon\\\\www\\\\multi-vendor-e-commerce\\\\storage\\\\framework\\/cache\\/laravel-excel\\\";s:59:\\\"\\u0000Maatwebsite\\\\Excel\\\\Files\\\\TemporaryFileFactory\\u0000temporaryDisk\\\";N;}s:9:\\\"\\u0000*\\u0000reader\\\";O:36:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\\":13:{s:15:\\\"\\u0000*\\u0000readDataOnly\\\";b:1;s:17:\\\"\\u0000*\\u0000readEmptyCells\\\";b:1;s:16:\\\"\\u0000*\\u0000includeCharts\\\";b:0;s:17:\\\"\\u0000*\\u0000loadSheetsOnly\\\";N;s:22:\\\"\\u0000*\\u0000allowExternalImages\\\";b:0;s:13:\\\"\\u0000*\\u0000readFilter\\\";O:49:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\DefaultReadFilter\\\":0:{}s:13:\\\"\\u0000*\\u0000fileHandle\\\";N;s:18:\\\"\\u0000*\\u0000securityScanner\\\";O:51:\\\"PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\\":2:{s:60:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\u0000pattern\\\";s:9:\\\"<!DOCTYPE\\\";s:61:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Security\\\\XmlScanner\\u0000callback\\\";N;}s:53:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000referenceHelper\\\";O:40:\\\"PhpOffice\\\\PhpSpreadsheet\\\\ReferenceHelper\\\":1:{s:61:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\ReferenceHelper\\u0000cellReferenceHelper\\\";N;}s:41:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000zip\\\";O:10:\\\"ZipArchive\\\":6:{s:6:\\\"lastId\\\";i:-1;s:6:\\\"status\\\";i:0;s:9:\\\"statusSys\\\";i:0;s:8:\\\"numFiles\\\";i:0;s:8:\\\"filename\\\";s:0:\\\"\\\";s:7:\\\"comment\\\";s:0:\\\"\\\";}s:49:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000styleReader\\\";N;s:52:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000sharedFormulae\\\";a:0:{}s:47:\\\"\\u0000PhpOffice\\\\PhpSpreadsheet\\\\Reader\\\\Xlsx\\u0000parseHuge\\\";b:0;}}s:52:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\AfterImportJob\\u0000dependencyIds\\\";a:0:{}s:47:\\\"\\u0000Maatwebsite\\\\Excel\\\\Jobs\\\\AfterImportJob\\u0000interval\\\";i:60;s:9:\\\"\\u0000*\\u0000events\\\";a:0:{}s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:12:\\\"messageGroup\\\";N;s:12:\\\"deduplicator\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;}\\\";}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:9:\\\"\\u0000*\\u0000events\\\";a:0:{}s:3:\\\"job\\\";N;}\"},\"createdAt\":1769090563,\"delay\":null}', 'Exception: Vendor not found. Please provide a valid vendor ID or name. in C:\\laragon\\www\\multi-vendor-e-commerce\\app\\Imports\\ProductsImport.php:79\nStack trace:\n#0 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(100): App\\Imports\\ProductsImport->model(Array)\n#1 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(110): Maatwebsite\\Excel\\Imports\\ModelManager->toModels(Object(App\\Imports\\ProductsImport), Array, 2)\n#2 [internal function]: Maatwebsite\\Excel\\Imports\\ModelManager->Maatwebsite\\Excel\\Imports\\{closure}(Array, 2)\n#3 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Arr.php(820): array_map(Object(Closure), Array, Array)\n#4 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Collection.php(846): Illuminate\\Support\\Arr::map(Array, Object(Closure))\n#5 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Collections\\Traits\\EnumeratesValues.php(441): Illuminate\\Support\\Collection->map(Object(Closure))\n#6 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(109): Illuminate\\Support\\Collection->flatMap(Object(Closure))\n#7 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelManager.php(80): Maatwebsite\\Excel\\Imports\\ModelManager->massFlush(Object(App\\Imports\\ProductsImport))\n#8 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(114): Maatwebsite\\Excel\\Imports\\ModelManager->flush(Object(App\\Imports\\ProductsImport), true)\n#9 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Imports\\ModelImporter.php(108): Maatwebsite\\Excel\\Imports\\ModelImporter->flush(Object(App\\Imports\\ProductsImport), 250, 2)\n#10 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Sheet.php(256): Maatwebsite\\Excel\\Imports\\ModelImporter->import(Object(PhpOffice\\PhpSpreadsheet\\Worksheet\\Worksheet), Object(App\\Imports\\ProductsImport), 2)\n#11 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Jobs\\ReadChunk.php(211): Maatwebsite\\Excel\\Sheet->import(Object(App\\Imports\\ProductsImport), 2)\n#12 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Database\\Concerns\\ManagesTransactions.php(35): Maatwebsite\\Excel\\Jobs\\ReadChunk->Maatwebsite\\Excel\\Jobs\\{closure}(Object(Illuminate\\Database\\MySqlConnection))\n#13 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Transactions\\DbTransactionHandler.php(30): Illuminate\\Database\\Connection->transaction(Object(Closure))\n#14 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\maatwebsite\\excel\\src\\Jobs\\ReadChunk.php(210): Maatwebsite\\Excel\\Transactions\\DbTransactionHandler->__invoke(Object(Closure))\n#15 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Maatwebsite\\Excel\\Jobs\\ReadChunk->handle(Object(Maatwebsite\\Excel\\Transactions\\DbTransactionHandler))\n#16 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#17 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#18 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#19 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#20 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(129): Illuminate\\Container\\Container->call(Array)\n#21 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(Maatwebsite\\Excel\\Jobs\\ReadChunk))\n#22 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Maatwebsite\\Excel\\Jobs\\ReadChunk))\n#23 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(133): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#24 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(134): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Maatwebsite\\Excel\\Jobs\\ReadChunk), false)\n#25 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(180): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(Maatwebsite\\Excel\\Jobs\\ReadChunk))\n#26 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(137): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(Maatwebsite\\Excel\\Jobs\\ReadChunk))\n#27 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(127): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#28 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(68): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Maatwebsite\\Excel\\Jobs\\ReadChunk))\n#29 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#30 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(485): Illuminate\\Queue\\Jobs\\Job->fire()\n#31 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(435): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#32 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(201): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#33 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(148): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#34 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(131): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#35 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#36 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#37 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#38 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#39 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(799): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#40 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(211): Illuminate\\Container\\Container->call(Array)\n#41 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Command\\Command.php(341): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#42 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(180): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#43 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(1102): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#44 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(356): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#45 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\symfony\\console\\Application.php(195): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#46 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\laragon\\www\\multi-vendor-e-commerce\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\laragon\\www\\multi-vendor-e-commerce\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#49 {main}', '2026-01-22 12:02:43');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(6, '0001_01_01_000000_create_users_table', 1),
(7, '0001_01_01_000001_create_cache_table', 1),
(8, '0001_01_01_000002_create_jobs_table', 1),
(9, '2026_01_11_095605_create_personal_access_tokens_table', 1),
(10, '2026_01_11_100028_create_permission_tables', 1),
(11, '2026_01_11_124557_create_notifications_table', 2),
(12, '2026_01_11_141610_create_settings_table', 3),
(13, '2026_01_11_163311_create_categories_table', 4),
(14, '2026_01_12_130211_create_plans_table', 5),
(15, '2026_01_12_135549_add_slug_to_categories_table', 6),
(16, '2026_01_12_161042_create_vendors_table', 7),
(17, '2026_01_12_162533_create_vendor_subscriptions_table', 7),
(18, '2026_01_13_125308_create_vendor_users_table', 8),
(19, '2026_01_13_131630_create_category_requests_table', 8),
(20, '2026_01_13_135759_create_variants_table', 9),
(21, '2026_01_13_135856_create_variant_options_table', 9),
(22, '2026_01_13_143158_create_variant_requests_table', 10),
(23, '2026_01_13_144228_create_branches_table', 11),
(25, '2026_01_13_144357_create_products_table', 12),
(26, '2026_01_13_145620_create_product_relations_table', 12),
(27, '2026_01_13_145646_create_category_product_table.', 12),
(28, '2026_01_13_145651_create_product_images_table', 13),
(29, '2026_01_13_145844_create_product_variants_table', 13),
(30, '2026_01_13_150009_create_product_variant_values_table', 13),
(31, '2026_01_13_151212_create_branch_product_stocks_table', 13),
(32, '2026_01_13_151220_create_branch_product_variant_stocks_table', 13),
(33, '2026_01_13_164459_add_thumbnail_to_product_variants_table', 14),
(34, '2026_01_13_170757_remove_stock_from_products_table', 15),
(35, '2026_01_14_113523_create_verifications_table', 16),
(36, '2026_01_15_154722_add_expires_at_to_password_reset_tokens_table', 17),
(37, '2026_01_18_101930_add_user_type_to_vendor_users_table', 18),
(38, '2026_01_18_120717_create_vendor_settings_table', 19),
(39, '2026_01_18_145542_create_favorites_table', 20),
(40, '2026_01_18_145810_create_addresses_table', 20),
(41, '2026_01_18_150006_create_sliders_table', 20),
(42, '2026_01_18_153221_add_is_active_to_addresses_table', 21),
(43, '2026_01_18_155417_create_tickets_table', 22),
(44, '2026_01_18_155427_create_ticket_messages_table', 22),
(46, '2026_01_18_165734_create_cart_items_table', 23),
(52, '2026_01_19_110102_create_coupons_table', 24),
(53, '2026_01_19_111832_add_wallet_to_users_table', 24),
(54, '2026_01_19_112342_create_wallet_transactions_table', 24),
(55, '2026_01_19_112643_create_point_transactions_table', 24),
(56, '2026_01_19_113050_create_orders_table copy', 24),
(57, '2026_01_19_115012_create_vendor_orders_table', 24),
(58, '2026_01_19_115950_create_vendor_order_items_table', 24),
(59, '2026_01_19_175224_add_payment_status_to_orders_table', 25),
(60, '2026_01_20_111524_add_refund_fields_to_orders_table', 25),
(61, '2026_01_20_132014_create_order_logs_table', 26),
(62, '2026_01_20_140401_create_product_ratings_table', 27),
(63, '2026_01_20_140411_create_vendor_ratings_table', 27),
(64, '2026_01_20_140500_create_product_reports_table', 27),
(65, '2026_01_20_140510_create_vendor_reports_table', 27),
(66, '2026_01_20_162810_add_is_visible_to_product_and_vendor_ratings', 28),
(67, '2026_01_21_123017_add_payment_method_and_paid_at_to_orders_table', 29),
(68, '2026_01_21_123031_create_vendor_balance_transactions_table', 29),
(69, '2026_01_21_124126_create_vendor_withdrawals_table', 30),
(71, '2026_01_21_125125_create_order_refund_requests_table', 31),
(72, '2026_01_22_112608_add_performance_indexes_to_tables', 32),
(73, '2026_02_22_000000_create_zones_table', 33),
(74, '2026_02_22_100000_create_deliveries_table', 34),
(75, '2026_02_22_100001_create_delivery_zone_table', 34),
(76, '2026_02_22_110000_add_wallet_to_deliveries_table', 34),
(77, '2026_02_22_120000_create_shifts_table', 34),
(78, '2026_02_22_120001_create_delivery_shift_table', 34),
(79, '2026_02_22_130000_create_delivery_requests_table', 35),
(80, '2026_02_22_140000_add_name_phone_to_delivery_requests', 36),
(81, '2026_02_22_150000_add_ready_for_pickup_to_vendor_orders', 37),
(82, '2026_02_22_150001_add_ready_for_delivery_to_orders', 37),
(83, '2026_02_22_150002_create_delivery_assignments_table', 37),
(84, '2026_02_22_150003_add_shipping_price_per_km_setting', 37),
(85, '2026_02_22_152344_add_max_delivery_wallet_setting', 38),
(86, '2026_02_22_153228_create_delivery_wallet_transactions_table', 39),
(87, '2026_02_23_122826_create_vendor_time_slots_table', 40),
(89, '2026_03_23_145542_add_attachments_to_deliveries_table', 41);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_permissions`
--

INSERT INTO `model_has_permissions` (`permission_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 17),
(11, 'App\\Models\\User', 17),
(12, 'App\\Models\\User', 17),
(13, 'App\\Models\\User', 17),
(14, 'App\\Models\\User', 17),
(16, 'App\\Models\\User', 17),
(27, 'App\\Models\\User', 17),
(1, 'App\\Models\\User', 19),
(2, 'App\\Models\\User', 19),
(4, 'App\\Models\\User', 19),
(5, 'App\\Models\\User', 19),
(11, 'App\\Models\\User', 19),
(12, 'App\\Models\\User', 19),
(13, 'App\\Models\\User', 19),
(14, 'App\\Models\\User', 19),
(16, 'App\\Models\\User', 19),
(27, 'App\\Models\\User', 19),
(1, 'App\\Models\\User', 22),
(2, 'App\\Models\\User', 22),
(3, 'App\\Models\\User', 22),
(4, 'App\\Models\\User', 22),
(5, 'App\\Models\\User', 22),
(11, 'App\\Models\\User', 22),
(12, 'App\\Models\\User', 22),
(13, 'App\\Models\\User', 22),
(14, 'App\\Models\\User', 22),
(15, 'App\\Models\\User', 22),
(16, 'App\\Models\\User', 22),
(26, 'App\\Models\\User', 22),
(27, 'App\\Models\\User', 22);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, 'App\\Models\\User', 1),
(2, 'App\\Models\\User', 2),
(2, 'App\\Models\\User', 3),
(2, 'App\\Models\\User', 4),
(2, 'App\\Models\\User', 8),
(2, 'App\\Models\\User', 9),
(2, 'App\\Models\\User', 10),
(2, 'App\\Models\\User', 11),
(2, 'App\\Models\\User', 12),
(2, 'App\\Models\\User', 13),
(2, 'App\\Models\\User', 14),
(2, 'App\\Models\\User', 15),
(2, 'App\\Models\\User', 16),
(4, 'App\\Models\\User', 17),
(3, 'App\\Models\\User', 18),
(4, 'App\\Models\\User', 19),
(4, 'App\\Models\\User', 22),
(4, 'App\\Models\\User', 23),
(3, 'App\\Models\\User', 24);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('05ee68d8-ea11-4fb9-8582-ed953739dc63', 'App\\Notifications\\VendorWithdrawalStatusUpdatedNotification', 'App\\Models\\User', 16, '{\"withdrawal_id\":3,\"amount\":\"40.00\",\"status\":\"approved\",\"title\":\"Withdrawal Request Approved\",\"message\":\"Your withdrawal request #3 for 40.00 has been approved and processed.\"}', NULL, '2026-01-25 13:15:41', '2026-01-25 13:15:41'),
('0a0b532a-0bd7-44c0-9c39-0845dc6060d3', 'App\\Notifications\\TicketMessageAddedNotification', 'App\\Models\\User', 1, '{\"ticket_id\":6,\"ticket_message_id\":6,\"title\":\"New ticket message\",\"message\":\"New message on ticket #6\",\"sender_type\":\"admin\",\"sender_id\":1}', NULL, '2026-01-25 12:38:33', '2026-01-25 12:38:33'),
('0a96a1de-28bf-4266-a23b-4046f133a07c', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 16, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":10,\"product_variant_id\":null,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:14:33', '2026-03-23 11:14:33'),
('0b711f26-6b16-45d1-adfb-45aebc069123', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":6,\"vendor_order_id\":11,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #11 of order #6 status changed to processing\"}', NULL, '2026-01-21 11:03:10', '2026-01-21 11:03:10'),
('11216a31-bb55-4b47-9cc8-4b1166e4217d', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 23, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":10,\"product_variant_id\":null,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:14:34', '2026-03-23 11:14:34'),
('166013f3-a3b0-43f8-a6b1-9b088c80068a', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":3,\"vendor_order_id\":5,\"status\":\"shipped\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #5 of order #3 status changed to shipped\"}', NULL, '2026-01-25 13:14:37', '2026-01-25 13:14:37'),
('1ca5b895-db9f-4f3f-b356-cacebfd771b4', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 19, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":10,\"product_variant_id\":null,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:14:34', '2026-03-23 11:14:34'),
('2549fd7d-f4aa-4a68-8d38-6146b54bf92c', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":16,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #16 of order #8 status changed to ready_for_pickup\"}', NULL, '2026-02-22 10:56:39', '2026-02-22 10:56:39'),
('30d6c1e3-b429-456f-8e7e-09cde7d32a26', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":14,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #14 of order #8 status changed to processing\"}', NULL, '2026-02-22 11:46:54', '2026-02-22 11:46:54'),
('345a271f-4ae6-42a8-874a-c0028bc28cbf', 'App\\Notifications\\AdminManualNotification', 'App\\Models\\User', 18, '{\"title\":\"Test Notification\",\"message\":\"Test Content\",\"sent_by_admin_id\":1}', NULL, '2026-01-21 10:15:03', '2026-01-21 10:15:03'),
('376d20a1-4799-4aa6-9062-f6945af94cb0', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 4, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":3,\"branch_id\":1,\"product_id\":7,\"product_variant_id\":8,\"quantity\":4,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Variant low stock: Hohos (Variant #8)\"}', NULL, '2026-02-22 10:42:57', '2026-02-22 10:42:57'),
('3b483d7a-3e26-4318-8058-a79a235a9c77', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 1, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":12,\"branch_id\":4,\"product_id\":8,\"product_variant_id\":null,\"quantity\":4,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Test Product (Product #8)\"}', NULL, '2026-02-22 10:42:59', '2026-02-22 10:42:59'),
('43435493-fb53-4b72-93ac-73f251106797', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 1, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":3,\"branch_id\":1,\"product_id\":7,\"product_variant_id\":8,\"quantity\":4,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Variant low stock: Hohos (Variant #8)\"}', NULL, '2026-02-22 10:42:57', '2026-02-22 10:42:57'),
('453215f6-6375-486e-8943-36a63b9b9eb8', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":9,\"vendor_order_id\":18,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #18 of order #9 status changed to ready_for_pickup\"}', NULL, '2026-03-23 11:39:37', '2026-03-23 11:39:37'),
('4748eb59-f8f6-4890-a90d-3ef2c26c43b2', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":10,\"vendor_order_id\":20,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #20 of order #10 status changed to processing\"}', NULL, '2026-03-23 11:19:35', '2026-03-23 11:19:35'),
('4df3d191-aff3-43a4-8825-8ff6161752d8', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 16, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":15,\"product_variant_id\":28,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Variant low stock: El Abd Chocolate Cookies (Variant #28)\"}', NULL, '2026-02-22 10:42:59', '2026-02-22 10:42:59'),
('509839bb-10ae-43bd-ae01-ba90a3572e66', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":16,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #16 of order #8 status changed to processing\"}', NULL, '2026-02-22 10:47:41', '2026-02-22 10:47:41'),
('59937956-d9e2-4fce-9b07-4dc845442066', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 17, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":6,\"product_id\":10,\"product_variant_id\":null,\"quantity\":1,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:11:57', '2026-03-23 11:11:57'),
('5cab9a6a-5c03-4a59-99a0-e44af81a8bcc', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":14,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #14 of order #8 status changed to ready_for_pickup\"}', NULL, '2026-02-22 11:47:00', '2026-02-22 11:47:00'),
('5db2ab36-92dc-4ff0-bfab-e62f0cb05e59', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 23, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":6,\"product_id\":10,\"product_variant_id\":null,\"quantity\":1,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:11:58', '2026-03-23 11:11:58'),
('5ee501d2-9577-422c-9250-5a70467b9778', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":9,\"vendor_order_id\":17,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #17 of order #9 status changed to ready_for_pickup\"}', NULL, '2026-03-23 11:38:49', '2026-03-23 11:38:49'),
('66a9a1ab-08c9-4fab-8c89-4a3f79785c8c', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 1, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":10,\"product_variant_id\":null,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:14:35', '2026-03-23 11:14:35'),
('7f73d1e6-6fb8-479a-a30e-42e64fd6fcb2', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":15,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #15 of order #8 status changed to processing\"}', NULL, '2026-02-22 11:45:51', '2026-02-22 11:45:51'),
('81f8d374-f011-4c42-9c32-05c53f21130e', 'App\\Notifications\\TicketMessageAddedNotification', 'App\\Models\\User', 18, '{\"ticket_id\":6,\"ticket_message_id\":6,\"title\":\"New ticket message\",\"message\":\"New message on ticket #6\",\"sender_type\":\"admin\",\"sender_id\":1}', NULL, '2026-01-25 12:38:33', '2026-01-25 12:38:33'),
('82c1d185-0116-4b91-a167-1699b08f8ffe', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 16, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":6,\"product_id\":10,\"product_variant_id\":null,\"quantity\":1,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:11:56', '2026-03-23 11:11:56'),
('8a2eb80f-1225-4adf-967c-66a2f1de88c4', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 19, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":6,\"product_id\":10,\"product_variant_id\":null,\"quantity\":1,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:11:57', '2026-03-23 11:11:57'),
('8e3d0cb7-1e04-44f7-9318-5f6699aa27ed', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":9,\"vendor_order_id\":18,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #18 of order #9 status changed to processing\"}', NULL, '2026-03-23 11:39:31', '2026-03-23 11:39:31'),
('9ec23c17-9a50-4bc4-8590-904d69330e39', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":8,\"vendor_order_id\":15,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #15 of order #8 status changed to ready_for_pickup\"}', NULL, '2026-02-22 11:46:25', '2026-02-22 11:46:25'),
('9f0f32c9-8905-47f7-b77c-ca3082df8ef6', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 17, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":5,\"product_id\":10,\"product_variant_id\":null,\"quantity\":5,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:14:33', '2026-03-23 11:14:33'),
('a7572c8b-374c-455f-a8e5-299f7861519b', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":10,\"vendor_order_id\":19,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #19 of order #10 status changed to processing\"}', NULL, '2026-03-23 11:20:10', '2026-03-23 11:20:10'),
('b5cacf31-02b5-49f4-b7d5-b0fd6ce54184', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":3,\"vendor_order_id\":5,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #5 of order #3 status changed to processing\"}', NULL, '2026-01-25 13:14:27', '2026-01-25 13:14:27'),
('b63679ac-eafe-4d98-a16e-3daca3769377', 'App\\Notifications\\VendorWithdrawalStatusUpdatedNotification', 'App\\Models\\User', 17, '{\"withdrawal_id\":3,\"amount\":\"40.00\",\"status\":\"approved\",\"title\":\"Withdrawal Request Approved\",\"message\":\"Your withdrawal request #3 for 40.00 has been approved and processed.\"}', NULL, '2026-01-25 13:15:41', '2026-01-25 13:15:41'),
('baabb43e-9a75-4cd2-b456-56187862e465', 'App\\Notifications\\TicketCreatedNotification', 'App\\Models\\User', 1, '{\"ticket_id\":6,\"title\":\"New support ticket\",\"message\":\"Ticket #6 - Test Subject\",\"status\":null,\"ticket_from\":\"user\",\"vendor_id\":null}', NULL, '2026-01-20 14:28:35', '2026-01-20 14:28:35'),
('bd4ed3dd-19a7-4f2a-9c92-bf8e0f59549f', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 1, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":13,\"branch_id\":6,\"product_id\":10,\"product_variant_id\":null,\"quantity\":1,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Nescafe Gold - 190 g (Product #10)\"}', NULL, '2026-03-23 11:11:58', '2026-03-23 11:11:58'),
('cbe2763a-ada8-4079-ad28-af76844f79f3', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":10,\"vendor_order_id\":20,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #20 of order #10 status changed to ready_for_pickup\"}', NULL, '2026-03-23 11:19:40', '2026-03-23 11:19:40'),
('d0fab8df-b262-40f6-bd56-9b8b3d7a8f1c', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":10,\"vendor_order_id\":19,\"status\":\"ready_for_pickup\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #19 of order #10 status changed to ready_for_pickup\"}', NULL, '2026-03-23 11:20:14', '2026-03-23 11:20:14'),
('db5ac76d-f9ce-4396-8f60-6ed22cb1e020', 'App\\Notifications\\AdminManualNotification', 'App\\Models\\User', 18, '{\"title\":\"Test Notification\",\"message\":\"Test Content\",\"sent_by_admin_id\":1}', NULL, '2026-01-21 10:15:04', '2026-01-21 10:15:04'),
('dc7e7c1d-4b69-4d56-9100-166c1804e3b3', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":6,\"vendor_order_id\":11,\"status\":\"shipped\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #11 of order #6 status changed to shipped\"}', NULL, '2026-01-21 11:03:15', '2026-01-21 11:03:15'),
('de516896-9a0c-4fc3-8bfe-bd16e11f37cc', 'App\\Notifications\\VendorWithdrawalStatusUpdatedNotification', 'App\\Models\\User', 19, '{\"withdrawal_id\":3,\"amount\":\"40.00\",\"status\":\"approved\",\"title\":\"Withdrawal Request Approved\",\"message\":\"Your withdrawal request #3 for 40.00 has been approved and processed.\"}', NULL, '2026-01-25 13:15:42', '2026-01-25 13:15:42'),
('dee3b418-4011-4201-bb69-240202a7391c', 'App\\Notifications\\InventoryAlertNotification', 'App\\Models\\User', 15, '{\"type\":\"inventory_alert\",\"level\":\"low\",\"vendor_id\":12,\"branch_id\":4,\"product_id\":8,\"product_variant_id\":null,\"quantity\":4,\"threshold\":10,\"title\":\"Low stock alert\",\"message\":\"Product low stock: Test Product (Product #8)\"}', NULL, '2026-02-22 10:42:58', '2026-02-22 10:42:58'),
('e89a6e16-7b05-4f9d-86c8-0685113db278', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 24, '{\"order_id\":9,\"vendor_order_id\":17,\"status\":\"processing\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #17 of order #9 status changed to processing\"}', NULL, '2026-03-23 11:38:44', '2026-03-23 11:38:44'),
('f145a841-f382-407c-818d-38b3ab7134e7', 'App\\Notifications\\TicketCreatedNotification', 'App\\Models\\User', 1, '{\"ticket_id\":5,\"title\":\"New support ticket\",\"message\":\"Ticket #5 - Test Subject\",\"status\":null,\"ticket_from\":\"user\",\"vendor_id\":null}', NULL, '2026-01-20 11:55:56', '2026-01-20 11:55:56'),
('f26d0868-b478-486a-9c2c-70af06c2be21', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":6,\"vendor_order_id\":11,\"status\":\"delivered\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #11 of order #6 status changed to delivered\"}', NULL, '2026-01-21 11:03:20', '2026-01-21 11:03:20'),
('f936d24e-9971-49e3-bddf-0b84bc1086b6', 'App\\Notifications\\OrderStatusUpdatedNotification', 'App\\Models\\User', 18, '{\"order_id\":6,\"vendor_order_id\":10,\"status\":\"delivered\",\"title\":\"Your order status has been updated\",\"message\":\"Vendor order #10 of order #6 status changed to delivered\"}', NULL, '2026-01-21 11:04:57', '2026-01-21 11:04:57');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `order_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `coupon_id` bigint(20) UNSIGNED DEFAULT NULL,
  `coupon_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total_shipping` decimal(10,2) NOT NULL DEFAULT 0.00,
  `points_discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `wallet_used` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('pending','processing','ready_for_delivery','shipped','delivered','cancelled','refunded') DEFAULT 'pending',
  `payment_status` enum('pending','paid','failed','refunded') NOT NULL DEFAULT 'pending',
  `payment_method` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `vendor_balance_processed_at` timestamp NULL DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `address_id` bigint(20) UNSIGNED DEFAULT NULL,
  `total_commission` decimal(10,2) NOT NULL DEFAULT 0.00,
  `refund_status` varchar(255) NOT NULL DEFAULT 'none',
  `refunded_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `sub_total`, `order_discount`, `coupon_id`, `coupon_discount`, `total_shipping`, `points_discount`, `total`, `wallet_used`, `status`, `payment_status`, `payment_method`, `paid_at`, `vendor_balance_processed_at`, `notes`, `address_id`, `total_commission`, `refund_status`, `refunded_total`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 18, 55.00, 0.00, NULL, 0.00, 25.00, 0.00, 80.00, 0.00, 'pending', 'pending', NULL, NULL, NULL, NULL, 1, 0.00, 'none', 0.00, '2026-01-19 11:57:37', '2026-01-19 11:57:37', NULL),
(2, 18, 960.00, 0.00, NULL, 0.00, 25.00, 0.00, 985.00, 0.00, 'cancelled', 'pending', NULL, NULL, NULL, NULL, 1, 0.00, 'none', 0.00, '2026-01-19 12:52:44', '2026-01-19 13:44:51', NULL),
(3, 18, 971.00, 49.00, NULL, 0.00, 25.00, 0.00, 996.00, 0.00, 'processing', 'paid', 'COD', '2026-01-21 10:35:47', '2026-01-21 10:35:47', NULL, 1, 0.00, 'none', 0.00, '2026-01-19 13:08:22', '2026-01-25 13:14:24', NULL),
(4, 18, 971.00, 49.00, NULL, 0.00, 25.00, 0.00, 947.00, 0.00, 'processing', 'pending', NULL, NULL, NULL, NULL, 1, 0.00, 'none', 0.00, '2026-01-19 13:16:43', '2026-01-20 08:23:26', NULL),
(5, 18, 50.00, 0.00, NULL, 0.00, 0.00, 0.00, 50.00, 0.00, 'pending', 'pending', NULL, NULL, NULL, NULL, 1, 0.00, 'none', 0.00, '2026-01-19 13:50:08', '2026-01-19 13:50:08', NULL),
(6, 18, 971.00, 49.00, NULL, 0.00, 100.00, 0.00, 1022.00, 0.00, 'delivered', 'pending', NULL, NULL, NULL, NULL, 1, 0.00, 'none', 0.00, '2026-01-19 14:54:26', '2026-01-21 11:04:54', NULL),
(7, 18, 971.00, 49.00, 1, 242.75, 100.00, 0.00, 779.25, 0.00, 'refunded', 'refunded', NULL, NULL, NULL, NULL, 1, 0.00, 'refunded', 779.25, '2026-01-19 14:57:29', '2026-01-20 10:54:13', NULL),
(8, 18, 321.00, 54.00, NULL, 0.00, 0.00, 0.00, 292.00, 0.00, 'ready_for_delivery', 'pending', NULL, NULL, NULL, NULL, 2, 0.00, 'none', 0.00, '2026-02-22 10:42:39', '2026-02-22 11:46:58', NULL),
(9, 24, 2164.00, 106.00, NULL, 0.00, 235.00, 0.00, 2293.00, 0.00, 'ready_for_delivery', 'pending', NULL, NULL, NULL, NULL, 3, 0.00, 'none', 0.00, '2026-03-23 11:11:55', '2026-03-23 11:39:35', NULL),
(10, 24, 2164.00, 106.00, NULL, 0.00, 60.00, 0.00, 2118.00, 0.00, 'delivered', 'refunded', 'COD', '2026-03-23 13:24:15', '2026-03-23 13:24:15', NULL, 3, 0.00, 'refunded', 2118.00, '2026-03-23 11:14:31', '2026-03-23 13:37:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_logs`
--

CREATE TABLE `order_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendor_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `from_status` varchar(255) DEFAULT NULL,
  `to_status` varchar(255) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_logs`
--

INSERT INTO `order_logs` (`id`, `order_id`, `vendor_order_id`, `user_id`, `type`, `from_status`, `to_status`, `payload`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 18, 'order_seed', NULL, 'pending', '{\"total\": 80, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(2, 1, 1, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 70, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(3, 1, 2, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 10, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(4, 2, NULL, 18, 'order_seed', NULL, 'cancelled', '{\"total\": 985, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(5, 2, 3, 18, 'vendor_seed', NULL, 'cancelled', '{\"total\": 30, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(6, 2, 4, 18, 'vendor_seed', NULL, 'cancelled', '{\"total\": 955, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(7, 3, NULL, 18, 'order_seed', NULL, 'pending', '{\"total\": 996, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(8, 3, 5, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 946, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(9, 3, 6, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 50, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(10, 4, NULL, 18, 'order_seed', NULL, 'processing', '{\"total\": 947, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(11, 4, 7, 18, 'vendor_seed', NULL, 'processing', '{\"total\": 946, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(12, 4, 8, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 50, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(13, 5, NULL, 18, 'order_seed', NULL, 'pending', '{\"total\": 50, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(14, 5, 9, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 50, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(15, 6, NULL, 18, 'order_seed', NULL, 'pending', '{\"total\": 1022, \"payment_status\": \"pending\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(16, 6, 10, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 1021, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(17, 6, 11, 18, 'vendor_seed', NULL, 'pending', '{\"total\": 50, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(18, 7, NULL, 18, 'order_seed', NULL, 'refunded', '{\"total\": 779.25, \"payment_status\": \"refunded\"}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(19, 7, 12, 18, 'vendor_seed', NULL, 'refunded', '{\"total\": 790.75, \"vendor_id\": 13}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(20, 7, 13, 18, 'vendor_seed', NULL, 'refunded', '{\"total\": 37.5, \"vendor_id\": 2}', '2026-01-20 11:26:43', '2026-01-20 11:26:43'),
(21, 6, 10, 16, 'vendor_status_change', 'pending', 'processing', NULL, '2026-01-20 11:34:14', '2026-01-20 11:34:14'),
(22, 6, 10, 16, 'vendor_status_change', 'processing', 'shipped', NULL, '2026-01-20 11:38:02', '2026-01-20 11:38:02'),
(23, 3, NULL, 18, 'payment_change', 'pending', 'paid', '{\"payment_method\": \"COD\"}', '2026-01-21 10:35:47', '2026-01-21 10:35:47'),
(24, 6, 11, 3, 'vendor_status_change', 'pending', 'processing', NULL, '2026-01-21 11:03:10', '2026-01-21 11:03:10'),
(25, 6, 11, 3, 'vendor_status_change', 'processing', 'shipped', NULL, '2026-01-21 11:03:15', '2026-01-21 11:03:15'),
(26, 6, 11, 3, 'vendor_status_change', 'shipped', 'delivered', NULL, '2026-01-21 11:03:20', '2026-01-21 11:03:20'),
(27, 6, 10, 16, 'order_status_change', 'processing', 'delivered', NULL, '2026-01-21 11:04:54', '2026-01-21 11:04:54'),
(28, 6, 10, 16, 'vendor_status_change', 'shipped', 'delivered', NULL, '2026-01-21 11:04:57', '2026-01-21 11:04:57'),
(29, 3, 5, 16, 'order_status_change', 'pending', 'processing', NULL, '2026-01-25 13:14:24', '2026-01-25 13:14:24'),
(30, 3, 5, 16, 'vendor_status_change', 'pending', 'processing', NULL, '2026-01-25 13:14:27', '2026-01-25 13:14:27'),
(31, 3, 5, 16, 'vendor_status_change', 'processing', 'shipped', NULL, '2026-01-25 13:14:37', '2026-01-25 13:14:37'),
(33, 8, 16, 16, 'order_status_change', 'pending', 'processing', NULL, '2026-02-22 10:47:20', '2026-02-22 10:47:20'),
(34, 8, 16, 16, 'vendor_status_change', 'pending', 'processing', NULL, '2026-02-22 10:47:41', '2026-02-22 10:47:41'),
(35, 8, 16, 16, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-02-22 10:56:39', '2026-02-22 10:56:39'),
(36, 8, 15, 15, 'vendor_status_change', 'pending', 'processing', NULL, '2026-02-22 11:45:51', '2026-02-22 11:45:51'),
(37, 8, 15, 15, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-02-22 11:46:25', '2026-02-22 11:46:25'),
(38, 8, 14, 4, 'vendor_status_change', 'pending', 'processing', NULL, '2026-02-22 11:46:54', '2026-02-22 11:46:54'),
(39, 8, 14, 4, 'order_status_change', 'processing', 'ready_for_delivery', NULL, '2026-02-22 11:46:58', '2026-02-22 11:46:58'),
(40, 8, 14, 4, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-02-22 11:47:00', '2026-02-22 11:47:00'),
(41, 10, 20, 16, 'order_status_change', 'pending', 'processing', NULL, '2026-03-23 11:19:34', '2026-03-23 11:19:34'),
(42, 10, 20, 16, 'vendor_status_change', 'pending', 'processing', NULL, '2026-03-23 11:19:35', '2026-03-23 11:19:35'),
(43, 10, 20, 16, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-03-23 11:19:40', '2026-03-23 11:19:40'),
(44, 10, 19, 3, 'vendor_status_change', 'pending', 'processing', NULL, '2026-03-23 11:20:10', '2026-03-23 11:20:10'),
(45, 10, 19, 3, 'order_status_change', 'processing', 'ready_for_delivery', NULL, '2026-03-23 11:20:12', '2026-03-23 11:20:12'),
(46, 10, 19, 3, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-03-23 11:20:14', '2026-03-23 11:20:14'),
(47, 9, 17, 3, 'order_status_change', 'pending', 'processing', NULL, '2026-03-23 11:38:43', '2026-03-23 11:38:43'),
(48, 9, 17, 3, 'vendor_status_change', 'pending', 'processing', NULL, '2026-03-23 11:38:44', '2026-03-23 11:38:44'),
(49, 9, 17, 3, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-03-23 11:38:49', '2026-03-23 11:38:49'),
(50, 9, 18, 16, 'vendor_status_change', 'pending', 'processing', NULL, '2026-03-23 11:39:31', '2026-03-23 11:39:31'),
(51, 9, 18, 16, 'order_status_change', 'processing', 'ready_for_delivery', NULL, '2026-03-23 11:39:35', '2026-03-23 11:39:35'),
(52, 9, 18, 16, 'vendor_status_change', 'processing', 'ready_for_pickup', NULL, '2026-03-23 11:39:37', '2026-03-23 11:39:37'),
(53, 10, NULL, 20, 'order_status_change', 'ready_for_delivery', 'delivered', '{\"delivery_assignment_id\":1}', '2026-03-23 12:01:24', '2026-03-23 12:01:24'),
(54, 10, NULL, 24, 'payment_change', 'pending', 'paid', '{\"payment_method\":\"COD\"}', '2026-03-23 13:24:15', '2026-03-23 13:24:15');

-- --------------------------------------------------------

--
-- Table structure for table `order_refund_requests`
--

CREATE TABLE `order_refund_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `reason` varchar(255) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `processed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_refund_requests`
--

INSERT INTO `order_refund_requests` (`id`, `order_id`, `user_id`, `status`, `reason`, `details`, `processed_by`, `processed_at`, `created_at`, `updated_at`) VALUES
(1, 10, 24, 'approved', 'test', 'test details', 1, '2026-03-23 13:37:16', '2026-03-23 12:41:06', '2026-03-23 13:37:16');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `email`, `phone`, `token`, `expires_at`, `created_at`) VALUES
(3, 'test@user.com', NULL, '$2y$12$twBtOza3Ij4Ibj6K1Etz6u9ya/W5.NdBTpuumDukF1SkVlM9JVNdO', NULL, '2026-01-21 10:07:57'),
(4, 'test@user.com', '+201234567890', '329056', '2026-01-21 10:22:49', '2026-01-21 10:12:49');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'manage-products', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(2, 'view-products', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(3, 'create-products', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(4, 'edit-products', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(5, 'delete-products', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(6, 'manage-branches', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(7, 'view-branches', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(8, 'create-branches', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(9, 'edit-branches', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(10, 'delete-branches', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(11, 'view-categories', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(12, 'view-variants', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(13, 'create-variant-requests', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(14, 'view-variant-requests', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(15, 'create-category-requests', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(16, 'view-category-requests', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(17, 'view-plans', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(18, 'subscribe-plans', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(19, 'view-subscriptions', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(20, 'cancel-subscriptions', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(21, 'manage-vendor-users', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(22, 'view-vendor-users', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(23, 'create-vendor-users', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(24, 'edit-vendor-users', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(25, 'delete-vendor-users', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(26, 'edit-profile', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(27, 'view-dashboard', 'web', '2026-01-15 10:39:12', '2026-01-15 10:39:12'),
(28, 'view-tickets', 'web', NULL, NULL);

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
(1, 'App\\Models\\User', 18, 'auth-token', 'fbd632b7f4f48b2a5f17fc1be65ba09b9af9da1531708aa984056dc8b886fb55', '[\"*\"]', NULL, NULL, '2026-01-15 12:39:06', '2026-01-15 12:39:06'),
(2, 'App\\Models\\User', 18, 'auth-token', '3cd639fe7b6102a92bde130df86654687cf99f1b0451ed4a2d53f5d1f51cadfb', '[\"*\"]', '2026-02-05 09:54:45', NULL, '2026-01-15 12:40:15', '2026-02-05 09:54:45'),
(3, 'App\\Models\\User', 18, 'auth-token', '2338e4efe22337f513d435594d031ebf3f99a577e550e0d44db3a27d55427b4e', '[\"*\"]', NULL, NULL, '2026-01-15 13:49:47', '2026-01-15 13:49:47'),
(4, 'App\\Models\\User', 18, 'auth-token', '228cff2e920b20508f45ef267716117cebd13bc2e40910a78fb1692171f03abb', '[\"*\"]', '2026-02-05 10:14:41', NULL, '2026-02-05 10:14:26', '2026-02-05 10:14:41'),
(5, 'App\\Models\\User', 18, 'auth-token', 'f0e99cc3b4ad519be803badb390735cedc5397d9245a1e9fc841cc100e42dd19', '[\"*\"]', '2026-02-22 12:28:23', NULL, '2026-02-22 10:39:03', '2026-02-22 12:28:23'),
(6, 'App\\Models\\User', 20, 'auth-token', '56b4ddf68d0b1e85232b5903e848fb1d40db075a8f36bacc7f6dda3f420f8412', '[\"*\"]', '2026-02-23 09:29:55', NULL, '2026-02-22 12:31:07', '2026-02-23 09:29:55'),
(7, 'App\\Models\\User', 20, 'auth-token', '275bbd559997eb551ab7c56fc4250a955c50e57fa068060956c5ce420f53a655', '[\"*\"]', NULL, NULL, '2026-03-23 10:17:17', '2026-03-23 10:17:17'),
(8, 'App\\Models\\User', 20, 'auth-token', 'cac8ed901e176287fe2a20c98900c36cce0e6f6dedda27bd14f8d85524d957db', '[\"*\"]', '2026-03-23 10:20:01', NULL, '2026-03-23 10:17:34', '2026-03-23 10:20:01'),
(9, 'App\\Models\\User', 24, 'auth-token', 'a361fd7c5f7fa47fb22a803285d0f08125116b0f637fa715bc43436c133cd4aa', '[\"*\"]', '2026-03-23 13:24:15', NULL, '2026-03-23 10:19:54', '2026-03-23 13:24:15'),
(10, 'App\\Models\\User', 20, 'auth-token', 'f4a7f0e59d448d65efd9a28f020f1d180fe35f54d0ccbac31c7b9e7fc817a3ca', '[\"*\"]', '2026-03-23 12:01:24', NULL, '2026-03-23 11:21:13', '2026-03-23 12:01:24');

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--

CREATE TABLE `plans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `slug` varchar(255) NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`description`)),
  `price` decimal(10,2) NOT NULL,
  `duration_days` int(11) NOT NULL DEFAULT 1,
  `can_feature_products` tinyint(1) NOT NULL DEFAULT 0,
  `max_products_count` int(11) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `name`, `slug`, `description`, `price`, `duration_days`, `can_feature_products`, `max_products_count`, `is_active`, `is_featured`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '{\"ar\": \"خطة مبدئية\", \"en\": \"Basic Plan\"}', 'basic-plan', '{\"ar\": \"مناسب للبائعين الصغار. ميزات محدودة.\", \"en\": \"Ideal for small vendors. Limited features.\"}', 250.00, 30, 0, 3, 1, 0, '2026-01-12 13:16:34', '2026-01-14 10:32:56', NULL),
(2, '{\"ar\": \"خطة بريميم\", \"en\": \"Premium Plan\"}', 'premium-plan', '{\"ar\": \"مثالي للبائعين المتوسّعين. يشمل خيار المنتجات المميزة.\", \"en\": \"Perfect for growing vendors. Includes featured products option.\"}', 500.00, 30, 1, 35, 1, 1, '2026-01-12 13:19:52', '2026-01-14 10:33:20', NULL),
(3, '{\"ar\": \"خطة برو\", \"en\": \"Pro Blan\"}', 'pro-blan', '{\"ar\": \"الأفضل للبائعين الكبار. منتجات غير محدودة وجميع الميزات متاحة.\", \"en\": \"Best for large vendors. Unlimited products and all features included.\"}', 850.00, 30, 1, NULL, 1, 0, '2026-01-12 13:20:43', '2026-01-14 10:33:35', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `point_transactions`
--

CREATE TABLE `point_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('addition','subtraction') NOT NULL,
  `amount` int(11) NOT NULL,
  `balance_after` int(11) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `point_transactions`
--

INSERT INTO `point_transactions` (`id`, `user_id`, `type`, `amount`, `balance_after`, `notes`, `created_at`, `updated_at`) VALUES
(1, 18, 'addition', 0, 0, 'Order #3', '2026-01-19 13:08:22', '2026-01-19 13:08:22'),
(2, 18, 'addition', 0, 0, 'Order #4', '2026-01-19 13:16:43', '2026-01-19 13:16:43'),
(3, 18, 'addition', 5, 5, 'Cashback for Order #5', '2026-01-19 13:50:08', '2026-01-19 13:50:08'),
(4, 18, 'addition', 102, 107, 'Cashback for Order #6', '2026-01-19 14:54:26', '2026-01-19 14:54:26'),
(5, 18, 'addition', 78, 185, 'Cashback for Order #7', '2026-01-19 14:57:29', '2026-01-19 14:57:29'),
(6, 18, 'subtraction', 5, 180, 'test action by admin', '2026-01-21 10:07:42', '2026-01-21 10:07:42'),
(7, 18, 'addition', 29, 209, 'Cashback for Order #8', '2026-02-22 10:42:39', '2026-02-22 10:42:39'),
(8, 24, 'addition', 229, 229, 'Cashback for Order #9', '2026-03-23 11:11:55', '2026-03-23 11:11:55'),
(9, 24, 'addition', 212, 441, 'Cashback for Order #10', '2026-03-23 11:14:31', '2026-03-23 11:14:31');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('simple','variable') NOT NULL DEFAULT 'simple',
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`description`)),
  `thumbnail` varchar(255) DEFAULT NULL,
  `sku` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `discount_type` enum('percentage','fixed') DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_new` tinyint(1) NOT NULL DEFAULT 0,
  `is_approved` tinyint(1) NOT NULL DEFAULT 1,
  `is_bookable` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `vendor_id`, `type`, `name`, `description`, `thumbnail`, `sku`, `slug`, `price`, `discount`, `discount_type`, `is_active`, `is_featured`, `is_new`, `is_approved`, `is_bookable`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 'simple', '{\"ar\": \"دوريتوس\", \"en\": \"Doritos\"}', '{\"ar\": \"إذا كنت مستعداً للتحدي، فاحصل على كيس من رقائق دوريتوس واستعد للتجربة. إنها تجربة جريئة في عالم الوجبات الخفيفة وأكثر.\", \"en\": \"If youre up to the challenge, grab a bag of DORITOS chips and get ready for the experience. Its a bold experience in snacking and beyond.\"}', 'products/9YrSXTaHJwWGnJ0X1e8F8TBmjC8dwVR1Dw7HmK3V.jpg', 'CH-123', 'doritos', 10.00, 0.00, 'percentage', 1, 0, 0, 1, 0, '2026-01-13 14:53:34', '2026-01-13 14:53:34', NULL),
(6, 2, 'variable', '{\"ar\": \"كاندي\", \"en\": \"Candy\"}', '{\"ar\": \"تُتيح لك حلوى نيردز تجربة حسية مميزة. استمتع بتناولها، أو احتفظ بها في مكتبك لتنشيط نفسك، أو قدمها كحلوى في حفلاتك لإسعاد الصغار والكبار. اختر من بين حلوى نيردز الأصلية، أو نيردز روب، أو نيردز غامي كلاستر، أو نيردز جوسي غامي كلاستر. مع نكهات متنوعة من الحلو إلى اللاذع، جرب جميع الأنواع!\", \"en\": \"candies take you on a sensory adventure. Eat them yourself, keep them at the office for a pick-me-up or as your party candy to make kids and adults happy. Choose from original NERDS candy, NERDS Rope, NERDS Gummy Clusters or our NERDS Juicy Gummy Clusters. With flavors ranging from sweet to tangy, try out all the varieties!\"}', 'products/X02YJZCmx7WvFmSOmdllrpCo7QmYyfrSER1bc5GS.jpg', 'CA-120', 'candy', 0.00, 0.00, 'percentage', 1, 0, 0, 1, 0, '2026-01-13 15:43:07', '2026-01-13 15:43:07', NULL),
(7, 3, 'variable', '{\"ar\": \"هوهوز\", \"en\": \"Hohos\"}', '{\"ar\": \"هوهوز كينج كيك ملفوف شوكولاتة بالكريمة، 60 غرام متوفر ويباع على طلبات عن طريق طلبات مارت، مع خدمة توصيل لكافة أنحاء Egypt وفي أقل من دقيقة. تسوق أونلاين الآن وتمتع بخدمة توصيل البقالة السريعة.\", \"en\": \"HoHo\'s King Cake Chocolate Cream Roll, 60g, is available and sold on Talabat through Talabat Mart, with delivery across Egypt in under a minute. Shop online now and enjoy fast grocery delivery.\"}', 'products/fTOk4dIRNoULDoWjs9NPk9x8VnbXnHJS9EsaCeJi.webp', 'HO-123', 'hohos', 0.00, 0.00, 'percentage', 1, 1, 1, 1, 0, '2026-01-13 16:02:37', '2026-01-13 16:02:37', NULL),
(8, 12, 'simple', '{\"ar\": \"منتج تجريبي\", \"en\": \"Test Product\"}', '{\"ar\": null}', NULL, 'TES-123', 'test-product', 350.00, 15.00, 'percentage', 1, 0, 0, 1, 0, '2026-01-14 12:21:31', '2026-01-15 09:21:28', NULL),
(9, 12, 'simple', '{\"ar\": \"منتج تجريبي 2\", \"en\": \"Test Product 2\"}', '{\"ar\": null}', NULL, 'TES-121', 'test-product-2', 300.00, 10.00, 'percentage', 0, 0, 0, 0, 0, '2026-01-14 12:38:43', '2026-01-14 12:40:48', NULL),
(10, 13, 'simple', '{\"ar\": \"نسكافية جولد 190 جرام\", \"en\": \"Nescafe Gold - 190 g\"}', '{\"ar\": \"نسكافيه جولد 190 جم قهوة فاخرة مصنوعة من أجود أنواع حبوب البن المختارة بعناية،\\r\\nتتميز بمذاق غني وناعم ورائحة مميزة تمنحك تجربة قهوة راقية في كل كوب.\\r\\n\\r\\nسواء كنت تفضلها سادة أو بالحليب، نسكافيه جولد هي الاختيار المثالي لعشاق القهوة المميزة.\", \"en\": \"Nescafé Gold 190g offers a rich, smooth, and aromatic coffee experience made from carefully selected premium coffee beans.\\r\\nIts well-balanced flavor and refined taste make it perfect for coffee lovers who enjoy a high-quality cup every time.\\r\\n\\r\\nWhether you prefer it black or with milk, Nescafé Gold delivers a satisfying and elegant coffee moment.\"}', 'products/Lioc9Z8E4kb9xm5nmyKqKJI4Jg3vMvxJyO6ZWsOZ.webp', 'NS-012', 'nescafe-gold-190-g', 440.00, 20.00, 'fixed', 1, 1, 0, 1, 0, '2026-01-15 10:46:23', '2026-01-15 10:46:42', NULL),
(11, 13, 'variable', '{\"ar\": \"نيدو لبن بودر\", \"en\": \"Nido Powdered Milk\"}', '{\"ar\": \"حليب نيدو المجفف هو خيار مثالي للعائلة، يتميز بطعم غني وقيمة غذائية عالية. غني بالكالسيوم والبروتينات والفيتامينات الأساسية التي تساعد على تقوية العظام ودعم النمو الصحي. يمكن استخدامه في تحضير المشروبات الساخنة، الحلويات، أو إضافته للوصفات اليومية بسهولة.\", \"en\": \"Nido Powdered Milk is a nutritious and delicious choice for the whole family. It is rich in calcium, protein, and essential vitamins that support strong bones and healthy growth. Perfect for hot drinks, desserts, or everyday recipes, Nido offers a creamy taste and easy preparation.\"}', 'products/dLRFQznTyk26GnNgafkCdZDfpjXUNbRM4R1sUdon.webp', 'MI-120', 'nido-powdered-milk', 0.00, 10.00, 'percentage', 1, 1, 0, 1, 0, '2026-01-18 10:37:46', '2026-01-18 11:06:47', NULL),
(14, 13, 'simple', '{\"ar\": \"العبد كوكيز شانكس بالشوكولاتة - 18 قطعة\", \"en\": \"El Abd Chunks Chocolate Cookies - 18 Pieces\"}', '{\"ar\": \"استمتع بالمذاق الغني لـ كوكيز العبد بقطع الشوكولاتة، المخبوزة بعناية والمليئة بقطع الشوكولاتة اللذيذة في كل قضمة. تتميز بقوام مقرمش من الخارج وطري من الداخل، مما يجعلها خيارًا مثاليًا للمشاركة مع العائلة والأصدقاء.\", \"en\": \"Enjoy the rich taste of El Abd Chunks Chocolate Cookies, baked to perfection with generous chocolate chunks in every bite. These delicious cookies offer a crispy texture on the outside and a soft, flavorful inside, making them perfect for sharing with family and friends.\"}', 'products/yfGooOAVAwq61Dj0dc6A95xQsRoFZ5rpKVG6BOoZ.jpg', 'PRD-101', 'el-abd-chunks-chocolate-cookies-18-pieces', 100.00, 5.00, 'fixed', 1, 0, 1, 1, 0, '2026-01-22 12:10:01', '2026-01-22 12:10:02', NULL),
(15, 13, 'variable', '{\"ar\": \"العبد كوكيز بالشوكولاتة\", \"en\": \"El Abd Chocolate Cookies\"}', '{\"ar\": \"استمتع بالمذاق الغني لـ كوكيز العبد الشوكولاتة، المخبوزة بعناية والمليئة بقطع الشوكولاتة اللذيذة في كل قضمة. تتميز بقوام مقرمش من الخارج وطري من الداخل، مما يجعلها خيارًا مثاليًا للمشاركة مع العائلة والأصدقاء.\", \"en\": \"Enjoy the rich taste of El Abd Chocolate Cookies, baked to perfection with generous chocolate in every bite. These delicious cookies offer a crispy texture on the outside and a soft, flavorful inside, making them perfect for sharing with family and friends.\"}', 'products/Yyvqrv2ABVRy3dxpkHTdNQBL49p6blPdKD9nSnuM.jpg', 'PRD-103', 'el-abd-chocolate-cookies', 0.00, 10.00, 'percentage', 1, 0, 1, 1, 0, '2026-01-22 12:20:40', '2026-03-23 11:22:36', NULL),
(16, 13, 'variable', '{\"en\":\"Clark Houston\",\"ar\":\"Shaine Townsend\"}', '{\"en\":\"Cupidatat assumenda\",\"ar\":\"Qui officia asperior\"}', 'products/CTRkxB8U3AR3t3FXK3ul0syDZbHNYY5fnYGEPE9Z.png', 'Voluptatem Cupidata', 'Totam et occaecat ul', 0.00, 0.00, 'percentage', 1, 1, 1, 0, 1, '2026-03-23 11:23:57', '2026-03-23 11:23:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `imageable_id` bigint(20) UNSIGNED NOT NULL,
  `imageable_type` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `imageable_id`, `imageable_type`, `path`, `created_at`, `updated_at`) VALUES
(3, 1, 'App\\Models\\Product', 'products/ZTwlBkIlqy7rrsss0Xo0cc17vU3qDRpXjDF3tSjV.jpg', '2026-01-13 15:18:10', '2026-01-13 15:18:10'),
(4, 1, 'App\\Models\\Product', 'products/1wa5bUFu5j7jR5pzsj3SpvTH60DiFVW1QTr25bh2.webp', '2026-01-13 15:18:10', '2026-01-13 15:18:10'),
(13, 6, 'App\\Models\\Product', 'products/WTXhI7DMnWhivXKaRbYijdmxRmNfaDsuYH2mPRDH.jpg', '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(14, 6, 'App\\Models\\Product', 'products/6FksgnhInLKxZv55hw7qTPbncwOAMmq6hSsKPVsa.jpg', '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(15, 7, 'App\\Models\\Product', 'products/yIMkex3QrGPuzfhPWwP4txM5uID7lZ10TRKSs1mn.jpg', '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(16, 7, 'App\\Models\\Product', 'products/spIGPU3rxuHwZpeEROqvbmzabEiKUtsGCEerMdgT.webp', '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(17, 10, 'App\\Models\\Product', 'products/CafzXMUr04u4p6XTXRRmylRSC45mPtk684rGaQ1Z.webp', '2026-01-15 10:46:23', '2026-01-15 10:46:23'),
(18, 10, 'App\\Models\\Product', 'products/x5nWxsnFnB4VZjae6Vae0tmB3Gvwowf1M9SFUUGi.webp', '2026-01-15 10:46:23', '2026-01-15 10:46:23'),
(51, 11, 'App\\Models\\Product', 'products/ht6PLvdIjgBBNUhvMST4wK1039d8oRslKASJmh9p.webp', '2026-01-18 11:24:25', '2026-01-18 11:24:25'),
(53, 11, 'App\\Models\\Product', 'products/7iPGhfFcRAohusghVd03HomwLXBcsZOcARf4kPAv.webp', '2026-01-18 11:24:25', '2026-01-18 11:24:25'),
(54, 11, 'App\\Models\\Product', 'products/m46IwYDG177gxRYs3FBLpooU12Zwj4kX5jy4hgW7.webp', '2026-01-18 11:24:25', '2026-01-18 11:24:25'),
(55, 11, 'App\\Models\\Product', 'products/Nqk1GuhUWNDtmK29xhQ8cwCEgSoAKJlcsaiEPK2e.webp', '2026-01-18 11:24:25', '2026-01-18 11:24:25'),
(56, 11, 'App\\Models\\Product', 'products/OFQg29hi6BUYLZXjiKy2ip3RbknuL1l5JCNMO5ub.webp', '2026-01-18 11:25:00', '2026-01-18 11:25:00'),
(57, 12, 'App\\Models\\Product', 'products/HdJ1MX3T9G6qOdrIosWnhnnMSHt5dZ95mpcVJVQB.jpg', '2026-01-22 12:03:51', '2026-01-22 12:03:51'),
(58, 13, 'App\\Models\\Product', 'products/RsqWZA7vXZZZdgRQhpnf9KxUIu3VEjuBzcG2XSYo.jpg', '2026-01-22 12:07:55', '2026-01-22 12:07:55'),
(59, 14, 'App\\Models\\Product', 'products/1BPC6QnMogXzUVa1hF9z4ZOUpEQGRmePQVWMNQO7.jpg', '2026-01-22 12:10:03', '2026-01-22 12:10:03'),
(60, 14, 'App\\Models\\Product', 'products/tB2eubuO2s0iUEtFXSsCKmkRBiuMGzsAmhf9GPPv.webp', '2026-01-22 12:15:36', '2026-01-22 12:15:36'),
(61, 15, 'App\\Models\\Product', 'products/J4Jnrm9ZltrU1sB0023XxhbsqQxhEnQbx0kZBoEw.jpg', '2026-01-22 12:20:41', '2026-01-22 12:20:41'),
(62, 15, 'App\\Models\\Product', 'products/rNDh49frgMpMhrKUcjeV46X4d4FsDJtJk3nFD5Qo.jpg', '2026-01-22 12:20:41', '2026-01-22 12:20:41'),
(63, 15, 'App\\Models\\Product', 'products/iZfgKzRxtPo7lBdPmnZt5N7BiNUMPdyzJsMonXRa.jpg', '2026-01-22 12:20:42', '2026-01-22 12:20:42'),
(72, 15, 'App\\Models\\Product', 'products/QDKHQIPqDI0RlnhvDFBCWObpKA9BZgf6Qo8oQbRn.webp', '2026-01-22 12:57:15', '2026-01-22 12:57:15');

-- --------------------------------------------------------

--
-- Table structure for table `product_ratings`
--

CREATE TABLE `product_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `comment` text DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_ratings`
--

INSERT INTO `product_ratings` (`id`, `product_id`, `user_id`, `rating`, `comment`, `is_visible`, `created_at`, `updated_at`) VALUES
(1, 11, 18, 3, 'Great Product', 1, '2026-01-20 14:10:44', '2026-01-20 14:38:35');

-- --------------------------------------------------------

--
-- Table structure for table `product_relations`
--

CREATE TABLE `product_relations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `related_product_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('related','cross_sell','up_sell','upsell') NOT NULL DEFAULT 'related',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_relations`
--

INSERT INTO `product_relations` (`id`, `product_id`, `related_product_id`, `type`, `created_at`, `updated_at`) VALUES
(1, 6, 1, 'related', '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(26, 15, 14, 'related', '2026-01-22 15:25:11', '2026-01-22 15:25:11'),
(27, 15, 14, 'cross_sell', '2026-01-22 15:25:11', '2026-01-22 15:25:11'),
(28, 15, 14, 'upsell', '2026-01-22 15:25:11', '2026-01-22 15:25:11'),
(29, 16, 11, 'related', '2026-03-23 11:23:57', '2026-03-23 11:23:57'),
(30, 16, 14, 'related', '2026-03-23 11:23:57', '2026-03-23 11:23:57'),
(31, 16, 15, 'related', '2026-03-23 11:23:57', '2026-03-23 11:23:57'),
(32, 16, 10, 'cross_sell', '2026-03-23 11:23:57', '2026-03-23 11:23:57'),
(33, 16, 11, 'cross_sell', '2026-03-23 11:23:57', '2026-03-23 11:23:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_reports`
--

CREATE TABLE `product_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `handled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `handled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_reports`
--

INSERT INTO `product_reports` (`id`, `product_id`, `user_id`, `reason`, `description`, `status`, `handled_by`, `handled_at`, `created_at`, `updated_at`) VALUES
(1, 1, 18, 'Expired Product', 'I bought this product and it arrived expired.', 'reviewed', 1, '2026-01-20 14:42:20', '2026-01-20 14:12:07', '2026-01-20 14:42:20'),
(2, 7, 18, 'Expired Product', 'I bought this product and it arrived expired.', 'ignored', 1, '2026-01-20 14:42:13', '2026-01-20 14:42:02', '2026-01-20 14:42:13');

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `sku` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) DEFAULT NULL,
  `discount_type` enum('percentage','fixed') NOT NULL DEFAULT 'percentage',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `name`, `sku`, `slug`, `thumbnail`, `price`, `discount`, `discount_type`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(4, 6, '{\"ar\": \"كاندي بالبطيخ صغيرة\", \"en\": \"Watermelon Candy S\"}', 'CA-120-red-s', 'watermelon-candy-s', 'products/variants/J7J12Ma1YFYH8GlgLNgbBAJm85ovIRgXr2iemS80.jpg', 45.00, NULL, 'percentage', 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07', NULL),
(5, 6, '{\"ar\": \"كاندي بالبطيخ وسط\", \"en\": \"Watermelon Candy M\"}', 'CA-120-red-m', 'watermelon-candy-m', 'products/variants/tVGsahmlx79qGfUf1qsRBxnQcSNtxuzXJVZ6Sh88.jpg', 60.00, NULL, 'percentage', 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07', NULL),
(6, 6, '{\"ar\": \"كاندي بالتفاح الاخضر صغيرة\", \"en\": \"Green Apple Candy S\"}', 'CA-120-green-s', 'green-apple-candy-s', 'products/variants/fkNHWPxVP1ljp00pXiu2TqMYHwiKpVPh8Kso8FlF.jpg', 45.00, NULL, 'percentage', 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07', NULL),
(7, 6, '{\"ar\": \"كاندي بالتفاح الاخضر وسط\", \"en\": \"Green Apple Candy M\"}', 'CA-120-green-m', 'green-apple-candy-m', 'products/variants/4z2vw7xXiFaOJU1yqJizE3SnNNVodP4PEgRtinq6.jpg', 60.00, NULL, 'percentage', 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07', NULL),
(8, 7, '{\"ar\": \"هوهوز بالشيكولاتة صغيرة\", \"en\": \"Chocolate Hohos  S\"}', 'HO-123-red-s', 'chocolate-hohos-s', 'products/variants/JqJxLtlYzAp2l9PgBIDHbGbvUVtFSdDkQr91V3d6.webp', 10.00, NULL, 'percentage', 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37', NULL),
(9, 7, '{\"ar\": \"هوهوز بالشيكولاتة وسط\", \"en\": \"Chocolate Hohos  M\"}', 'HO-123-red-m', 'chocolate-hohos-m', 'products/variants/9NcrtLYKxT8KS8c1dgJRcHkwjP3oyxSM7keVrE4d.webp', 15.00, NULL, 'percentage', 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37', NULL),
(10, 7, '{\"ar\": \"هوهوز بالقهوة صغيرة\", \"en\": \"Coffee Hohos  S\"}', 'HO-123-green-s', 'coffee-hohos-s', 'products/variants/ZPTQ4yE8KJkbQ0VC8zG1y624D3wCXnn92Yp9Tn4W.jpg', 10.00, NULL, 'percentage', 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37', NULL),
(11, 7, '{\"ar\": \"هوهوز بالقهوة وسط\", \"en\": \"Coffee Hohos  M\"}', 'HO-123-green-m', 'coffee-hohos-m', 'products/variants/r45Xj222MOG4HfSLq4viLI8AXIc4oTOPuknKd6P9.jpg', 15.00, NULL, 'percentage', 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37', NULL),
(12, 11, '{\"ar\": \"نيدو لبن بودر 100 جم\", \"en\": \"Nido Powdered Milk 100g\"}', 'MI-120-s', 'nido-powdered-milk-100g', 'products/variants/SeoVR3Tk4WrL2AgLIPDgITi4tCOK29FvXT4qQgAX.webp', 45.00, NULL, 'percentage', 1, '2026-01-18 10:37:46', '2026-01-18 11:06:30', NULL),
(13, 11, '{\"ar\": \"نيدو لبن بودر 500 جم\", \"en\": \"Nido Powdered Milk 500g\"}', 'MI-120-m', 'nido-powdered-milk-500g', 'products/variants/MD493smL9EOOHrBgUW8wCyAGNYxG3q9dwJRktNNM.webp', 220.00, NULL, 'percentage', 1, '2026-01-18 10:37:46', '2026-01-18 11:06:30', NULL),
(14, 11, '{\"ar\": \"نيدو لبن بودر 900 + 100 جم\", \"en\": \"Nido Powdered Milk 900+100 g\"}', 'MI-120-l', 'nido-powdered-milk-900100-g', 'products/variants/I9L8SMfqhR7UbctCgjqOzL8iqGBIqMbl28ACr4TO.webp', 400.00, NULL, 'percentage', 1, '2026-01-18 10:37:46', '2026-01-18 11:06:30', NULL),
(28, 15, '{\"ar\": \"كوكيز شوكولاتة العبد - 2 قطعة\", \"en\": \"El Abd Chocolate Cookies - 2 Pieces\"}', 'PRD-103-s', 'el-abd-chocolate-cookies-2-pieces', 'products/variants/dEkSdxdiZMKVKc4dt6NBtvq3VFOerMOULd9XTotQ.webp', 15.00, NULL, 'percentage', 1, '2026-01-22 14:58:04', '2026-01-22 15:25:11', NULL),
(29, 15, '{\"ar\": \"كوكيز شوكولاتة العبد - 6 قطعة\", \"en\": \"El Abd Chocolate Cookies - 6 Pieces\"}', 'PRD-103-m', 'el-abd-chocolate-cookies-6-pieces', 'products/variants/IwpCAnKmewPcvJdsV8r7ShouOqYX7Vf8NZYkTxNQ.webp', 25.00, NULL, 'percentage', 1, '2026-01-22 14:58:04', '2026-01-22 15:25:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_variant_values`
--

CREATE TABLE `product_variant_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `product_variant_id` bigint(20) UNSIGNED NOT NULL,
  `variant_option_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_variant_values`
--

INSERT INTO `product_variant_values` (`id`, `product_variant_id`, `variant_option_id`, `created_at`, `updated_at`) VALUES
(1, 4, 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(2, 4, 4, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(3, 5, 1, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(4, 5, 5, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(5, 6, 2, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(6, 6, 4, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(7, 7, 2, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(8, 7, 5, '2026-01-13 15:43:07', '2026-01-13 15:43:07'),
(9, 8, 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(10, 8, 4, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(11, 9, 1, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(12, 9, 5, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(13, 10, 2, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(14, 10, 4, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(15, 11, 2, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(16, 11, 5, '2026-01-13 16:02:37', '2026-01-13 16:02:37'),
(17, 12, 4, '2026-01-18 10:37:46', '2026-01-18 10:37:46'),
(18, 13, 5, '2026-01-18 10:37:46', '2026-01-18 10:37:46'),
(19, 14, 6, '2026-01-18 10:37:46', '2026-01-18 10:37:46'),
(22, 28, 4, '2026-01-22 15:25:11', '2026-01-22 15:25:11'),
(23, 29, 5, '2026-01-22 15:25:11', '2026-01-22 15:25:11');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2026-01-11 10:44:25', '2026-01-11 10:44:25'),
(2, 'vendor', 'web', '2026-01-11 10:44:25', '2026-01-11 10:44:25'),
(3, 'user', 'web', '2026-01-11 10:44:25', '2026-01-11 10:44:25'),
(4, 'vendor_employee', 'web', '2026-01-11 10:44:25', '2026-01-11 10:44:25');

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('1O3h8Zxz0ynLXqv6TkvBT5t9ZqSnfbOqIeVHU9tH', NULL, '74.7.241.58', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaVFZSzBVM1dDa0gwclFSVnhGS0doak54VFZSVFA3SGdHUGNCcmRtQyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzU6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZS9wcmljaW5nIjtzOjU6InJvdXRlIjtzOjE1OiJsYW5kaW5nLnByaWNpbmciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjY6ImxvY2FsZSI7czoyOiJlbiI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9fQ==', 1775435108),
('4nLzULbUx8RFpJgQEk3SKCGh7xWTYCgzJ0pJzLej', NULL, '41.41.21.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY2s3Zk15c2VEQTlsZVVsNnAzYllTYTM0U2lpdnZtRDJZYlZXUUFNSSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZS9sb2dpbiI7czo1OiJyb3V0ZSI7czo1OiJsb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775065330),
('7iU6HL843W20PqPvDQ4mGpwMFf7RxN73LimeTdpH', NULL, '74.7.243.223', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZElIbXF1clZJOGtGNnRjcG5sZmd1VW1HbmpuYkhhTEM1UzBZMDF0WSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDc6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUvdmVuZG9yL3JlZ2lzdGVyIjtzOjU6InJvdXRlIjtzOjE1OiJ2ZW5kb3IucmVnaXN0ZXIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775583971),
('a37AVCL64rw11GHt0Md8sGLhnCOEgMf5eyNxPp6P', NULL, '206.189.20.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSDJyS0l4SUwwUUlBWkVzMm1CRVBVcjJjaHh3UFlZNHg4c083aDZtUCI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775726651),
('AU3iZ9PviQGnuxjB9zsbwMtM7scwBACZg0ibffL0', NULL, '92.118.39.126', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) SecurityScanner/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYUlZSVNrd1JjMEkwc2lwRW1WU21QYzhod1BINTBuSVd3TENuNm1lQSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775114436),
('ExXqU0rF5ImV9Tqkgm2R9hIEOjDm8a3R2jyX41Em', NULL, '195.178.110.64', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieEpReml0cW5RVnozSkVnQTR2dkowWG5USnIxdUlvY2x3UGZxS0xWZyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775392711),
('GQxoNyJ5V8uZ5ytyOjOeUMwooWDPmuVVsgbIjB8b', NULL, '205.210.31.39', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU21RSTB2ZkczUjJUNzNJRmJPazR2MFdhV0k2Wm9OS1Q5YnFaRFN3byI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly93d3cuemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775572584),
('iKuriz8w0gB1VgTi2JFuR34Uo57EyzcbK1NegwjG', NULL, '167.94.146.57', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZ3ZXYktsc1Z0VUxaZ1VpMER6M0g5WlZHZTVKYnM5a1pqZjQ2Tm9SUSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775636175),
('J5xRb3vbCuVXnm4TaVb10UQtxSPjL9Z02oTlmcIH', NULL, '156.204.59.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiek5QWG1aWkRTYkFncmRlbjNINXo0U3dvd210emhSQXdnMVNoT016ZSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly96ZXcuYmFja2VuZHByby5zaXRlIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775662639),
('j6hQySxkTNrT5RCosgS4loEIUMYQyFCh92hjYHIL', NULL, '44.250.145.68', 'Mozilla/5.0 (compatible; wpbot/1.4; +https://forms.gle/ajBaxygz9jSR8p8G9)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZTRRVnNpdDJJNW9RbmgwWjZtWDMybGNjbzVSVWM3NWxxaFlXelhFNCI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775690273),
('jodqUi60yChwy1CXSl6dd8T6dT2avUjTZom2bRgX', NULL, '167.94.146.57', 'Mozilla/5.0 (compatible; CensysInspect/1.1; +https://about.censys.io/)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZjRHalBubG5YQjZybUFUcTFmWmFNbnlwOGU1ZWRQVXZFZ3BpTlZQTyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775636192),
('KN4OBhVtPVHw5F4PulJjotT3pZO57E610k2FjXQ6', NULL, '92.118.39.126', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) SecurityScanner/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiUmZLVDhmOUcyVU5OY2xYaGxRVjh2ekxURm9aQ0FjS3BjZEVNck5KUyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775114436),
('Ku0nsA3N9vtHHCXFgLiPJDgNgqPP3OVEoTkn2aaz', NULL, '204.76.203.25', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.3', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidE5sMHRNNmYyMlM3Q2ZTT1RBaE1JNkpIWG9aS1dpUzZzZ0JValkzUiI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775355150),
('lw5JWHoBjGtInS070eulWi7MbTCV8D16Rv36h5S9', NULL, '3.18.186.238', 'visionheight.com/scan Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQWJLS0VqN1ZEVGFUZlpUbkd3MDFVWW9BcU1Kdktza0hrNzBvTWRObSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly96ZXcuYmFja2VuZHByby5zaXRlIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775470221),
('m6RIJ9sB25eorVUmOFvUgfnVWCo2GiUevw1VYwBX', NULL, '18.235.110.182', 'RecordedFuture Global Inventory Crawler', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVFM2T1owbXF4Yjg2S1pZeTF5aWZRMXhRUGp6aXdRaE1lVzNsUXlwZSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775544222),
('mCCfuS7TKS0bGnSEAf3csDu1gJ20yaT7qCnN8yxF', 1, '156.204.59.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiMzVEczlzbjE1emQxNWJ3NnpyN3pkZkZ1cE0xcjlNREVjaWZKR2kzUCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjQ2OiJodHRwczovL3pldy5iYWNrZW5kcHJvLnNpdGUvYWRtaW4vem9uZXMvY3JlYXRlIjtzOjU6InJvdXRlIjtzOjE4OiJhZG1pbi56b25lcy5jcmVhdGUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjI6IlBIUERFQlVHQkFSX1NUQUNLX0RBVEEiO2E6MDp7fX0=', 1775646690),
('mKAkGwdWSnadsAmMVeOnMThTvHCWZHmFuB5HtaQM', NULL, '41.41.117.61', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoibmlPZ1YzTFFNMXF1ZTFIMFhEcnJ3WlJkaUx5YllMSDhPVWw2TkxJNiI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1776853064),
('oArB9y6TQA4id6FSxxdFtM4LjjBxKDAesgKed0zh', 16, '156.204.115.253', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiQ3JFd3BLNmp1VTdWakNxWHpseVdza0RDa2cwM3NIRDE2V0U0eGYzRiI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjQ5OiJodHRwczovL3pldy5iYWNrZW5kcHJvLnNpdGUvYWRtaW4vcHJvZHVjdHMvaW1wb3J0IjtzOjU6InJvdXRlIjtzOjIxOiJhZG1pbi5wcm9kdWN0cy5pbXBvcnQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxNjtzOjIyOiJQSFBERUJVR0JBUl9TVEFDS19EQVRBIjthOjA6e319', 1775065860),
('oXQWrO05GV6DaIjvUWyR8tqDxKe4jTve3uqzJoby', 1, '41.41.21.7', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoib3lkMUxmdmQ3amIzZU1jUktuM2xzYVB3bmQ5eVZOT1JRRzVTSTEwTyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZS9hZG1pbi92YXJpYW50cyI7czo1OiJyb3V0ZSI7czoyMDoiYWRtaW4udmFyaWFudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjI6IlBIUERFQlVHQkFSX1NUQUNLX0RBVEEiO2E6MDp7fX0=', 1775075287),
('P2lJukYWwYsVEfzmChLkMGUKoHfRId9xpeyE6yNS', NULL, '74.7.227.150', 'Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; GPTBot/1.3; +https://openai.com/gptbot)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR1ZUWGkzdWViWDlUQUt4SUpFZ25yMWRSMnZ2NXJiM20xbll0Q1hsbCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo2OiJsb2NhbGUiO3M6MjoiZW4iO30=', 1775585728),
('rNH1Bc17EnaaEc6gkCJmdqoWIc3oHNUZwNGjBkck', NULL, '205.210.31.41', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZmpVdWVRZ0JnemkwVnpiNnZXcHB6MUtRSlJYbm12ZzhIaHF3TVpSUyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly96ZXcuYmFja2VuZHByby5zaXRlIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775286653),
('Rozo6quvVAQNSO1aKX04pryejzR95rSSgW73Ned2', NULL, '156.204.59.76', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYkwyRHZOcUJieHVmcmJIbXhDTUx2cUM0QzlHQmlVdWl6RVVEY2lVViI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDM6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZS92ZW5kb3IvcmVnaXN0ZXIiO3M6NToicm91dGUiO3M6MTU6InZlbmRvci5yZWdpc3RlciI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775473535),
('TEBbTkRG55Fd9IrHRtoo6Vkwhtgt0hftD73CIdUn', NULL, '206.189.20.212', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWUhzRzkzS1hxWXpqelNDUUpFMlNGWTVtTDJZU0ZKNU5GMkgzRHhtZyI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly96ZXcuYmFja2VuZHByby5zaXRlIjtzOjU6InJvdXRlIjtzOjk6ImRhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1775726650),
('WNP4DaAZS3MzgxheTJOmDIh3n0Fw843hf4LRMzIL', 1, '102.44.163.199', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoid05ZOTVvRjNJVkkzMkhpOUh1MGh0RUdhS0pyZDZma0lkaUY0Z0g5OCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDI6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZS9hZG1pbi92YXJpYW50cyI7czo1OiJyb3V0ZSI7czoyMDoiYWRtaW4udmFyaWFudHMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjI6IlBIUERFQlVHQkFSX1NUQUNLX0RBVEEiO2E6MDp7fX0=', 1776521000),
('Zleaqg9VtFkVTZ8blkgXYIqLb1UOH06ok07iY3Tf', NULL, '198.235.24.37', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiR2VFZEZIUHNHeVZxZ1RkcDNDMU8wWkRoVjhCbnkzR2J5SUNKaGJHNSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vemV3LmJhY2tlbmRwcm8uc2l0ZSI7czo1OiJyb3V0ZSI7czo5OiJkYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1775454014),
('ZwNE6P50uP4bDz2lxt0Y7oMcKo1G0fw2kqG1s8wU', NULL, '198.235.24.19', 'Hello from Palo Alto Networks, find out more about our scans in https://docs-cortex.paloaltonetworks.com/r/1/Cortex-Xpanse/Scanning-activity', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicGV2RnNPU1NoTUxDUFhlQWVvaUxkUm9ydXVrTVNMWnRGZ1JuMWNyeSI7czoyMjoiUEhQREVCVUdCQVJfU1RBQ0tfREFUQSI7YTowOnt9czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzE6Imh0dHBzOi8vd3d3Lnpldy5iYWNrZW5kcHJvLnNpdGUiO3M6NToicm91dGUiO3M6OToiZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1775649785);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` enum('string','number','boolean','image') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `created_at`, `updated_at`) VALUES
(1, 'app_name', 'Zew', 'string', '2026-01-11 12:23:03', '2026-01-25 11:59:48'),
(2, 'app_logo', 'settings/FtzkBtvL5StDe8LhqFVOmkJG8VPDQ57GhYrCwK6D.jpg', 'image', '2026-01-11 12:23:14', '2026-01-11 14:18:43'),
(3, 'app_icon', 'settings/BXPoHAUDV7tHZzlJIJRx7u5jsBSPzwp2EhvsQKz9.jpg', 'image', '2026-01-11 12:23:20', '2026-01-11 14:18:43'),
(4, 'profit_type', 'commission', 'string', '2026-01-11 12:41:59', '2026-03-23 11:18:27'),
(5, 'profit_value', '1', 'number', '2026-01-11 12:42:20', '2026-03-23 11:18:27'),
(6, 'currency', 'EGP', 'string', '2026-01-11 12:42:20', '2026-01-11 14:21:41'),
(7, 'referral_points', '50', 'number', '2026-01-11 12:42:20', '2026-01-15 08:15:55'),
(8, 'cache_back_points_rate', '10', 'number', '2026-01-11 12:42:20', '2026-01-19 10:42:41'),
(9, 'shipping_price_per_km', '5', 'number', '2026-02-22 10:38:03', '2026-02-22 10:38:03'),
(10, 'max_delivery_wallet', '10000', 'number', '2026-02-22 13:25:36', '2026-02-22 13:27:07');

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `capacity` smallint(5) UNSIGNED NOT NULL COMMENT 'Max number of deliveries in this shift',
  `name` varchar(255) DEFAULT NULL COMMENT 'e.g. Morning, Evening',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `date`, `start_time`, `end_time`, `capacity`, `name`, `created_at`, `updated_at`) VALUES
(1, '2026-02-22', '10:00:00', '17:00:00', 5, 'Morning', '2026-02-22 09:07:17', '2026-02-22 09:07:17'),
(2, '2026-02-22', '18:00:00', '23:59:00', 5, 'Night', '2026-02-22 09:08:02', '2026-02-22 09:08:02'),
(3, '2026-02-26', '06:00:00', '14:00:00', 6, 'Morning', '2026-02-25 14:28:06', '2026-02-25 14:28:06');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `image`, `created_at`, `updated_at`) VALUES
(1, 'sliders/2FQiEUZVCxavkYNXPCPLXr58EB4DD6eMBunjd6ON.webp', '2026-01-18 13:09:17', '2026-01-18 13:09:17'),
(2, 'sliders/ZNMS4uZRVJGfq7uQfaxVihrz9OJ0EW0FXQrZyhkS.webp', '2026-01-18 13:09:28', '2026-01-18 13:09:28'),
(3, 'sliders/FgfQ6A7J7tDUu2CcepSTmbjzysYEAqnKDNSz7cAE.webp', '2026-01-18 13:09:33', '2026-01-18 13:09:33'),
(4, 'sliders/3Yrw6PI2wrOft7TXDTKLlAKZLvxMa85N3hWC1YSQ.webp', '2026-01-18 13:09:39', '2026-01-18 13:09:39'),
(5, 'sliders/kDN9AuDPsgg1emGk52876zjZz6bOgfkXz0lk5gf7.webp', '2026-01-18 13:09:43', '2026-01-18 13:09:53');

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subject` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `status` enum('pending','resolved','closed') NOT NULL DEFAULT 'pending',
  `ticket_from` enum('user','vendor') NOT NULL DEFAULT 'user',
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `user_id`, `vendor_id`, `subject`, `description`, `status`, `ticket_from`, `attachments`, `created_at`, `updated_at`) VALUES
(1, 16, NULL, 'Test Support Ticket', 'This is a test support ticket created to verify that the ticketing system is working correctly.\r\nNo real issue is being reported. Please ignore or close this ticket after confirmation.', 'resolved', 'vendor', '[\"tickets/0HZWTGCAk00LBKOdFF4OENMOEhQQG7EHoxevbes9.jpg\"]', '2026-01-18 14:08:38', '2026-01-18 14:20:49'),
(2, 16, NULL, 'Test Support Ticket 2', 'This is a test support ticket created to verify that the ticketing system is working correctly.\r\nNo real issue is being reported. Please ignore or close this ticket after confirmation.', 'pending', 'vendor', NULL, '2026-01-18 14:10:24', '2026-01-18 14:10:24'),
(3, 18, NULL, 'Test Subject', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni earum aliquam, quisquam blanditiis iusto nam fuga deserunt quo. Quam nobis excepturi ipsa repellat doloremque illum laboriosam reprehenderit iure quod soluta.', 'resolved', 'user', '[\"tickets/OUZ0rvXizMCPb4Hx1kBYib9DF3KgtKwDxftdAZYw.png\", \"tickets/bC2FIGlCj7W7QVPxRcqC24gfALwc1gqSjyiLWbOo.png\"]', '2026-01-18 14:39:35', '2026-01-18 14:46:54'),
(5, 18, NULL, 'Test Subject', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni earum aliquam, quisquam blanditiis iusto nam fuga deserunt quo. Quam nobis excepturi ipsa repellat doloremque illum laboriosam reprehenderit iure quod soluta.', 'closed', 'user', '[\"tickets/YnjMHF6v6z1amT4gIK9TxBMoTgI5DIChYCaJIxsq.png\", \"tickets/YS9uqliWO4M0Bl3hURBnJaOe4TPv8tLrArj9ZTPO.png\"]', '2026-01-20 11:55:53', '2026-03-23 11:15:50'),
(6, 18, NULL, 'Test Subject', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Magni earum aliquam, quisquam blanditiis iusto nam fuga deserunt quo. Quam nobis excepturi ipsa repellat doloremque illum laboriosam reprehenderit iure quod soluta.', 'resolved', 'user', '[\"tickets/YuZP1i16lxTppWFf5YUv1J1fjkGus3HTQQxU1Oht.png\", \"tickets/WLAfR2ciFESSvt69ldpPfWsW2tE8KmhPWu3N9b8J.png\"]', '2026-01-20 14:28:32', '2026-01-25 12:38:53');

-- --------------------------------------------------------

--
-- Table structure for table `ticket_messages`
--

CREATE TABLE `ticket_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ticket_id` bigint(20) UNSIGNED NOT NULL,
  `sender_type` enum('user','vendor','admin') NOT NULL DEFAULT 'user',
  `sender_id` bigint(20) UNSIGNED NOT NULL,
  `message` text NOT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ticket_messages`
--

INSERT INTO `ticket_messages` (`id`, `ticket_id`, `sender_type`, `sender_id`, `message`, `attachments`, `created_at`, `updated_at`) VALUES
(1, 1, 'admin', 1, 'test message', '[\"tickets/messages/pnfS7fhi7HelbeVBMrwtlcqEkpf2RAiziNCLVnbZ.png\"]', '2026-01-18 14:11:33', '2026-01-18 14:11:33'),
(2, 1, 'vendor', 16, 'test 2', '[]', '2026-01-18 14:13:29', '2026-01-18 14:13:29'),
(3, 1, 'admin', 1, '123', '[]', '2026-01-18 14:17:09', '2026-01-18 14:17:09'),
(4, 3, 'admin', 1, 'Test Message', '[\"tickets/messages/fPsXL68ulQePyhOE1zzqhWd4BGbR6SDD2vqSG5Qt.png\"]', '2026-01-18 14:42:57', '2026-01-18 14:42:57'),
(5, 3, 'user', 18, 'tset user reply', '[]', '2026-01-18 14:43:59', '2026-01-18 14:43:59'),
(6, 6, 'admin', 1, 'Test reply', '[]', '2026-01-25 12:38:30', '2026-01-25 12:38:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `phone_verified_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','vendor','user','delivery') NOT NULL DEFAULT 'user',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `wallet` decimal(10,2) NOT NULL DEFAULT 0.00,
  `points` decimal(10,2) NOT NULL DEFAULT 0.00,
  `referral_code` varchar(255) DEFAULT NULL,
  `referred_by_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `email_verified_at`, `phone_verified_at`, `role`, `is_active`, `is_verified`, `password`, `image`, `wallet`, `points`, `referral_code`, `referred_by_id`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Admin', 'admin@admin.com', '01234567890', NULL, NULL, 'admin', 1, 1, '$2y$12$d7i2L.FlERwj2OBj/S9O.eiuxMmBCe3q0rQ1MHaSD1gLhgbRqw1u.', NULL, 0.00, 0.00, NULL, NULL, 'OaQKQDqfslXs7k08lbh2uRsr2RLsGIHu5q9TSAiAhvfAQoS90zDO4CJvWAtA', '2026-01-11 10:45:25', '2026-01-11 10:45:25', NULL),
(3, 'Test Vendor', 'test@vendor.com', '01233211230', NULL, NULL, 'vendor', 1, 0, '$2y$12$1BGvAlnxPs2yiEXtIZrWbuJyjI4y05UNHAqckOCzOgT4jb42gKD/y', NULL, 0.00, 0.00, NULL, NULL, NULL, '2026-01-12 15:10:07', '2026-01-12 15:10:07', NULL),
(4, 'Test Vendor 2', 'test@vendor2.com', '01233211231', NULL, NULL, 'vendor', 1, 0, '$2y$12$Cn9yN8era2hZ1uC.8shbMepvmx2MRq0qScjtQRidXBwFIJPYHNahS', NULL, 0.00, 0.00, NULL, NULL, NULL, '2026-01-12 15:23:47', '2026-01-12 15:23:47', NULL),
(15, 'khaled', 'khaled@vendor.com', '+20109988770', '2026-01-14 10:06:50', NULL, 'vendor', 1, 1, '$2y$12$1iqV2iaWG6FrfpN6tGoXLeTMf8uha9LwRLBcKH5xADu2ChZMx7fvS', 'users/eVdwuWMErtxikpWJNi3c2GzCz3uN3CpLOCijY0yK.png', 0.00, 0.00, NULL, NULL, NULL, '2026-01-14 10:06:38', '2026-01-14 14:58:44', NULL),
(16, 'Islam', 'islam@vendor.com', '+20123032101', NULL, NULL, 'vendor', 1, 1, '$2y$12$3RHRfXqnCxm6zNpvRG66m.db/fFT0cXqYBQdBOGr.AB6kmJRWfd/y', NULL, 0.00, 0.00, NULL, NULL, NULL, '2026-01-15 08:07:55', '2026-02-26 03:10:48', NULL),
(17, 'islam 2', 'islam2@vendor.com', '+201023230231', NULL, NULL, 'vendor', 1, 0, '$2y$12$OFi68bFc/VuOeEoCNV0X4us2yvOPzKDoTxF5v2Gen38G6UjI2KfFW', NULL, 0.00, 0.00, NULL, NULL, NULL, '2026-01-15 10:40:43', '2026-01-15 10:40:43', NULL),
(18, 'Test User', 'test@user.com', '+201234567890', NULL, NULL, 'user', 1, 1, '$2y$12$ULTfZljbkO/B4cAQAlva9OOrNabUH6q8a4fAqwkWE7r9OmCxEhPv2', 'users/OofEca30obQjClbwg88umNT7bLBl6H1qDJ2sR6Z3.png', 779.25, 209.00, 'AHMED123', NULL, NULL, '2026-01-15 12:33:55', '2026-02-22 10:42:39', NULL),
(19, 'Islam Branch', 'islam@branch.com', '+201109002010', NULL, NULL, 'vendor', 1, 0, '$2y$12$ylGfk4Rsi43m6ctSqkgwLuObmoO1W.w1eBtcAnU2yS0h/G9dpxXyq', NULL, 0.00, 0.00, NULL, NULL, NULL, '2026-01-18 09:43:34', '2026-02-26 03:11:14', NULL),
(20, 'Delivery Man 1', 'delivery1@zew.com', '+201551001120', '2026-02-22 12:31:07', NULL, 'delivery', 1, 1, '$2y$12$BMS5Nco4t8pybRrTS4Me5.zqZoyOR/50XM14QAYNnPZGl5.E5foti', NULL, 0.00, 0.00, '7N4xFyoh', NULL, NULL, '2026-02-22 09:25:51', '2026-02-22 12:31:07', NULL),
(21, 'Test Delivery 2', 'testdel@zew.com', '+2012255510', NULL, NULL, 'delivery', 1, 0, '$2y$12$jw9yW.V.5kUz.SRsfamKK.q47DqSNrkPnYLPOMEAKkr9tErXWb./G', NULL, 0.00, 0.00, 'Oz5VZbT9', NULL, NULL, '2026-02-22 10:16:32', '2026-02-22 10:16:32', NULL),
(22, 'branch user', 'khaled@branch.com', '+201088112121', NULL, NULL, 'vendor', 1, 0, '$2y$12$HjwKZoTabBcZBACtks8d5ev.CB6cnsZK82wEdjamlNi1grSHHox2K', NULL, 0.00, 0.00, '8wVChHok', NULL, NULL, '2026-02-26 02:40:51', '2026-02-26 02:40:51', NULL),
(23, 'tt', 't@t.t', '012345678952', NULL, NULL, 'vendor', 1, 0, '$2y$12$LMyMl5s/I.uo6A9TwqZRueRFp/l8.h5lbGbqWO2ALJ40WuFFNUedy', NULL, 0.00, 0.00, 'oAATUcTe', NULL, NULL, '2026-02-26 03:08:00', '2026-02-26 03:08:00', NULL),
(24, 'Test User 2', 'test@user2.com', '+201234567810', '2026-03-23 10:19:54', NULL, 'user', 1, 1, '$2y$12$HWZwsWVQoRCxWs6OCFlF9O1bljWwYTQFoOafPFO5DWbXN/kUs65C2', NULL, 2118.00, 441.00, 'UCBQgbXY', NULL, NULL, '2026-03-23 10:18:46', '2026-03-23 13:37:16', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `variants`
--

CREATE TABLE `variants` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variants`
--

INSERT INTO `variants` (`id`, `name`, `is_required`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, '{\"ar\": \"اللون\", \"en\": \"Color\"}', 0, 1, '2026-01-13 12:30:07', '2026-01-13 12:30:07', NULL),
(2, '{\"ar\": \"المقاس\", \"en\": \"Size\"}', 0, 1, '2026-01-13 12:30:32', '2026-01-13 12:30:32', NULL),
(3, '{\"ar\": \"الخامة\", \"en\": \"Material\"}', 0, 1, '2026-01-13 12:37:59', '2026-01-13 12:39:13', NULL),
(4, '{\"ar\": \"فارينت تجريبي\", \"en\": \"Test VAR\"}', 1, 1, '2026-01-22 11:24:37', '2026-01-22 11:24:48', '2026-01-22 11:24:48'),
(5, '{\"ar\": \"طلب تجريبي\", \"en\": \"Test Req\"}', 0, 1, '2026-01-25 13:10:17', '2026-01-25 13:10:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `variant_options`
--

CREATE TABLE `variant_options` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `variant_id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `code` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variant_options`
--

INSERT INTO `variant_options` (`id`, `variant_id`, `name`, `code`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, '{\"ar\": \"أحمر\", \"en\": \"Red\"}', 'red', '2026-01-13 12:30:07', '2026-01-13 12:30:07', NULL),
(2, 1, '{\"ar\": \"أخضر\", \"en\": \"Green\"}', 'green', '2026-01-13 12:30:07', '2026-01-13 12:30:07', NULL),
(3, 1, '{\"ar\": \"أسود\", \"en\": \"Black\"}', 'black', '2026-01-13 12:30:07', '2026-01-13 12:30:07', NULL),
(4, 2, '{\"ar\": \"صغير\", \"en\": \"S\"}', 's', '2026-01-13 12:30:32', '2026-01-13 12:30:32', NULL),
(5, 2, '{\"ar\": \"متوسط\", \"en\": \"M\"}', 'm', '2026-01-13 12:30:32', '2026-01-13 12:30:32', NULL),
(6, 2, '{\"ar\": \"كبير\", \"en\": \"L\"}', 'l', '2026-01-13 12:30:32', '2026-01-13 12:30:32', NULL),
(7, 3, '{\"ar\": \"قطن\", \"en\": \"Cotton\"}', 'cotton', '2026-01-13 12:37:59', '2026-01-13 12:37:59', NULL),
(8, 3, '{\"ar\": \"صوف\", \"en\": \"Wool\"}', 'wool', '2026-01-13 12:37:59', '2026-01-13 12:37:59', NULL),
(9, 4, '{\"ar\": \"اختيار اول\", \"en\": \"OPT1\"}', 'opt1', '2026-01-22 11:24:37', '2026-01-22 11:24:37', NULL),
(10, 4, '{\"ar\": \"اختيار ثاني\", \"en\": \"OPT2\"}', 'opt2', '2026-01-22 11:24:37', '2026-01-22 11:24:37', NULL),
(11, 4, '{\"ar\": \"اختيار ثالث\", \"en\": \"OPT3\"}', 'opt3', '2026-01-22 11:24:37', '2026-01-22 11:24:37', NULL),
(12, 4, '{\"ar\": \"اختيار رابع\", \"en\": \"OPT4\"}', 'opt4', '2026-01-22 11:24:37', '2026-01-22 11:24:37', NULL),
(13, 5, '{\"ar\": \"opt1\", \"en\": \"opt1\"}', 'opt12', '2026-01-25 13:10:17', '2026-01-25 13:10:17', NULL),
(14, 5, '{\"ar\": \"opt2\", \"en\": \"opt2\"}', 'opt22', '2026-01-25 13:10:17', '2026-01-25 13:10:17', NULL),
(15, 5, '{\"ar\": \"opt3\", \"en\": \"opt3\"}', 'opt32', '2026-01-25 13:10:17', '2026-01-25 13:10:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `variant_requests`
--

CREATE TABLE `variant_requests` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`options`)),
  `description` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `admin_notes` text DEFAULT NULL,
  `reviewed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `reviewed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `variant_requests`
--

INSERT INTO `variant_requests` (`id`, `vendor_id`, `name`, `options`, `description`, `status`, `admin_notes`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, '{\"ar\": \"الخامة\", \"en\": \"Material\"}', '[{\"code\": null, \"name\": {\"ar\": \"قطن\", \"en\": \"Cotton\"}}, {\"code\": null, \"name\": {\"ar\": \"صوف\", \"en\": \"Wool\"}}]', NULL, 'approved', NULL, 1, '2026-01-13 12:37:55', '2026-01-13 12:36:59', '2026-01-13 12:37:55', NULL),
(2, 3, '{\"ar\": \"test\", \"en\": \"test\"}', '[]', NULL, 'rejected', 'reject reason', 1, '2026-01-13 12:37:28', '2026-01-13 12:37:10', '2026-01-13 12:37:28', NULL),
(3, 13, '{\"ar\": \"طلب تجريبي\", \"en\": \"Test Req\"}', '[{\"code\": \"opt1\", \"name\": {\"ar\": \"opt1\", \"en\": \"opt1\"}}, {\"code\": \"opt2\", \"name\": {\"ar\": \"opt2\", \"en\": \"opt2\"}}, {\"code\": \"opt3\", \"name\": {\"ar\": \"opt3\", \"en\": \"opt3\"}}]', 'test', 'approved', NULL, 1, '2026-01-25 13:09:59', '2026-01-25 13:09:45', '2026-01-25 13:09:59', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(255) NOT NULL,
  `name` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`name`)),
  `owner_id` bigint(20) UNSIGNED NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `balance` double NOT NULL DEFAULT 0,
  `commission_rate` double NOT NULL DEFAULT 0,
  `plan_id` bigint(20) UNSIGNED DEFAULT NULL,
  `subscription_start` date DEFAULT NULL,
  `subscription_end` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendors`
--

INSERT INTO `vendors` (`id`, `slug`, `name`, `owner_id`, `phone`, `address`, `image`, `is_active`, `is_featured`, `balance`, `commission_rate`, `plan_id`, `subscription_start`, `subscription_end`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'banda-vendor', '{\"ar\": \"ماركت باندا\", \"en\": \"Banda Vendor\"}', 3, '01233211230', '3 wzf st Cairo. Egypt', 'vendors/27RqJdLmLF1nHArn6d7PxMeOrvOVs2A5a2qgWWaM.png', 1, 0, 111, 0, 1, '2026-01-12', '2026-02-11', '2026-01-12 15:10:07', '2026-03-23 13:24:15', NULL),
(3, 'hayper-vendor', '{\"ar\": \"ماركت هايبر\", \"en\": \"Hayper Vendor\"}', 4, '01233211231', '3 wzf st Cairo. Egypt', 'vendors/f11PzLAar52uyvJfQQkRfubvgHmNFTp0GcogVcmc.png', 1, 0, 0, 0, 1, '2026-01-12', '2026-02-11', '2026-01-12 15:23:47', '2026-01-14 07:55:18', NULL),
(12, 'fathalla-market', '{\"ar\": \"فتح الله ماركت\", \"en\": \"Fathalla Market\"}', 15, '+20109988770', '3 abbas st. nasr city, Cairo, Egypt', 'vendors/ox7x0kfsews9fSuoRvvRfSqvb1vJBSCjp0VrHsu2.jpg', 1, 0, 0, 0, 1, '2026-01-14', '2026-02-13', '2026-01-14 10:06:38', '2026-01-14 14:29:42', NULL),
(13, 'saudi-market', '{\"ar\": \"سعودي ماركت\", \"en\": \"Saudi Market\"}', 16, '+20123032101', '3 Makram St. Cairo Egypt', 'vendors/ln8IAKuQUZmw8Xx2VPhYgiMDievBF3kCxYzAbiLN.webp', 1, 0, 3063, 10, 2, '2026-01-15', '2026-02-14', '2026-01-15 08:07:55', '2026-03-23 13:24:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_balance_transactions`
--

CREATE TABLE `vendor_balance_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `vendor_order_id` bigint(20) UNSIGNED DEFAULT NULL,
  `type` enum('addition','subtraction') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_balance_transactions`
--

INSERT INTO `vendor_balance_transactions` (`id`, `vendor_id`, `order_id`, `vendor_order_id`, `type`, `amount`, `balance_after`, `notes`, `payload`, `created_at`, `updated_at`) VALUES
(1, 13, 3, 5, 'addition', 946.00, 946.00, 'Order #3 (Vendor Order #5)', '{\"gross\": 946, \"commission\": 0, \"profit_type\": \"subscription\", \"payment_method\": \"COD\"}', '2026-01-21 10:35:47', '2026-01-21 10:35:47'),
(2, 2, 3, 6, 'addition', 50.00, 50.00, 'Order #3 (Vendor Order #6)', '{\"gross\": 50, \"commission\": 0, \"profit_type\": \"subscription\", \"payment_method\": \"COD\"}', '2026-01-21 10:35:47', '2026-01-21 10:35:47'),
(3, 13, NULL, NULL, 'subtraction', 6.00, 940.00, 'Withdrawal #1', '{\"method\": \"InstaPay\", \"processed_by\": 1}', '2026-01-21 10:49:24', '2026-01-21 10:49:24'),
(4, 13, NULL, NULL, 'subtraction', 40.00, 900.00, 'Withdrawal #3', '{\"method\": \"Instapay\", \"processed_by\": 1}', '2026-01-25 13:15:38', '2026-01-25 13:15:38'),
(5, 2, 10, 19, 'addition', 61.00, 111.00, 'Order #10 (Vendor Order #19)', '{\"profit_type\":\"commission\",\"gross\":61,\"commission\":0,\"payment_method\":\"COD\"}', '2026-03-23 13:24:15', '2026-03-23 13:24:15'),
(6, 13, 10, 20, 'addition', 2163.00, 3063.00, 'Order #10 (Vendor Order #20)', '{\"profit_type\":\"commission\",\"gross\":2163,\"commission\":0,\"payment_method\":\"COD\"}', '2026-03-23 13:24:15', '2026-03-23 13:24:15');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_orders`
--

CREATE TABLE `vendor_orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL,
  `status` enum('pending','processing','ready_for_pickup','shipped','delivered','cancelled','refunded') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `commission` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_orders`
--

INSERT INTO `vendor_orders` (`id`, `order_id`, `vendor_id`, `branch_id`, `sub_total`, `discount`, `shipping_cost`, `total`, `status`, `notes`, `commission`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 13, 5, 45.00, 0.00, 0.00, 70.00, 'pending', NULL, 0.00, '2026-01-19 11:57:37', '2026-01-19 11:57:37', NULL),
(2, 1, 2, 3, 10.00, 0.00, 0.00, 10.00, 'pending', NULL, 0.00, '2026-01-19 11:57:37', '2026-01-19 11:57:37', NULL),
(3, 2, 2, 3, 30.00, 0.00, 0.00, 30.00, 'cancelled', NULL, 0.00, '2026-01-19 12:52:44', '2026-01-19 12:52:44', NULL),
(4, 2, 13, 5, 930.00, 0.00, 25.00, 955.00, 'cancelled', NULL, 0.00, '2026-01-19 12:52:44', '2026-01-19 12:52:44', NULL),
(5, 3, 13, 5, 921.00, 0.00, 25.00, 946.00, 'shipped', NULL, 0.00, '2026-01-19 13:08:22', '2026-01-25 13:14:35', NULL),
(6, 3, 2, 3, 50.00, 0.00, 0.00, 50.00, 'pending', NULL, 0.00, '2026-01-19 13:08:22', '2026-01-19 13:08:22', NULL),
(7, 4, 13, 5, 921.00, 0.00, 25.00, 946.00, 'processing', NULL, 0.00, '2026-01-19 13:16:43', '2026-01-20 07:42:11', NULL),
(8, 4, 2, 3, 50.00, 0.00, 0.00, 50.00, 'pending', NULL, 0.00, '2026-01-19 13:16:43', '2026-01-19 13:16:43', NULL),
(9, 5, 2, 3, 50.00, 0.00, 0.00, 50.00, 'pending', NULL, 0.00, '2026-01-19 13:50:08', '2026-01-19 13:50:08', NULL),
(10, 6, 13, 6, 921.00, 0.00, 100.00, 1021.00, 'delivered', NULL, 0.00, '2026-01-19 14:54:26', '2026-01-21 11:04:54', NULL),
(11, 6, 2, 3, 50.00, 0.00, 0.00, 50.00, 'delivered', NULL, 0.00, '2026-01-19 14:54:26', '2026-01-21 11:03:18', NULL),
(12, 7, 13, 6, 921.00, 230.25, 100.00, 790.75, 'refunded', NULL, 0.00, '2026-01-19 14:57:29', '2026-01-20 09:23:29', NULL),
(13, 7, 2, 3, 50.00, 12.50, 0.00, 37.50, 'refunded', NULL, 0.00, '2026-01-19 14:57:29', '2026-01-20 09:24:32', NULL),
(14, 8, 3, 1, 10.00, 0.00, 0.00, 10.00, 'ready_for_pickup', NULL, 0.00, '2026-02-22 10:42:39', '2026-02-22 11:46:58', NULL),
(15, 8, 12, 4, 297.50, 0.00, 0.00, 297.50, 'ready_for_pickup', NULL, 0.00, '2026-02-22 10:42:39', '2026-02-22 11:46:23', NULL),
(16, 8, 13, 5, 13.50, 0.00, 0.00, 13.50, 'ready_for_pickup', NULL, 0.00, '2026-02-22 10:42:39', '2026-02-22 10:56:35', NULL),
(17, 9, 2, 3, 10.00, 0.00, 97.00, 107.00, 'ready_for_pickup', NULL, 0.00, '2026-03-23 11:11:55', '2026-03-23 11:38:47', NULL),
(18, 9, 13, 6, 2154.00, 0.00, 138.00, 2292.00, 'ready_for_pickup', NULL, 0.00, '2026-03-23 11:11:55', '2026-03-23 11:39:35', NULL),
(19, 10, 2, 3, 10.00, 0.00, 51.00, 61.00, 'cancelled', NULL, 0.00, '2026-03-23 11:14:31', '2026-03-23 13:16:26', NULL),
(20, 10, 13, 5, 2154.00, 0.00, 9.00, 2163.00, 'cancelled', NULL, 0.00, '2026-03-23 11:14:31', '2026-03-23 13:16:26', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_order_items`
--

CREATE TABLE `vendor_order_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `variant_id` bigint(20) UNSIGNED DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `total` decimal(10,2) NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_order_items`
--

INSERT INTO `vendor_order_items` (`id`, `vendor_order_id`, `product_id`, `variant_id`, `price`, `quantity`, `total`, `notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 11, 12, 45.00, 1, 45.00, NULL, '2026-01-19 11:57:37', '2026-01-19 11:57:37', NULL),
(2, 2, 1, NULL, 10.00, 1, 10.00, NULL, '2026-01-19 11:57:37', '2026-01-19 11:57:37', NULL),
(3, 3, 1, NULL, 10.00, 3, 30.00, NULL, '2026-01-19 12:52:44', '2026-01-19 12:52:44', NULL),
(4, 4, 11, 12, 45.00, 2, 90.00, NULL, '2026-01-19 12:52:44', '2026-01-19 12:52:44', NULL),
(5, 4, 10, NULL, 420.00, 2, 840.00, NULL, '2026-01-19 12:52:44', '2026-01-19 12:52:44', NULL),
(6, 5, 10, NULL, 420.00, 2, 840.00, NULL, '2026-01-19 13:08:22', '2026-01-19 13:08:22', NULL),
(7, 5, 11, 12, 40.50, 2, 81.00, NULL, '2026-01-19 13:08:22', '2026-01-19 13:08:22', NULL),
(8, 6, 1, NULL, 10.00, 5, 50.00, NULL, '2026-01-19 13:08:22', '2026-01-19 13:08:22', NULL),
(9, 7, 10, NULL, 420.00, 2, 840.00, NULL, '2026-01-19 13:16:43', '2026-01-19 13:16:43', NULL),
(10, 7, 11, 12, 40.50, 2, 81.00, NULL, '2026-01-19 13:16:43', '2026-01-19 13:16:43', NULL),
(11, 8, 1, NULL, 10.00, 5, 50.00, NULL, '2026-01-19 13:16:43', '2026-01-19 13:16:43', NULL),
(12, 9, 1, NULL, 10.00, 5, 50.00, NULL, '2026-01-19 13:50:08', '2026-01-19 13:50:08', NULL),
(13, 10, 10, NULL, 420.00, 2, 840.00, NULL, '2026-01-19 14:54:26', '2026-01-19 14:54:26', NULL),
(14, 10, 11, 12, 40.50, 2, 81.00, NULL, '2026-01-19 14:54:26', '2026-01-19 14:54:26', NULL),
(15, 11, 1, NULL, 10.00, 5, 50.00, NULL, '2026-01-19 14:54:26', '2026-01-19 14:54:26', NULL),
(16, 12, 10, NULL, 420.00, 2, 840.00, NULL, '2026-01-19 14:57:29', '2026-01-19 14:57:29', NULL),
(17, 12, 11, 12, 40.50, 2, 81.00, NULL, '2026-01-19 14:57:29', '2026-01-19 14:57:29', NULL),
(18, 13, 1, NULL, 10.00, 5, 50.00, NULL, '2026-01-19 14:57:29', '2026-01-19 14:57:29', NULL),
(19, 14, 7, 8, 10.00, 1, 10.00, NULL, '2026-02-22 10:42:39', '2026-02-22 10:42:39', NULL),
(20, 15, 8, NULL, 297.50, 1, 297.50, NULL, '2026-02-22 10:42:39', '2026-02-22 10:42:39', NULL),
(21, 16, 15, 28, 13.50, 1, 13.50, NULL, '2026-02-22 10:42:39', '2026-02-22 10:42:39', NULL),
(22, 17, 1, NULL, 10.00, 1, 10.00, NULL, '2026-03-23 11:11:55', '2026-03-23 11:11:55', NULL),
(23, 18, 10, NULL, 420.00, 5, 2100.00, NULL, '2026-03-23 11:11:55', '2026-03-23 11:11:55', NULL),
(24, 18, 11, 12, 40.50, 1, 40.50, NULL, '2026-03-23 11:11:55', '2026-03-23 11:11:55', NULL),
(25, 18, 15, 28, 13.50, 1, 13.50, NULL, '2026-03-23 11:11:55', '2026-03-23 11:11:55', NULL),
(26, 19, 1, NULL, 10.00, 1, 10.00, NULL, '2026-03-23 11:14:31', '2026-03-23 11:14:31', NULL),
(27, 20, 10, NULL, 420.00, 5, 2100.00, NULL, '2026-03-23 11:14:31', '2026-03-23 11:14:31', NULL),
(28, 20, 11, 12, 40.50, 1, 40.50, NULL, '2026-03-23 11:14:31', '2026-03-23 11:14:31', NULL),
(29, 20, 15, 28, 13.50, 1, 13.50, NULL, '2026-03-23 11:14:31', '2026-03-23 11:14:31', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_ratings`
--

CREATE TABLE `vendor_ratings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `rating` tinyint(3) UNSIGNED NOT NULL,
  `comment` text DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_ratings`
--

INSERT INTO `vendor_ratings` (`id`, `vendor_id`, `user_id`, `rating`, `comment`, `is_visible`, `created_at`, `updated_at`) VALUES
(1, 2, 18, 3, 'Great Product', 1, '2026-01-20 14:44:06', '2026-01-25 12:43:23');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_reports`
--

CREATE TABLE `vendor_reports` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `handled_by` bigint(20) UNSIGNED DEFAULT NULL,
  `handled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_reports`
--

INSERT INTO `vendor_reports` (`id`, `vendor_id`, `user_id`, `reason`, `description`, `status`, `handled_by`, `handled_at`, `created_at`, `updated_at`) VALUES
(1, 3, 18, 'Very Bad Store', 'I bought a product from this stpre and it arrived expired.', 'reviewed', 1, '2026-01-20 14:59:05', '2026-01-20 14:44:48', '2026-01-20 14:59:05');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_settings`
--

CREATE TABLE `vendor_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `type` enum('string','number','boolean','json') NOT NULL DEFAULT 'string',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_settings`
--

INSERT INTO `vendor_settings` (`id`, `vendor_id`, `key`, `value`, `type`, `created_at`, `updated_at`) VALUES
(1, 13, 'allow_branch_user_to_edit_stock', '0', 'boolean', '2026-01-18 10:14:37', '2026-01-18 10:21:53'),
(2, 13, 'free_shipping_threshold', '0', 'number', '2026-01-18 10:14:37', '2026-01-18 10:14:37'),
(3, 13, 'shipping_cost_per_km', '10', 'number', '2026-01-18 10:14:37', '2026-01-18 10:14:37'),
(4, 13, 'minimum_shipping_cost', '25', 'number', '2026-01-18 10:14:37', '2026-01-18 10:14:37'),
(5, 13, 'maximum_shipping_cost', '100', 'number', '2026-01-18 10:14:37', '2026-01-18 10:14:37'),
(6, 13, 'allow_free_shipping_threshold', '', 'boolean', '2026-01-18 10:21:53', '2026-01-18 10:21:53');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_subscriptions`
--

CREATE TABLE `vendor_subscriptions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `price` double NOT NULL,
  `status` enum('active','inactive','expired') NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_subscriptions`
--

INSERT INTO `vendor_subscriptions` (`id`, `vendor_id`, `plan_id`, `start_date`, `end_date`, `price`, `status`, `created_at`, `updated_at`) VALUES
(2, 12, 2, '2026-01-14', '2026-02-13', 500, 'inactive', '2026-01-14 12:15:02', '2026-01-14 12:41:05'),
(3, 12, 1, '2026-01-14', '2026-02-13', 250, 'active', '2026-01-14 12:41:05', '2026-01-14 12:41:05'),
(4, 13, 2, '2026-01-15', '2026-02-14', 500, 'active', '2026-01-15 10:09:44', '2026-01-15 10:09:44');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_time_slots`
--

CREATE TABLE `vendor_time_slots` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `day_of_week` tinyint(3) UNSIGNED NOT NULL,
  `opens_at` time NOT NULL,
  `closes_at` time NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_time_slots`
--

INSERT INTO `vendor_time_slots` (`id`, `vendor_id`, `day_of_week`, `opens_at`, `closes_at`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 13, 0, '09:00:00', '23:59:00', 1, '2026-02-23 11:06:08', '2026-02-23 11:06:14'),
(2, 13, 1, '08:00:00', '23:59:00', 1, '2026-02-23 11:08:21', '2026-02-23 11:08:21'),
(3, 13, 2, '06:00:00', '23:00:00', 1, '2026-02-23 11:08:41', '2026-02-23 11:08:41'),
(4, 13, 3, '07:30:00', '22:00:00', 1, '2026-02-23 11:09:14', '2026-02-23 11:09:14'),
(5, 13, 4, '10:00:00', '22:00:00', 1, '2026-02-23 11:09:36', '2026-02-23 11:09:36'),
(6, 13, 5, '10:00:00', '23:00:00', 1, '2026-02-23 11:09:52', '2026-02-23 11:09:52'),
(7, 13, 6, '10:00:00', '23:59:00', 1, '2026-02-23 11:10:11', '2026-02-23 11:10:11');

-- --------------------------------------------------------

--
-- Table structure for table `vendor_users`
--

CREATE TABLE `vendor_users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `user_type` enum('owner','branch') NOT NULL DEFAULT 'owner',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_users`
--

INSERT INTO `vendor_users` (`id`, `vendor_id`, `user_id`, `is_active`, `user_type`, `created_at`, `updated_at`, `deleted_at`, `branch_id`) VALUES
(1, 13, 17, 1, 'owner', '2026-01-15 10:40:43', '2026-01-15 10:40:43', NULL, NULL),
(2, 13, 19, 1, 'branch', '2026-01-18 09:43:34', '2026-01-18 09:43:34', NULL, 6),
(3, 12, 22, 1, 'branch', '2026-02-26 02:40:51', '2026-02-26 02:40:51', NULL, 4),
(4, 13, 23, 1, 'owner', '2026-02-26 03:08:00', '2026-02-26 03:10:08', '2026-02-26 03:10:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `vendor_withdrawals`
--

CREATE TABLE `vendor_withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `vendor_id` bigint(20) UNSIGNED NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `method` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `processed_by` bigint(20) UNSIGNED DEFAULT NULL,
  `processed_at` timestamp NULL DEFAULT NULL,
  `balance_before` decimal(10,2) DEFAULT NULL,
  `balance_after` decimal(10,2) DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payload`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vendor_withdrawals`
--

INSERT INTO `vendor_withdrawals` (`id`, `vendor_id`, `amount`, `status`, `method`, `notes`, `processed_by`, `processed_at`, `balance_before`, `balance_after`, `payload`, `created_at`, `updated_at`) VALUES
(1, 13, 6.00, 'approved', 'InstaPay', NULL, 1, '2026-01-21 10:49:24', 946.00, 940.00, NULL, '2026-01-21 10:48:08', '2026-01-21 10:49:24'),
(2, 13, 100.00, 'rejected', 'Wallet', 'Test Request', 1, '2026-01-21 10:49:30', 946.00, 946.00, NULL, '2026-01-21 10:48:45', '2026-01-21 10:49:30'),
(3, 13, 40.00, 'approved', 'Instapay', 'test note', 1, '2026-01-25 13:15:38', 940.00, 900.00, NULL, '2026-01-25 13:15:13', '2026-01-25 13:15:38'),
(4, 13, 500.00, 'pending', 'تحويل بنكى', NULL, NULL, NULL, 900.00, 900.00, NULL, '2026-03-23 11:25:18', '2026-03-23 11:25:18');

-- --------------------------------------------------------

--
-- Table structure for table `verifications`
--

CREATE TABLE `verifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `expires_at` timestamp NOT NULL,
  `verified_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `verifications`
--

INSERT INTO `verifications` (`id`, `user_id`, `type`, `target`, `code`, `expires_at`, `verified_at`, `created_at`, `updated_at`) VALUES
(6, 15, 'email', 'khaled@vendor.com', '739701', '2026-01-14 10:16:38', '2026-01-14 10:06:50', '2026-01-14 10:06:38', '2026-01-14 10:06:50'),
(7, 16, 'email', 'islam@vendor.com', '475013', '2026-01-15 08:17:55', '2026-01-15 08:08:18', '2026-01-15 08:07:55', '2026-01-15 08:08:18'),
(9, 18, 'email', 'newemail@user.com', '980517', '2026-01-15 12:59:51', NULL, '2026-01-15 12:49:51', '2026-01-15 12:49:51');

-- --------------------------------------------------------

--
-- Table structure for table `wallet_transactions`
--

CREATE TABLE `wallet_transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('addition','subtraction') NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `balance_after` decimal(10,2) NOT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wallet_transactions`
--

INSERT INTO `wallet_transactions` (`id`, `user_id`, `type`, `amount`, `balance_after`, `notes`, `created_at`, `updated_at`) VALUES
(1, 18, 'addition', 0.00, 0.00, 'Order #3', '2026-01-19 13:08:22', '2026-01-19 13:08:22'),
(2, 18, 'addition', 0.00, 0.00, 'Order #4', '2026-01-19 13:16:43', '2026-01-19 13:16:43'),
(3, 18, 'addition', 779.25, 779.25, 'Refund for Order #7', '2026-01-20 10:54:13', '2026-01-20 10:54:13'),
(4, 24, 'addition', 2118.00, 2118.00, 'Refund for Order #10', '2026-03-23 13:37:16', '2026-03-23 13:37:16');

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `polygon` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`polygon`)),
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`id`, `name`, `polygon`, `is_active`, `created_at`, `updated_at`) VALUES
(2, 'Downtown Cairo (وسط البلد)', '[{\"lat\": 30.038, \"lng\": 31.228}, {\"lat\": 30.038, \"lng\": 31.242}, {\"lat\": 30.05, \"lng\": 31.242}, {\"lat\": 30.05, \"lng\": 31.228}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(3, 'Zamalek', '[{\"lat\": 30.058, \"lng\": 31.212}, {\"lat\": 30.058, \"lng\": 31.226}, {\"lat\": 30.068, \"lng\": 31.226}, {\"lat\": 30.068, \"lng\": 31.212}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(4, 'Heliopolis (مصر الجديدة)', '[{\"lat\": 30.082, \"lng\": 31.318}, {\"lat\": 30.082, \"lng\": 31.336}, {\"lat\": 30.096, \"lng\": 31.336}, {\"lat\": 30.096, \"lng\": 31.318}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(5, 'Nasr City (مدينة نصر)', '[{\"lat\": 30.07901538444205, \"lng\": 31.360397998795293}, {\"lat\": 30.09520542115028, \"lng\": 31.342713563855096}, {\"lat\": 30.08064936159867, \"lng\": 31.316616145302625}, {\"lat\": 30.069582352365018, \"lng\": 31.29223566218122}, {\"lat\": 30.061559853791476, \"lng\": 31.307688081060956}, {\"lat\": 30.05071359064657, \"lng\": 31.31163703255248}, {\"lat\": 30.02411293169379, \"lng\": 31.344258805743067}, {\"lat\": 30.04719015650133, \"lng\": 31.367703546657793}, {\"lat\": 30.05788822935935, \"lng\": 31.37766177215808}, {\"lat\": 30.073190407423382, \"lng\": 31.388650158917024}, {\"lat\": 30.079875082379395, \"lng\": 31.38573136868419}]', 1, '2026-02-22 08:05:21', '2026-02-22 09:41:25'),
(6, 'Maadi (المعادي)', '[{\"lat\": 29.954, \"lng\": 31.252}, {\"lat\": 29.954, \"lng\": 31.268}, {\"lat\": 29.966, \"lng\": 31.268}, {\"lat\": 29.966, \"lng\": 31.252}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(7, 'Abbassia (العباسية)', '[{\"lat\": 30.068, \"lng\": 31.268}, {\"lat\": 30.068, \"lng\": 31.282}, {\"lat\": 30.078, \"lng\": 31.282}, {\"lat\": 30.078, \"lng\": 31.268}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(8, 'Giza - Haram (الهرم)', '[{\"lat\": 29.968, \"lng\": 31.122}, {\"lat\": 29.968, \"lng\": 31.142}, {\"lat\": 29.982, \"lng\": 31.142}, {\"lat\": 29.982, \"lng\": 31.122}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(9, 'Dokki & Mohandessin (الدقي - المهندسين)', '[{\"lat\": 30.042, \"lng\": 31.198}, {\"lat\": 30.042, \"lng\": 31.218}, {\"lat\": 30.054, \"lng\": 31.218}, {\"lat\": 30.054, \"lng\": 31.198}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(10, 'Agouza (العجوزة)', '[{\"lat\": 30.05, \"lng\": 31.206}, {\"lat\": 30.05, \"lng\": 31.224}, {\"lat\": 30.06, \"lng\": 31.224}, {\"lat\": 30.06, \"lng\": 31.206}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(11, '6th October City (مدينة 6 أكتوبر)', '[{\"lat\": 29.958, \"lng\": 30.922}, {\"lat\": 29.958, \"lng\": 30.945}, {\"lat\": 29.975, \"lng\": 30.945}, {\"lat\": 29.975, \"lng\": 30.922}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(12, 'Faisal (فيصل)', '[{\"lat\": 29.99, \"lng\": 31.138}, {\"lat\": 29.99, \"lng\": 31.158}, {\"lat\": 30.004, \"lng\": 31.158}, {\"lat\": 30.004, \"lng\": 31.138}]', 1, '2026-02-22 08:05:21', '2026-02-22 08:05:21'),
(13, 'test area', '[{\"lat\":30.0588297116807,\"lng\":31.252531331896424},{\"lat\":30.057942901236597,\"lng\":31.25265473663054},{\"lat\":30.057743251716573,\"lng\":31.250975359162005},{\"lat\":30.05842112984508,\"lng\":31.250497836495242},{\"lat\":30.05889471318091,\"lng\":31.250750011386685},{\"lat\":30.059066502654566,\"lng\":31.251399227596558}]', 1, '2026-02-25 14:23:19', '2026-02-25 14:23:19'),
(14, 'التخفيضات', '[{\"lat\":30.06518585705433,\"lng\":31.334765520499637},{\"lat\":30.06592868110115,\"lng\":31.351154746213563},{\"lat\":30.056865846876253,\"lng\":31.351412168606963},{\"lat\":30.05530576712475,\"lng\":31.334508098106237}]', 1, '2026-04-01 18:46:13', '2026-04-01 18:46:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_user_id_index` (`user_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branches_vendor_id_foreign` (`vendor_id`);

--
-- Indexes for table `branch_product_stocks`
--
ALTER TABLE `branch_product_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branch_product_stocks_branch_product_index` (`branch_id`,`product_id`),
  ADD KEY `branch_product_stocks_branch_quantity_index` (`branch_id`,`quantity`),
  ADD KEY `branch_product_stocks_product_quantity_index` (`product_id`,`quantity`);

--
-- Indexes for table `branch_product_variant_stocks`
--
ALTER TABLE `branch_product_variant_stocks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `branch_variant_stocks_branch_variant_index` (`branch_id`,`product_variant_id`),
  ADD KEY `branch_variant_stocks_branch_quantity_index` (`branch_id`,`quantity`),
  ADD KEY `branch_variant_stocks_variant_quantity_index` (`product_variant_id`,`quantity`);

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
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_items_product_id_foreign` (`product_id`),
  ADD KEY `cart_items_variant_id_foreign` (`variant_id`),
  ADD KEY `cart_items_user_product_index` (`user_id`,`product_id`),
  ADD KEY `cart_items_user_product_variant_index` (`user_id`,`product_id`,`variant_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categories_status_index` (`is_active`,`is_featured`),
  ADD KEY `categories_parent_id_index` (`parent_id`),
  ADD KEY `categories_created_at_index` (`created_at`);

--
-- Indexes for table `category_product`
--
ALTER TABLE `category_product`
  ADD UNIQUE KEY `category_product_product_id_category_id_unique` (`product_id`,`category_id`),
  ADD KEY `category_product_category_id_foreign` (`category_id`);

--
-- Indexes for table `category_requests`
--
ALTER TABLE `category_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_requests_vendor_id_foreign` (`vendor_id`),
  ADD KEY `category_requests_reviewed_by_foreign` (`reviewed_by`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`),
  ADD KEY `coupons_active_end_date_index` (`is_active`,`end_date`);

--
-- Indexes for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `deliveries_user_id_foreign` (`user_id`);

--
-- Indexes for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_assignments_order_id_foreign` (`order_id`),
  ADD KEY `delivery_assignments_delivery_id_foreign` (`delivery_id`);

--
-- Indexes for table `delivery_assignment_pickups`
--
ALTER TABLE `delivery_assignment_pickups`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_assignment_pickups_delivery_assignment_id_foreign` (`delivery_assignment_id`),
  ADD KEY `delivery_assignment_pickups_vendor_order_id_foreign` (`vendor_order_id`);

--
-- Indexes for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_requests_reviewed_by_foreign` (`reviewed_by`),
  ADD KEY `delivery_requests_user_id_foreign` (`user_id`);

--
-- Indexes for table `delivery_shift`
--
ALTER TABLE `delivery_shift`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `delivery_shift_delivery_id_shift_id_unique` (`delivery_id`,`shift_id`),
  ADD KEY `delivery_shift_shift_id_foreign` (`shift_id`);

--
-- Indexes for table `delivery_wallet_transactions`
--
ALTER TABLE `delivery_wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_wallet_transactions_delivery_id_foreign` (`delivery_id`);

--
-- Indexes for table `delivery_zone`
--
ALTER TABLE `delivery_zone`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `delivery_zone_delivery_id_zone_id_unique` (`delivery_id`,`zone_id`),
  ADD KEY `delivery_zone_zone_id_foreign` (`zone_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `favorites_user_id_product_id_unique` (`user_id`,`product_id`),
  ADD KEY `favorites_product_id_foreign` (`product_id`),
  ADD KEY `favorites_user_product_index` (`user_id`,`product_id`);

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
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_coupon_id_foreign` (`coupon_id`),
  ADD KEY `orders_address_id_foreign` (`address_id`),
  ADD KEY `orders_user_status_index` (`user_id`,`status`),
  ADD KEY `orders_status_payment_index` (`status`,`payment_status`),
  ADD KEY `orders_created_at_index` (`created_at`),
  ADD KEY `orders_total_index` (`total`),
  ADD KEY `orders_payment_method_index` (`payment_method`),
  ADD KEY `orders_refund_status_index` (`refund_status`);

--
-- Indexes for table `order_logs`
--
ALTER TABLE `order_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_logs_order_id_foreign` (`order_id`),
  ADD KEY `order_logs_vendor_order_id_foreign` (`vendor_order_id`),
  ADD KEY `order_logs_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_refund_requests`
--
ALTER TABLE `order_refund_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_refund_requests_user_id_foreign` (`user_id`),
  ADD KEY `order_refund_requests_processed_by_foreign` (`processed_by`),
  ADD KEY `order_refund_requests_order_id_status_index` (`order_id`,`status`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plans_slug_unique` (`slug`);

--
-- Indexes for table `point_transactions`
--
ALTER TABLE `point_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `point_transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_sku_unique` (`sku`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_status_index` (`is_active`,`is_approved`,`is_featured`),
  ADD KEY `products_price_index` (`price`),
  ADD KEY `products_vendor_id_index` (`vendor_id`),
  ADD KEY `products_type_index` (`type`),
  ADD KEY `products_created_at_index` (`created_at`),
  ADD KEY `products_is_new_index` (`is_new`),
  ADD KEY `products_is_bookable_index` (`is_bookable`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_imageable_id_imageable_type_index` (`imageable_id`,`imageable_type`);

--
-- Indexes for table `product_ratings`
--
ALTER TABLE `product_ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_ratings_product_id_user_id_unique` (`product_id`,`user_id`),
  ADD KEY `product_ratings_product_visible_index` (`product_id`,`is_visible`),
  ADD KEY `product_ratings_user_id_index` (`user_id`);

--
-- Indexes for table `product_relations`
--
ALTER TABLE `product_relations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_relations_product_id_foreign` (`product_id`),
  ADD KEY `product_relations_related_product_id_foreign` (`related_product_id`);

--
-- Indexes for table `product_reports`
--
ALTER TABLE `product_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_reports_product_id_foreign` (`product_id`),
  ADD KEY `product_reports_user_id_foreign` (`user_id`),
  ADD KEY `product_reports_handled_by_foreign` (`handled_by`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_variants_sku_unique` (`sku`),
  ADD UNIQUE KEY `product_variants_slug_unique` (`slug`),
  ADD KEY `product_variants_product_id_foreign` (`product_id`);

--
-- Indexes for table `product_variant_values`
--
ALTER TABLE `product_variant_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_variant_values_product_variant_id_foreign` (`product_variant_id`),
  ADD KEY `product_variant_values_variant_option_id_foreign` (`variant_option_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `shifts_date_index` (`date`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tickets_vendor_id_foreign` (`vendor_id`),
  ADD KEY `tickets_user_status_index` (`user_id`,`status`),
  ADD KEY `tickets_status_index` (`status`);

--
-- Indexes for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ticket_messages_ticket_id_foreign` (`ticket_id`),
  ADD KEY `ticket_messages_sender_id_foreign` (`sender_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_phone_unique` (`phone`),
  ADD UNIQUE KEY `users_referral_code_unique` (`referral_code`),
  ADD KEY `users_referred_by_id_foreign` (`referred_by_id`),
  ADD KEY `users_role_status_index` (`role`,`is_active`),
  ADD KEY `users_created_at_index` (`created_at`);

--
-- Indexes for table `variants`
--
ALTER TABLE `variants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variant_options`
--
ALTER TABLE `variant_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `variant_options_code_unique` (`code`),
  ADD KEY `variant_options_variant_id_foreign` (`variant_id`);

--
-- Indexes for table `variant_requests`
--
ALTER TABLE `variant_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `variant_requests_vendor_id_foreign` (`vendor_id`),
  ADD KEY `variant_requests_reviewed_by_foreign` (`reviewed_by`);

--
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendors_slug_unique` (`slug`),
  ADD KEY `vendors_status_index` (`is_active`,`is_featured`),
  ADD KEY `vendors_owner_id_index` (`owner_id`),
  ADD KEY `vendors_plan_id_index` (`plan_id`),
  ADD KEY `vendors_balance_index` (`balance`),
  ADD KEY `vendors_commission_rate_index` (`commission_rate`),
  ADD KEY `vendors_created_at_index` (`created_at`);

--
-- Indexes for table `vendor_balance_transactions`
--
ALTER TABLE `vendor_balance_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_balance_transactions_vendor_id_created_at_index` (`vendor_id`,`created_at`),
  ADD KEY `vendor_balance_transactions_order_id_index` (`order_id`),
  ADD KEY `vendor_balance_transactions_vendor_order_id_index` (`vendor_order_id`);

--
-- Indexes for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_orders_vendor_status_index` (`vendor_id`,`status`),
  ADD KEY `vendor_orders_order_vendor_index` (`order_id`,`vendor_id`),
  ADD KEY `vendor_orders_branch_id_index` (`branch_id`),
  ADD KEY `vendor_orders_status_index` (`status`);

--
-- Indexes for table `vendor_order_items`
--
ALTER TABLE `vendor_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_order_items_vendor_order_id_foreign` (`vendor_order_id`),
  ADD KEY `vendor_order_items_product_id_foreign` (`product_id`),
  ADD KEY `vendor_order_items_variant_id_foreign` (`variant_id`);

--
-- Indexes for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_ratings_vendor_id_user_id_unique` (`vendor_id`,`user_id`),
  ADD KEY `vendor_ratings_vendor_visible_index` (`vendor_id`,`is_visible`),
  ADD KEY `vendor_ratings_user_id_index` (`user_id`);

--
-- Indexes for table `vendor_reports`
--
ALTER TABLE `vendor_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_reports_vendor_id_foreign` (`vendor_id`),
  ADD KEY `vendor_reports_user_id_foreign` (`user_id`),
  ADD KEY `vendor_reports_handled_by_foreign` (`handled_by`);

--
-- Indexes for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `vendor_settings_vendor_id_key_unique` (`vendor_id`,`key`);

--
-- Indexes for table `vendor_subscriptions`
--
ALTER TABLE `vendor_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_subscriptions_vendor_id_foreign` (`vendor_id`),
  ADD KEY `vendor_subscriptions_plan_id_foreign` (`plan_id`);

--
-- Indexes for table `vendor_time_slots`
--
ALTER TABLE `vendor_time_slots`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_time_slots_vendor_id_day_of_week_index` (`vendor_id`,`day_of_week`);

--
-- Indexes for table `vendor_users`
--
ALTER TABLE `vendor_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_users_vendor_id_foreign` (`vendor_id`),
  ADD KEY `vendor_users_user_id_foreign` (`user_id`),
  ADD KEY `vendor_users_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `vendor_withdrawals`
--
ALTER TABLE `vendor_withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vendor_withdrawals_vendor_id_status_index` (`vendor_id`,`status`);

--
-- Indexes for table `verifications`
--
ALTER TABLE `verifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `verifications_user_id_foreign` (`user_id`);

--
-- Indexes for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wallet_transactions_user_id_foreign` (`user_id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `branch_product_stocks`
--
ALTER TABLE `branch_product_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `branch_product_variant_stocks`
--
ALTER TABLE `branch_product_variant_stocks`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `category_requests`
--
ALTER TABLE `category_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `deliveries`
--
ALTER TABLE `deliveries`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_assignment_pickups`
--
ALTER TABLE `delivery_assignment_pickups`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `delivery_shift`
--
ALTER TABLE `delivery_shift`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `delivery_wallet_transactions`
--
ALTER TABLE `delivery_wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `delivery_zone`
--
ALTER TABLE `delivery_zone`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `order_logs`
--
ALTER TABLE `order_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `order_refund_requests`
--
ALTER TABLE `order_refund_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `point_transactions`
--
ALTER TABLE `point_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `product_ratings`
--
ALTER TABLE `product_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_relations`
--
ALTER TABLE `product_relations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `product_reports`
--
ALTER TABLE `product_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `product_variant_values`
--
ALTER TABLE `product_variant_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `variants`
--
ALTER TABLE `variants`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `variant_options`
--
ALTER TABLE `variant_options`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `variant_requests`
--
ALTER TABLE `variant_requests`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `vendor_balance_transactions`
--
ALTER TABLE `vendor_balance_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `vendor_order_items`
--
ALTER TABLE `vendor_order_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vendor_reports`
--
ALTER TABLE `vendor_reports`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `vendor_subscriptions`
--
ALTER TABLE `vendor_subscriptions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendor_time_slots`
--
ALTER TABLE `vendor_time_slots`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `vendor_users`
--
ALTER TABLE `vendor_users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `vendor_withdrawals`
--
ALTER TABLE `vendor_withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `verifications`
--
ALTER TABLE `verifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `branches`
--
ALTER TABLE `branches`
  ADD CONSTRAINT `branches_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `branch_product_stocks`
--
ALTER TABLE `branch_product_stocks`
  ADD CONSTRAINT `branch_product_stocks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `branch_product_stocks_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `branch_product_variant_stocks`
--
ALTER TABLE `branch_product_variant_stocks`
  ADD CONSTRAINT `branch_product_variant_stocks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `branch_product_variant_stocks_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `category_product`
--
ALTER TABLE `category_product`
  ADD CONSTRAINT `category_product_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `category_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_requests`
--
ALTER TABLE `category_requests`
  ADD CONSTRAINT `category_requests_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `category_requests_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `deliveries`
--
ALTER TABLE `deliveries`
  ADD CONSTRAINT `deliveries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `delivery_assignments`
--
ALTER TABLE `delivery_assignments`
  ADD CONSTRAINT `delivery_assignments_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_assignments_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_assignment_pickups`
--
ALTER TABLE `delivery_assignment_pickups`
  ADD CONSTRAINT `delivery_assignment_pickups_delivery_assignment_id_foreign` FOREIGN KEY (`delivery_assignment_id`) REFERENCES `delivery_assignments` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_assignment_pickups_vendor_order_id_foreign` FOREIGN KEY (`vendor_order_id`) REFERENCES `vendor_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_requests`
--
ALTER TABLE `delivery_requests`
  ADD CONSTRAINT `delivery_requests_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `delivery_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `delivery_shift`
--
ALTER TABLE `delivery_shift`
  ADD CONSTRAINT `delivery_shift_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_shift_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_wallet_transactions`
--
ALTER TABLE `delivery_wallet_transactions`
  ADD CONSTRAINT `delivery_wallet_transactions_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `delivery_zone`
--
ALTER TABLE `delivery_zone`
  ADD CONSTRAINT `delivery_zone_delivery_id_foreign` FOREIGN KEY (`delivery_id`) REFERENCES `deliveries` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_zone_zone_id_foreign` FOREIGN KEY (`zone_id`) REFERENCES `zones` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_logs`
--
ALTER TABLE `order_logs`
  ADD CONSTRAINT `order_logs_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `order_logs_vendor_order_id_foreign` FOREIGN KEY (`vendor_order_id`) REFERENCES `vendor_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_refund_requests`
--
ALTER TABLE `order_refund_requests`
  ADD CONSTRAINT `order_refund_requests_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_refund_requests_processed_by_foreign` FOREIGN KEY (`processed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `order_refund_requests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `point_transactions`
--
ALTER TABLE `point_transactions`
  ADD CONSTRAINT `point_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_ratings`
--
ALTER TABLE `product_ratings`
  ADD CONSTRAINT `product_ratings_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_relations`
--
ALTER TABLE `product_relations`
  ADD CONSTRAINT `product_relations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_relations_related_product_id_foreign` FOREIGN KEY (`related_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reports`
--
ALTER TABLE `product_reports`
  ADD CONSTRAINT `product_reports_handled_by_foreign` FOREIGN KEY (`handled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `product_reports_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_variant_values`
--
ALTER TABLE `product_variant_values`
  ADD CONSTRAINT `product_variant_values_product_variant_id_foreign` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_variant_values_variant_option_id_foreign` FOREIGN KEY (`variant_option_id`) REFERENCES `variant_options` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `tickets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tickets_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket_messages`
--
ALTER TABLE `ticket_messages`
  ADD CONSTRAINT `ticket_messages_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_messages_ticket_id_foreign` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_referred_by_id_foreign` FOREIGN KEY (`referred_by_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `variant_options`
--
ALTER TABLE `variant_options`
  ADD CONSTRAINT `variant_options_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `variants` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `variant_requests`
--
ALTER TABLE `variant_requests`
  ADD CONSTRAINT `variant_requests_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `variant_requests_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendors`
--
ALTER TABLE `vendors`
  ADD CONSTRAINT `vendors_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendors_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_balance_transactions`
--
ALTER TABLE `vendor_balance_transactions`
  ADD CONSTRAINT `vendor_balance_transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vendor_balance_transactions_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_balance_transactions_vendor_order_id_foreign` FOREIGN KEY (`vendor_order_id`) REFERENCES `vendor_orders` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `vendor_orders`
--
ALTER TABLE `vendor_orders`
  ADD CONSTRAINT `vendor_orders_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_orders_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_order_items`
--
ALTER TABLE `vendor_order_items`
  ADD CONSTRAINT `vendor_order_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_order_items_variant_id_foreign` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_order_items_vendor_order_id_foreign` FOREIGN KEY (`vendor_order_id`) REFERENCES `vendor_orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_ratings`
--
ALTER TABLE `vendor_ratings`
  ADD CONSTRAINT `vendor_ratings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_ratings_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_reports`
--
ALTER TABLE `vendor_reports`
  ADD CONSTRAINT `vendor_reports_handled_by_foreign` FOREIGN KEY (`handled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vendor_reports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `vendor_reports_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_settings`
--
ALTER TABLE `vendor_settings`
  ADD CONSTRAINT `vendor_settings_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_subscriptions`
--
ALTER TABLE `vendor_subscriptions`
  ADD CONSTRAINT `vendor_subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_subscriptions_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_time_slots`
--
ALTER TABLE `vendor_time_slots`
  ADD CONSTRAINT `vendor_time_slots_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_users`
--
ALTER TABLE `vendor_users`
  ADD CONSTRAINT `vendor_users_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `vendor_users_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vendor_withdrawals`
--
ALTER TABLE `vendor_withdrawals`
  ADD CONSTRAINT `vendor_withdrawals_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `verifications`
--
ALTER TABLE `verifications`
  ADD CONSTRAINT `verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wallet_transactions`
--
ALTER TABLE `wallet_transactions`
  ADD CONSTRAINT `wallet_transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
deliveries
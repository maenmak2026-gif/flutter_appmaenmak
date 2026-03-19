-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: maenmak_db
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin_users`
--

DROP TABLE IF EXISTS `admin_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('admin','editor') DEFAULT 'admin',
  `name` varchar(120) NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin_users`
--

LOCK TABLES `admin_users` WRITE;
/*!40000 ALTER TABLE `admin_users` DISABLE KEYS */;
INSERT INTO `admin_users` VALUES (1,'admin@maenmak.local','$2b$10$TOFhMZ2rwEAU/piFQuo/WeoBpwwmyFtge0uAzlHLOxbUuPyXLAsk.','admin','Super Admin',1,'2026-03-08 15:04:10','2026-03-09 14:18:02');
/*!40000 ALTER TABLE `admin_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_installs`
--

DROP TABLE IF EXISTS `app_installs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_installs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `platform` varchar(50) DEFAULT 'unknown',
  `country` varchar(8) DEFAULT NULL,
  `app_version` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_install_created` (`created_at`),
  KEY `idx_install_device` (`device_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `app_installs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_installs`
--

LOCK TABLES `app_installs` WRITE;
/*!40000 ALTER TABLE `app_installs` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_installs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_settings`
--

DROP TABLE IF EXISTS `app_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_settings` (
  `setting_key` varchar(120) NOT NULL,
  `setting_value` json DEFAULT NULL,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_settings`
--

LOCK TABLES `app_settings` WRITE;
/*!40000 ALTER TABLE `app_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lotteries`
--

DROP TABLE IF EXISTS `lotteries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lotteries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(120) NOT NULL,
  `category` varchar(80) DEFAULT NULL,
  `description` text,
  `display_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_lotteries_code_name` (`code`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lotteries`
--

LOCK TABLES `lotteries` WRITE;
/*!40000 ALTER TABLE `lotteries` DISABLE KEYS */;
INSERT INTO `lotteries` VALUES (1,'thai_gov','สลากกินแบ่งรัฐบาล','thai','รัฐบาลไทย',1,1,'2026-03-08 15:04:10','2026-03-08 15:04:10'),(7,'lao_patthana','ลาวพัฒนา','lao','หวยลาวพัฒนา',2,1,'2026-03-10 12:48:11','2026-03-10 12:48:11'),(8,'hanoi_special','ฮานอยพิเศษ','hanoi','หวยฮานอยพิเศษ',3,1,'2026-03-10 12:48:11','2026-03-10 12:48:11'),(9,'hanoi_normal','ฮานอยปกติ','hanoi','หวยฮานอยปกติ',4,1,'2026-03-10 12:48:11','2026-03-10 12:48:11'),(10,'hanoi_vip','ฮานอย VIP','hanoi','หวยฮานอยวีไอพี',5,1,'2026-03-10 12:48:11','2026-03-10 12:48:11');
/*!40000 ALTER TABLE `lotteries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lottery_predictions`
--

DROP TABLE IF EXISTS `lottery_predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lottery_predictions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lottery_id` int NOT NULL,
  `draw_date_text` varchar(120) DEFAULT '',
  `highlight_numbers_json` json NOT NULL,
  `tail_4_json` json DEFAULT NULL,
  `tail_3_json` json DEFAULT NULL,
  `tail_2_json` json DEFAULT NULL,
  `vip_3_top_json` json DEFAULT NULL,
  `vip_3_bottom_json` json DEFAULT NULL,
  `vip_2_bottom_json` json DEFAULT NULL,
  `vip_message` varchar(255) DEFAULT '',
  `is_premium_locked` tinyint(1) DEFAULT '1',
  `latest_win_text` varchar(255) DEFAULT '',
  `month` int NOT NULL,
  `year` int NOT NULL,
  `display_order` int DEFAULT '0',
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_predictions_month_year` (`month`,`year`),
  KEY `idx_predictions_lottery` (`lottery_id`),
  CONSTRAINT `lottery_predictions_ibfk_1` FOREIGN KEY (`lottery_id`) REFERENCES `lotteries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lottery_predictions`
--

LOCK TABLES `lottery_predictions` WRITE;
/*!40000 ALTER TABLE `lottery_predictions` DISABLE KEYS */;
INSERT INTO `lottery_predictions` VALUES (1,1,'6 มีนาคม 2569','[\"5\", \"6\", \"4\", \"2\", \"3\", \"6\"]',NULL,NULL,NULL,'[\"123\", \"456\"]','[\"789\", \"012\"]','[\"34\", \"56\"]','ปลดล็อคข้อมูลชุดเต็ม 3 ตัวตรง และ 2 ตัว เต็มๆ',1,'เลขเข้า WIN รายเดือนล่าสุด',3,2569,1,1,'2026-03-08 15:04:10','2026-03-08 15:04:10');
/*!40000 ALTER TABLE `lottery_predictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lottery_statistics`
--

DROP TABLE IF EXISTS `lottery_statistics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lottery_statistics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `lottery_id` int NOT NULL,
  `month` int NOT NULL,
  `year` int NOT NULL,
  `win_count` int DEFAULT '0',
  `miss_count` int DEFAULT '0',
  `note_text` varchar(255) DEFAULT '',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_stats_lottery_month_year` (`lottery_id`,`month`,`year`),
  CONSTRAINT `lottery_statistics_ibfk_1` FOREIGN KEY (`lottery_id`) REFERENCES `lotteries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lottery_statistics`
--

LOCK TABLES `lottery_statistics` WRITE;
/*!40000 ALTER TABLE `lottery_statistics` DISABLE KEYS */;
INSERT INTO `lottery_statistics` VALUES (1,1,3,2569,2,0,'สถิติเข้า 2 ครั้ง เดือนนี้','2026-03-08 15:04:10','2026-03-08 15:04:10');
/*!40000 ALTER TABLE `lottery_statistics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `package_orders`
--

DROP TABLE IF EXISTS `package_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `package_orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `package_name` varchar(120) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(10) DEFAULT 'THB',
  `platform` varchar(50) DEFAULT 'google_play',
  `fee_percent` decimal(5,2) DEFAULT '0.00',
  `fee_amount` decimal(10,2) DEFAULT '0.00',
  `net_amount` decimal(10,2) DEFAULT '0.00',
  `payment_method` varchar(50) DEFAULT NULL,
  `status` varchar(30) DEFAULT 'paid',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `package_orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `package_orders`
--

LOCK TABLES `package_orders` WRITE;
/*!40000 ALTER TABLE `package_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `package_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `predictions`
--

DROP TABLE IF EXISTS `predictions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `predictions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `prediction_text` text,
  `created_at` datetime DEFAULT NULL,
  `result_number` int DEFAULT NULL,
  `confidence` float DEFAULT NULL,
  `prediction_type` varchar(50) DEFAULT NULL,
  `model_version` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `predictions`
--

LOCK TABLES `predictions` WRITE;
/*!40000 ALTER TABLE `predictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `predictions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `plan` varchar(50) DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '1',
  `vip_level` int DEFAULT '0',
  `vip_expire` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `uk_users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,NULL,'songtest01@gmail.com','songtest01','$2b$10$nYuVwMt2lMCsqOKnTwA9ZOv7nhVGFi1Rl1cnCXcuaQ66ppXqOOdlm',NULL,1,1,'2026-04-08 11:38:37','2026-03-09 04:25:49','2026-03-09 14:44:45'),(2,NULL,'admin@maenmak.local','admin','$2b$10$yYx4jQk2nE6Hn7f4T1Y6xO7zHqC3m7x1kJ7l6x0f5bY1n7k8aYQ5e',NULL,1,0,NULL,'2026-03-09 06:36:27','2026-03-09 14:44:45'),(3,NULL,'munsdeemedai@gmail.com','Munsdee','$2b$10$s26gDqYc6SR1Sw3qObIibucLZf6b4Wo6kYzG/0NapMaAMlxAoM1D.','0928060177',1,0,NULL,'2026-03-10 07:23:18','2026-03-10 07:23:18');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vip_members`
--

DROP TABLE IF EXISTS `vip_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vip_members` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `vip_expire` date DEFAULT NULL,
  `package_name` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `vip_members_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vip_members`
--

LOCK TABLES `vip_members` WRITE;
/*!40000 ALTER TABLE `vip_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `vip_members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-19 18:39:10

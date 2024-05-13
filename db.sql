CREATE DATABASE  IF NOT EXISTS `projectshoes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `projectshoes`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projectshoes
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_category`
--

DROP TABLE IF EXISTS `tbl_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(300) COLLATE utf8mb4_bin NOT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  `seo` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_create_category_idx` (`create_by`),
  KEY `fk_user_update_category_idx` (`update_by`),
  CONSTRAINT `fk_user_create_category` FOREIGN KEY (`create_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_update_category` FOREIGN KEY (`update_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_category`
--

LOCK TABLES `tbl_category` WRITE;
/*!40000 ALTER TABLE `tbl_category` DISABLE KEYS */;
INSERT INTO `tbl_category` VALUES (1,'Giày Adidas',1,1,'2024-01-11 00:00:00',NULL,1,'abc',NULL),(2,'GiàyNike',1,1,'2024-02-11 00:00:00',NULL,1,'cde',NULL),(3,'Converse',1,1,'2024-01-21 00:00:00',NULL,0,'',NULL),(4,'Boot',1,1,'2024-02-20 00:00:00',NULL,0,'',NULL),(5,'Puma',1,1,'2024-02-28 00:00:00',NULL,0,'',NULL),(6,'Giay cao got',1,1,'2024-05-04 00:00:00',NULL,1,'',NULL);
/*!40000 ALTER TABLE `tbl_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_contact`
--

DROP TABLE IF EXISTS `tbl_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lastname` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `mobile` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `request_type` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `message` varchar(1200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_contact`
--

LOCK TABLES `tbl_contact` WRITE;
/*!40000 ALTER TABLE `tbl_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_product`
--

DROP TABLE IF EXISTS `tbl_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `price` decimal(15,2) DEFAULT NULL,
  `sale_price` decimal(15,2) DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `is_hot` tinyint DEFAULT NULL,
  `short_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `detail_description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `seo` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category_product_idx` (`category_id`),
  KEY `fk_user_create_product` (`create_by`),
  KEY `fk_user_update_product` (`update_by`),
  CONSTRAINT `fk_category_product` FOREIGN KEY (`category_id`) REFERENCES `tbl_category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_create_product` FOREIGN KEY (`create_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_update_product` FOREIGN KEY (`update_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product`
--

LOCK TABLES `tbl_product` WRITE;
/*!40000 ALTER TABLE `tbl_product` DISABLE KEYS */;
INSERT INTO `tbl_product` VALUES (1,2,'Nike Air Force 1 07 Cam','Product/Avatar/avatar1.jpg',5000000.00,NULL,1,1,'2023-03-15 00:00:00','2024-02-23 00:00:00',1,0,'','',NULL),(2,2,'Nike Air Force 1 07 LV8','Product/Avatar/avatar2.jpg',3900000.00,NULL,1,1,'2023-06-07 00:00:00','2024-02-23 00:00:00',1,0,'','',NULL),(3,2,'Nike Air Force 1 07','Product/Avatar/avartar3.jpg',2000000.00,NULL,1,1,'2023-11-09 00:00:00','2024-02-23 00:00:00',1,0,'','',NULL),(4,2,'LeBron 19','Product/Avatar/avatar4.png',5600000.00,NULL,1,1,'2023-12-14 00:00:00','2024-02-23 00:00:00',1,0,'','',NULL),(5,2,'Nike Blazer x sacai x KAWS','Product/Avatar/avatar5.jpg',5100000.00,NULL,1,1,'2024-01-31 00:00:00','2024-02-23 00:00:00',1,0,'','',NULL),(6,2,'Nike Air Max 90','Product/Avatar/avatar6.jpg',5500000.00,NULL,1,1,'2024-03-15 00:00:00','2024-02-28 00:00:00',1,1,'','',NULL),(9,2,'Nike Air Huarache PRM QS','Product/Avatar/avatar7.jpg',5829000.00,NULL,1,1,'2024-01-31 00:00:00','2024-02-27 00:00:00',1,0,'','',NULL),(10,2,'Kyrie Infinity','Product/Avatar/avatar8.jpg',4829000.00,NULL,1,1,'2024-02-23 00:00:00',NULL,1,0,'','',NULL),(11,2,'Niken VSS8','Product/Avatar/avatar9.jpg',11000000.00,NULL,1,1,'2024-02-28 00:00:00','2024-02-28 00:00:00',0,0,'','',NULL),(12,1,'Nike SCC2','Product/Avatar/avatar11.jpg',8000000.00,NULL,1,1,'2024-02-29 00:00:00','2024-02-29 00:00:00',0,0,'','',NULL);
/*!40000 ALTER TABLE `tbl_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_product_image`
--

DROP TABLE IF EXISTS `tbl_product_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_product_image` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `title` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `path` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pr_image_product_idx` (`product_id`),
  CONSTRAINT `fk_pr_image_product` FOREIGN KEY (`product_id`) REFERENCES `tbl_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_product_image`
--

LOCK TABLES `tbl_product_image` WRITE;
/*!40000 ALTER TABLE `tbl_product_image` DISABLE KEYS */;
INSERT INTO `tbl_product_image` VALUES (11,1,'image1-4.png','Product/Image/image1-4.png',NULL,NULL,'2024-02-23 20:27:45',NULL,1),(12,1,'image1-1.png','Product/Image/image1-1.png',NULL,NULL,'2024-02-23 20:27:45',NULL,1),(13,1,'image1-2.png','Product/Image/image1-2.png',NULL,NULL,'2024-02-23 20:27:45',NULL,1),(14,1,'image1-3.png','Product/Image/image1-3.png',NULL,NULL,'2024-02-23 20:27:45',NULL,1),(15,2,'img2-1.png','Product/Image/img2-1.png',NULL,NULL,'2024-02-23 20:31:36',NULL,1),(16,2,'img2-2.png','Product/Image/img2-2.png',NULL,NULL,'2024-02-23 20:31:36',NULL,1),(17,2,'img2-3.png','Product/Image/img2-3.png',NULL,NULL,'2024-02-23 20:31:36',NULL,1),(18,2,'img2-4.png','Product/Image/img2-4.png',NULL,NULL,'2024-02-23 20:31:36',NULL,1),(19,3,'img3-1.png','Product/Image/img3-1.png',NULL,NULL,'2024-02-23 20:34:30',NULL,1),(20,3,'img3-2.png','Product/Image/img3-2.png',NULL,NULL,'2024-02-23 20:34:30',NULL,1),(21,3,'img3-3.png','Product/Image/img3-3.png',NULL,NULL,'2024-02-23 20:34:30',NULL,1),(22,3,'img3-4.png','Product/Image/img3-4.png',NULL,NULL,'2024-02-23 20:34:30',NULL,1),(23,4,'img4-1.png','Product/Image/img4-1.png',NULL,NULL,'2024-02-23 20:38:39',NULL,1),(24,4,'img4-4.png','Product/Image/img4-4.png',NULL,NULL,'2024-02-23 20:38:39',NULL,1),(25,4,'img4-3.png','Product/Image/img4-3.png',NULL,NULL,'2024-02-23 20:38:39',NULL,1),(26,4,'img4-2.png','Product/Image/img4-2.png',NULL,NULL,'2024-02-23 20:38:39',NULL,1),(27,5,'img5-2.png','Product/Image/img5-2.png',NULL,NULL,'2024-02-23 20:49:18',NULL,1),(28,5,'img5-3.png','Product/Image/img5-3.png',NULL,NULL,'2024-02-23 20:49:18',NULL,1),(29,5,'img5-4.png','Product/Image/img5-4.png',NULL,NULL,'2024-02-23 20:49:18',NULL,1),(30,5,'img5-1.png','Product/Image/img5-1.png',NULL,NULL,'2024-02-23 20:49:18',NULL,1),(31,6,'img6-1.png','Product/Image/img6-1.png',NULL,NULL,'2024-02-23 20:52:03',NULL,1),(32,6,'img6-2.png','Product/Image/img6-2.png',NULL,NULL,'2024-02-23 20:52:03',NULL,1),(33,6,'img6-4.png','Product/Image/img6-4.png',NULL,NULL,'2024-02-23 20:52:03',NULL,1),(34,6,'img6-3.png','Product/Image/img6-3.png',NULL,NULL,'2024-02-23 20:52:03',NULL,1),(35,9,'img7-1.png','Product/Image/img7-1.png',NULL,NULL,'2024-02-23 20:55:19',NULL,1),(36,9,'img7-4.png','Product/Image/img7-4.png',NULL,NULL,'2024-02-23 20:55:19',NULL,1),(37,9,'img7-3.png','Product/Image/img7-3.png',NULL,NULL,'2024-02-23 20:55:19',NULL,1),(38,9,'img7-2.png','Product/Image/img7-2.png',NULL,NULL,'2024-02-23 20:55:19',NULL,1),(39,10,'img8-3.png','Product/Image/img8-3.png',NULL,NULL,'2024-02-23 20:57:17',NULL,1),(40,10,'img8-1.png','Product/Image/img8-1.png',NULL,NULL,'2024-02-23 20:57:17',NULL,1),(41,10,'img8-2.png','Product/Image/img8-2.png',NULL,NULL,'2024-02-23 20:57:17',NULL,1),(42,10,'img8-4.png','Product/Image/img8-4.png',NULL,NULL,'2024-02-23 20:57:17',NULL,1),(51,11,'img9-4.jpg','Product/Image/img9-4.jpg',NULL,NULL,'2024-02-28 00:17:06',NULL,1),(52,11,'img9-1.jpg','Product/Image/img9-1.jpg',NULL,NULL,'2024-02-28 00:17:06',NULL,1),(53,11,'img9-2.jpg','Product/Image/img9-2.jpg',NULL,NULL,'2024-02-28 00:17:06',NULL,1),(54,11,'img9-3.jpg','Product/Image/img9-3.jpg',NULL,NULL,'2024-02-28 00:17:06',NULL,1),(55,12,'img11-1.jpg','Product/Image/img11-1.jpg',NULL,NULL,'2024-02-29 14:07:25',NULL,1),(56,12,'img11-2.jpg','Product/Image/img11-2.jpg',NULL,NULL,'2024-02-29 14:07:25',NULL,1);
/*!40000 ALTER TABLE `tbl_product_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_role`
--

DROP TABLE IF EXISTS `tbl_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_create_by_user_idx` (`create_by`),
  KEY `fk_update_by_role_idx` (`update_by`),
  CONSTRAINT `fk_updateby_user` FOREIGN KEY (`create_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_updateby_users` FOREIGN KEY (`update_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_role`
--

LOCK TABLES `tbl_role` WRITE;
/*!40000 ALTER TABLE `tbl_role` DISABLE KEYS */;
INSERT INTO `tbl_role` VALUES (1,'ADMIN',1,1,NULL,NULL,1,NULL),(2,'GUEST',1,1,NULL,NULL,1,NULL),(3,'admin2',1,1,'2024-02-20 00:00:00',NULL,0,''),(4,' admin2',1,1,'2024-02-19 00:00:00',NULL,1,''),(5,'guest1',1,1,'2024-02-28 00:00:00',NULL,1,'');
/*!40000 ALTER TABLE `tbl_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sale_order`
--

DROP TABLE IF EXISTS `tbl_sale_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `code` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `total` decimal(15,2) DEFAULT NULL,
  `customer_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `customer_mobile` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `customer_email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `customer_address` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_sale_order_idx` (`user_id`),
  KEY `fk_createby_sale_order_idx` (`create_by`),
  KEY `fk_user_update_sale_order_idx` (`update_by`),
  CONSTRAINT `fk_createby_sale_order` FOREIGN KEY (`create_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_sale_order` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_update_sale_order` FOREIGN KEY (`update_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_order`
--

LOCK TABLES `tbl_sale_order` WRITE;
/*!40000 ALTER TABLE `tbl_sale_order` DISABLE KEYS */;
INSERT INTO `tbl_sale_order` VALUES (1,NULL,'a2024125',5000000.00,'a','123456788',NULL,'Phú THọ',1,NULL,'2024-02-27 00:00:00',NULL,1),(2,NULL,'07623333332024125',5000000.00,'Long','0762333333',NULL,'Hai Phong',1,NULL,'2024-02-27 00:00:00',NULL,1),(3,1,'01234567892024125',8900000.00,'Linh','0123456789','linh@gmail.com','Hà Nội',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(4,1,'09351799992024126',8900000.00,'Hoang Van','0935179999','van@gmail.com','Ninh Bình',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(5,1,'07884519992024126',8900000.00,'Triệu Vân','0788451999','trieu@gmail.com','Thanh Hóa',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(6,1,'0382569992024126',32000000.00,'Nguyên','038256999','nguyen@gmail.com','Hai Phong',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(7,1,'09876543212024126',14000000.00,'anh','0987654321','quocanh@gmail.com','Hải Phòng',NULL,NULL,'2024-02-27 17:30:37',NULL,0),(8,1,'06365897792024126',8900000.00,'Triệu Vân','0636589779','trieuvan@gmail.com','HaiDuong',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(9,1,'03781234562024126',5900000.00,'nguyen','0378123456','nguyenhp@gmail.com','Hải Phòng',NULL,NULL,'2024-02-27 17:30:37',NULL,1),(10,1,'06365897792024126',10000000.00,'Triệu Vân','0636589779','trieuvan@gmail.com','HaiDuong',NULL,NULL,'2024-02-27 17:30:37',NULL,0),(11,1,'09351799562024129',40000000.00,'Nguoi Dung','0935179956','ng@gmail.com','Hải Dương',NULL,NULL,NULL,NULL,0),(12,NULL,'0762380296202448',5900000.00,'luan','0762380296',NULL,'Hải Phòng',1,NULL,NULL,NULL,1),(13,1,'06365897792024412',13900000.00,'Triệu Vân','0636589779','trieuvan@gmail.com','HaiDuong',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `tbl_sale_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sale_order_product`
--

DROP TABLE IF EXISTS `tbl_sale_order_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sale_order_product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sale_order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_sale_order_product_idx` (`product_id`),
  KEY `fk_sale_order_s_o_product_idx` (`sale_order_id`),
  CONSTRAINT `fk_product_sale_order_product` FOREIGN KEY (`product_id`) REFERENCES `tbl_product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_sale_order_s_o_product` FOREIGN KEY (`sale_order_id`) REFERENCES `tbl_sale_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sale_order_product`
--

LOCK TABLES `tbl_sale_order_product` WRITE;
/*!40000 ALTER TABLE `tbl_sale_order_product` DISABLE KEYS */;
INSERT INTO `tbl_sale_order_product` VALUES (1,1,1,1,NULL,NULL,NULL,NULL,1,NULL),(2,2,1,1,NULL,NULL,NULL,NULL,1,NULL),(3,3,1,1,NULL,NULL,NULL,NULL,1,NULL),(4,3,2,1,NULL,NULL,NULL,NULL,1,NULL),(5,4,1,1,NULL,NULL,NULL,NULL,1,NULL),(6,4,2,1,NULL,NULL,NULL,NULL,1,NULL),(7,5,1,1,NULL,NULL,NULL,NULL,1,NULL),(8,5,2,1,NULL,NULL,NULL,NULL,1,NULL),(9,6,3,2,NULL,NULL,NULL,NULL,1,NULL),(10,6,1,2,NULL,NULL,NULL,NULL,1,NULL),(11,6,5,2,NULL,NULL,NULL,NULL,1,NULL),(12,6,2,2,NULL,NULL,NULL,NULL,1,NULL),(13,7,3,7,NULL,NULL,NULL,NULL,1,NULL),(14,8,1,1,NULL,NULL,NULL,NULL,1,NULL),(15,8,2,1,NULL,NULL,NULL,NULL,1,NULL),(16,9,2,1,NULL,NULL,NULL,NULL,1,NULL),(17,9,3,1,NULL,NULL,NULL,NULL,1,NULL),(18,10,1,2,NULL,NULL,NULL,NULL,1,NULL),(19,11,1,8,NULL,NULL,NULL,NULL,1,NULL),(20,12,2,1,NULL,NULL,NULL,NULL,1,NULL),(21,12,3,1,NULL,NULL,NULL,NULL,1,NULL),(22,13,2,1,NULL,NULL,NULL,NULL,1,NULL),(23,13,1,2,NULL,NULL,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `tbl_sale_order_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user`
--

DROP TABLE IF EXISTS `tbl_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `mobile` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `address` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `avatar` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_create_by_user_idx` (`create_by`),
  KEY `fk_update_by_user_idx` (`update_by`),
  CONSTRAINT `fk_create_by_user` FOREIGN KEY (`create_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_update_by_user` FOREIGN KEY (`update_by`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user`
--

LOCK TABLES `tbl_user` WRITE;
/*!40000 ALTER TABLE `tbl_user` DISABLE KEYS */;
INSERT INTO `tbl_user` VALUES (1,'admin','$2a$04$TY3UYyoOqn3tVb21ZfXRv.bXk02lPR4fLcssDwFasSlG8mrc990iW','Hoàng Luân','0762380299','duongqua@gmail.com','HaNoi',NULL,1,1,NULL,NULL,1,''),(2,'guest','$2a$04$TY3UYyoOqn3tVb21ZfXRv.bXk02lPR4fLcssDwFasSlG8mrc990iW','Triệu Vân','0636589779','trieuvan@gmail.com','HaiDuong',NULL,1,1,NULL,NULL,1,''),(9,'luan','$2a$04$Axr.LiBal7xzd83lPlVL4uajh6RotXt/BJ21hLgQouD8YRZvR1XXu','luan','0762380296','luan@gmail.com','Hải Phòng',NULL,1,1,NULL,NULL,1,''),(10,'nguyen','$2a$04$XQisT4a5AX3a9giikVnLg.SH6LfKMqOnGDYjr03.WaX/j7xLvJinG','nguyen','0935179999','nguyen@gmail.com','Hải Phòng',NULL,NULL,NULL,NULL,NULL,1,NULL),(11,'demlanhleo','$2a$04$aaabaqZvrQpXc/edz6MaGudKAIBNmtvc4Eg0SGMcveRnwJW10ZV8u','nguyen','0378123456','nguyenhp@gmail.com','Hải Phòng',NULL,NULL,NULL,NULL,NULL,1,NULL),(12,'luan','$2a$04$TY3UYyoOqn3tVb21ZfXRv.bXk02lPR4fLcssDwFasSlG8mrc990iW','HoangLuan','0762380296','hoangvanluan9a1@gmail.com','Hải Phòng',NULL,1,1,'2024-02-27 00:00:00',NULL,1,''),(13,'anh','$2a$04$4yMiqSEfr12cTl/XuoeJie6WdyHUprCRj5aoigFOLwaA1wgI0hThC','NgoAnh','0965999686','anh@gmail.com','Hải Phòng',NULL,1,1,'2024-02-27 00:00:00',NULL,1,''),(14,'loan','$2a$04$X0ZvzDCnqpe4WvgKWlmXbu/bpcIhC6lUC/7ltPnbXZZw12bgZe8ra','Loan','0935124687','loan@gmail.com','Bắc Giang 1',NULL,1,1,'2024-02-28 00:00:00',NULL,1,''),(15,'nguoidung','$2a$04$EO8j0u7mQ81s7SGrYsaikuXUxfbW0YwddGoXYIIDtVVZk1DnBzMKa','Nguoi Dung','0935179956','ng@gmail.com','Hải Phòng',NULL,NULL,NULL,NULL,NULL,1,NULL),(16,'kcntt','$2a$04$SX5Z0W1M9arZz3zDx7NyEegckR8NAChfMwoYLWbtQCJQxv0.hOHl2','Loan','0123456789','loan@gmail.com','Hà Nội',NULL,1,1,'2024-02-29 00:00:00',NULL,1,''),(17,'test','$2a$04$z9lBi9nya69cqc/EBjROkO.5bmUzmPChrbDZ1jxbuie63rBxPM1MO','Tiểu Vũ','0123456789','hoangvanluan@gmail.com','',NULL,2,2,'2024-02-29 00:00:00',NULL,1,''),(19,'abc','$2a$04$jIHDDQm4tGQKlmzAsd1ntOGowb6CptX0hURKVCqnXK4ubc1rw4nvS','QuocAnh','0364801195','anhlx@gmail.com','Hai Phong',NULL,NULL,NULL,NULL,NULL,1,NULL),(20,'admin','$2a$04$XLZndx.aCfFjK8Av41fqeOf56tX9DlT6LydeMWKz6mmTGiPnGOL42','','','','',NULL,NULL,NULL,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `tbl_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_user_role`
--

DROP TABLE IF EXISTS `tbl_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `role_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role_idx` (`user_id`),
  KEY `fk_role_user_idx` (`role_id`),
  CONSTRAINT `fk_role_user` FOREIGN KEY (`role_id`) REFERENCES `tbl_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`user_id`) REFERENCES `tbl_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_user_role`
--

LOCK TABLES `tbl_user_role` WRITE;
/*!40000 ALTER TABLE `tbl_user_role` DISABLE KEYS */;
INSERT INTO `tbl_user_role` VALUES (1,1,1),(26,2,2),(27,9,2),(28,10,2),(29,11,2),(30,15,2),(31,19,2),(32,20,2);
/*!40000 ALTER TABLE `tbl_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-13 10:07:03

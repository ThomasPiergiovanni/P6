-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: p6_db
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street_number` varchar(64) DEFAULT NULL,
  `street_name` varchar(128) DEFAULT NULL,
  `ZIP_code` varchar(64) DEFAULT NULL,
  `city_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'16','Avenue Jean-Moulin','75014','Paris'),(2,'99b','Avenue du Général Leclerc','75007','Paris'),(3,'65','Rue de Lagny','75020','Paris'),(4,'80','Rue de Wattignies','75012','Paris'),(5,'17','Rue Baudin','94200','Ivry-sur-Seine'),(6,'40','Avenue Laplace','94110','Arceuil'),(7,'55','Rue du Faubourg Saint-Honoré','75008','Paris');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'boisson'),(3,'dessert'),(1,'pizza');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `unit_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name_UNIQUE` (`name`),
  KEY `fk_ingredient_unit1_idx` (`unit_id`),
  CONSTRAINT `fk_ingredient_unit1` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingredient`
--

LOCK TABLES `ingredient` WRITE;
/*!40000 ALTER TABLE `ingredient` DISABLE KEYS */;
INSERT INTO `ingredient` VALUES (1,'pâtes à pizza',1),(2,'sauce tomate',2),(3,'jambon cuit',1),(4,'mozzarella',1),(5,'coca-cola',3),(6,'champignon',1);
/*!40000 ALTER TABLE `ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_number` int NOT NULL,
  `user_id` int NOT NULL,
  `restaurant_id` int NOT NULL,
  `address_id` int NOT NULL,
  `status_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number_UNIQUE` (`order_number`),
  KEY `fk_order_address1_idx` (`address_id`),
  KEY `fk_order_user1_idx` (`user_id`),
  KEY `fk_order_pizzeria1_idx` (`restaurant_id`),
  KEY `fk_order_status1_idx` (`status_id`),
  CONSTRAINT `fk_order_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `fk_order_restaurant1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`),
  CONSTRAINT `fk_order_status1` FOREIGN KEY (`status_id`) REFERENCES `status` (`id`),
  CONSTRAINT `fk_order_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,1,3,1,2,1),(2,2,3,1,2,4),(3,3,4,2,5,5);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderline`
--

DROP TABLE IF EXISTS `orderline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderline` (
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_has_product_product1_idx` (`product_id`),
  KEY `fk_order_has_product_order1_idx` (`order_id`),
  CONSTRAINT `fk_order_has_product_order1` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
  CONSTRAINT `fk_order_has_product_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderline`
--

LOCK TABLES `orderline` WRITE;
/*!40000 ALTER TABLE `orderline` DISABLE KEYS */;
INSERT INTO `orderline` VALUES (1,1,1),(1,3,1),(2,1,2),(2,2,1),(2,3,3),(2,4,3);
/*!40000 ALTER TABLE `orderline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `price`
--

DROP TABLE IF EXISTS `price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `price` (
  `id` int NOT NULL AUTO_INCREMENT,
  `start_validity_date` date NOT NULL,
  `end_validity_date` date NOT NULL,
  `price` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `price`
--

LOCK TABLES `price` WRITE;
/*!40000 ALTER TABLE `price` DISABLE KEYS */;
INSERT INTO `price` VALUES (1,'2019-01-01','2019-12-31',10.50),(2,'2020-01-01','2020-12-31',11.50),(3,'2019-01-01','2019-12-31',12.00),(4,'2020-01-01','2020-12-31',13.00),(5,'2019-01-01','2019-12-31',1.50),(6,'2020-01-01','2020-12-31',2.00),(7,'2019-01-01','2019-12-31',3.00),(8,'2020-01-01','2020-12-31',3.50);
/*!40000 ALTER TABLE `price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_product_category1_idx` (`category_id`),
  CONSTRAINT `fk_product_category1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'Margherita',1),(2,'Regina',1),(3,'Coca-Cola',2),(4,'Tiramisù',3);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productprice`
--

DROP TABLE IF EXISTS `productprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productprice` (
  `product_id` int NOT NULL,
  `price_id` int NOT NULL,
  PRIMARY KEY (`product_id`,`price_id`),
  KEY `fk_productprice_product1_idx` (`product_id`),
  KEY `fk_productprice_price1_idx` (`price_id`),
  CONSTRAINT `fk_productprice_price1_idx` FOREIGN KEY (`price_id`) REFERENCES `price` (`id`),
  CONSTRAINT `fk_productprice_product1_idx` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productprice`
--

LOCK TABLES `productprice` WRITE;
/*!40000 ALTER TABLE `productprice` DISABLE KEYS */;
INSERT INTO `productprice` VALUES (1,1),(1,2),(2,3),(2,4),(3,5),(3,6),(4,7),(4,8);
/*!40000 ALTER TABLE `productprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receipt`
--

DROP TABLE IF EXISTS `receipt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receipt` (
  `product_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`product_id`,`ingredient_id`),
  KEY `fk_receipt_ingredient1_idx` (`ingredient_id`),
  CONSTRAINT `fk_receipt_ingredient1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
  CONSTRAINT `fk_receipt_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receipt`
--

LOCK TABLES `receipt` WRITE;
/*!40000 ALTER TABLE `receipt` DISABLE KEYS */;
INSERT INTO `receipt` VALUES (1,1,100),(1,2,20),(1,4,50),(2,1,100),(2,2,20),(2,3,20),(2,4,50),(2,6,10),(3,5,1);
/*!40000 ALTER TABLE `receipt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `restaurant`
--

DROP TABLE IF EXISTS `restaurant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `restaurant` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name_UNIQUE` (`name`),
  KEY `fk_pizzeria_address1_idx` (`address_id`),
  CONSTRAINT `fk_pizzeria_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `restaurant`
--

LOCK TABLES `restaurant` WRITE;
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
INSERT INTO `restaurant` VALUES (1,'OC Pizza Paris14','ocpizzaparis14@fakeemail.com','75014',1),(2,'OC Pizza Paris12','ocpizzaparis12@fakeemail.com','75012',4);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (4,'client'),(3,'livreur'),(2,'pizzaiolo'),(1,'reponsable'),(5,'visiteur');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (6,'Annulée'),(4,'En livraison'),(2,'En préparation'),(5,'Livrée'),(1,'Nouvelle'),(3,'Préparée');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `restaurant_id` int NOT NULL,
  `ingredient_id` int NOT NULL,
  `quantity` int NOT NULL,
  PRIMARY KEY (`restaurant_id`,`ingredient_id`),
  KEY `fk_stock_ingredient1_idx` (`ingredient_id`),
  CONSTRAINT `fk_stock_ingredient1` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredient` (`id`),
  CONSTRAINT `fk_stock_restaurant1` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (1,1,10000),(1,2,500),(1,3,2000),(1,4,3000),(1,5,100),(1,6,3000),(2,1,5000),(2,2,250),(2,3,1000),(2,4,1500),(2,5,50),(2,6,1500);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit`
--

DROP TABLE IF EXISTS `unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit`
--

LOCK TABLES `unit` WRITE;
/*!40000 ALTER TABLE `unit` DISABLE KEYS */;
INSERT INTO `unit` VALUES (2,'centilitre'),(1,'gramme'),(3,'unitaire');
/*!40000 ALTER TABLE `unit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(128) DEFAULT NULL,
  `last_name` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `password` varchar(128) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `role_id` int NOT NULL,
  `address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_role1_idx` (`role_id`),
  KEY `fk_user_address1_idx` (`address_id`),
  CONSTRAINT `fk_user_address1` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  CONSTRAINT `fk_user_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Alexandra','Cheffeu','alexandra_cheffeu@fakeemail.com','xxxxx','5040302010',1,4),(2,'Rajat','Di Pomodoro','rajat_dipomodoro@fakeemail.com','yyyyy','0150024003',2,6),(3,'Elodie','Pasouvent','elodie_pasouvent@fakeemail.com','','1122334455',5,2),(4,'Hans','Legourmand','hans_legourmand@fakeemail.com','mmmmm','5544332211',4,3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-15 13:24:33

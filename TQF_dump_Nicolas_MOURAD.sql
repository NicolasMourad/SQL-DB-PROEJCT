CREATE DATABASE  IF NOT EXISTS `thequanticfactory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `thequanticfactory`;
-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: thequanticfactory
-- ------------------------------------------------------
-- Server version	8.0.30

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
-- Table structure for table `channeltype`
--

DROP TABLE IF EXISTS `channeltype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `channeltype` (
  `ChannelTypeID` smallint NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  PRIMARY KEY (`ChannelTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `channeltype`
--

LOCK TABLES `channeltype` WRITE;
/*!40000 ALTER TABLE `channeltype` DISABLE KEYS */;
/*!40000 ALTER TABLE `channeltype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content` (
  `ContentID` int NOT NULL AUTO_INCREMENT,
  `ClientContentID` bigint NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`ContentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contentprice`
--

DROP TABLE IF EXISTS `contentprice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contentprice` (
  `ContentPriceID` mediumint NOT NULL AUTO_INCREMENT,
  `ContentID` int NOT NULL,
  `Price` decimal(8,2) NOT NULL,
  `Currency` char(3) NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`ContentPriceID`),
  KEY `fk_ContentPrice_ContentID` (`ContentID`),
  CONSTRAINT `fk_ContentPrice_ContentID` FOREIGN KEY (`ContentID`) REFERENCES `content` (`ContentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contentprice`
--

LOCK TABLES `contentprice` WRITE;
/*!40000 ALTER TABLE `contentprice` DISABLE KEYS */;
/*!40000 ALTER TABLE `contentprice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `CustomerID` bigint NOT NULL AUTO_INCREMENT,
  `ClientCustomerID` bigint NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerdata`
--

DROP TABLE IF EXISTS `customerdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerdata` (
  `CustomerChannelID` bigint NOT NULL AUTO_INCREMENT,
  `CustomerID` bigint NOT NULL,
  `ChannelTypeID` smallint NOT NULL,
  `ChannelValue` varchar(600) NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`CustomerChannelID`),
  KEY `fk_CustomerData_CustomerID` (`CustomerID`),
  KEY `fk_CustomerData_ChannelTypeID` (`ChannelTypeID`),
  CONSTRAINT `fk_CustomerData_ChannelTypeID` FOREIGN KEY (`ChannelTypeID`) REFERENCES `channeltype` (`ChannelTypeID`),
  CONSTRAINT `fk_CustomerData_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerdata`
--

LOCK TABLES `customerdata` WRITE;
/*!40000 ALTER TABLE `customerdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerevent`
--

DROP TABLE IF EXISTS `customerevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerevent` (
  `EventID` bigint NOT NULL AUTO_INCREMENT,
  `ClientEventID` bigint NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`EventID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerevent`
--

LOCK TABLES `customerevent` WRITE;
/*!40000 ALTER TABLE `customerevent` DISABLE KEYS */;
/*!40000 ALTER TABLE `customerevent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customereventdata`
--

DROP TABLE IF EXISTS `customereventdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customereventdata` (
  `EventDataID` bigint NOT NULL AUTO_INCREMENT,
  `EventID` bigint NOT NULL,
  `ContentID` int NOT NULL,
  `CustomerID` bigint NOT NULL,
  `EventTypeID` smallint NOT NULL,
  `EventDate` timestamp NOT NULL,
  `Quantity` smallint NOT NULL,
  `InsertDate` timestamp NOT NULL,
  PRIMARY KEY (`EventDataID`),
  KEY `fk_CustomerEventData_EventID` (`EventID`),
  KEY `fk_CustomerEventData_ContentID` (`ContentID`),
  KEY `fk_CustomerEventData_CustomerID` (`CustomerID`),
  KEY `fk_CustomerEventData_EventTypeID` (`EventTypeID`),
  CONSTRAINT `fk_CustomerEventData_ContentID` FOREIGN KEY (`ContentID`) REFERENCES `content` (`ContentID`),
  CONSTRAINT `fk_CustomerEventData_CustomerID` FOREIGN KEY (`CustomerID`) REFERENCES `customer` (`CustomerID`),
  CONSTRAINT `fk_CustomerEventData_EventID` FOREIGN KEY (`EventID`) REFERENCES `customerevent` (`EventID`),
  CONSTRAINT `fk_CustomerEventData_EventTypeID` FOREIGN KEY (`EventTypeID`) REFERENCES `eventtype` (`EventTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customereventdata`
--

LOCK TABLES `customereventdata` WRITE;
/*!40000 ALTER TABLE `customereventdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `customereventdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventtype`
--

DROP TABLE IF EXISTS `eventtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `eventtype` (
  `EventTypeID` smallint NOT NULL AUTO_INCREMENT,
  `Name` varchar(30) NOT NULL,
  PRIMARY KEY (`EventTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventtype`
--

LOCK TABLES `eventtype` WRITE;
/*!40000 ALTER TABLE `eventtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `eventtype` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-27 19:28:02

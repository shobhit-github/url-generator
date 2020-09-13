-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: localhost    Database: UrlGen
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


--
--  Create Event
--

DROP EVENT IF EXISTS DeleteUrlEvent;

CREATE EVENT DeleteUrlEvent
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
ON COMPLETION NOT PRESERVE
ENABLE
DO DELETE FROM UrlGen.urls WHERE urls.createdAt < DATE_SUB(NOW() ,INTERVAL 30 DAY)

-- SET GLOBAL event_scheduler = ON;

--
-- Table structure for table `Analytics`
--

DROP TABLE IF EXISTS `Analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Analytics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `totalVisit` varchar(100) DEFAULT NULL,
  `countries` varchar(200) DEFAULT NULL,
  `raw_data` text,
  `url_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Analytics_FK` (`url_id`),
  CONSTRAINT `Analytics_FK` FOREIGN KEY (`url_id`) REFERENCES `urls` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Analytics`
--

LOCK TABLES `Analytics` WRITE;
/*!40000 ALTER TABLE `Analytics` DISABLE KEYS */;
INSERT INTO `Analytics` VALUES (1,'186350000','United States,United Kingdom,Germany,Japan,Canada','{\"engagement\":{\"avgVisitDuration\":291,\"bounceRate\":0.4237,\"pagesPerVisit\":6.46,\"totalVisits\":186350000},\"monthlyVisitsEstimate\":{\"2020-03-01\":193700000,\"2020-04-01\":205200000,\"2020-05-01\":197300000,\"2020-06-01\":181200000,\"2020-07-01\":186100000,\"2020-08-01\":186300000},\"name\":\"dropbox.com\",\"trafficShareByCountry\":[{\"United States\":0.3458},{\"United Kingdom\":0.0556},{\"Germany\":0.0431},{\"Japan\":0.042},{\"Canada\":0.0343}],\"trafficSources\":{\"Direct\":0.5601,\"Mail\":0.1744,\"Paid Referrals\":0.0096,\"Referrals\":0.1013,\"Search\":0.081,\"Social\":0.0733}}',1),(2,'587330','India,United States,Brazil,United Kingdom,Netherlands','{\"engagement\":{\"avgVisitDuration\":72,\"bounceRate\":0.8784,\"pagesPerVisit\":1.16,\"totalVisits\":587330},\"monthlyVisitsEstimate\":{\"2020-03-01\":625800,\"2020-04-01\":664300,\"2020-05-01\":630900,\"2020-06-01\":532100,\"2020-07-01\":584200,\"2020-08-01\":587300},\"name\":\"jsonlint.com\",\"trafficShareByCountry\":[{\"India\":0.2044},{\"United States\":0.1719},{\"Brazil\":0.041},{\"United Kingdom\":0.0323},{\"Netherlands\":0.0291}],\"trafficSources\":{\"Direct\":0.5993,\"Mail\":0.001,\"Paid Referrals\":4.9562,\"Referrals\":0.0121,\"Search\":0.3849,\"Social\":0.0025}}',2);
/*!40000 ALTER TABLE `Analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `urls`
--

DROP TABLE IF EXISTS `urls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `urls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `actualPath` text NOT NULL,
  `url` varchar(200) NOT NULL,
  `createdAt` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `urls`
--

LOCK TABLES `urls` WRITE;
/*!40000 ALTER TABLE `urls` DISABLE KEYS */;
INSERT INTO `urls` VALUES (1,'https://paper.dropbox.com/doc/Build-a-URL-shortener--A7hTAYBdH83BbdsY~AKmBk8xAg-BdG2JwuLz5jG4ke1kf4Ye','82626','2020-09-13 22:00:20'),(2,'https://jsonlint.com/','a705f','2020-09-13 22:04:15');
/*!40000 ALTER TABLE `urls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'UrlGen'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `DeleteUrlEvent` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 */ /*!50106 EVENT `DeleteUrlEvent` ON SCHEDULE EVERY 1 DAY STARTS '2020-09-13 15:18:41' ON COMPLETION NOT PRESERVE ENABLE DO DELETE FROM UrlGen.urls WHERE urls.createdAt < DATE_SUB(NOW() ,INTERVAL 30 DAY) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'UrlGen'
--
/*!50003 DROP FUNCTION IF EXISTS `GENERATE_URL_CODE` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  FUNCTION `GENERATE_URL_CODE`() RETURNS varchar(100) CHARSET latin1
BEGIN
	
	DECLARE RANDOM_TEXT VARCHAR(100) DEFAULT NULL;
	
	SELECT SUBSTRING(MD5( RAND() ) FROM 1 FOR 5) INTO RANDOM_TEXT;
	
	RETURN RANDOM_TEXT;
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getAnalytics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `getAnalytics`()
BEGIN
	SELECT * FROM UrlGen.urls AS U
		LEFT JOIN Analytics AS A ON A.url_id = U.id; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `saveAnalytics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `saveAnalytics`( IN urlId INT, IN totalVisits VARCHAR(100), IN country VARCHAR(200), IN rawData TEXT )
BEGIN
	
	INSERT INTO UrlGen.Analytics (url_id , totalVisit, countries, raw_data) VALUES ( urlId, totalVisits, country, rawData);

	SELECT * FROM UrlGen.urls AS U
		LEFT JOIN Analytics AS A ON A.url_id = U.id WHERE U.id = urlId; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `saveUrl` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE  PROCEDURE `saveUrl`( IN actualPath TEXT )
BEGIN
	
	
	INSERT INTO UrlGen.urls (actualPath, url) VALUES ( actualPath , GENERATE_URL_CODE() );

	SELECT * FROM UrlGen.urls AS U WHERE U.id = LAST_INSERT_ID() ; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-13 22:05:36

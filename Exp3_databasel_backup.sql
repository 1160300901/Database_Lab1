-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: localhost    Database: company
-- ------------------------------------------------------
-- Server version	5.7.15-log

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
-- Table structure for table `award`
--

DROP TABLE IF EXISTS `award`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `award` (
  `AID` int(11) NOT NULL AUTO_INCREMENT,
  `essn` varchar(30) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`AID`),
  KEY `fk_award_employee1_idx` (`essn`),
  CONSTRAINT `fk_award_employee1` FOREIGN KEY (`essn`) REFERENCES `employee` (`essn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `award`
--

LOCK TABLES `award` WRITE;
/*!40000 ALTER TABLE `award` DISABLE KEYS */;
INSERT INTO `award` VALUES (1,'00003',2000),(2,'00005',3250),(3,'00016',15550),(4,'00015',22000),(5,'00021',1200),(7,'00029',10000),(8,'00017',5000),(17,'00009',5000);
/*!40000 ALTER TABLE `award` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building` (
  `BID` int(11) NOT NULL,
  `BNAME` varchar(60) NOT NULL,
  `LOC` varchar(60) NOT NULL,
  PRIMARY KEY (`BID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (0,'ZXB','Hongkong'),(1,'CXB','Shanghai'),(2,'GWB','Harbin'),(3,'ZZB','US');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `CID` int(11) NOT NULL,
  `CNAME` varchar(60) NOT NULL,
  PRIMARY KEY (`CID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (0,'Tom'),(1,'Sam'),(2,'Jim'),(3,'Liu');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dno` varchar(30) NOT NULL,
  `dname` varchar(30) NOT NULL,
  `mgrssn` varchar(30) NOT NULL,
  PRIMARY KEY (`dno`),
  KEY `fo_mgessn_idx` (`mgrssn`),
  CONSTRAINT `fo_mgessn` FOREIGN KEY (`mgrssn`) REFERENCES `employee` (`essn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('AD-1','AD Department','00004'),('HR-0','Human Resource','00001'),('PD-0','PR Department','00005'),('RD-0','Research Department','00002'),('SD-0','Sales Department','00003');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `essn` varchar(30) NOT NULL,
  `ename` varchar(30) NOT NULL,
  `address` varchar(100) NOT NULL,
  `salary` float NOT NULL,
  `dno` varchar(30) NOT NULL,
  `BID` int(11) NOT NULL,
  `RID` int(11) NOT NULL,
  PRIMARY KEY (`essn`),
  KEY `dno_idx` (`dno`),
  KEY `fk_employee_building1_idx` (`BID`),
  KEY `fk_employee_rank1_idx` (`RID`),
  KEY `address_idx` (`address`),
  KEY `salary_idx` (`salary`),
  CONSTRAINT `fk_employee_building1` FOREIGN KEY (`BID`) REFERENCES `building` (`BID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_rank1` FOREIGN KEY (`RID`) REFERENCES `rank` (`RID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `foreign_dno` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('00001','Rex','US',10000,'RD-0',0,0),('00002','Sam','US',18000,'RD-0',1,2),('00003','Lost','FR',20000,'HR-0',1,2),('00004','张红','PRC',8000,'RD-0',2,2),('00005','Flash','PRC',12000,'HR-0',1,2),('00006','Stork','FR',1000,'PD-0',3,0),('00007','Bisu','KR',7000,'RD-0',1,1),('00008','tom','TR',4500,'HR-0',0,2),('00009','t1','PRC',9000,'SD-0',0,1),('00010','t2','PRC',6300,'RD-0',0,0),('00011','t3','FL',9000,'SD-0',0,0),('00012','t4','PRC',4000,'SD-0',0,0),('00013','t5','PRC',8000,'SD-0',0,0),('00014','t6','US',8000,'HR-0',0,0),('00015','t7','UK',7000,'SD-0',2,2),('00016','t8','TW',100,'PD-0',1,1),('00017','t9','HK',6000,'HR-0',0,3),('00018','t10','UK',5000,'SD-0',0,0),('00019','Lee','Tw',4400,'HR-0',0,0),('00020','Eng','TW',1000,'SD-0',0,0),('00021','one','TW',2000,'SD-0',0,0),('00022','two','TW',2000,'SD-0',3,1),('00023','three','PRC',3000,'SD-0',0,2),('00024','four','PRC',800,'SD-0',0,3),('00025','five','PRC',300,'SD-0',0,2),('00026','six','PRC',600,'SD-0',0,1),('00027','seven','PRC',300,'SD-0',0,0),('00028','eight','PRC',300,'SD-0',1,2),('00029','nine','PRC',800,'PD-0',2,0),('00030','ten','PRC',600,'RD-0',0,0),('00031','eleven','UK',100,'AD-1',0,0),('00032','twelve','UK',300,'RD-0',0,0),('00033','thirteen','UK',7000,'RD-0',0,0),('00034','forteen','UK',3000,'RD-0',3,2),('00035','fifteen','IT',100,'PD-0',1,0),('00036','sixteen','IT',300,'AD-1',0,3),('00037','seventeen','IT',600,'AD-1',0,2),('00038','nineteen','IT',79530,'HR-0',0,1),('00039','twenty','KA',16119,'RD-0',0,2),('00040','january','KA',16315,'RD-0',0,1),('00041','java','KA',1576,'SD-0',0,2),('00042','python','KA',1618,'SD-0',2,0),('00043','cpp','GE',15618,'AD-1',1,0),('00044','c','GE',1618,'PD-0',2,0),('00045','ruby','GE',1518,'RD-0',0,0),('00046','sql','GE',1619,'RD-0',0,2),('00047','php','GE',19623,'HR-0',0,3),('00048','matlab','GE',49226,'HR-0',0,0),('00049','r','GE',1494,'HR-0',0,0),('00050','struts','GE',1931,'RD-0',3,1),('00051','hibernate','US',100,'RD-0',0,3);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `grade_salary`
--

DROP TABLE IF EXISTS `grade_salary`;
/*!50001 DROP VIEW IF EXISTS `grade_salary`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `grade_salary` AS SELECT 
 1 AS `essn`,
 1 AS `ename`,
 1 AS `salary`,
 1 AS `grade`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `performance`
--

DROP TABLE IF EXISTS `performance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `performance` (
  `essn` varchar(30) NOT NULL,
  `grade` int(11) NOT NULL,
  PRIMARY KEY (`essn`),
  KEY `fk_performance_employee1_idx` (`essn`),
  CONSTRAINT `fk_performance_employee1` FOREIGN KEY (`essn`) REFERENCES `employee` (`essn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `performance`
--

LOCK TABLES `performance` WRITE;
/*!40000 ALTER TABLE `performance` DISABLE KEYS */;
INSERT INTO `performance` VALUES ('00001',2),('00002',5),('00003',3),('00004',5),('00005',4),('00006',6),('00007',2),('00008',5),('00009',4),('00010',2),('00011',2),('00012',4),('00013',5),('00014',2),('00015',5),('00016',3),('00017',4),('00018',5),('00019',6),('00020',4),('00021',5),('00022',4),('00023',6),('00024',4),('00025',5),('00026',8),('00027',5),('00028',6),('00029',4),('00030',5),('00031',6),('00032',7),('00033',9),('00034',8),('00035',7),('00036',9),('00037',7),('00038',5),('00039',5),('00040',4),('00041',6),('00042',7),('00043',7),('00044',9),('00045',8),('00046',7),('00047',8),('00048',6),('00049',5),('00050',6),('00051',1);
/*!40000 ALTER TABLE `performance` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `company`.`performance_AFTER_INSERT` AFTER INSERT ON `performance` FOR EACH ROW
BEGIN
UPDATE employee
SET salary = 100
where employee.essn = NEW.essn and NEW.grade < 2;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `pno` varchar(30) NOT NULL,
  `pname` varchar(30) NOT NULL,
  `plocation` varchar(100) NOT NULL,
  `dno` varchar(30) NOT NULL,
  PRIMARY KEY (`pno`),
  KEY `foproject_dno_idx` (`dno`),
  CONSTRAINT `foproject_dno` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('P1','blue shit','Washington','AD-1'),('P10','sleeping Project','New York','HR-0'),('P11','CE project','guangzhou','RD-0'),('P2','Vista Project','Hang Zhou','PD-0'),('P3','SQL Project','Sydney','SD-0'),('P4','OS Project','Seattle','HR-0'),('P5','Lenovo Project','New York','SD-0'),('P6','Cpp  Project','Shang Hai','RD-0'),('P7','Py Project','Harbin','RD-0'),('P8','Lost Project','Moscow','RD-0'),('P9','Java Project','Changchun','PD-0');
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project_has_client`
--

DROP TABLE IF EXISTS `project_has_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project_has_client` (
  `pno` varchar(30) NOT NULL,
  `CID` int(11) NOT NULL,
  PRIMARY KEY (`pno`,`CID`),
  KEY `fk_project_has_client_client1_idx` (`CID`),
  KEY `fk_project_has_client_project1_idx` (`pno`),
  CONSTRAINT `fk_project_has_client_client1` FOREIGN KEY (`CID`) REFERENCES `client` (`CID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_client_project1` FOREIGN KEY (`pno`) REFERENCES `project` (`pno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project_has_client`
--

LOCK TABLES `project_has_client` WRITE;
/*!40000 ALTER TABLE `project_has_client` DISABLE KEYS */;
INSERT INTO `project_has_client` VALUES ('P1',0),('P3',0),('P1',1),('P3',1),('P1',2),('P4',3);
/*!40000 ALTER TABLE `project_has_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rank`
--

DROP TABLE IF EXISTS `rank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rank` (
  `RID` int(11) NOT NULL,
  `RNAME` varchar(60) NOT NULL,
  `RECOMSALARY` int(11) NOT NULL,
  PRIMARY KEY (`RID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rank`
--

LOCK TABLES `rank` WRITE;
/*!40000 ALTER TABLE `rank` DISABLE KEYS */;
INSERT INTO `rank` VALUES (0,'basic',5000),(1,'normal',10000),(2,'senoir',12000),(3,'leader',15000);
/*!40000 ALTER TABLE `rank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `rd_employee`
--

DROP TABLE IF EXISTS `rd_employee`;
/*!50001 DROP VIEW IF EXISTS `rd_employee`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `rd_employee` AS SELECT 
 1 AS `ename`,
 1 AS `essn`,
 1 AS `address`,
 1 AS `salary`,
 1 AS `dno`,
 1 AS `BID`,
 1 AS `RID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `work_location`
--

DROP TABLE IF EXISTS `work_location`;
/*!50001 DROP VIEW IF EXISTS `work_location`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `work_location` AS SELECT 
 1 AS `essn`,
 1 AS `ename`,
 1 AS `BNAME`,
 1 AS `loc`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works_on` (
  `essn` varchar(30) NOT NULL,
  `pno` varchar(30) NOT NULL,
  `hours` float NOT NULL,
  PRIMARY KEY (`essn`,`pno`),
  KEY `fo_pno_idx` (`pno`),
  CONSTRAINT `fo_essn` FOREIGN KEY (`essn`) REFERENCES `employee` (`essn`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fo_pno` FOREIGN KEY (`pno`) REFERENCES `project` (`pno`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('00001','P1',3),('00002','P1',25),('00003','P2',54),('00004','P8',40),('00005','P7',23),('00006','P7',25),('00007','P1',43),('00008','P1',82),('00009','P4',25),('00010','P4',24),('00011','P1',24),('00011','P10',21),('00011','P2',35),('00011','P3',34),('00011','P4',38),('00011','P5',38),('00011','P6',47),('00011','P7',38),('00011','P8',42),('00011','P9',35),('00012','P1',40),('00012','P2',34),('00013','P1',40),('00013','P3',10),('00014','P1',23),('00014','P3',30),('00015','P1',1),('00015','P2',2),('00015','P3',3),('00017','P5',38),('00018','P1',96),('00019','P1',72),('00020','P1',40),('00021','P1',25),('00022','P1',40),('00023','P1',25),('00024','P1',40),('00025','P1',67),('00026','P1',37),('00027','P1',48),('00028','P1',68),('00029','P1',13),('00030','P1',75),('00031','P1',24),('00032','P1',37),('00033','P1',37),('00034','P1',37),('00035','P2',38),('00036','P1',34),('00037','P1',15),('00038','P7',34),('00039','P1',25),('00040','P1',26),('00041','P8',43),('00042','P8',37),('00043','P8',37),('00044','P5',38),('00045','P5',24),('00046','P5',34),('00047','P2',35),('00048','P2',37),('00049','P2',38),('00050','P2',35),('00051','P2',36);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `grade_salary`
--

/*!50001 DROP VIEW IF EXISTS `grade_salary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `grade_salary` AS select `employee`.`essn` AS `essn`,`employee`.`ename` AS `ename`,`employee`.`salary` AS `salary`,`performance`.`grade` AS `grade` from (`performance` join `employee`) where (`performance`.`essn` = `employee`.`essn`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `rd_employee`
--

/*!50001 DROP VIEW IF EXISTS `rd_employee`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `rd_employee` AS select `employee`.`ename` AS `ename`,`employee`.`essn` AS `essn`,`employee`.`address` AS `address`,`employee`.`salary` AS `salary`,`employee`.`dno` AS `dno`,`employee`.`BID` AS `BID`,`employee`.`RID` AS `RID` from `employee` where (`employee`.`dno` = 'RD-0') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `work_location`
--

/*!50001 DROP VIEW IF EXISTS `work_location`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `work_location` AS select `employee`.`essn` AS `essn`,`employee`.`ename` AS `ename`,`building`.`BNAME` AS `BNAME`,`building`.`LOC` AS `loc` from (`building` join `employee`) where (`employee`.`BID` = `building`.`BID`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-29 21:36:41

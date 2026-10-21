-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: elderly_care
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `preference`
--

DROP TABLE IF EXISTS `preference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preference` (
  `id` int NOT NULL COMMENT '主键',
  `customer_id` int DEFAULT NULL COMMENT '顾客ID',
  `preferences` varchar(30) DEFAULT NULL COMMENT '饮食喜好',
  `attention` varchar(30) DEFAULT NULL COMMENT '注意事项',
  `remark` varchar(30) DEFAULT NULL COMMENT '备注',
  `is_deleted` int DEFAULT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preference`
--

LOCK TABLES `preference` WRITE;
/*!40000 ALTER TABLE `preference` DISABLE KEYS */;
INSERT INTO `preference` VALUES (1,1,'清淡饮食，喜欢粤菜','对海鲜过敏','早餐要送早一点',0),(2,1,'清淡饮食，喜欢粤菜','对海鲜过敏','早餐要送早一点',0);
/*!40000 ALTER TABLE `preference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` int NOT NULL COMMENT '主键',
  `create_time` datetime(6) NOT NULL COMMENT '创建时间',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` int DEFAULT NULL COMMENT '更新人',
  `is_deleted` int NOT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `name` varchar(50) NOT NULL COMMENT '系统角色名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'2026-10-10 08:38:38.470062','2026-10-14 17:47:55.021634',NULL,0,'管理员'),(2,'2026-10-10 08:40:41.292991',NULL,NULL,0,'护理主管'),(3,'2026-10-10 08:57:21.465561','2026-10-14 17:48:29.251619',NULL,0,'健康管家'),(4,'2026-10-10 15:57:21.741750','2026-10-10 15:57:21.796610',NULL,1,'修改后的角色名'),(5,'2026-10-10 16:03:53.795734','2026-10-10 16:03:53.842725',NULL,1,'修改后的角色名');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu` (
  `id` int NOT NULL COMMENT '主键',
  `menus_index` varchar(5) DEFAULT NULL COMMENT '一级菜单索引',
  `title` varchar(50) NOT NULL COMMENT '菜单标题',
  `icon` varchar(50) NOT NULL COMMENT '菜单图标',
  `path` varchar(100) DEFAULT NULL COMMENT '菜单路径',
  `parent_id` int DEFAULT NULL COMMENT '父级Id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'1','客户管理','customer','/customer',0),(2,'1','客户列表','list','/customer/list',1),(3,'1','客户管理','customer','/customer',0),(4,'1','客户列表','list','/customer/list',3),(5,'1','客户管理','customer','/customer',0),(6,'1','客户列表','list','/customer/list',5),(7,'1','客户管理','customer','/customer',0),(8,'1','客户列表','list','/customer/list',7);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolemenu`
--

DROP TABLE IF EXISTS `rolemenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rolemenu` (
  `id` int NOT NULL COMMENT '主键',
  `role_id` int NOT NULL COMMENT '角色编号',
  `menu` int NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolemenu`
--

LOCK TABLES `rolemenu` WRITE;
/*!40000 ALTER TABLE `rolemenu` DISABLE KEYS */;
INSERT INTO `rolemenu` VALUES (1,1,1),(2,1,2),(3,1,1),(4,1,2);
/*!40000 ALTER TABLE `rolemenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` int NOT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` int DEFAULT NULL COMMENT '更新者',
  `is_deleted` int NOT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `nickname` varchar(20) NOT NULL COMMENT '真实姓名',
  `username` varchar(20) NOT NULL COMMENT '系统账号',
  `password` varchar(20) NOT NULL COMMENT '密码',
  `sex` int NOT NULL COMMENT '性别（0：女 1：男）',
  `email` varchar(254) DEFAULT NULL COMMENT '邮箱',
  `phone_number` varchar(20) NOT NULL COMMENT '电话号码',
  `role_id` int NOT NULL COMMENT '系统角色编号（1：管理员 2：健康管家）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (5,'2026-10-10 08:34:01',0,'2026-10-10 16:52:37',0,1,'小李','123456','123456',0,'xiaoli@163.com','13900002222',1),(6,'2026-10-10 08:34:24',0,'2026-10-10 08:34:24',0,0,'小李','xiaoli','123456',0,'xiaoli@163.com','13900001111',1),(7,'2026-10-10 08:38:39',0,'2026-10-10 08:38:39',0,0,'小王','xiaowang','123456',0,'xiaowang@163.com','13900003333',1),(8,'2026-10-10 08:38:59',0,'2026-10-10 08:38:59',0,1,'小李','xiaoli','123456',0,'xiaoli@163.com','13900001111',1),(10,'2026-10-14 09:43:54',0,'2026-10-14 09:43:54',0,0,'小吕','xiaolv','123456',0,'15000000000','15000000000',1),(11,'2026-10-15 14:33:38',0,'2026-10-15 14:33:38',0,0,'xiaozhang','011011','123456',1,'','01201230123',1),(12,'2026-10-15 14:39:45',0,'2026-10-15 14:39:45',0,0,'小王','nurse1','123456',0,'nurse@qq.com','13900009999',2);
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

-- Dump completed on 2026-10-21 10:29:41

-- MySQL dump 10.13  Distrib 8.0.23, for osx10.16 (x86_64)
--
-- Host: 52.221.244.159    Database: yiran_db
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `biz_article`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_article` (
                               `id` bigint NOT NULL AUTO_INCREMENT,
                               `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `create_time` datetime NOT NULL,
                               `is_delete` bit(1) DEFAULT NULL,
                               `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL,
                               `channel_id` bigint NOT NULL,
                               `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_article`
--


--
-- Table structure for table `biz_banner`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_banner` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `create_time` datetime NOT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `banner_link` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `banner_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `banner_type` int DEFAULT NULL,
                              `channel_id` bigint NOT NULL,
                              `content` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `image_url` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `position` int DEFAULT NULL,
                              `sort` int DEFAULT NULL,
                              `status` int DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_banner`
--


--
-- Table structure for table `biz_member`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_member` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `create_time` datetime NOT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `channel_id` bigint NOT NULL,
                              `login_address` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `login_ip` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `login_time` datetime DEFAULT NULL,
                              `member_code` varchar(6) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `register_time` datetime NOT NULL,
                              `status` varchar(8) COLLATE utf8mb4_general_ci NOT NULL,
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `idx_la_chid` (`login_address`,`channel_id`),
                              KEY `idx_loginAddress` (`login_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_member`
--


--
-- Table structure for table `biz_notice`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_notice` (
                              `id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `create_time` datetime NOT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `channel_id` bigint NOT NULL,
                              `content` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `is_play` int DEFAULT NULL,
                              `is_top` int DEFAULT NULL,
                              `link` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `status` int DEFAULT NULL,
                              `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_notice`
--


--
-- Table structure for table `biz_platform_param_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_platform_param_config` (
                                             `id` bigint NOT NULL AUTO_INCREMENT,
                                             `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `create_time` datetime NOT NULL,
                                             `is_delete` bit(1) DEFAULT NULL,
                                             `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `update_time` datetime DEFAULT NULL,
                                             `channel_id` bigint DEFAULT NULL,
                                             `config_group` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `config_key` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `config_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `config_value` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `description` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             `value_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `idx_cc_query_key` (`channel_id`,`config_key`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_platform_param_config`
--

INSERT INTO `biz_platform_param_config` VALUES (1,'admin','2025-12-28 08:22:20',_binary '\0',NULL,NULL,'2025-12-28 08:22:20',NULL,'sys','NOTICE_SWITCH','通知开关','','初始化,没有设置',NULL);
INSERT INTO `biz_platform_param_config` VALUES (2,'admin','2025-12-28 08:22:20',_binary '\0',NULL,NULL,'2025-12-28 08:22:20',NULL,'sys','DEFAULT_HEAD_IMG','默认头像','','初始化,没有设置',NULL);

--
-- Table structure for table `biz_question`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `biz_question` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                `create_time` datetime NOT NULL,
                                `is_delete` bit(1) DEFAULT NULL,
                                `remark` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                `update_time` datetime DEFAULT NULL,
                                `channel_id` bigint NOT NULL,
                                `content` text COLLATE utf8mb4_general_ci,
                                `sort_no` int DEFAULT NULL,
                                `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `biz_question`
--


--
-- Table structure for table `sys_analysis_item`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_analysis_item` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `create_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `create_time` datetime NOT NULL,
                                     `is_delete` bit(1) DEFAULT NULL,
                                     `remark` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `update_time` datetime DEFAULT NULL,
                                     `belong_date` date DEFAULT NULL,
                                     `channel_id` bigint DEFAULT NULL,
                                     `key_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `value` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     `sub_type` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `idx_ty_date` (`type`,`belong_date`),
                                     KEY `idx_chid_type` (`channel_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_analysis_item`
--


--
-- Table structure for table `sys_channel`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_channel` (
                               `channel_id` bigint NOT NULL AUTO_INCREMENT,
                               `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `create_time` datetime DEFAULT NULL,
                               `is_delete` bit(1) DEFAULT NULL,
                               `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL,
                               `channel_code` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
                               `channel_name` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
                               `channel_type` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `expire_date` date NOT NULL,
                               `status` varchar(2) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `channel_sort` int DEFAULT NULL,
                               `domain_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `logo` longtext COLLATE utf8mb4_general_ci,
                               `display_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `icon` longtext COLLATE utf8mb4_general_ci,
                               `dig_currency` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `pay_currency` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `h5domain_name` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `h5logo` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `order_need_invite_code` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               `register_need_invite_code` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                               PRIMARY KEY (`channel_id`),
                               UNIQUE KEY `idx_cha_code` (`channel_code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_channel`
--

INSERT INTO `sys_channel` VALUES (1,'admin','2025-12-28 08:22:21',_binary '\0',NULL,'admin','2025-12-28 08:22:21','HTY','HTY','Y','2999-12-31','1',1,'admin.host.com','/api/profile/upload/2024/07/bd3aa353578a0f3f5b93b6a1665cbd3b.jpg','HTY后台管理系统','/ccf46c8e7a1aa980fee753271f15ff5a.ico','','USDT','h5.host.com',NULL,'N','N');

--
-- Table structure for table `sys_config`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_config` (
                              `config_id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `create_time` datetime DEFAULT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `config_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `config_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `config_type` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `config_value` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              PRIMARY KEY (`config_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

INSERT INTO `sys_config` VALUES (1,NULL,'2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','system_user_initPassword','新用户初始化密码','Y','123456');
INSERT INTO `sys_config` VALUES (2,NULL,'2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','system_theme','系统主题','Y','red');

--
-- Table structure for table `sys_dept`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `dept_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `leader` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `order_num` int NOT NULL,
                            `parent_id` bigint DEFAULT NULL,
                            `parent_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `phone` varchar(11) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `dept_code` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dept`
--

INSERT INTO `sys_dept` VALUES (1,'admin','2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','总部','xxx@email.com',NULL,1,0,NULL,NULL,'1','0001');
INSERT INTO `sys_dept` VALUES (2,'admin','2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','技术部','xxx@email.com',NULL,2,1,'总部',NULL,'1','000101');
INSERT INTO `sys_dept` VALUES (3,'admin','2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','运营部','xxx@email.com',NULL,3,1,'总部',NULL,'1','000102');
INSERT INTO `sys_dept` VALUES (4,'admin','2025-12-28 08:22:22',_binary '\0',NULL,NULL,'2025-12-28 08:22:22','市场部','xxx@email.com',NULL,4,1,'总部',NULL,'1','001004');

--
-- Table structure for table `sys_dict_data`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint NOT NULL AUTO_INCREMENT,
                                 `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `create_time` datetime DEFAULT NULL,
                                 `is_delete` bit(1) DEFAULT NULL,
                                 `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `update_time` datetime DEFAULT NULL,
                                 `css_class` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `dict_label` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `dict_value` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `is_default` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `list_class` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `order_num` int DEFAULT NULL,
                                 PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_data`
--

INSERT INTO `sys_dict_data` VALUES (1,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','正常','system_user_status','1','0',NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (2,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','冻结','system_user_status','2','1',NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (3,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','正常','system_normal_disable','1','Y',NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (4,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','停用','system_normal_disable','2','N',NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (5,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'是','system_yes_no','Y',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (6,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'否','system_yes_no','N',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (7,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'通知','system_notice_type','1',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (8,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'公告','system_notice_type','2',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (9,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'正常','system_notice_status','1',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (10,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'关闭','system_notice_status','2',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (11,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','新增','system_operate_type','1',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (12,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','yellow','修改','system_operate_type','2',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (13,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','删除','system_operate_type','3',NULL,NULL,'1',3);
INSERT INTO `sys_dict_data` VALUES (14,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'授权','system_operate_type','4',NULL,NULL,'1',4);
INSERT INTO `sys_dict_data` VALUES (15,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'导出','system_operate_type','5',NULL,NULL,'1',5);
INSERT INTO `sys_dict_data` VALUES (16,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'导入','system_operate_type','6',NULL,NULL,'1',6);
INSERT INTO `sys_dict_data` VALUES (17,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'强退','system_operate_type','7',NULL,NULL,'1',7);
INSERT INTO `sys_dict_data` VALUES (18,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'生成代码','system_operate_type','8',NULL,NULL,'1',8);
INSERT INTO `sys_dict_data` VALUES (19,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'清空数据','system_operate_type','9',NULL,NULL,'1',9);
INSERT INTO `sys_dict_data` VALUES (20,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23',NULL,'执行','system_operate_type','10',NULL,NULL,'1',10);
INSERT INTO `sys_dict_data` VALUES (21,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','审核','system_operate_type','11',NULL,NULL,'1',11);
INSERT INTO `sys_dict_data` VALUES (22,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','成功','system_result_status','SUCCESS','1',NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (23,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','失败','system_result_status','FAIL',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (24,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','yellow','未知','system_result_status','UNKNOW',NULL,NULL,'1',3);
INSERT INTO `sys_dict_data` VALUES (25,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','在线','system_online_offline','on_line',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (26,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','离线','system_online_offline','off_line',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (27,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','blue','显示','system_visible_status','1',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (28,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','yellow','隐藏','system_visible_status','2',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (29,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','yellow','待审核','system_audit_status','0',NULL,NULL,'1',1);
INSERT INTO `sys_dict_data` VALUES (30,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','green','审核通过','system_audit_status','1',NULL,NULL,'1',2);
INSERT INTO `sys_dict_data` VALUES (31,'admin','2025-12-28 08:22:23',_binary '\0',NULL,'admin','2025-12-28 08:22:23','red','审核拒绝','system_audit_status','2',NULL,NULL,'1',3);

--
-- Table structure for table `sys_dict_type`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint NOT NULL AUTO_INCREMENT,
                                 `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `create_time` datetime DEFAULT NULL,
                                 `is_delete` bit(1) DEFAULT NULL,
                                 `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `update_time` datetime DEFAULT NULL,
                                 `dict_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `dict_type` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                 PRIMARY KEY (`dict_id`),
                                 KEY `idx_dictName` (`dict_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_dict_type`
--

INSERT INTO `sys_dict_type` VALUES (1,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','用户状态','system_user_status','1');
INSERT INTO `sys_dict_type` VALUES (2,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','正常停用','system_normal_disable','1');
INSERT INTO `sys_dict_type` VALUES (3,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','是否','system_yes_no','1');
INSERT INTO `sys_dict_type` VALUES (4,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','通知类型','system_notice_type','1');
INSERT INTO `sys_dict_type` VALUES (5,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','通知状态','system_notice_status','1');
INSERT INTO `sys_dict_type` VALUES (6,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','操作类型','system_operate_type','1');
INSERT INTO `sys_dict_type` VALUES (7,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','结果状态','system_result_status','1');
INSERT INTO `sys_dict_type` VALUES (8,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','在线离线','system_online_offline','1');
INSERT INTO `sys_dict_type` VALUES (9,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','显示隐藏状态','system_visible_status','1');
INSERT INTO `sys_dict_type` VALUES (10,'admin','2025-12-28 08:22:24',_binary '\0',NULL,'admin','2025-12-28 08:22:24','审核状态','system_audit_status','1');

--
-- Table structure for table `sys_login_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_login_info` (
                                  `info_id` bigint NOT NULL AUTO_INCREMENT,
                                  `create_by` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
                                  `create_time` datetime NOT NULL,
                                  `is_delete` bit(1) DEFAULT NULL,
                                  `remark` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `update_time` datetime DEFAULT NULL,
                                  `browser` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `ip_addr` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `login_location` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `login_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `login_time` datetime DEFAULT NULL,
                                  `msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `os` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `category` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                  `channel_id` bigint DEFAULT NULL,
                                  `category_id` bigint DEFAULT NULL,
                                  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_login_info`
--

--
-- Table structure for table `sys_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint NOT NULL AUTO_INCREMENT,
                            `router` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `component` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `icon` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `menu_name` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `menu_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `order_num` int NOT NULL,
                            `parent_id` bigint DEFAULT NULL,
                            `perms` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `visible` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `is_cache` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `is_frame` varchar(1) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `query` varchar(200) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            PRIMARY KEY (`menu_id`),
                            KEY `idx_parentId` (`parent_id`),
                            KEY `idx_menuName` (`menu_name`)
) ENGINE=InnoDB AUTO_INCREMENT=10009 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

INSERT INTO `sys_menu` VALUES (1,'home','/pages/home','alert','首页','C',10,0,'system:home','1',NULL,'2',NULL,'p=我是首页&q=欢迎90',NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (20,'member',NULL,'team','用户管理','M',20,0,'','1',NULL,'2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (97,'content',NULL,'profile','内容管理','M',97,0,NULL,'1',NULL,'2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','sys','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (98,'param',NULL,'api','参数管理','M',98,0,'','1',NULL,'2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (99,'system',NULL,'setting','系统管理','M',99,0,NULL,'1',NULL,'2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (201,'member','/pages/biz/member','user','用户列表','C',1,20,'biz:member:view','1','1','2',NULL,'',NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (971,'banner','/pages/biz/banner','','Banner管理','C',1,97,'biz:banner:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (972,'message','/pages/biz/notice','','消息管理','C',2,97,'biz:notice:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (973,'article','/pages/biz/article',NULL,'文章管理','C',3,97,'biz:article:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (974,'question','/pages/biz/question',NULL,'常见问题','C',4,97,'biz:question:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (981,'platformParamConfig2','/pages/biz/platformParamConfig',NULL,'基础参数','C',5,98,'biz:platformParamConfig:view','1',NULL,'2',NULL,'configGroup=sys',NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (991,'menu','/pages/system/menu','flag','菜单管理','C',1,99,'system:menu:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (992,'role','/pages/system/role','team','角色管理','C',2,99,'system:role:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (993,'channel','/pages/system/channel','thunderbolt','渠道管理','C',3,99,'system:channel:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (994,'user','/pages/system/user','user','后台账号','C',4,99,'system:user:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (995,'dept','/pages/system/dept','bank','部门管理','C',5,99,'system:dept:view','2','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (996,'config','/pages/system/config','database','系统参数','C',6,99,'system:config:view','1','2','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (997,'notice','/pages/system/notice','alert','公告通知','C',7,99,'system:notice:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (998,'dict','/pages/system/dict','book','数据字典','C',8,99,'system:dict:view','1','2','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (999,'online','/pages/system/online','usergroup-delete','在线用户','C',9,99,'system:online:view','1','1','2',NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (1000,'operateLog','/pages/system/operateLog','bug','操作日志','C',10,99,'system:operate:log:view','1','2','2',NULL,'log=1',NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (2011,'',NULL,NULL,'用户查询','F',1,201,'biz:member:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (2012,'',NULL,NULL,'用户新增','F',2,201,'biz:member:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (2013,'',NULL,NULL,'用户修改','F',3,201,'biz:member:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (2014,'',NULL,NULL,'用户删除','F',4,201,'biz:member:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (2063,'',NULL,NULL,'强退用户','F',1,999,'system:online:forceLogout','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9711,'',NULL,NULL,'Banner查询','F',1,971,'biz:banner:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9712,'',NULL,NULL,'Banner新增','F',2,971,'biz:banner:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9713,'',NULL,NULL,'Banner修改','F',3,971,'biz:banner:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9714,'',NULL,NULL,'Banner删除','F',4,971,'biz:banner:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9721,'',NULL,NULL,'消息管理查询','F',1,972,'biz:notice:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9722,'',NULL,NULL,'消息管理新增','F',1,972,'biz:notice:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9723,'',NULL,NULL,'消息管理修改','F',2,972,'biz:notice:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9724,'',NULL,NULL,'消息管理删除','F',3,972,'biz:notice:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9731,'',NULL,NULL,'文章管理查询','F',1,973,'biz:article:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9732,'',NULL,NULL,'文章管理新增','F',2,973,'biz:article:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9733,'',NULL,NULL,'文章管理修改','F',3,973,'biz:article:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9734,'',NULL,NULL,'文章管理删除','F',4,973,'biz:article:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9741,'',NULL,NULL,'常见问题查询','F',1,974,'biz:question:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9742,'',NULL,NULL,'常见问题新增','F',2,974,'biz:question:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9743,'',NULL,NULL,'常见问题修改','F',3,974,'biz:question:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9744,'',NULL,NULL,'常见问题删除','F',4,974,'biz:question:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9811,'',NULL,NULL,'参数管理修改','F',3,981,'biz:platformParamConfig:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9911,'',NULL,NULL,'菜单管理查看','F',1,991,'system:menu:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9912,'',NULL,NULL,'菜单管理修改','F',2,991,'system:menu:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9913,'',NULL,NULL,'菜单管理删除','F',3,991,'system:menu:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9914,'',NULL,NULL,'菜单管理新增','F',4,991,'system:menu:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9921,'',NULL,NULL,'角色管理查询','F',1,992,'system:role:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9922,'',NULL,NULL,'角色管理修改','F',3,992,'system:role:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9923,'',NULL,NULL,'角色管理新增','F',2,992,'system:role:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9924,'',NULL,NULL,'角色管理删除','F',4,992,'system:role:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9925,'',NULL,NULL,'角色管理导出','F',5,992,'system:role:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9926,'',NULL,NULL,'角色管理授权','F',6,992,'system:role:auth','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9931,'',NULL,NULL,'渠道管理查询','F',1,993,'system:channel:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9932,'',NULL,NULL,'渠道管理新增','F',2,993,'system:channel:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9933,'',NULL,NULL,'渠道管理修改','F',3,993,'system:channel:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9934,'',NULL,NULL,'渠道管理删除','F',4,993,'system:channel:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9941,'',NULL,NULL,'后台账号修改','F',3,994,'system:user:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9942,'',NULL,NULL,'后台账号新增','F',2,994,'system:user:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9943,'',NULL,NULL,'后台账号查询','F',1,994,'system:user:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9944,'',NULL,NULL,'后台账号删除','F',4,994,'system:user:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9945,'',NULL,NULL,'后台账号导出','F',5,994,'system:user:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9946,'',NULL,NULL,'后台账号授权','F',6,994,'system:user:auth','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9947,'',NULL,NULL,'后台账号重置密码','F',7,994,'system:user:resetPwd','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9948,'',NULL,NULL,'后台账号解锁','F',9,994,'system:user:unlock','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9951,'',NULL,NULL,'部门管理新增','F',1,995,'system:dept:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9952,'',NULL,NULL,'部门管理修改','F',2,995,'system:dept:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9953,'',NULL,NULL,'部门管理删除','F',3,995,'system:dept:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9954,'',NULL,NULL,'部门管理查询','F',1,995,'system:dept:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9961,'',NULL,NULL,'系统参数查询','F',1,996,'system:config:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9962,'',NULL,NULL,'系统参数新增','F',2,996,'system:config:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9963,'',NULL,NULL,'系统参数修改','F',3,996,'system:config:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9964,'',NULL,NULL,'系统参数删除','F',4,996,'system:config:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9965,'',NULL,NULL,'系统参数导出','F',5,996,'system:config:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9971,'',NULL,NULL,'公告通知查询','F',1,997,'system:notice:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9972,'',NULL,NULL,'公告通知心中','F',2,997,'system:notice:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9973,'',NULL,NULL,'公告通知修改','F',3,997,'system:notice:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9974,'',NULL,NULL,'公告通知删除','F',4,997,'system:notice:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9975,'',NULL,NULL,'公告通知导出','F',5,997,'system:notice:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9981,'',NULL,NULL,'数据字典查询','F',1,998,'system:dict:view','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9982,'',NULL,NULL,'数据字典新增','F',2,998,'system:dict:add','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9983,'',NULL,NULL,'数据字典修改','F',3,998,'system:dict:edit','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9984,'',NULL,NULL,'数据字典删除','F',4,998,'system:dict:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (9985,'',NULL,NULL,'数据字典导出','F',5,998,'system:dict:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (10001,'',NULL,NULL,'操作日志删除','F',1,1000,'system:operate:log:delete','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (10002,'',NULL,NULL,'操作日志导出','F',2,1000,'system:operate:log:export','1',NULL,NULL,NULL,NULL,NULL,'2025-12-28 08:22:25','admin','admin','2025-12-28 08:22:25');
INSERT INTO `sys_menu` VALUES (10003,'',NULL,NULL,'用户导出','F',5,201,'system:user:export','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:26:44','admin',NULL,'2025-12-29 20:26:44');
INSERT INTO `sys_menu` VALUES (10004,'',NULL,NULL,'用户导入','F',6,201,'system:user:import','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:27:06','admin',NULL,'2025-12-29 20:27:06');
INSERT INTO `sys_menu` VALUES (10005,'',NULL,NULL,'用户重置密码','F',7,201,'system:user:resetPwd','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:27:31','admin',NULL,'2025-12-29 20:27:31');
INSERT INTO `sys_menu` VALUES (10006,'',NULL,NULL,'用户解锁','F',8,201,'system:user:unlock','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:28:19','admin',NULL,'2025-12-29 20:28:19');
INSERT INTO `sys_menu` VALUES (10007,'',NULL,NULL,'用户授权','F',9,201,'system:user:auth','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:28:35','admin',NULL,'2025-12-29 20:28:35');
INSERT INTO `sys_menu` VALUES (10008,'',NULL,NULL,'用户重置google验证码','F',10,201,'system:user:google','1',NULL,'2',NULL,NULL,NULL,'2025-12-29 20:29:03','admin',NULL,'2025-12-29 20:29:03');

--
-- Table structure for table `sys_notice`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_notice` (
                              `notice_id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `create_time` datetime DEFAULT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `notice_content` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
                              `notice_title` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              `notice_type` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
                              `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                              PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_notice`
--

INSERT INTO `sys_notice` VALUES (1,'tt','2022-09-18 00:12:33',NULL,NULL,'admin','2024-04-22 00:19:43','<p><b>123123</b></p><p><b>呼哈</b></p>','公告类型1','2','1');
INSERT INTO `sys_notice` VALUES (2,'admin','2022-09-19 12:12:32',NULL,NULL,'admin','2024-04-22 00:19:48','<p>12312390909</p>','1haha','2','1');

--
-- Table structure for table `sys_operate_log`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_operate_log` (
                                   `operate_id` bigint NOT NULL AUTO_INCREMENT,
                                   `create_by` varchar(32) COLLATE utf8mb4_general_ci NOT NULL,
                                   `create_time` datetime NOT NULL,
                                   `is_delete` bit(1) DEFAULT NULL,
                                   `remark` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `update_by` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `update_time` datetime DEFAULT NULL,
                                   `business_type` int NOT NULL,
                                   `business_types` int DEFAULT NULL,
                                   `dept_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `error_msg` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `json_result` varchar(2048) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `method` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operate_ip` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operate_location` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operate_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operate_param` varchar(4096) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operate_time` datetime DEFAULT NULL,
                                   `operate_url` varchar(256) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `operator_type` int DEFAULT NULL,
                                   `request_method` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `session_type` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `title` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   PRIMARY KEY (`operate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_operate_log`
--

--
-- Table structure for table `sys_perm`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_perm` (
                            `perm_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `perm_group` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `perm_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `perm_operation` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `perm_sort` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_perm`
--

INSERT INTO `sys_perm` VALUES (1,'admin','2025-12-28 08:22:27',NULL,NULL,'admin','2025-12-28 08:22:27','user','用户查询','user.query','6','0');
INSERT INTO `sys_perm` VALUES (2,'admin','2025-12-28 08:22:27',NULL,NULL,'admin','2025-12-28 08:22:27','user','用户编辑','user.edit','3','0');
INSERT INTO `sys_perm` VALUES (3,'admin','2025-12-28 08:22:27',NULL,NULL,'admin','2025-12-28 08:22:27','用户组','用户删除','user.delete','1','0');

--
-- Table structure for table `sys_post`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_post` (
                            `post_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `flag` bit(1) NOT NULL,
                            `post_code` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `post_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `post_sort` int DEFAULT NULL,
                            `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_post`
--


--
-- Table structure for table `sys_role`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role` (
                            `role_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `role_key` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `role_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `role_sort` int DEFAULT NULL,
                            `status` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `menu_check_strictly` bit(1) DEFAULT NULL,
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

INSERT INTO `sys_role` VALUES (1,'admin','2025-12-28 08:22:28',_binary '\0','管理员角色','test','2020-12-06 09:26:45','role:admin','管理员',1,'1',_binary '');

--
-- Table structure for table `sys_role_dept`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_dept` (
                                 `id` bigint NOT NULL,
                                 `dept_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_dept` (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_dept`
--


--
-- Table structure for table `sys_role_menu`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_menu` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `menu_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_menu` (`role_id`,`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=175 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

INSERT INTO `sys_role_menu` VALUES (88,1,1);
INSERT INTO `sys_role_menu` VALUES (100,20,1);
INSERT INTO `sys_role_menu` VALUES (121,97,1);
INSERT INTO `sys_role_menu` VALUES (124,98,1);
INSERT INTO `sys_role_menu` VALUES (174,99,1);
INSERT INTO `sys_role_menu` VALUES (99,201,1);
INSERT INTO `sys_role_menu` VALUES (105,971,1);
INSERT INTO `sys_role_menu` VALUES (110,972,1);
INSERT INTO `sys_role_menu` VALUES (115,973,1);
INSERT INTO `sys_role_menu` VALUES (120,974,1);
INSERT INTO `sys_role_menu` VALUES (123,981,1);
INSERT INTO `sys_role_menu` VALUES (129,991,1);
INSERT INTO `sys_role_menu` VALUES (136,992,1);
INSERT INTO `sys_role_menu` VALUES (141,993,1);
INSERT INTO `sys_role_menu` VALUES (150,994,1);
INSERT INTO `sys_role_menu` VALUES (156,996,1);
INSERT INTO `sys_role_menu` VALUES (162,997,1);
INSERT INTO `sys_role_menu` VALUES (168,998,1);
INSERT INTO `sys_role_menu` VALUES (170,999,1);
INSERT INTO `sys_role_menu` VALUES (173,1000,1);
INSERT INTO `sys_role_menu` VALUES (89,2011,1);
INSERT INTO `sys_role_menu` VALUES (90,2012,1);
INSERT INTO `sys_role_menu` VALUES (91,2013,1);
INSERT INTO `sys_role_menu` VALUES (92,2014,1);
INSERT INTO `sys_role_menu` VALUES (169,2063,1);
INSERT INTO `sys_role_menu` VALUES (101,9711,1);
INSERT INTO `sys_role_menu` VALUES (102,9712,1);
INSERT INTO `sys_role_menu` VALUES (103,9713,1);
INSERT INTO `sys_role_menu` VALUES (104,9714,1);
INSERT INTO `sys_role_menu` VALUES (106,9721,1);
INSERT INTO `sys_role_menu` VALUES (107,9722,1);
INSERT INTO `sys_role_menu` VALUES (108,9723,1);
INSERT INTO `sys_role_menu` VALUES (109,9724,1);
INSERT INTO `sys_role_menu` VALUES (111,9731,1);
INSERT INTO `sys_role_menu` VALUES (112,9732,1);
INSERT INTO `sys_role_menu` VALUES (113,9733,1);
INSERT INTO `sys_role_menu` VALUES (114,9734,1);
INSERT INTO `sys_role_menu` VALUES (116,9741,1);
INSERT INTO `sys_role_menu` VALUES (117,9742,1);
INSERT INTO `sys_role_menu` VALUES (118,9743,1);
INSERT INTO `sys_role_menu` VALUES (119,9744,1);
INSERT INTO `sys_role_menu` VALUES (122,9811,1);
INSERT INTO `sys_role_menu` VALUES (125,9911,1);
INSERT INTO `sys_role_menu` VALUES (126,9912,1);
INSERT INTO `sys_role_menu` VALUES (127,9913,1);
INSERT INTO `sys_role_menu` VALUES (128,9914,1);
INSERT INTO `sys_role_menu` VALUES (130,9921,1);
INSERT INTO `sys_role_menu` VALUES (132,9922,1);
INSERT INTO `sys_role_menu` VALUES (131,9923,1);
INSERT INTO `sys_role_menu` VALUES (133,9924,1);
INSERT INTO `sys_role_menu` VALUES (134,9925,1);
INSERT INTO `sys_role_menu` VALUES (135,9926,1);
INSERT INTO `sys_role_menu` VALUES (137,9931,1);
INSERT INTO `sys_role_menu` VALUES (138,9932,1);
INSERT INTO `sys_role_menu` VALUES (139,9933,1);
INSERT INTO `sys_role_menu` VALUES (140,9934,1);
INSERT INTO `sys_role_menu` VALUES (144,9941,1);
INSERT INTO `sys_role_menu` VALUES (143,9942,1);
INSERT INTO `sys_role_menu` VALUES (142,9943,1);
INSERT INTO `sys_role_menu` VALUES (145,9944,1);
INSERT INTO `sys_role_menu` VALUES (146,9945,1);
INSERT INTO `sys_role_menu` VALUES (147,9946,1);
INSERT INTO `sys_role_menu` VALUES (148,9947,1);
INSERT INTO `sys_role_menu` VALUES (149,9948,1);
INSERT INTO `sys_role_menu` VALUES (151,9961,1);
INSERT INTO `sys_role_menu` VALUES (152,9962,1);
INSERT INTO `sys_role_menu` VALUES (153,9963,1);
INSERT INTO `sys_role_menu` VALUES (154,9964,1);
INSERT INTO `sys_role_menu` VALUES (155,9965,1);
INSERT INTO `sys_role_menu` VALUES (157,9971,1);
INSERT INTO `sys_role_menu` VALUES (158,9972,1);
INSERT INTO `sys_role_menu` VALUES (159,9973,1);
INSERT INTO `sys_role_menu` VALUES (160,9974,1);
INSERT INTO `sys_role_menu` VALUES (161,9975,1);
INSERT INTO `sys_role_menu` VALUES (163,9981,1);
INSERT INTO `sys_role_menu` VALUES (164,9982,1);
INSERT INTO `sys_role_menu` VALUES (165,9983,1);
INSERT INTO `sys_role_menu` VALUES (166,9984,1);
INSERT INTO `sys_role_menu` VALUES (167,9985,1);
INSERT INTO `sys_role_menu` VALUES (171,10001,1);
INSERT INTO `sys_role_menu` VALUES (172,10002,1);
INSERT INTO `sys_role_menu` VALUES (93,10003,1);
INSERT INTO `sys_role_menu` VALUES (94,10004,1);
INSERT INTO `sys_role_menu` VALUES (95,10005,1);
INSERT INTO `sys_role_menu` VALUES (96,10006,1);
INSERT INTO `sys_role_menu` VALUES (97,10007,1);
INSERT INTO `sys_role_menu` VALUES (98,10008,1);

--
-- Table structure for table `sys_role_perm`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_role_perm` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `perm_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_perm` (`role_id`,`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_perm`
--


--
-- Table structure for table `sys_user`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user` (
                            `user_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_by` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `avatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `dept_id` bigint DEFAULT NULL,
                            `dept_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `email` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `email_login_enable` bit(1) DEFAULT NULL,
                            `login_date` datetime DEFAULT NULL,
                            `login_ip` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `login_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `open_id` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `password_error_count` bigint DEFAULT NULL,
                            `password_error_time` datetime DEFAULT NULL,
                            `password_update_time` datetime DEFAULT NULL,
                            `phone_number` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `phone_number_login_enable` bit(1) DEFAULT NULL,
                            `salt` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `sex` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `status` varchar(8) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `user_name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `user_type` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `assert_password` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `assert_password_update_time` datetime DEFAULT NULL,
                            `assert_salt` varchar(32) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            `channel_id` bigint DEFAULT NULL,
                            `google_key` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
                            PRIMARY KEY (`user_id`),
                            KEY `idx_phoneNumber` (`phone_number`),
                            KEY `idx_userName` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

INSERT INTO `sys_user` VALUES (1,'admin','2025-12-28 08:22:30',_binary '\0',NULL,'admin','2025-12-28 08:22:30','/api/profile/avatar/2024/07/5c8465b67250123948d7f59f73fad856.png',2,NULL,'xunlian@xunlian.co',NULL,'2025-12-29 20:29:28','192.168.100.50','admin',NULL,'14797f4a1361622dd6947c3a48713fc2',0,NULL,NULL,NULL,NULL,'salt@defalut','0','1','超级管理员',NULL,NULL,NULL,NULL,1,'WllOQ1hISFJXTVhCWk9YTg==');
INSERT INTO `sys_user` VALUES (2,'admin','2025-12-29 20:25:02',_binary '\0',NULL,'admin','2025-12-29 20:25:02',NULL,1,NULL,'123@gg.com',NULL,'2025-12-29 20:29:47','192.168.100.50','test',NULL,'14797f4a1361622dd6947c3a48713fc2',NULL,NULL,'2025-12-29 20:25:02','12',NULL,'salt@defalut',NULL,'1',NULL,NULL,NULL,NULL,NULL,1,NULL);

--
-- Table structure for table `sys_user_online`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_online` (
                                   `session_id` varchar(64) COLLATE utf8mb4_general_ci NOT NULL,
                                   `browser` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `dept_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `expire_time` bigint DEFAULT NULL,
                                   `ip_addr` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `last_access_time` datetime DEFAULT NULL,
                                   `login_location` varchar(128) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `login_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `os` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   `start_timestamp` datetime DEFAULT NULL,
                                   `status` int DEFAULT NULL,
                                   `channel_name` varchar(64) COLLATE utf8mb4_general_ci DEFAULT NULL,
                                   PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_online`
--

--
-- Table structure for table `sys_user_post`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_post` (
                                 `id` bigint NOT NULL,
                                 `post_id` bigint DEFAULT NULL,
                                 `user_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_user_post` (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_post`
--


--
-- Table structure for table `sys_user_role`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sys_user_role` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `role_id` bigint NOT NULL,
                                 `user_id` bigint NOT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_user_role` (`user_id`,`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

INSERT INTO `sys_user_role` VALUES (1,1,1);
INSERT INTO `sys_user_role` VALUES (2,1,2);
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-29 20:32:57

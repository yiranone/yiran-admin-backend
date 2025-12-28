DROP TABLE IF EXISTS `biz_platform_param_config`;
CREATE TABLE `biz_platform_param_config` (
                                             `id` bigint NOT NULL AUTO_INCREMENT,
                                             `create_by` varchar(32) DEFAULT NULL,
                                             `create_time` datetime NOT NULL,
                                             `is_delete` bit(1) DEFAULT NULL,
                                             `remark` varchar(200) DEFAULT NULL,
                                             `update_by` varchar(32) DEFAULT NULL,
                                             `update_time` datetime DEFAULT NULL,
                                             `channel_id` bigint DEFAULT NULL,
                                             `config_group` varchar(10) DEFAULT NULL,
                                             `config_key` varchar(32) DEFAULT NULL,
                                             `config_name` varchar(32) DEFAULT NULL,
                                             `config_value` varchar(2048) DEFAULT NULL,
                                             `description` varchar(1024) DEFAULT NULL,
                                             `value_type` varchar(32) DEFAULT NULL,
                                             PRIMARY KEY (`id`),
                                             UNIQUE KEY `idx_cc_query_key` (`channel_id`,`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `biz_platform_param_config` WRITE;
INSERT INTO `biz_platform_param_config` VALUES
                                            (1,'admin',now(),false,NULL,NULL,now(),NULL,'sys','NOTICE_SWITCH','通知开关','','初始化,没有设置',NULL),
                                            (2,'admin',now(),false,NULL,NULL,now(),NULL,'sys','DEFAULT_HEAD_IMG','默认头像','','初始化,没有设置',NULL);
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_analysis_item`;
CREATE TABLE `sys_analysis_item` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `create_by` varchar(32) DEFAULT NULL,
                                     `create_time` datetime NOT NULL,
                                     `is_delete` bit(1) DEFAULT NULL,
                                     `remark` varchar(64) DEFAULT NULL,
                                     `update_by` varchar(32) DEFAULT NULL,
                                     `update_time` datetime DEFAULT NULL,
                                     `belong_date` date DEFAULT NULL,
                                     `channel_id` bigint DEFAULT NULL,
                                     `key_name` varchar(32) DEFAULT NULL,
                                     `type` varchar(32) DEFAULT NULL,
                                     `value` varchar(32) DEFAULT NULL,
                                     `sub_type` varchar(32) DEFAULT NULL,
                                     PRIMARY KEY (`id`),
                                     KEY `idx_ty_date` (`type`,`belong_date`),
                                     KEY `idx_chid_type` (`channel_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_channel`;
CREATE TABLE `sys_channel` (
                               `channel_id` bigint NOT NULL AUTO_INCREMENT,
                               `create_by` varchar(255) DEFAULT NULL,
                               `create_time` datetime DEFAULT NULL,
                               `is_delete` bit(1) DEFAULT NULL,
                               `remark` varchar(255) DEFAULT NULL,
                               `update_by` varchar(255) DEFAULT NULL,
                               `update_time` datetime DEFAULT NULL,
                               `channel_code` varchar(32) NOT NULL,
                               `channel_name` varchar(32) NOT NULL,
                               `channel_type` varchar(1) DEFAULT NULL,
                               `expire_date` date NOT NULL,
                               `status` varchar(2) DEFAULT NULL,
                               `channel_sort` int DEFAULT NULL,
                               `domain_name` varchar(32) DEFAULT NULL,
                               `logo` longtext,
                               `display_name` varchar(32) DEFAULT NULL,
                               `icon` longtext,
                               `dig_currency` varchar(32) DEFAULT NULL,
                               `pay_currency` varchar(32) DEFAULT NULL,
                               `h5domain_name` varchar(32) DEFAULT NULL,
                               `h5logo` varchar(256) DEFAULT NULL,
                               `order_need_invite_code` varchar(1) DEFAULT NULL,
                               `register_need_invite_code` varchar(1) DEFAULT NULL,
                               PRIMARY KEY (`channel_id`),
                               UNIQUE KEY `idx_cha_code` (`channel_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_channel` WRITE;
INSERT INTO `sys_channel` VALUES (1,'admin',now(),false,NULL,'admin',now(),'HTY','HTY','Y','2999-12-31','1',1,'admin.host.com','/api/profile/upload/2024/07/bd3aa353578a0f3f5b93b6a1665cbd3b.jpg','HTY后台管理系统','/ccf46c8e7a1aa980fee753271f15ff5a.ico','','USDT','h5.host.com',NULL,'N','N');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
                              `config_id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(255) DEFAULT NULL,
                              `create_time` datetime DEFAULT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(255) DEFAULT NULL,
                              `update_by` varchar(255) DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `config_key` varchar(100) DEFAULT NULL,
                              `config_name` varchar(100) DEFAULT NULL,
                              `config_type` varchar(1) DEFAULT NULL,
                              `config_value` varchar(500) DEFAULT NULL,
                              PRIMARY KEY (`config_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_config` WRITE;
INSERT INTO `sys_config` VALUES
                             (1,NULL,now(),false,NULL,NULL,now(),'system_user_initPassword','新用户初始化密码','Y','123456'),
                             (2,NULL,now(),false,NULL,NULL,now(),'system_theme','系统主题','Y','red');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
                            `dept_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `dept_name` varchar(30) DEFAULT NULL,
                            `email` varchar(50) DEFAULT NULL,
                            `leader` varchar(11) DEFAULT NULL,
                            `order_num` int NOT NULL,
                            `parent_id` bigint DEFAULT NULL,
                            `parent_name` varchar(255) DEFAULT NULL,
                            `phone` varchar(11) DEFAULT NULL,
                            `status` varchar(255) DEFAULT NULL,
                            `dept_code` varchar(32) DEFAULT NULL,
                            PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_dept` WRITE;
INSERT INTO `sys_dept` VALUES
                           (1,'admin',now(),false,NULL,NULL,now(),'总部',  'xxx@email.com',NULL,1,0,NULL,NULL,'1','0001'),
                           (2,'admin',now(),false,NULL,NULL,now(),'技术部','xxx@email.com',NULL,2,1,'总部',NULL,'1','000101'),
                           (3,'admin',now(),false,NULL,NULL,now(),'运营部','xxx@email.com',NULL,3,1,'总部',NULL,'1','000102'),
                           (4,'admin',now(),false,NULL,NULL,now(),'市场部','xxx@email.com',NULL,4,1,'总部',NULL,'1','001004');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
                                 `dict_code` bigint NOT NULL AUTO_INCREMENT,
                                 `create_by` varchar(255) DEFAULT NULL,
                                 `create_time` datetime DEFAULT NULL,
                                 `is_delete` bit(1) DEFAULT NULL,
                                 `remark` varchar(255) DEFAULT NULL,
                                 `update_by` varchar(255) DEFAULT NULL,
                                 `update_time` datetime DEFAULT NULL,
                                 `css_class` varchar(100) DEFAULT NULL,
                                 `dict_label` varchar(100) DEFAULT NULL,
                                 `dict_type` varchar(100) DEFAULT NULL,
                                 `dict_value` varchar(100) DEFAULT NULL,
                                 `is_default` varchar(255) DEFAULT NULL,
                                 `list_class` varchar(255) DEFAULT NULL,
                                 `status` varchar(255) DEFAULT NULL,
                                 `order_num` int DEFAULT NULL,
                                 PRIMARY KEY (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_dict_data` WRITE;
INSERT INTO `sys_dict_data` VALUES
                                (1, 'admin',now(),false,NULL,'admin',now(),'green','正常','system_user_status','1','0',NULL,'1',1),
                                (2, 'admin',now(),false,NULL,'admin',now(),'red','冻结','system_user_status','2','1',NULL,'1',2),
                                (3, 'admin',now(),false,NULL,'admin',now(),'green','正常','system_normal_disable','1','Y',NULL,'1',1),
                                (4, 'admin',now(),false,NULL,'admin',now(),'red','停用','system_normal_disable','2','N',NULL,'1',2),
                                (5, 'admin',now(),false,NULL,'admin',now(),NULL,'是','system_yes_no','Y',NULL,NULL,'1',1),
                                (6, 'admin',now(),false,NULL,'admin',now(),NULL,'否','system_yes_no','N',NULL,NULL,'1',2),
                                (7, 'admin',now(),false,NULL,'admin',now(),NULL,'通知','system_notice_type','1',NULL,NULL,'1',1),
                                (8, 'admin',now(),false,NULL,'admin',now(),NULL,'公告','system_notice_type','2',NULL,NULL,'1',2),
                                (9, 'admin',now(),false,NULL,'admin',now(),NULL,'正常','system_notice_status','1',NULL,NULL,'1',1),
                                (10,'admin',now(),false,NULL,'admin',now(),NULL,'关闭','system_notice_status','2',NULL,NULL,'1',2),
                                (11,'admin',now(),false,NULL,'admin',now(),'green','新增','system_operate_type','1',NULL,NULL,'1',1),
                                (12,'admin',now(),false,NULL,'admin',now(),'yellow','修改','system_operate_type','2',NULL,NULL,'1',2),
                                (13,'admin',now(),false,NULL,'admin',now(),'red','删除','system_operate_type','3',NULL,NULL,'1',3),
                                (14,'admin',now(),false,NULL,'admin',now(),NULL,'授权','system_operate_type','4',NULL,NULL,'1',4),
                                (15,'admin',now(),false,NULL,'admin',now(),NULL,'导出','system_operate_type','5',NULL,NULL,'1',5),
                                (16,'admin',now(),false,NULL,'admin',now(),NULL,'导入','system_operate_type','6',NULL,NULL,'1',6),
                                (17,'admin',now(),false,NULL,'admin',now(),NULL,'强退','system_operate_type','7',NULL,NULL,'1',7),
                                (18,'admin',now(),false,NULL,'admin',now(),NULL,'生成代码','system_operate_type','8',NULL,NULL,'1',8),
                                (19,'admin',now(),false,NULL,'admin',now(),NULL,'清空数据','system_operate_type','9',NULL,NULL,'1',9),
                                (20,'admin',now(),false,NULL,'admin',now(),NULL,'执行','system_operate_type','10',NULL,NULL,'1',10),
                                (21,'admin',now(),false,NULL,'admin',now(),'red','审核','system_operate_type','11',NULL,NULL,'1',11),
                                (22,'admin',now(),false,NULL,'admin',now(),'green','成功','system_result_status','SUCCESS','1',NULL,'1',1),
                                (23,'admin',now(),false,NULL,'admin',now(),'red','失败','system_result_status','FAIL',NULL,NULL,'1',2),
                                (24,'admin',now(),false,NULL,'admin',now(),'yellow','未知','system_result_status','UNKNOW',NULL,NULL,'1',3),
                                (25,'admin',now(),false,NULL,'admin',now(),'green','在线','system_online_offline','on_line',NULL,NULL,'1',1),
                                (26,'admin',now(),false,NULL,'admin',now(),'red','离线','system_online_offline','off_line',NULL,NULL,'1',2),
                                (27,'admin',now(),false,NULL,'admin',now(),'blue','显示','system_visible_status','1',NULL,NULL,'1',1),
                                (28,'admin',now(),false,NULL,'admin',now(),'yellow','隐藏','system_visible_status','2',NULL,NULL,'1',2),
                                (29,'admin',now(),false,NULL,'admin',now(),'yellow','待审核','system_audit_status','0',NULL,NULL,'1',1),
                                (30,'admin',now(),false,NULL,'admin',now(),'green','审核通过','system_audit_status','1',NULL,NULL,'1',2),
                                (31,'admin',now(),false,NULL,'admin',now(),'red','审核拒绝','system_audit_status','2',NULL,NULL,'1',3);
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
                                 `dict_id` bigint NOT NULL AUTO_INCREMENT,
                                 `create_by` varchar(255) DEFAULT NULL,
                                 `create_time` datetime DEFAULT NULL,
                                 `is_delete` bit(1) DEFAULT NULL,
                                 `remark` varchar(255) DEFAULT NULL,
                                 `update_by` varchar(255) DEFAULT NULL,
                                 `update_time` datetime DEFAULT NULL,
                                 `dict_name` varchar(100) DEFAULT NULL,
                                 `dict_type` varchar(100) DEFAULT NULL,
                                 `status` varchar(255) DEFAULT NULL,
                                 PRIMARY KEY (`dict_id`),
                                 KEY `idx_dictName` (`dict_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_dict_type` WRITE;
INSERT INTO `sys_dict_type` VALUES
                                (1, 'admin',now(),false,NULL,'admin',now(),'用户状态','system_user_status','1'),
                                (2, 'admin',now(),false,NULL,'admin',now(),'正常停用','system_normal_disable','1'),
                                (3, 'admin',now(),false,NULL,'admin',now(),'是否','system_yes_no','1'),
                                (4, 'admin',now(),false,NULL,'admin',now(),'通知类型','system_notice_type','1'),
                                (5, 'admin',now(),false,NULL,'admin',now(),'通知状态','system_notice_status','1'),
                                (6, 'admin',now(),false,NULL,'admin',now(),'操作类型','system_operate_type','1'),
                                (7, 'admin',now(),false,NULL,'admin',now(),'结果状态','system_result_status','1'),
                                (8, 'admin',now(),false,NULL,'admin',now(),'在线离线','system_online_offline','1'),
                                (9, 'admin',now(),false,NULL,'admin',now(),'显示隐藏状态','system_visible_status','1'),
                                (10,'admin',now(),false,NULL,'admin',now(),'审核状态','system_audit_status','1');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_login_info`;
CREATE TABLE `sys_login_info` (
                                  `info_id` bigint NOT NULL AUTO_INCREMENT,
                                  `create_by` varchar(32) NOT NULL,
                                  `create_time` datetime NOT NULL,
                                  `is_delete` bit(1) DEFAULT NULL,
                                  `remark` varchar(64) DEFAULT NULL,
                                  `update_by` varchar(32) DEFAULT NULL,
                                  `update_time` datetime DEFAULT NULL,
                                  `browser` varchar(255) DEFAULT NULL,
                                  `ip_addr` varchar(255) DEFAULT NULL,
                                  `login_location` varchar(255) DEFAULT NULL,
                                  `login_name` varchar(255) DEFAULT NULL,
                                  `login_time` datetime DEFAULT NULL,
                                  `msg` varchar(255) DEFAULT NULL,
                                  `os` varchar(255) DEFAULT NULL,
                                  `status` varchar(255) DEFAULT NULL,
                                  `category` varchar(32) DEFAULT NULL,
                                  `channel_id` bigint DEFAULT NULL,
                                  `category_id` bigint DEFAULT NULL,
                                  PRIMARY KEY (`info_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
                            `menu_id` bigint NOT NULL AUTO_INCREMENT,
                            `router` varchar(255) DEFAULT NULL,
                            `component` varchar(200) DEFAULT NULL,
                            `icon` varchar(255) DEFAULT NULL,
                            `menu_name` varchar(50) DEFAULT NULL,
                            `menu_type` varchar(255) DEFAULT NULL,
                            `order_num` int NOT NULL,
                            `parent_id` bigint DEFAULT NULL,
                            `perms` varchar(100) DEFAULT NULL,
                            `visible` varchar(255) DEFAULT NULL,
                            `is_cache` varchar(1) DEFAULT NULL,
                            `is_frame` varchar(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `query` varchar(200) DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `create_by` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            PRIMARY KEY (`menu_id`),
                            KEY `idx_parentId` (`parent_id`),
                            KEY `idx_menuName` (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_menu` WRITE;
INSERT INTO `sys_menu` VALUES
                           (1,'home','/pages/home','alert','首页','C',10,0,'system:home','1',NULL,'2',NULL,'p=我是首页&q=欢迎90',NULL,now(),'admin','admin',now()),


                           (20,'member',NULL,'team','用户管理','M',20,0,'','1',NULL,'2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (201,'member','/pages/biz/member','user','用户列表','C',1,20,'biz:member:view','1','1','2',NULL,'',NULL,now(),'admin','admin',now()),
                           (2011,'',NULL,NULL,'用户查询','F',1,201,'biz:member:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (2012,'',NULL,NULL,'用户新增','F',2,201,'biz:member:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (2013,'',NULL,NULL,'用户修改','F',3,201,'biz:member:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (2014,'',NULL,NULL,'用户删除','F',4,201,'biz:member:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),


                           (97,'content',NULL,'profile','内容管理','M',97,0,NULL,'1',NULL,'2',NULL,NULL,NULL,now(),'admin','sys',now()),
                           (971,'banner','/pages/biz/banner','','Banner管理','C',1,97,'biz:banner:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9711,'',NULL,NULL,'Banner查询','F',1,971,'biz:banner:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9712,'',NULL,NULL,'Banner新增','F',2,971,'biz:banner:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9713,'',NULL,NULL,'Banner修改','F',3,971,'biz:banner:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9714,'',NULL,NULL,'Banner删除','F',4,971,'biz:banner:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (972,'message','/pages/biz/notice','','消息管理','C',2,97,'biz:notice:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9721,'',NULL,NULL,'消息管理查询','F',1,972,'biz:notice:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9722,'',NULL,NULL,'消息管理新增','F',1,972,'biz:notice:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9723,'',NULL,NULL,'消息管理修改','F',2,972,'biz:notice:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9724,'',NULL,NULL,'消息管理删除','F',3,972,'biz:notice:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (973,'article','/pages/biz/article',NULL,'文章管理','C',3,97,'biz:article:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9731,'',NULL,NULL,'文章管理查询','F',1,973,'biz:article:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9732,'',NULL,NULL,'文章管理新增','F',2,973,'biz:article:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9733,'',NULL,NULL,'文章管理修改','F',3,973,'biz:article:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9734,'',NULL,NULL,'文章管理删除','F',4,973,'biz:article:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (974,'question','/pages/biz/question',NULL,'常见问题','C',4,97,'biz:question:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9741,'',NULL,NULL,'常见问题查询','F',1,974,'biz:question:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9742,'',NULL,NULL,'常见问题新增','F',2,974,'biz:question:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9743,'',NULL,NULL,'常见问题修改','F',3,974,'biz:question:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9744,'',NULL,NULL,'常见问题删除','F',4,974,'biz:question:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),



                           (98,'param',NULL,'api','参数管理','M',98,0,'','1',NULL,'2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (981,'platformParamConfig2','/pages/biz/platformParamConfig',NULL,'基础参数','C',5,98,'biz:platformParamConfig:view','1',NULL,'2',NULL,'configGroup=sys',NULL,now(),'admin','admin',now()),
                           (9811,'',NULL,NULL,'参数管理修改','F',3,981,'biz:platformParamConfig:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),


                           (99,'system',NULL,'setting','系统管理','M',99,0,NULL,'1',NULL,'2',NULL,NULL,NULL,now(),'admin','admin',now()),

                           (991,'menu','/pages/system/menu','flag','菜单管理','C',1,99,'system:menu:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9911,'',NULL,NULL,'菜单管理查看','F',1,991,'system:menu:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9912,'',NULL,NULL,'菜单管理修改','F',2,991,'system:menu:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9913,'',NULL,NULL,'菜单管理删除','F',3,991,'system:menu:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9914,'',NULL,NULL,'菜单管理新增','F',4,991,'system:menu:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (992,'role','/pages/system/role','team','角色管理','C',2,99,'system:role:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9921,'',NULL,NULL,'角色管理查询','F',1,992,'system:role:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9922,'',NULL,NULL,'角色管理修改','F',3,992,'system:role:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9923,'',NULL,NULL,'角色管理新增','F',2,992,'system:role:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9924,'',NULL,NULL,'角色管理删除','F',4,992,'system:role:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9925,'',NULL,NULL,'角色管理导出','F',5,992,'system:role:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9926,'',NULL,NULL,'角色管理授权','F',6,992,'system:role:auth','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (993,'channel','/pages/system/channel','thunderbolt','渠道管理','C',3,99,'system:channel:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9931,'',NULL,NULL,'渠道管理查询','F',1,993,'system:channel:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9932,'',NULL,NULL,'渠道管理新增','F',2,993,'system:channel:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9933,'',NULL,NULL,'渠道管理修改','F',3,993,'system:channel:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9934,'',NULL,NULL,'渠道管理删除','F',4,993,'system:channel:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (994,'user','/pages/system/user','user','后台账号','C',4,99,'system:user:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9941,'',NULL,NULL,'后台账号修改','F',3,994,'system:user:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9942,'',NULL,NULL,'后台账号新增','F',2,994,'system:user:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9943,'',NULL,NULL,'后台账号查询','F',1,994,'system:user:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9944,'',NULL,NULL,'后台账号删除','F',4,994,'system:user:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9945,'',NULL,NULL,'后台账号导出','F',5,994,'system:user:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9946,'',NULL,NULL,'后台账号授权','F',6,994,'system:user:auth','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9947,'',NULL,NULL,'后台账号重置密码','F',7,994,'system:user:resetPwd','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9948,'',NULL,NULL,'后台账号解锁','F',9,994,'system:user:unlock','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (995,'dept','/pages/system/dept','bank','部门管理','C',5,99,'system:dept:view','2','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9951,'',NULL,NULL,'部门管理新增','F',1,995,'system:dept:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9952,'',NULL,NULL,'部门管理修改','F',2,995,'system:dept:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9953,'',NULL,NULL,'部门管理删除','F',3,995,'system:dept:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9954,'',NULL,NULL,'部门管理查询','F',1,995,'system:dept:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (996,'config','/pages/system/config','database','系统参数','C',6,99,'system:config:view','1','2','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9961,'',NULL,NULL,'系统参数查询','F',1,996,'system:config:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9962,'',NULL,NULL,'系统参数新增','F',2,996,'system:config:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9963,'',NULL,NULL,'系统参数修改','F',3,996,'system:config:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9964,'',NULL,NULL,'系统参数删除','F',4,996,'system:config:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9965,'',NULL,NULL,'系统参数导出','F',5,996,'system:config:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (997,'notice','/pages/system/notice','alert','公告通知','C',7,99,'system:notice:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9971,'',NULL,NULL,'公告通知查询','F',1,997,'system:notice:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9972,'',NULL,NULL,'公告通知心中','F',2,997,'system:notice:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9973,'',NULL,NULL,'公告通知修改','F',3,997,'system:notice:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9974,'',NULL,NULL,'公告通知删除','F',4,997,'system:notice:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9975,'',NULL,NULL,'公告通知导出','F',5,997,'system:notice:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (998,'dict','/pages/system/dict','book','数据字典','C',8,99,'system:dict:view','1','2','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9981,'',NULL,NULL,'数据字典查询','F',1,998,'system:dict:view','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9982,'',NULL,NULL,'数据字典新增','F',2,998,'system:dict:add','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9983,'',NULL,NULL,'数据字典修改','F',3,998,'system:dict:edit','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9984,'',NULL,NULL,'数据字典删除','F',4,998,'system:dict:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (9985,'',NULL,NULL,'数据字典导出','F',5,998,'system:dict:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (999,'online','/pages/system/online','usergroup-delete','在线用户','C',9,99,'system:online:view','1','1','2',NULL,NULL,NULL,now(),'admin','admin',now()),
                           (2063,'',NULL,NULL,'强退用户','F',1,999,'system:online:forceLogout','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),

                           (1000,'operateLog','/pages/system/operateLog','bug','操作日志','C',10,99,'system:operate:log:view','1','2','2',NULL,'log=1',NULL,now(),'admin','admin',now()),
                           (10001,'',NULL,NULL,'操作日志删除','F',1,1000,'system:operate:log:delete','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now()),
                           (10002,'',NULL,NULL,'操作日志导出','F',2,1000,'system:operate:log:export','1',NULL,NULL,NULL,NULL,NULL,now(),'admin','admin',now());
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
                              `notice_id` bigint NOT NULL AUTO_INCREMENT,
                              `create_by` varchar(255) DEFAULT NULL,
                              `create_time` datetime DEFAULT NULL,
                              `is_delete` bit(1) DEFAULT NULL,
                              `remark` varchar(255) DEFAULT NULL,
                              `update_by` varchar(255) DEFAULT NULL,
                              `update_time` datetime DEFAULT NULL,
                              `notice_content` varchar(2000) NOT NULL,
                              `notice_title` varchar(50) DEFAULT NULL,
                              `notice_type` varchar(255) NOT NULL,
                              `status` varchar(255) DEFAULT NULL,
                              PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_notice` WRITE;
INSERT INTO `sys_notice` VALUES
                             (1,'tt','2022-09-18 00:12:33',NULL,NULL,'admin','2024-04-22 00:19:43','<p><b>123123</b></p><p><b>呼哈</b></p>','公告类型1','2','1'),
                             (2,'admin','2022-09-19 12:12:32',NULL,NULL,'admin','2024-04-22 00:19:48','<p>12312390909</p>','1haha','2','1');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_operate_log`;
CREATE TABLE `sys_operate_log` (
                                   `operate_id` bigint NOT NULL AUTO_INCREMENT,
                                   `create_by` varchar(32) NOT NULL,
                                   `create_time` datetime NOT NULL,
                                   `is_delete` bit(1) DEFAULT NULL,
                                   `remark` varchar(64) DEFAULT NULL,
                                   `update_by` varchar(32) DEFAULT NULL,
                                   `update_time` datetime DEFAULT NULL,
                                   `business_type` int NOT NULL,
                                   `business_types` int DEFAULT NULL,
                                   `dept_name` varchar(255) DEFAULT NULL,
                                   `error_msg` varchar(255) DEFAULT NULL,
                                   `json_result` varchar(2048) DEFAULT NULL,
                                   `method` varchar(255) DEFAULT NULL,
                                   `operate_ip` varchar(64) DEFAULT NULL,
                                   `operate_location` varchar(64) DEFAULT NULL,
                                   `operate_name` varchar(255) DEFAULT NULL,
                                   `operate_param` varchar(4096) DEFAULT NULL,
                                   `operate_time` datetime DEFAULT NULL,
                                   `operate_url` varchar(256) DEFAULT NULL,
                                   `operator_type` int DEFAULT NULL,
                                   `request_method` varchar(255) DEFAULT NULL,
                                   `session_type` varchar(8) DEFAULT NULL,
                                   `status` varchar(255) DEFAULT NULL,
                                   `title` varchar(32) DEFAULT NULL,
                                   PRIMARY KEY (`operate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_perm`;
CREATE TABLE `sys_perm` (
                            `perm_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `perm_group` varchar(100) DEFAULT NULL,
                            `perm_name` varchar(30) DEFAULT NULL,
                            `perm_operation` varchar(100) DEFAULT NULL,
                            `perm_sort` varchar(255) DEFAULT NULL,
                            `status` varchar(255) DEFAULT NULL,
                            PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_perm` WRITE;
INSERT INTO `sys_perm` VALUES
                           (1,'admin',now(),NULL,NULL,'admin',now(),'user','用户查询','user.query','6','0'),
                           (2,'admin',now(),NULL,NULL,'admin',now(),'user','用户编辑','user.edit','3','0'),
                           (3,'admin',now(),NULL,NULL,'admin',now(),'用户组','用户删除','user.delete','1','0');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
                            `post_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `flag` bit(1) NOT NULL,
                            `post_code` varchar(255) DEFAULT NULL,
                            `post_name` varchar(255) DEFAULT NULL,
                            `post_sort` int DEFAULT NULL,
                            `status` varchar(255) DEFAULT NULL,
                            PRIMARY KEY (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
                            `role_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `role_key` varchar(100) DEFAULT NULL,
                            `role_name` varchar(30) DEFAULT NULL,
                            `role_sort` int DEFAULT NULL,
                            `status` varchar(255) DEFAULT NULL,
                            `menu_check_strictly` bit(1) DEFAULT NULL,
                            PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_role` WRITE;
INSERT INTO `sys_role` VALUES (1,'admin',now(),false,'管理员角色','admin','2020-12-06 09:26:45','role:admin','管理员',1,'1',_binary '');
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
                                 `id` bigint NOT NULL,
                                 `dept_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_dept` (`role_id`,`dept_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `menu_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_menu` (`role_id`,`menu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_role_perm`;
CREATE TABLE `sys_role_perm` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `perm_id` bigint DEFAULT NULL,
                                 `role_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_role_perm` (`role_id`,`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
                            `user_id` bigint NOT NULL AUTO_INCREMENT,
                            `create_by` varchar(255) DEFAULT NULL,
                            `create_time` datetime DEFAULT NULL,
                            `is_delete` bit(1) DEFAULT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `update_by` varchar(255) DEFAULT NULL,
                            `update_time` datetime DEFAULT NULL,
                            `avatar` varchar(255) DEFAULT NULL,
                            `dept_id` bigint DEFAULT NULL,
                            `dept_name` varchar(255) DEFAULT NULL,
                            `email` varchar(50) DEFAULT NULL,
                            `email_login_enable` bit(1) DEFAULT NULL,
                            `login_date` datetime DEFAULT NULL,
                            `login_ip` varchar(64) DEFAULT NULL,
                            `login_name` varchar(30) DEFAULT NULL,
                            `open_id` varchar(255) DEFAULT NULL,
                            `password` varchar(255) DEFAULT NULL,
                            `password_error_count` bigint DEFAULT NULL,
                            `password_error_time` datetime DEFAULT NULL,
                            `password_update_time` datetime DEFAULT NULL,
                            `phone_number` varchar(32) DEFAULT NULL,
                            `phone_number_login_enable` bit(1) DEFAULT NULL,
                            `salt` varchar(32) DEFAULT NULL,
                            `sex` varchar(255) DEFAULT NULL,
                            `status` varchar(8) DEFAULT NULL,
                            `user_name` varchar(30) DEFAULT NULL,
                            `user_type` varchar(255) DEFAULT NULL,
                            `assert_password` varchar(255) DEFAULT NULL,
                            `assert_password_update_time` datetime DEFAULT NULL,
                            `assert_salt` varchar(32) DEFAULT NULL,
                            `channel_id` bigint DEFAULT NULL,
                            PRIMARY KEY (`user_id`),
                            KEY `idx_phoneNumber` (`phone_number`),
                            KEY `idx_userName` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_user` WRITE;
INSERT INTO `sys_user` VALUES
    (1,'admin',now(),false,NULL,'admin',now(),'/api/profile/avatar/2024/07/5c8465b67250123948d7f59f73fad856.png',2,NULL,'xunlian@xunlian.co',NULL,NULL,NULL,'admin',NULL,'14797f4a1361622dd6947c3a48713fc2',0,NULL,NULL,NULL,NULL,'salt@defalut','0','1','超级管理员',NULL,NULL,NULL,NULL,1);
UNLOCK TABLES;


DROP TABLE IF EXISTS `sys_user_online`;
CREATE TABLE `sys_user_online` (
                                   `session_id` varchar(64) NOT NULL,
                                   `browser` varchar(64) DEFAULT NULL,
                                   `dept_name` varchar(64) DEFAULT NULL,
                                   `expire_time` bigint DEFAULT NULL,
                                   `ip_addr` varchar(64) DEFAULT NULL,
                                   `last_access_time` datetime DEFAULT NULL,
                                   `login_location` varchar(128) DEFAULT NULL,
                                   `login_name` varchar(64) DEFAULT NULL,
                                   `os` varchar(64) DEFAULT NULL,
                                   `start_timestamp` datetime DEFAULT NULL,
                                   `status` int DEFAULT NULL,
                                   `channel_name` varchar(64) DEFAULT NULL,
                                   PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
                                 `id` bigint NOT NULL,
                                 `post_id` bigint DEFAULT NULL,
                                 `user_id` bigint DEFAULT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_user_post` (`user_id`,`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `role_id` bigint NOT NULL,
                                 `user_id` bigint NOT NULL,
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `idx_user_role` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

LOCK TABLES `sys_user_role` WRITE;
INSERT INTO `sys_user_role` VALUES (1,1,1);
UNLOCK TABLES;

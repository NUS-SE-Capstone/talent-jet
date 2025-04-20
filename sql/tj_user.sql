-- MySQL dump 10.13  Distrib 8.0.41, for macos15.2 (arm64)
--
-- Host: 127.0.0.1    Database: tj_user
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` bigint NOT NULL COMMENT '主键',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `cell_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '手机号',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '用户类型：1-员工, 2-普通学员，3-老师',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '账户状态：0-禁用 1-正常',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creater` bigint DEFAULT NULL COMMENT '创建者id',
  `updater` bigint DEFAULT '0' COMMENT '更新者id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username_idx` (`username`) USING BTREE,
  UNIQUE KEY `cell_idx` (`cell_phone`,`type`) USING BTREE,
  KEY `type_idx` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='学员用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `cell_phone`, `password`, `type`, `status`, `create_time`, `update_time`, `creater`, `updater`) VALUES (1,'admin','13500010002','$2a$10$4duXTHlB9/jgnaNylGD2rOfwvko/T7fCjqLqpVoqVyRo11GGatyFS',1,1,'2022-06-28 08:36:20','2025-03-09 09:57:29',1,1),(2,'jack','13500010003','$2a$10$6ptTq3V9XfaJmFYwYT2W9ud377BUkEWk.whf.iQ.0sX5F.L497rAC',2,1,'2022-06-28 12:23:56','2025-03-09 09:57:29',1,1),(129,'rose','13500010004','$2a$10$4o7O/ywpRqFdVzdSFgUoQeHIIgetWgrd2QOT5GRMPG64RcXhw.W4u',2,1,'2022-06-28 12:47:51','2025-03-09 15:21:40',1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_detail`
--

DROP TABLE IF EXISTS `user_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_detail` (
  `id` bigint NOT NULL COMMENT '关联用户id',
  `type` tinyint DEFAULT '2' COMMENT '用户类型：1-员工, 2-普通学员，3-老师',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '名字',
  `gender` tinyint NOT NULL DEFAULT '0' COMMENT '性别：0-男性，1-女性',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '头像地址',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '邮箱',
  `qq` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'QQ号码',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `job` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '岗位',
  `province` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '省',
  `city` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '市',
  `district` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '区',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '个人介绍',
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '形象照地址',
  `role_id` bigint NOT NULL COMMENT '角色id',
  `course_amount` smallint DEFAULT '0' COMMENT '购买课程数量，学生才有该字段信息',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creater` bigint DEFAULT NULL COMMENT '创建者id',
  `updater` bigint DEFAULT '0' COMMENT '更新者id',
  `dep_id` bigint NOT NULL DEFAULT '0' COMMENT '部门id',
  PRIMARY KEY (`id`) USING BTREE,
  FULLTEXT KEY `name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='教师详情表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_detail`
--

LOCK TABLES `user_detail` WRITE;
/*!40000 ALTER TABLE `user_detail` DISABLE KEYS */;
INSERT INTO `user_detail` (`id`, `type`, `name`, `gender`, `icon`, `email`, `qq`, `birthday`, `job`, `province`, `city`, `district`, `intro`, `photo`, `role_id`, `course_amount`, `create_time`, `update_time`, `creater`, `updater`, `dep_id`) VALUES (1,1,'虎哥',0,'/img-tx/1.jpg','','',NULL,'管理员',NULL,NULL,NULL,NULL,NULL,1,NULL,'2022-07-14 03:19:18','2022-09-03 09:57:38',1,1,0),(2,2,'Jack',0,'/img-tx/0abcd1d7a66a4fad98b80c1bb48ec6ec.png','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2022-07-18 18:15:00','2025-04-16 14:10:07',1,1,0),(129,2,'Rose',1,'/img-tx/a71d11ed64ac40668bdfa5bfc63b97bf.png','','',NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2022-07-18 18:16:40','2025-04-16 14:10:07',1,1,0),(1548889371405492225,3,'罗老师',0,'/img-tx/1.jpg','','',NULL,'讲师',NULL,NULL,NULL,'Sklearn机器学习工具源码贡献者；Google Tensorflow中文社区开发者；具有多年企业级AI项目开发经验，对推荐系统，NLP，知识图谱，问答系统有较深入研究。','/img-tx/b473f39c6501431f9e29c7a0beb4c668.jpg',3,NULL,'2022-07-18 12:36:18','2022-11-08 15:49:11',1,1,0),(1548940676303970306,3,'张老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'拥有全栈开发能力，精通各类 Web 前端开发技术以及后端Java技术栈、Node.js技术栈等。乐于帮助学生成长为专业软件开发从业者。','/img-tx/ff4e37433bc54621b7e237926c3c5998.jpg',3,NULL,'2022-07-18 16:00:10','2022-11-08 15:49:18',1,1,0),(1548940777449611265,3,'王老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'拥有9年设计经验，曾服务北京正邦品牌策划，百度用户体验中心，北京资海科技集团，龙采科技集团，优逸客科技教育集团，洛杉矶张大钦律师事务所等众多一线互联网设计与外包平台。','/img-tx/262241a6efd147c9b3c849561720429f.jpg',3,NULL,'2022-07-18 16:00:34','2022-11-08 15:49:25',1,1,0),(1548940921662365698,3,'李老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'Apache Flink源码贡献者。专注于亿级用户规模的大数据平台研发建设和研发，历任项目经理、工程师、技术总监等职务','/img-tx/8d025db3e8ed4e47a4bbdd3fe485f03e.jpg',3,NULL,'2022-07-18 16:01:09','2022-11-08 15:49:31',1,1,0),(1548941239125041153,3,'郎老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'先后在国内IT名企担任软件开发工程师、项目经理等职务。 掌握Java SE，Java Web、MySQL、Redis以及Dubbo、ZooKeeper 、SpringBoot、SpringCloud等分布式架构技术以及Vue.js等前端框架','/img-tx/62e4c4c5a6de428cb327691554f44787.jpg',3,NULL,'2022-07-18 16:02:25','2022-11-08 15:49:37',1,1,0),(1548941336596471809,3,'孙老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'人工智能博士，曾就职多家知名互联网人工智能公司，善于并引入深度学习领域的新进展。在算法架构及算法模型方面都有较深的造诣，在多模态、内容理解及内容安全、情感计算等方面具备多年实践经验，发表国内外论文多篇。项目经历：多模态内容标签、多模态安全检测、知识图谱','/img-tx/fc3052bdb2e84106a7a2809fa660b333.jpg',3,NULL,'2022-07-18 16:02:48','2022-11-08 15:49:45',1,1548941336596471809,0),(1549358501685448706,3,'李老师',0,'/img-tx/header_default.png','','',NULL,'讲师',NULL,NULL,NULL,'10多年IT从业经验，北大计算机毕业，曾在中科软从事系统分析与架构工作，精通OOM、PD、DDD建模；对计算机原理、体系结构、常用算法有深入研究；熟练分布式和微服务环境下的主流技术架构。','/img-tx/65b7682b82c24946b58b77730588a4d2.jpg',3,NULL,'2022-07-19 19:40:27','2022-11-08 15:49:52',1,1,0),(1549358967710371842,3,'王老师',0,'/img-tx/header_default.png','','',NULL,'Java讲师',NULL,NULL,NULL,'曾研发广西税务系统、易迅网络发票、三维度商城、三维度支付系统。\\n主导B2B2C大型电商，神州培训网、万语网、金融平台的研发与重构。','/img-tx/9361d2bb70b54a48a820159542df879e.png',3,NULL,'2022-07-19 19:42:18','2022-11-08 15:48:25',1,1,0),(1557020684306108417,1,'老王吧',0,'/img-tx/header_default.png','','',NULL,'管理员',NULL,NULL,NULL,'',NULL,6,NULL,'2022-08-09 23:07:13','2022-11-08 15:48:26',1,1,0),(1565885870605664257,3,'小白',0,'/img-tx/header_default.png',NULL,NULL,NULL,'舞蹈老师',NULL,NULL,NULL,'某破站知名舞蹈区UP主，百大UP主','/img-tx/001df90614b74e81bc78494619b035a2.jpg',3,0,'2022-09-03 10:14:21','2022-11-08 15:50:20',NULL,0,0),(1565891617586503681,3,'小虎',0,'/img-tx/header_default.png',NULL,NULL,NULL,'Java高级讲师',NULL,NULL,NULL,'高级Java讲师，多套课程排名小破站榜首','/img-tx/ef605f8a5b654780bcee8fab2ff2f61d.png',3,0,'2022-09-03 10:37:11','2022-11-08 15:48:27',NULL,0,0),(1575480245375016961,3,'老陈',0,'/img-tx/header_default.png',NULL,NULL,NULL,'前端讲师',NULL,NULL,NULL,'曾在多家软件企业担任系统架构师、技术负责人。\\n2014年在大唐高鸿某事业部担任技术总监，主导“敲敲运营平台”的开发。\\n精通dubbo 、spring cloud等分布式架构技术以及vue.js等前端框架。','/img-tx/01f4090c638d407ebcbf2c3c60615f82.jpg',3,0,'2022-09-29 21:38:56','2022-11-08 15:50:47',1,1,0),(1628197514417012738,2,'小王',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:35','2023-02-22 08:59:35',NULL,0,0),(1628197514995826689,2,'小丽',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 08:59:41',NULL,0,0),(1628197515331371010,2,'小李',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 08:59:52',NULL,0,0),(1628197515645943809,2,'小孙',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 08:59:59',NULL,0,0),(1628197515960516610,2,'小张',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:00:09',NULL,0,0),(1628197516270895106,2,'紫悦',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:04:09',NULL,0,0),(1628197516577079298,2,'醒目露露',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:03:41',NULL,0,0),(1628197516895846402,2,'珍奇',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:03:31',NULL,0,0),(1628197517206224897,2,'云宝',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:03:22',NULL,0,0),(1628197517529186306,2,'小美',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:01:11',NULL,0,0),(1628197517835370497,2,'小帅',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:01:19',NULL,0,0),(1628197518124777473,2,'甜心宝宝',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:01:41',NULL,0,0),(1628197518439350274,2,'闪亮盔甲',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:01:56',NULL,0,0),(1628197518737145858,2,'余晖烁烁',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:02:10',NULL,0,0),(1628197519030747137,2,'苹果丽丽',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:36','2023-02-22 09:02:43',NULL,0,0),(1628197519345319938,2,'碧琪',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:37','2023-02-22 09:03:00',NULL,0,0),(1628197519685058561,2,'穗龙',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:37','2023-02-22 09:04:31',NULL,0,0),(1628197519970271234,2,'暗影之月',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:37','2023-02-22 09:04:49',NULL,0,0),(1628197520280649730,2,'月亮公主',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,0,'2023-02-22 08:58:37','2023-02-22 09:04:43',NULL,0,0),(1630092739039825922,1,'老墨',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,0,'2023-02-27 14:29:29','2023-02-27 14:29:29',1,1,0);
/*!40000 ALTER TABLE `user_detail` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-21  1:24:04

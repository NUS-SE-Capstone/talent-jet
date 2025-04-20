-- MySQL dump 10.13  Distrib 8.0.41, for macos15.2 (arm64)
--
-- Host: 127.0.0.1    Database: nacos
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
-- Table structure for table `config_info`
--

DROP TABLE IF EXISTS `config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `c_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `c_use` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `effect` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `c_schema` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfo_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='config_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info`
--

LOCK TABLES `config_info` WRITE;
/*!40000 ALTER TABLE `config_info` DISABLE KEYS */;
INSERT INTO `config_info` (`id`, `data_id`, `group_id`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `app_name`, `tenant_id`, `c_desc`, `c_use`, `effect`, `type`, `c_schema`, `encrypted_data_key`) VALUES (1,'seataServer.properties','DEFAULT_GROUP','# 数据存储方式，db代表数据库\nstore.mode=db\nstore.db.datasource=druid\nstore.db.dbType=mysql\nstore.db.driverClassName=com.mysql.cj.jdbc.Driver\nstore.db.url=jdbc:mysql://mysql:3306/seata?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai&rewriteBatchedStatements=true\nstore.db.user=root\nstore.db.password=123\nstore.db.minConn=5\nstore.db.maxConn=30\nstore.db.globalTable=global_table\nstore.db.branchTable=branch_table\nstore.db.queryLimit=100\nstore.db.lockTable=lock_table\nstore.db.maxWait=5000\n# 事务、日志等配置\nserver.recovery.committingRetryPeriod=1000\nserver.recovery.asynCommittingRetryPeriod=1000\nserver.recovery.rollbackingRetryPeriod=1000\nserver.recovery.timeoutRetryPeriod=1000\nserver.maxCommitRetryTimeout=-1\nserver.maxRollbackRetryTimeout=-1\nserver.rollbackRetryTimeoutUnlockEnable=false\nserver.undo.logSaveDays=7\nserver.undo.logDeletePeriod=86400000\n\n# 客户端与服务端传输方式\ntransport.serialization=seata\ntransport.compressor=none\n# 关闭metrics功能，提高性能\nmetrics.enabled=false\nmetrics.registryType=compact\nmetrics.exporterList=prometheus\nmetrics.exporterPrometheusPort=9898','90bf27416b67bd3ed4d525a806bc60d6','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'properties',NULL,''),(2,'shared-mybatis.yaml','DEFAULT_GROUP','mybatis-plus:\n  configuration:\n    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler\n  global-config:\n    field-strategy: 0\n    db-config:\n      logic-delete-field: deleted\n      id-type: assign_id\nspring:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://${tj.jdbc.host}:${tj.jdbc.port}/${tj.jdbc.database}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: ${tj.jdbc.username}\n    password: ${tj.jdbc.password}','5d6f3a6f635f9f199d98ba54511b2dbc','2023-04-13 05:55:18','2025-04-20 09:20:41','nacos','192.168.65.1','','','','','','yaml','',''),(3,'shared-mq.yaml','DEFAULT_GROUP','spring:\n  rabbitmq:\n    host: ${tj.mq.host:192.168.150.101}\n    port: ${tj.mq.port:5672}\n    virtual-host: ${tj.mq.vhost:/tjxt}\n    username: ${tj.mq.username:tjxt}\n    password: ${tj.mq.password:123321}\n    listener:\n      simple:\n        retry:\n          enabled: ${tj.mq.listener.retry.enable:true} # 开启消费者失败重试\n          initial-interval: ${tj.mq.listener.retry.interval:1000ms} # 初始的失败等待时长为1秒\n          multiplier: ${tj.mq.listener.retry.multiplier:2} # 失败的等待时长倍数，下次等待时长 = multiplier * last-interval\n          max-attempts: ${tj.mq.listener.retry.max-attempts:3} # 最大重试次数\n          stateless: ${tj.mq.listener.retry.stateless:true} # true无状态；false有状态。如果业务中包含事务，这里改为false','0f9a19bbcec3c267eee1140911e1177a','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(4,'shared-redis.yaml','DEFAULT_GROUP','spring:\n  redis:\n    host: ${tj.redis.host}\n    password: ${tj.redis.password}\n    lettuce:\n      pool:\n        max-active: ${tj.redis.pool.max-active:8}\n        max-idle: ${tj.redis.pool.max-idle:8}\n        min-idle: ${tj.redis.pool.min-idle:1}\n        max-wait: ${tj.redis.pool.max-wait:300}','2f24e37bbdae3a3e52e1003c0ffeabbc','2023-04-13 05:55:18','2025-04-20 10:04:01','nacos','192.168.65.1','','','','','','yaml','',''),(5,'shared-spring.yaml','DEFAULT_GROUP','spring:\n  jackson:\n    default-property-inclusion: non_null\n  main:\n    allow-bean-definition-overriding: true\n  mvc:\n    pathmatch:\n      #解决异常：swagger Failed to start bean \'documentationPluginsBootstrapper\'; nested exception is java.lang.NullPointerException\n      #因为Springfox使用的路径匹配是基于AntPathMatcher的，而Spring Boot 2.6.X使用的是PathPatternMatcher\n      matching-strategy: ant_path_matcher','3f6050d899e7ed450711c1d1c202c747','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(6,'shared-logs.yaml','DEFAULT_GROUP','logging:\r\n  pattern:\r\n    dateformat: HH:mm:ss.SSS\r\n    console: \"%clr(%d{${LOG_DATEFORMAT_PATTERN}}){faint}-[${hostname}][%X{requestId:-sys}] %clr(${LOG_LEVEL_PATTERN:-%5p}) %clr(${PID:- }){magenta} %clr(---){faint} %clr([%15.15t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n\"\r\n    file: \"%d{${LOG_DATEFORMAT_PATTERN}}-[${hostname}][%X{requestId:-sys}]-${LOG_LEVEL_PATTERN:-%5p} ${PID:- } --- [%15.15t] %-40.40logger{39} : %m%n\"\r\n  file:\r\n    path: \"logs/${spring.application.name}\"','4b426a16f3e7b1b175705c365be50e9b','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(7,'shared-feign.yaml','DEFAULT_GROUP','feign:\n  client:\n    config:\n      default: # default全局的配置\n        loggerLevel: BASIC # 日志级别，BASIC就是基本的请求和响应信息\n  httpclient:\n    enabled: true # 开启feign对HttpClient的支持\n    max-connections: 200 # 最大的连接数\n    max-connections-per-route: 50 # 每个路径的最大连接数\n  sentinel:\n    enabled: true\n','acd2cb9f89d8abf074eb32ed4b707755','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(8,'shared-xxljob.yaml','DEFAULT_GROUP','tj:\r\n  xxl-job:\r\n    access-token: tianji\r\n    admin:\r\n      address: http://192.168.150.101:8880/xxl-job-admin\r\n    executor:\r\n      appname: ${spring.application.name}\r\n      log-retention-days: 10\r\n      logPath: job/${spring.application.name}','e53871c104d2dcdca565645a2a338d8b','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(9,'search-service.yaml','DEFAULT_GROUP','tj:\r\n  interests:\r\n    topNumber: 4 # 首页课程推荐的最大数量','b94cf80690ac12567611aa247e86eb71','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(10,'gateway-service.yaml','DEFAULT_GROUP','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\n  redis:\n    # host: 127.0.0.1 本地\n    host: host.docker.internal\n    password: 123456','8094aa4bd9e8bdd67e35cf29cbc34dea','2023-04-13 05:55:18','2025-04-20 12:09:40','nacos','192.168.65.1','','','','','','yaml','',''),(11,'course-service.yaml','DEFAULT_GROUP','course:\r\n  media:\r\n    trailer-duration: 3 #单位分钟','7bca242a8dba5272e1f3ab1c5cdd740b','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(12,'trade-service.yaml','DEFAULT_GROUP','tj:\n  carts:\n    maxCourseAmount: 9','30934042971b3fd8db12a64b920d2d26','2023-04-13 05:55:18','2023-04-13 05:56:39','nacos','172.17.0.1','','','','','','yaml','',''),(13,'shared-sentinel.yaml','DEFAULT_GROUP','seata:\r\n  registry: # TC服务注册中心的配置，微服务根据这些信息去注册中心获取tc服务地址\r\n    type: nacos # 注册中心类型 nacos\r\n    nacos:\r\n      server-addr: 127.0.0.1:8848 # nacos地址\r\n      namespace: \"c975b6f4-de7e-40ad-9b15-4a245ce7a2ef\" # namespace，默认为空\r\n      group: DEFAULT_GROUP # 分组，默认是DEFAULT_GROUP\r\n      application: seata-server # seata服务名称\r\n      username: nacos\r\n      password: nacos\r\n  tx-service-group: tjxt # 事务组名称\r\n  service:\r\n    vgroup-mapping: # 事务组与cluster的映射关系\r\n      tjxt: DEFAULT','a562467ae2dc1b12cfff32896350badf','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(14,'shared-seata.yaml','DEFAULT_GROUP','seata:\n  registry: # TC服务注册中心的配置，微服务根据这些信息去注册中心获取tc服务地址\n    type: nacos # 注册中心类型 nacos\n    nacos:\n      server-addr: 192.168.150.101:8848 # nacos地址\n      namespace: \"c975b6f4-de7e-40ad-9b15-4a245ce7a2ef\" # namespace，默认为空\n      group: DEFAULT_GROUP # 分组，默认是DEFAULT_GROUP\n      application: seata-server # seata服务名称\n      username: nacos\n      password: nacos\n  tx-service-group: tjxt # 事务组名称\n  service:\n    vgroup-mapping: # 事务组与cluster的映射关系\n      tjxt: \"default\"','26a4cdc57695d1d88eae16537231f9ba','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(15,'pay-service.yaml','DEFAULT_GROUP','tj:\n  pay:\n    notifyHost: https://624613b8.cpolar.cn/ps','bd0a251f6159d992c0092011d76bb923','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,''),(16,'shared-mongo.yaml','DEFAULT_GROUP','spring:\r\n  data:\r\n    mongodb:\r\n      uri: mongodb://${tj.mongo.username:tianji}:${tj.mongo.password:123}@${tj.mongo.ip:192.168.150.101}:${tj.mongo.port:27017}/${tj.mongo.database:exam}','8cd56aa01b50ddddca61dcfd64d6f25e','2023-04-13 05:55:18','2023-04-13 05:55:18',NULL,'172.17.0.1','','',NULL,NULL,NULL,'yaml',NULL,'');
/*!40000 ALTER TABLE `config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_aggr`
--

DROP TABLE IF EXISTS `config_info_aggr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_aggr` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `datum_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'datum_id',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '内容',
  `gmt_modified` datetime NOT NULL COMMENT '修改时间',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfoaggr_datagrouptenantdatum` (`data_id`,`group_id`,`tenant_id`,`datum_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='增加租户字段';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_aggr`
--

LOCK TABLES `config_info_aggr` WRITE;
/*!40000 ALTER TABLE `config_info_aggr` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_aggr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_beta`
--

DROP TABLE IF EXISTS `config_info_beta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_beta` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `beta_ips` varchar(1024) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'betaIps',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT '秘钥',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfobeta_datagrouptenant` (`data_id`,`group_id`,`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_beta';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_beta`
--

LOCK TABLES `config_info_beta` WRITE;
/*!40000 ALTER TABLE `config_info_beta` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_beta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_info_tag`
--

DROP TABLE IF EXISTS `config_info_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_info_tag` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tag_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_id',
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'content',
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'md5',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin COMMENT 'source user',
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'source ip',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_configinfotag_datagrouptenanttag` (`data_id`,`group_id`,`tenant_id`,`tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='config_info_tag';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_info_tag`
--

LOCK TABLES `config_info_tag` WRITE;
/*!40000 ALTER TABLE `config_info_tag` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_info_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_tags_relation`
--

DROP TABLE IF EXISTS `config_tags_relation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `config_tags_relation` (
  `id` bigint NOT NULL COMMENT 'id',
  `tag_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'tag_name',
  `tag_type` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tag_type',
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'data_id',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'group_id',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `nid` bigint NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`nid`) USING BTREE,
  UNIQUE KEY `uk_configtagrelation_configidtag` (`id`,`tag_name`,`tag_type`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='config_tag_relation';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_tags_relation`
--

LOCK TABLES `config_tags_relation` WRITE;
/*!40000 ALTER TABLE `config_tags_relation` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_tags_relation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_capacity`
--

DROP TABLE IF EXISTS `group_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数，，0表示使用默认值',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='集群、各Group容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_capacity`
--

LOCK TABLES `group_capacity` WRITE;
/*!40000 ALTER TABLE `group_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `his_config_info`
--

DROP TABLE IF EXISTS `his_config_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `his_config_info` (
  `id` bigint unsigned NOT NULL,
  `nid` bigint unsigned NOT NULL AUTO_INCREMENT,
  `data_id` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `group_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `app_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'app_name',
  `content` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `md5` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `src_user` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin,
  `src_ip` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `op_type` char(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT '租户字段',
  `encrypted_data_key` text COLLATE utf8mb3_bin COMMENT '秘钥',
  PRIMARY KEY (`nid`) USING BTREE,
  KEY `idx_gmt_create` (`gmt_create`) USING BTREE,
  KEY `idx_gmt_modified` (`gmt_modified`) USING BTREE,
  KEY `idx_did` (`data_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='多租户改造';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `his_config_info`
--

LOCK TABLES `his_config_info` WRITE;
/*!40000 ALTER TABLE `his_config_info` DISABLE KEYS */;
INSERT INTO `his_config_info` (`id`, `nid`, `data_id`, `group_id`, `app_name`, `content`, `md5`, `gmt_create`, `gmt_modified`, `src_user`, `src_ip`, `op_type`, `tenant_id`, `encrypted_data_key`) VALUES (2,18,'shared-mybatis.yaml','DEFAULT_GROUP','','mybatis-plus:\r\n  configuration:\r\n    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler\r\n  global-config:\r\n    field-strategy: 0\r\n    db-config:\r\n      logic-delete-field: deleted\r\n      id-type: assign_id\r\nspring:\r\n  datasource:\r\n    driver-class-name: com.mysql.cj.jdbc.Driver\r\n    url: jdbc:mysql://${tj.jdbc.host:192.168.150.101}:${tj.jdbc.port:3306}/${tj.jdbc.database}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\r\n    username: ${tj.jdbc.username:root}\r\n    password: ${tj.jdbc.password:123}','4b1ab0646c41bea2fc1cd2311257ea46','2025-04-13 22:43:44','2025-04-13 14:43:44','nacos','127.0.0.1','U','',NULL),(4,19,'shared-redis.yaml','DEFAULT_GROUP','','spring:\n  redis:\n    host: ${tj.redis.host:192.168.150.101}\n    password: ${tj.redis.password:123321}\n    lettuce:\n      pool:\n        max-active: ${tj.redis.pool.max-active:8}\n        max-idle: ${tj.redis.pool.max-idle:8}\n        min-idle: ${tj.redis.pool.min-idle:1}\n        max-wait: ${tj.redis.pool.max-wait:300}','e716bf4ae9da1cc93d83ae24f91e89b8','2025-04-13 22:44:05','2025-04-13 14:44:06','nacos','127.0.0.1','U','',NULL),(4,20,'shared-redis.yaml','DEFAULT_GROUP','','spring:\n  redis:\n    host: ${tj.redis.host:127.0.0.1}\n    password: ${tj.redis.password:}\n    lettuce:\n      pool:\n        max-active: ${tj.redis.pool.max-active:8}\n        max-idle: ${tj.redis.pool.max-idle:8}\n        min-idle: ${tj.redis.pool.min-idle:1}\n        max-wait: ${tj.redis.pool.max-wait:300}','adaa157f24ec70b981b5ea57c26c3c5f','2025-04-13 23:15:40','2025-04-13 15:15:41','nacos','127.0.0.1','U','',NULL),(2,21,'shared-mybatis.yaml','DEFAULT_GROUP','','mybatis-plus:\n  configuration:\n    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler\n  global-config:\n    field-strategy: 0\n    db-config:\n      logic-delete-field: deleted\n      id-type: assign_id\nspring:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://${tj.jdbc.host:127.0.0.1}:${tj.jdbc.port:3306}/${tj.jdbc.database}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: ${tj.jdbc.username:root}\n    password: ${tj.jdbc.password:root}','a44f55d2e1e833c4fa2577077a0515fe','2025-04-20 19:52:58','2025-04-20 06:52:58','nacos','192.168.65.1','U','',NULL),(2,22,'shared-mybatis.yaml','DEFAULT_GROUP','','mybatis-plus:\n  configuration:\n    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler\n  global-config:\n    field-strategy: 0\n    db-config:\n      logic-delete-field: deleted\n      id-type: assign_id\nspring:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://${tj.jdbc.host:host.docker.internal}:${tj.jdbc.port:3306}/${tj.jdbc.database}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: ${tj.jdbc.username:root}\n    password: ${tj.jdbc.password:root}','062d708bb7899c11027f436db4c8e832','2025-04-20 20:02:35','2025-04-20 07:02:36','nacos','192.168.65.1','U','',NULL),(2,23,'shared-mybatis.yaml','DEFAULT_GROUP','','mybatis-plus:\n  configuration:\n    default-enum-type-handler: com.baomidou.mybatisplus.core.handlers.MybatisEnumTypeHandler\n  global-config:\n    field-strategy: 0\n    db-config:\n      logic-delete-field: deleted\n      id-type: assign_id\nspring:\n  datasource:\n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://${tj.jdbc.host:127.0.0.1}:${tj.jdbc.port:3306}/${tj.jdbc.database}?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai\n    username: ${tj.jdbc.username:root}\n    password: ${tj.jdbc.password:root}','a44f55d2e1e833c4fa2577077a0515fe','2025-04-20 22:20:40','2025-04-20 09:20:41','nacos','192.168.65.1','U','',NULL),(4,24,'shared-redis.yaml','DEFAULT_GROUP','','spring:\n  redis:\n    host: ${tj.redis.host:127.0.0.1}\n    password: ${tj.redis.password:123456}\n    lettuce:\n      pool:\n        max-active: ${tj.redis.pool.max-active:8}\n        max-idle: ${tj.redis.pool.max-idle:8}\n        min-idle: ${tj.redis.pool.min-idle:1}\n        max-wait: ${tj.redis.pool.max-wait:300}','1b21b31e622ee5ef015a78cfe1193f91','2025-04-20 23:04:00','2025-04-20 10:04:01','nacos','192.168.65.1','U','',NULL),(10,25,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**','b0ba971a465dd7af34f216e47baeba05','2025-04-20 23:44:16','2025-04-20 10:44:16','nacos','192.168.65.1','U','',NULL),(10,26,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\ntj:\n  redis:\n    host: host.docker.internal\n    password: 123456','eb7c59767ef60d2b1d2a1d4f76c16412','2025-04-20 23:45:21','2025-04-20 10:45:22','nacos','192.168.65.1','U','',NULL),(10,27,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\n  redis:\n    host: host.docker.internal\n    password: 123456','f423f12009903aaf6479bb7afb1a20d6','2025-04-20 23:53:39','2025-04-20 10:53:39','nacos','192.168.65.1','U','',NULL),(10,28,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**','b0ba971a465dd7af34f216e47baeba05','2025-04-21 00:12:03','2025-04-20 11:12:04','nacos','192.168.65.1','U','',NULL),(10,29,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\n  redis:\n    host: host.docker.internal\n    password: 123456','f423f12009903aaf6479bb7afb1a20d6','2025-04-21 00:15:47','2025-04-20 11:15:47','nacos','192.168.65.1','U','',NULL),(10,30,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**','b0ba971a465dd7af34f216e47baeba05','2025-04-21 00:19:44','2025-04-20 11:19:44','nacos','192.168.65.1','U','',NULL),(10,31,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\n  redis:\n    host: host.docker.internal\n    password: 123456','f423f12009903aaf6479bb7afb1a20d6','2025-04-21 00:23:50','2025-04-20 11:23:51','nacos','192.168.65.1','U','',NULL),(10,32,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**','b0ba971a465dd7af34f216e47baeba05','2025-04-21 00:46:41','2025-04-20 11:46:41','nacos','192.168.65.1','U','',NULL),(10,33,'gateway-service.yaml','DEFAULT_GROUP','','tj.auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**','3d5982013d80802bc12c55ae11f199da','2025-04-21 01:07:34','2025-04-20 12:07:34','nacos','192.168.65.1','U','',NULL),(10,34,'gateway-service.yaml','DEFAULT_GROUP','','tj:\n  auth:\n    excludePath: # 无需登录即可访问的路径\n      - /categorys/all\n      - /courses/catas/index/list/{id}\n      - /courses/teachers/{id}\n      - /courses/catas/{id}\n      - /course/checkCoursePurchase\n      - /course/{id}\n      - /courses/portal\n      - /code\n      - /students/register\n      - /search\n      - /notify/**\n  redis:\n    host: 127.0.0.1\n    password: 123456','2b34f25647be3bd468a9c219471c9d2e','2025-04-21 01:09:39','2025-04-20 12:09:40','nacos','192.168.65.1','U','',NULL);
/*!40000 ALTER TABLE `his_config_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE KEY `uk_role_permission` (`role`,`resource`,`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  UNIQUE KEY `idx_user_role` (`username`,`role`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`username`, `role`) VALUES ('nacos','ROLE_ADMIN');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_capacity`
--

DROP TABLE IF EXISTS `tenant_capacity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_capacity` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
  `quota` int unsigned NOT NULL DEFAULT '0' COMMENT '配额，0表示使用默认值',
  `usage` int unsigned NOT NULL DEFAULT '0' COMMENT '使用量',
  `max_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
  `max_aggr_count` int unsigned NOT NULL DEFAULT '0' COMMENT '聚合子配置最大个数',
  `max_aggr_size` int unsigned NOT NULL DEFAULT '0' COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
  `max_history_count` int unsigned NOT NULL DEFAULT '0' COMMENT '最大变更历史数量',
  `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='租户容量信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_capacity`
--

LOCK TABLES `tenant_capacity` WRITE;
/*!40000 ALTER TABLE `tenant_capacity` DISABLE KEYS */;
/*!40000 ALTER TABLE `tenant_capacity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenant_info`
--

DROP TABLE IF EXISTS `tenant_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenant_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `kp` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL COMMENT 'kp',
  `tenant_id` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_id',
  `tenant_name` varchar(128) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '' COMMENT 'tenant_name',
  `tenant_desc` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'tenant_desc',
  `create_source` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL COMMENT 'create_source',
  `gmt_create` bigint NOT NULL COMMENT '创建时间',
  `gmt_modified` bigint NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_info_kptenantid` (`kp`,`tenant_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin ROW_FORMAT=DYNAMIC COMMENT='tenant_info';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenant_info`
--

LOCK TABLES `tenant_info` WRITE;
/*!40000 ALTER TABLE `tenant_info` DISABLE KEYS */;
INSERT INTO `tenant_info` (`id`, `kp`, `tenant_id`, `tenant_name`, `tenant_desc`, `create_source`, `gmt_create`, `gmt_modified`) VALUES (1,'1','f923fb34-cb0a-4c06-8fca-ad61ea61a3f0','tj-dev','开发环境','nacos',1681383294095,1744554051557),(2,'1','0b28cd9d-6c25-4aeb-8607-80a3c0361484','tj-test','测试环境','nacos',1681383303639,1744554047285);
/*!40000 ALTER TABLE `tenant_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`username`, `password`, `enabled`) VALUES ('nacos','$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-21  1:23:05

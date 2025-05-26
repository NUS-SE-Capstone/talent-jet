-- --------------------------------------------------------
-- 主机:                           192.168.150.101
-- 服务器版本:                        8.0.29 - MySQL Community Server - GPL
-- 服务器操作系统:                      Linux
-- HeidiSQL 版本:                  12.2.0.6576
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `tj_learning` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `tj_learning`;
-- 导出  表 tj_learning.learning_lesson 结构
DROP TABLE IF EXISTS `learning_lesson`;
CREATE TABLE IF NOT EXISTS `learning_lesson` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '学员id',
  `course_id` bigint NOT NULL COMMENT '课程id',
  `status` tinyint DEFAULT '0' COMMENT '课程状态，0-未学习，1-学习中，2-已学完，3-已失效',
  `week_freq` tinyint DEFAULT NULL COMMENT '每周学习频率，例如每周学习6小节，则频率为6',
  `plan_status` tinyint NOT NULL DEFAULT '0' COMMENT '学习计划状态，0-没有计划，1-计划进行中',
  `learned_sections` int NOT NULL DEFAULT '0' COMMENT '已学习小节数量',
  `latest_section_id` bigint DEFAULT NULL COMMENT '最近一次学习的小节id',
  `latest_learn_time` datetime DEFAULT NULL COMMENT '最近一次学习的时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_user_id` (`user_id`,`course_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='学生课程表';

-- 正在导出表  tj_learning.learning_lesson 的数据：~4 rows (大约)
DELETE FROM `learning_lesson`;
INSERT INTO `learning_lesson` (`id`, `user_id`, `course_id`, `status`, `week_freq`, `plan_status`, `learned_sections`, `latest_section_id`, `latest_learn_time`, `create_time`, `expire_time`, `update_time`) VALUES
	(1, 2, 2, 2, 6, 1, 12, 16, '2023-04-11 22:34:45', '2022-08-05 20:02:50', '2023-08-05 20:02:29', '2023-04-19 10:29:29'),
	(2, 2, 3, 1, 4, 1, 3, 31, '2023-04-19 11:42:50', '2022-08-06 15:16:48', '2023-08-06 15:16:37', '2023-04-19 11:42:50'),
	(1585170299127607297, 129, 2, 0, NULL, 0, 0, 16, '2023-04-11 22:37:05', '2022-12-05 23:00:29', '2023-10-26 15:14:54', '2023-04-11 22:37:05'),
	(1601061367207464961, 2, 1549025085494521857, 1, 3, 1, 4, 1550383240983875589, '2023-04-11 16:34:44', '2022-12-09 11:49:11', '2023-12-09 11:49:11', '2023-04-11 16:34:43');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- 导出  表 tj_learning.learning_record 结构
CREATE TABLE IF NOT EXISTS `learning_record` (
  `id` bigint NOT NULL COMMENT '学习记录的id',
  `lesson_id` bigint NOT NULL COMMENT '对应课表的id',
  `section_id` bigint NOT NULL COMMENT '对应小节的id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `moment` int DEFAULT '0' COMMENT '视频的当前观看时间点，单位秒',
  `finished` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否完成学习，默认false',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '第一次观看时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成学习的时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间（最近一次观看时间）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_update_time` (`update_time`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_lesson_id` (`lesson_id`,`section_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='学习记录表';

-- 正在导出表  tj_learning.learning_record 的数据：~14 rows (大约)
DELETE FROM `learning_record`;
INSERT INTO `learning_record` (`id`, `lesson_id`, `section_id`, `user_id`, `moment`, `finished`, `create_time`, `finish_time`, `update_time`) VALUES
	(1582555272977592322, 1, 16, 2, 239, b'1', '2022-10-19 10:12:34', '2022-10-19 10:45:55', '2022-10-19 15:50:12'),
	(1582565729037791233, 1, 17, 2, 148, b'1', '2022-10-19 10:54:07', '2022-10-19 10:57:47', '2022-10-19 15:50:05'),
	(1582572518466760706, 1, 18, 2, 14, b'1', '2022-10-19 11:21:06', '2022-10-19 14:52:50', '2022-10-27 12:05:14'),
	(1582572534866489346, 1, 19, 2, 250, b'1', '2022-10-19 11:21:10', '2022-10-19 17:53:55', '2022-10-19 17:56:01'),
	(1582572535164284930, 1, 20, 2, 135, b'1', '2022-10-19 11:21:10', '2022-10-19 17:58:09', '2022-10-27 12:07:12'),
	(1582572537429209089, 1, 21, 2, 253, b'1', '2022-10-19 11:21:10', '2022-10-19 18:02:34', '2022-10-19 18:04:54'),
	(1582674101338656770, 1, 22, 2, 257, b'1', '2022-10-19 18:04:45', '2022-10-19 18:07:15', '2022-10-19 18:09:35'),
	(1582675262523326466, 1, 23, 2, 254, b'1', '2022-10-19 18:09:22', '2022-10-19 18:11:37', '2022-10-19 18:13:57'),
	(1582676374013886465, 1, 24, 2, 250, b'1', '2022-10-19 18:13:47', '2022-10-19 18:16:02', '2022-10-20 11:36:50'),
	(1582938844335001602, 1, 25, 2, 80, b'1', '2022-10-20 11:36:44', '2022-10-20 11:38:59', '2022-10-20 11:58:00'),
	(1583012729738776577, 1, 26, 2, 262, b'1', '2022-10-20 16:30:20', '2022-10-20 16:30:21', '2022-10-20 16:38:39'),
	(1586757474101342209, 1, 27, 2, 0, b'1', '2022-10-31 00:30:37', '2022-10-31 00:30:36', '2022-10-31 00:30:37'),
	(1586757474101342309, 2, 29, 2, 10, b'0', '2022-10-31 00:30:37', NULL, '2022-10-31 00:30:37'),
	(1599780755855228929, 1585170299127607297, 16, 129, 37, b'0', '2022-12-05 23:00:29', NULL, '2022-12-05 23:01:34');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- 导出  表 tj_learning.interaction_question 结构
CREATE TABLE IF NOT EXISTS `interaction_question` (
  `id` bigint NOT NULL COMMENT '主键，互动问题的id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '互动问题的标题',
  `description` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '问题描述信息',
  `course_id` bigint NOT NULL COMMENT '所属课程id',
  `chapter_id` bigint NOT NULL COMMENT '所属课程章id',
  `section_id` bigint NOT NULL COMMENT '所属课程节id',
  `user_id` bigint NOT NULL COMMENT '提问学员id',
  `latest_answer_id` bigint DEFAULT NULL COMMENT '最新的一个回答的id',
  `answer_times` int unsigned NOT NULL DEFAULT '0' COMMENT '问题下的回答数量',
  `anonymity` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否匿名，默认false',
  `hidden` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否被隐藏，默认false',
  `status` tinyint DEFAULT '0' COMMENT '管理端问题状态：0-未查看，1-已查看',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '提问时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_course_id` (`course_id`) USING BTREE,
  KEY `section_id` (`section_id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='互动提问的问题表';

-- 正在导出表  tj_learning.interaction_question 的数据：~3 rows (大约)
DELETE FROM `interaction_question`;
INSERT INTO `interaction_question` (`id`, `title`, `description`, `course_id`, `chapter_id`, `section_id`, `user_id`, `latest_answer_id`, `answer_times`, `anonymity`, `hidden`, `status`, `create_time`, `update_time`) VALUES
	(1552212554946768897, 'redis安装的时候有问题，一直报错是怎么回事？', 'redis安装的时候有问题，总是报错是怎么回事？redis安装的时候有问题，总是报错是怎么回事？redis安装的时候有问题，总是报错是怎么回事？redis安装的时候有问题，总是报错是怎么回事？', 2, 15, 17, 5, 1548889371405492225, 0, b'1', b'0', 1, '2022-07-27 16:41:27', '2023-01-31 21:46:47'),
	(1585089140469317634, 'JDK安装后为什么没有效果？', '我按照老师的方式安装了JDK，但是控制台输入 java -version没有效果啊', 2, 15, 16, 2, 1585178277083951106, 0, b'0', b'0', 1, '2022-10-26 10:01:16', '2023-01-31 21:46:47'),
	(1585589766919852033, 'Java的IO是阻塞IO吗？', '比如IO流中的数据读写', 2, 15, 17, 2, 1588103282121805825, 0, b'0', b'0', 1, '2022-10-27 12:31:44', '2023-01-31 21:46:47');

-- 导出  表 tj_learning.interaction_reply 结构
CREATE TABLE IF NOT EXISTS `interaction_reply` (
  `id` bigint NOT NULL COMMENT '互动问题的回答id',
  `question_id` bigint NOT NULL COMMENT '互动问题问题id',
  `answer_id` bigint DEFAULT '0' COMMENT '回复的上级回答id',
  `user_id` bigint NOT NULL COMMENT '回答者id',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '回答内容',
  `target_user_id` bigint DEFAULT '0' COMMENT '回复的目标用户id',
  `target_reply_id` bigint DEFAULT '0' COMMENT '回复的目标回复id',
  `reply_times` int NOT NULL DEFAULT '0' COMMENT '评论数量',
  `liked_times` int NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `hidden` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否被隐藏，默认false',
  `anonymity` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否匿名，默认false',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_question_id` (`question_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='互动问题的回答或评论';

-- 正在导出表  tj_learning.interaction_reply 的数据：~12 rows (大约)
DELETE FROM `interaction_reply`;
INSERT INTO `interaction_reply` (`id`, `question_id`, `answer_id`, `user_id`, `content`, `target_user_id`, `target_reply_id`, `reply_times`, `liked_times`, `hidden`, `anonymity`, `create_time`, `update_time`) VALUES
	(1548889371405492225, 1552212554946768897, 0, 1548889371405492225, '是不是Redis的依赖没有安装呢？', 0, 0, 0, 0, b'0', b'0', '2022-07-27 16:44:37', '2022-07-28 10:36:08'),
	(1585177426969833473, 1585089140469317634, 0, 129, '同问啊，我也碰到这个问题了，老师，救救孩子吧', 2, 0, 0, 0, b'0', b'1', '2022-10-26 15:52:04', '2022-11-29 15:25:06'),
	(1585178277083951106, 1585089140469317634, 0, 1548889371405492225, '安装完成后有没有配置环境变量呢？', 2, 0, 2, 0, b'0', b'0', '2022-10-26 15:55:27', '2022-10-27 10:10:56'),
	(1585179315912388610, 1585089140469317634, 1585178277083951106, 2, '配置了，在Path中配置了JAVA_HOME', 1548889371405492225, 1585178277083951106, 0, 0, b'0', b'0', '2022-10-26 15:59:34', '2022-10-26 16:02:09'),
	(1585180460118519809, 1585089140469317634, 1585178277083951106, 1548889371405492225, '如果确定环境变量没有配置错误的话，试试看关闭CMD窗口，再次打开', 2, 1585179315912388610, 2, 0, b'0', b'0', '2022-10-26 16:04:07', '2022-10-27 10:11:18'),
	(1585183997506433026, 1585089140469317634, 1585178277083951106, 2, '老师牛啊，确实是这个问题。不过为什么要关闭呢？', 1548889371405492225, 1585178277083951106, 1, 0, b'0', b'0', '2022-10-26 16:18:10', '2022-10-27 10:27:55'),
	(1585184256685060098, 1585089140469317634, 1585178277083951106, 129, '666，老师还是厉害啊', 1548889371405492225, 1585178277083951106, 0, 0, b'0', b'1', '2022-10-26 16:19:12', '2022-11-29 15:25:09'),
	(1585184666292400129, 1585089140469317634, 1585178277083951106, 1548889371405492225, '因为CMD默认加载的还是你配置Path之前的环境变量，关闭重新打开后才会读取到最新的Path', 2, 1585183997506433026, 1, 0, b'0', b'0', '2022-10-26 16:20:50', '2022-10-27 10:26:50'),
	(1585191151894343681, 1585089140469317634, 1585178277083951106, 2, '你个老6，为什么老匿名', 129, 1585184256685060098, 0, 0, b'0', b'0', '2022-10-26 16:46:36', '2022-11-29 15:25:13'),
	(1588103282121805825, 1585589766919852033, 0, 1, '阻塞IO和非阻塞IO都有。java.io包下的都是阻塞IO，java.nio下的是非阻塞IO', 0, 0, 0, 0, b'0', b'0', '2022-11-03 16:35:32', '2022-11-03 18:13:24'),
	(1588105119793188865, 1585589766919852033, 1588103282121805825, 2, '感谢老师的回复，我们课堂中没有讲过NIO，有没有资料啊', 0, 0, 0, 0, b'0', b'0', '2022-11-03 16:43:27', '2022-11-03 18:13:24'),
	(1588110148121956353, 1585589766919852033, 1588103282121805825, 1, 'NIO资料可以联系客服MM获取哦', 2, 1588105119793188865, 0, 0, b'0', b'0', '2022-11-03 17:05:06', '2022-11-03 18:13:24');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- 导出  表 tj_learning.points_board 结构
CREATE TABLE IF NOT EXISTS `points_board` (
  `id` bigint NOT NULL COMMENT '榜单id',
  `user_id` bigint NOT NULL COMMENT '学生id',
  `points` int NOT NULL COMMENT '积分值',
  `rank` tinyint NOT NULL COMMENT '名次，只记录赛季前100',
  `season` smallint NOT NULL COMMENT '赛季，例如 1,就是第一赛季，2-就是第二赛季',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_season_user` (`season`,`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='学霸天梯榜';

-- 正在导出表  tj_learning.points_board 的数据：~0 rows (大约)
DELETE FROM `points_board`;

-- 导出  表 tj_learning.points_board_season 结构
CREATE TABLE IF NOT EXISTS `points_board_season` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '自增长id，season标示',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '赛季名称，例如：第1赛季',
  `begin_time` date NOT NULL COMMENT '赛季开始时间',
  `end_time` date NOT NULL COMMENT '赛季结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

-- 正在导出表  tj_learning.points_board_season 的数据：~12 rows (大约)
DELETE FROM `points_board_season`;
INSERT INTO `points_board_season` (`id`, `name`, `begin_time`, `end_time`) VALUES
	(1, '第1赛季', '2022-10-01', '2022-10-31'),
	(2, '第2赛季', '2022-11-01', '2022-11-30'),
	(3, '第3赛季', '2022-12-01', '2022-12-31'),
	(4, '第4赛季', '2023-01-01', '2023-01-31'),
	(5, '第5赛季', '2023-02-01', '2023-02-28'),
	(6, '第6赛季', '2023-03-01', '2023-03-31'),
	(7, '第7赛季', '2023-04-01', '2023-04-30'),
	(8, '第8赛季', '2023-05-01', '2023-05-31'),
	(9, '第9赛季', '2023-06-01', '2023-06-30'),
	(10, '第10赛季', '2023-07-01', '2023-07-31'),
	(11, '第11赛季', '2023-08-01', '2023-08-31'),
	(12, '第12赛季', '2023-09-01', '2023-09-30');

-- 导出  表 tj_learning.points_record 结构
CREATE TABLE IF NOT EXISTS `points_record` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '积分记录表id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `type` tinyint NOT NULL COMMENT '积分方式：1-课程学习，2-每日签到，3-课程问答， 4-课程笔记，5-课程评价',
  `points` tinyint NOT NULL COMMENT '积分值',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`,`type`) USING BTREE,
  KEY `idx_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='学习积分记录，每个月底清零';

-- 正在导出表  tj_learning.points_record 的数据：~0 rows (大约)
DELETE FROM `points_record`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

CREATE TABLE `note` (
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '笔记ID',
    `user_id` BIGINT UNSIGNED NOT NULL COMMENT '笔记所属用户ID',
    `author_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '原始作者ID（用于引用他人笔记）',
    `course_id` BIGINT UNSIGNED NOT NULL COMMENT '课程ID',
    `chapter_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '章节ID',
    `section_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '小节ID',
    `note_moment` INT UNSIGNED NOT NULL COMMENT '笔记时间点（单位：秒）',
    `content` TEXT NOT NULL COMMENT '笔记内容',
    `is_private` BOOLEAN DEFAULT 0 COMMENT '是否私密（0：公开，1：私密）',
    `hidden` BOOLEAN DEFAULT 0 COMMENT '是否隐藏（后台屏蔽，0：否，1：是）',
    `hidden_reason` VARCHAR(255) DEFAULT NULL COMMENT '隐藏原因',
    `gathered_note_id` BIGINT UNSIGNED DEFAULT NULL COMMENT '引用的笔记ID（用于笔记聚合）',
    `is_gathered` BOOLEAN DEFAULT 0 COMMENT '是否是聚合笔记（0：否，1：是）',
    `create_time` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='学习笔记表';
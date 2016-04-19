/*
Navicat MySQL Data Transfer

Source Server         : sdb
Source Server Version : 50628
Source Host           : 192.168.40.131:3306
Source Database       : sdb

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2016-04-18 16:06:43
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for mdb_likes
-- ----------------------------
DROP TABLE IF EXISTS `mdb_likes`;
CREATE TABLE `mdb_likes` (
  `wish_id` int(11) NOT NULL,
  `like_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `wish_like` int(11) DEFAULT '0',
  PRIMARY KEY (`like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of mdb_likes
-- ----------------------------
INSERT INTO `mdb_likes` VALUES ('20', '1', '15', '1');
INSERT INTO `mdb_likes` VALUES ('21', '2', '15', '1');
INSERT INTO `mdb_likes` VALUES ('23', '3', '15', '0');

-- ----------------------------
-- Table structure for mdb_user
-- ----------------------------
DROP TABLE IF EXISTS `mdb_user`;
CREATE TABLE `mdb_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `user_username` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `user_password` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of mdb_user
-- ----------------------------
INSERT INTO `mdb_user` VALUES ('15', 'sunon', 'sunon@sunon.com', 'pbkdf2:sha1:1000$sCjKUCmz$fd1904302ef01406e3505061f6e6bca8488b3e88');

-- ----------------------------
-- Table structure for mdb_wish
-- ----------------------------
DROP TABLE IF EXISTS `mdb_wish`;
CREATE TABLE `mdb_wish` (
  `wish_id` int(11) NOT NULL AUTO_INCREMENT,
  `wish_title` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `wish_description` varchar(5000) CHARACTER SET utf8 DEFAULT NULL,
  `wish_user_id` int(11) DEFAULT NULL,
  `wish_date` datetime DEFAULT NULL,
  `wish_file_path` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `wish_accomplished` int(11) DEFAULT '0',
  `wish_private` int(11) DEFAULT NULL,
  PRIMARY KEY (`wish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of mdb_wish
-- ----------------------------
INSERT INTO `mdb_wish` VALUES ('4', 'hello', 'hello world~', '15', '2016-02-23 01:33:49', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('12', 'world', 'world', '15', '2016-02-24 00:02:55', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('13', 'aliya', 'aliya', '15', '2016-02-24 00:03:08', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('14', '你好', '世界', '15', '2016-02-24 19:21:17', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('15', 'nihaoma ', '1234567', '15', '2016-02-24 19:21:35', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('16', 'nihao', 'flower', '15', '2016-02-24 19:40:20', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('17', 'nihao ', 'i love you', '15', '2016-02-24 19:47:37', null, '0', '0');
INSERT INTO `mdb_wish` VALUES ('20', 'night', 'good night.yes', '15', '2016-02-24 20:22:18', 'static/Uploads/fb606bca-953a-42bc-b4f6-673fb687d51f.jpg', '0', '0');
INSERT INTO `mdb_wish` VALUES ('21', 'aaa', 'aaaa', '15', '2016-02-24 20:42:48', 'static/Uploads/56adf4ea-16dc-42c0-9d98-0e24fa7da190.jpg', '0', '0');
INSERT INTO `mdb_wish` VALUES ('23', '迪士尼', '主题乐园', '15', '2016-02-25 13:21:37', '', '0', '0');

-- ----------------------------
-- Table structure for per_tag
-- ----------------------------
DROP TABLE IF EXISTS `per_tag`;
CREATE TABLE `per_tag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of per_tag
-- ----------------------------
INSERT INTO `per_tag` VALUES ('1', '很高');
INSERT INTO `per_tag` VALUES ('2', '很瘦');
INSERT INTO `per_tag` VALUES ('3', '很高');
INSERT INTO `per_tag` VALUES ('4', '很胖');

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `post` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('1', '杨过', '22', '739367ed-29f4-4a3e-a33a-ee4cea557fda.jpg');
INSERT INTO `person` VALUES ('2', '令狐冲', '23', '739367ed-29f4-4a3e-a33a-ee4cea557fda.jpg');
INSERT INTO `person` VALUES ('3', '小龙女', '22', '739367ed-29f4-4a3e-a33a-ee4cea557fda.jpg');
INSERT INTO `person` VALUES ('4', '任盈盈', '21', '739367ed-29f4-4a3e-a33a-ee4cea557fda.jpg');
INSERT INTO `person` VALUES ('5', '乔峰', '30', '739367ed-29f4-4a3e-a33a-ee4cea557fda.jpg');

-- ----------------------------
-- Table structure for person_tag
-- ----------------------------
DROP TABLE IF EXISTS `person_tag`;
CREATE TABLE `person_tag` (
  `pid` int(11) unsigned DEFAULT NULL,
  `tag_id` int(11) unsigned DEFAULT NULL,
  KEY `tag_fk` (`tag_id`),
  KEY `person_fk` (`pid`),
  CONSTRAINT `person_fk` FOREIGN KEY (`pid`) REFERENCES `person` (`pid`),
  CONSTRAINT `tag_fk` FOREIGN KEY (`tag_id`) REFERENCES `per_tag` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of person_tag
-- ----------------------------
INSERT INTO `person_tag` VALUES ('1', '2');

-- ----------------------------
-- Table structure for work_per
-- ----------------------------
DROP TABLE IF EXISTS `work_per`;
CREATE TABLE `work_per` (
  `wpid` int(11) NOT NULL AUTO_INCREMENT,
  `wid` int(11) unsigned DEFAULT NULL,
  `pid` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`wpid`),
  KEY `wp_f1` (`wid`),
  KEY `wp_f2` (`pid`),
  CONSTRAINT `wp_f1` FOREIGN KEY (`wid`) REFERENCES `works` (`wid`),
  CONSTRAINT `wp_f2` FOREIGN KEY (`pid`) REFERENCES `person` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of work_per
-- ----------------------------
INSERT INTO `work_per` VALUES ('1', '1', '2');
INSERT INTO `work_per` VALUES ('2', '1', '4');
INSERT INTO `work_per` VALUES ('3', '3', '1');
INSERT INTO `work_per` VALUES ('4', '3', '3');

-- ----------------------------
-- Table structure for work_tag
-- ----------------------------
DROP TABLE IF EXISTS `work_tag`;
CREATE TABLE `work_tag` (
  `wtid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `wid` int(11) unsigned DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`wtid`),
  KEY `wt_f1` (`wid`),
  CONSTRAINT `wt_f1` FOREIGN KEY (`wid`) REFERENCES `works` (`wid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of work_tag
-- ----------------------------
INSERT INTO `work_tag` VALUES ('1', '1', '1', '黑木崖', '地点');
INSERT INTO `work_tag` VALUES ('2', '3', '2', '桃花岛', '地点');

-- ----------------------------
-- Table structure for works
-- ----------------------------
DROP TABLE IF EXISTS `works`;
CREATE TABLE `works` (
  `wid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`wid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of works
-- ----------------------------
INSERT INTO `works` VALUES ('1', '笑傲江湖');
INSERT INTO `works` VALUES ('2', '雪山飞狐');
INSERT INTO `works` VALUES ('3', '神雕侠侣');

-- ----------------------------
-- Procedure structure for sp_AddUpdateLikes
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_AddUpdateLikes`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_AddUpdateLikes`(`p_wish_id` int,`p_user_id` int,`p_like` int)
BEGIN
	#Routine body goes here...
    if (select exists (select 1 from mdb_likes where wish_id = p_wish_id and user_id = p_user_id)) then
 
       select wish_like into @currentVal from mdb_likes where wish_id = p_wish_id and user_id = p_user_id;
         
        if @currentVal = 0 then
            update mdb_likes set wish_like = 1 where wish_id = p_wish_id and user_id = p_user_id;
        else
            update mdb_likes set wish_like = 0 where wish_id = p_wish_id and user_id = p_user_id;
        end if;
    else
         
        insert into mdb_likes(
            wish_id,
            user_id,
            wish_like
        )
        values(
            p_wish_id,
            p_user_id,
            p_like
        );
 
    end if;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_addWish
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_addWish`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_addWish`(IN `p_title` varchar(45),IN `p_description` varchar(1000),IN `p_user_id` bigint,IN `p_file_path` varchar(200), IN `p_is_private` int, IN `p_is_done` int)
BEGIN
	#Routine body goes here...
    insert into mdb_wish(
        wish_title,
        wish_description,
        wish_user_id,
        wish_date,
        wish_file_path,
        wish_private,
        wish_accomplished
    )
    values
    (
        p_title,
        p_description,
        p_user_id,
        NOW(),
        p_file_path,
        p_is_private,
        p_is_done
    );
    SET @last_id = LAST_INSERT_ID();
    insert into mdb_likes(
        wish_id,
        user_id,
        wish_like
    )
    values(
        @last_id,
        p_user_id,
        0
    );
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_createUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_createUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_createUser`(IN `p_name` varchar(20),IN `p_username` varchar(20),IN `p_password` varchar(100))
BEGIN
    IF ( select exists (select 1 from mdb_user where user_username = p_username) ) THEN
     
        select 'Username Exists !!';
     
    ELSE
     
        insert into mdb_user
        (
            user_name,
            user_username,
            user_password
        )
        values
        (
            p_name,
            p_username,
            p_password
        );
     
    END IF;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_deleteWish
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_deleteWish`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_deleteWish`(IN `p_wish_id` bigint,IN `p_user_id` bigint)
BEGIN
	#Routine body goes here...
delete from mdb_wish where wish_id = p_wish_id and wish_user_id = p_user_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_GetAllWishes
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetAllWishes`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetAllWishes`()
BEGIN
	#Routine body goes here...
select wish_id,wish_title,wish_description,wish_file_path,getSum(wish_id)
    from mdb_wish where wish_private = 0;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_getLikeStatus
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_getLikeStatus`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_getLikeStatus`(IN `p_wish_id` int,IN `p_user_id` int)
BEGIN
	#Routine body goes here...
	select getSum(p_wish_id),hasLiked(p_wish_id,p_user_id);
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_GetWishById
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetWishById`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetWishById`(IN `p_wish_id` bigint,IN `p_user_id` bigint)
BEGIN
	#Routine body goes here...
select wish_id
			,wish_title
			,wish_description
			,wish_file_path
			,wish_private
			,wish_accomplished 
 from mdb_wish where wish_id = p_wish_id and wish_user_id = p_user_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_GetWishByUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_GetWishByUser`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_GetWishByUser`(IN `p_user_id` bigint,IN `p_limit` int,IN `p_offset` int,OUT `p_total` bigint)
BEGIN
	#Routine body goes here...
    select count(*) into p_total from mdb_wish where wish_user_id = p_user_id;
 
    SET @t1 = CONCAT( 'select * from mdb_wish where wish_user_id = ', p_user_id, ' order by wish_date desc limit ',p_limit,' offset ',p_offset);
    PREPARE stmt FROM @t1;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_updateWish
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_updateWish`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_updateWish`(IN `p_title` varchar(45),IN `p_description` varchar(1000),IN `p_wish_id` bigint,IN `p_user_id` bigint,IN `p_file_path` varchar(200), IN `p_is_private` int, IN `p_is_done` int)
BEGIN
	#Routine body goes here...
update mdb_wish set
    wish_title = p_title,
    wish_description = p_description,
    wish_file_path = p_file_path,
    wish_private = p_is_private,
    wish_accomplished = p_is_done
    where wish_id = p_wish_id and wish_user_id = p_user_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sp_validateLogin
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_validateLogin`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `sp_validateLogin`(IN `p_username` varchar(20))
BEGIN
	#Routine body goes here...
    select * from mdb_user where user_username = p_username;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for getSum
-- ----------------------------
DROP FUNCTION IF EXISTS `getSum`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `getSum`(`p_wish_id` int) RETURNS int(11)
BEGIN
	#Routine body goes here...
select sum(wish_like) into @sm from mdb_likes where wish_id = p_wish_id;
	RETURN @sm;
END
;;
DELIMITER ;

-- ----------------------------
-- Function structure for hasLiked
-- ----------------------------
DROP FUNCTION IF EXISTS `hasLiked`;
DELIMITER ;;
CREATE DEFINER=`root`@`%` FUNCTION `hasLiked`(`p_wish` int,`p_user` int) RETURNS int(11)
BEGIN
	#Routine body goes here...
select wish_like into @myval from mdb_likes where wish_id =  p_wish and user_id = p_user;
RETURN @myval;
END
;;
DELIMITER ;

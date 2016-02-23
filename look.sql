/*
Navicat MySQL Data Transfer

Source Server         : sdb
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : look

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-02-16 08:38:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for person
-- ----------------------------
DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
  `pid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of person
-- ----------------------------
INSERT INTO `person` VALUES ('1', '杨过', '22');
INSERT INTO `person` VALUES ('2', '令狐冲', '23');
INSERT INTO `person` VALUES ('3', '小龙女', '22');
INSERT INTO `person` VALUES ('4', '任盈盈', '21');

-- ----------------------------
-- Table structure for per_tag
-- ----------------------------
DROP TABLE IF EXISTS `per_tag`;
CREATE TABLE `per_tag` (
  `ptid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(11) unsigned DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ptid`),
  KEY `pp` (`pid`),
  CONSTRAINT `pp` FOREIGN KEY (`pid`) REFERENCES `person` (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of per_tag
-- ----------------------------
INSERT INTO `per_tag` VALUES ('1', '1', '1', '很高', '体征');
INSERT INTO `per_tag` VALUES ('2', '1', '2', '很瘦', '体征');
INSERT INTO `per_tag` VALUES ('3', '2', '1', '很高', '体征');
INSERT INTO `per_tag` VALUES ('4', '2', '3', '很胖', '体征');

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

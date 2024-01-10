/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80031 (8.0.31)
 Source Host           : localhost:3306
 Source Schema         : property_management

 Target Server Type    : MySQL
 Target Server Version : 80031 (8.0.31)
 File Encoding         : 65001

 Date: 10/01/2024 17:44:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_token
-- ----------------------------
DROP TABLE IF EXISTS `admin_token`;
CREATE TABLE `admin_token`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `deadline` bigint NOT NULL,
  `admin_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_token
-- ----------------------------
INSERT INTO `admin_token` VALUES (8, '1536316910276tokenddd', 1536921710276, 1);
INSERT INTO `admin_token` VALUES (9, '1536906504242tokenddd', 1537511304242, 1);
INSERT INTO `admin_token` VALUES (10, '1539516058550tokenddd', 1540120858550, 1);
INSERT INTO `admin_token` VALUES (11, '1539828735258tokenddd', 1540433535258, 1);
INSERT INTO `admin_token` VALUES (12, '1539830468911tokenddd', 1540435268911, 1);
INSERT INTO `admin_token` VALUES (13, '1539848186595tokenddd', 1540452986595, 1);
INSERT INTO `admin_token` VALUES (14, '1539928514804tokenddd', 1540533314804, 1);
INSERT INTO `admin_token` VALUES (15, '1540173569587tokenddd', 1540778369587, 1);
INSERT INTO `admin_token` VALUES (16, '1540187477990tokenddd', 1540792277990, 1);
INSERT INTO `admin_token` VALUES (17, '1540199683277tokenddd', 1540804483277, 1);
INSERT INTO `admin_token` VALUES (18, '1540207431365tokenddd', 1540812231365, 1);
INSERT INTO `admin_token` VALUES (19, '1540275631730tokenddd', 1540880431730, 1);
INSERT INTO `admin_token` VALUES (20, '1540354564240tokenddd', 1540959364240, 1);
INSERT INTO `admin_token` VALUES (21, '1540354783604tokenddd', 1540959583604, 1);
INSERT INTO `admin_token` VALUES (22, '1540354879940tokenddd', 1540959679940, 1);
INSERT INTO `admin_token` VALUES (23, '1540354914703tokenddd', 1540959714703, 1);
INSERT INTO `admin_token` VALUES (24, '1540354958941tokenddd', 1540959758941, 1);
INSERT INTO `admin_token` VALUES (25, '1540355038764tokenddd', 1540959838764, 1);
INSERT INTO `admin_token` VALUES (26, '1540355055538tokenddd', 1540959855538, 1);
INSERT INTO `admin_token` VALUES (27, '1540355058822tokenddd', 1540959858822, 1);
INSERT INTO `admin_token` VALUES (28, '1540361896334tokenddd', 1540966696334, 1);
INSERT INTO `admin_token` VALUES (29, '1540365499923tokentestAdmin', 1540970299924, 3);
INSERT INTO `admin_token` VALUES (30, '1540365511923tokenddd', 1540970311923, 1);
INSERT INTO `admin_token` VALUES (31, '1540365542629tokenddd', 1540970342629, 1);
INSERT INTO `admin_token` VALUES (32, '1540365558604tokenddd', 1540970358604, 1);
INSERT INTO `admin_token` VALUES (33, '1540370213589tokenddd', 1540975013589, 1);
INSERT INTO `admin_token` VALUES (34, '1540378532582tokentestAdmin', 1540983332582, 3);
INSERT INTO `admin_token` VALUES (35, '1701235762990tokenddd', 1701840562990, 1);
INSERT INTO `admin_token` VALUES (36, '1701236476262tokentestEmployee', 1701841276262, 4);
INSERT INTO `admin_token` VALUES (37, '1702879901420tokenddd', 1703484701420, 1);
INSERT INTO `admin_token` VALUES (38, '1702964627574tokenddd', 1703569427574, 1);
INSERT INTO `admin_token` VALUES (39, '1703051772155tokenddd', 1703656572155, 1);
INSERT INTO `admin_token` VALUES (40, '1703645836854tokenddd', 1704250636854, 1);
INSERT INTO `admin_token` VALUES (41, '1704865410557tokenddd', 1705470210557, 1);

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role` int NOT NULL COMMENT '1：超级管理员\r\n2：管理员',
  `isDel` int UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'ddd', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 1, 0);
INSERT INTO `admin_user` VALUES (2, 'ffffffff', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 1, 0);
INSERT INTO `admin_user` VALUES (3, 'testAdmin', '670b14728ad9902aecba32e22fa4f6bd', 2, 0);
INSERT INTO `admin_user` VALUES (4, 'testEmployee', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 2, 0);

-- ----------------------------
-- Table structure for feedback
-- ----------------------------
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` int NOT NULL,
  `create_time` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf32 COLLATE = utf32_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of feedback
-- ----------------------------
INSERT INTO `feedback` VALUES (2, 'test', 'loki', '13937678708', 1, '1703576397170');
INSERT INTO `feedback` VALUES (3, '1156test', 'Mario', '15334707626', 1, '1703649408807');
INSERT INTO `feedback` VALUES (4, '1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test1157test', 'Mario', '18835195259', 0, '1703649448143');

-- ----------------------------
-- Table structure for part
-- ----------------------------
DROP TABLE IF EXISTS `part`;
CREATE TABLE `part`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `part_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `price` float(10, 2) NOT NULL,
  `type_id` int NOT NULL,
  `isDel` int NOT NULL DEFAULT 0,
  `count` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of part
-- ----------------------------
INSERT INTO `part` VALUES (4, '3mm螺丝', 2.00, 2, 0, 0);
INSERT INTO `part` VALUES (5, '5mm螺丝', 2.00, 1, 0, 0);
INSERT INTO `part` VALUES (6, '5cm地漏', 5.00, 2, 0, 0);
INSERT INTO `part` VALUES (7, '一字改锥', 2.00, 5, 0, 949);

-- ----------------------------
-- Table structure for part_order
-- ----------------------------
DROP TABLE IF EXISTS `part_order`;
CREATE TABLE `part_order`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `repair_id` int NOT NULL,
  `part_id` int NOT NULL,
  `count` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of part_order
-- ----------------------------
INSERT INTO `part_order` VALUES (1, 2, 1, 50);
INSERT INTO `part_order` VALUES (2, 2, 3, 50);
INSERT INTO `part_order` VALUES (3, 2, 4, 50);
INSERT INTO `part_order` VALUES (4, 1, 7, 50);

-- ----------------------------
-- Table structure for part_type
-- ----------------------------
DROP TABLE IF EXISTS `part_type`;
CREATE TABLE `part_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `isDel` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of part_type
-- ----------------------------
INSERT INTO `part_type` VALUES (1, '螺丝', 0);
INSERT INTO `part_type` VALUES (2, '地漏', 0);
INSERT INTO `part_type` VALUES (3, '板子', 0);
INSERT INTO `part_type` VALUES (4, '灯泡', 0);
INSERT INTO `part_type` VALUES (5, '改锥', 0);

-- ----------------------------
-- Table structure for payment
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `pay_type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `pay_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `amount` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `pay_method` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `pay_status` int NOT NULL,
  `notes` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  `create_time` varchar(255) CHARACTER SET utf32 COLLATE utf32_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf32 COLLATE = utf32_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payment
-- ----------------------------
INSERT INTO `payment` VALUES (1, 'dianfei', '王富贵', '100', 'zhifubao', 0, '尽快缴纳！', 1, '1704878724109');
INSERT INTO `payment` VALUES (2, 'nuanqifei', '萌新', '1111', 'weixin', 0, '快快快！！！', 3, '1704878806686');

-- ----------------------------
-- Table structure for repair_list
-- ----------------------------
DROP TABLE IF EXISTS `repair_list`;
CREATE TABLE `repair_list`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `status` int NOT NULL COMMENT '0：已撤消\r\n1：已报修\r\n2：已联系\r\n3：已派修\r\n4：已维修\r\n5：已缴费',
  `photos` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `price` float(10, 2) NULL DEFAULT NULL,
  `user_id` int NOT NULL,
  `create_time` varchar(13) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `appointment_time` varchar(13) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '派修时间',
  `pay_time` varchar(13) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of repair_list
-- ----------------------------
INSERT INTO `repair_list` VALUES (1, 'title test', 5, '', NULL, 1, '1701235006000', '1701235939298', '1701267016396');
INSERT INTO `repair_list` VALUES (7, '测试', 5, NULL, 123.00, 1, '1702613745444', '1702700145285', '1702710945457');
INSERT INTO `repair_list` VALUES (8, '不知道啥玩意坏了', 3, NULL, NULL, 3, '1702876545555', '1702894545723', NULL);
INSERT INTO `repair_list` VALUES (29, '测试', 1, '[\"/img/repair153889045376411987.png\"]', 123.00, 2, '1702973745496', NULL, NULL);
INSERT INTO `repair_list` VALUES (30, '测试1', 1, '[\"/img/repair153889059018213784.png\",\"/img/repair153889059018214899.png\"]', 20.00, 1, '1702973766262', NULL, NULL);
INSERT INTO `repair_list` VALUES (31, '测试新增', 1, '[\"/img/repair153889087536812713.png\",\"/img/repair153889087536815888.png\"]', 123.00, 13, '1702973777510', NULL, NULL);
INSERT INTO `repair_list` VALUES (32, '灯泡碎了', 4, '[\"/img/repair154037665688518226.png\"]', 2.00, 1, '1702973788565', '1702973788358', NULL);
INSERT INTO `repair_list` VALUES (33, 'test1326', 4, '[\"/img/repair170123560288510612.png\"]', 1222.00, 1, '1701235610735', '1701235816000', NULL);

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `room_num` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `building` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `area` float(255, 0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, '101', '1', 50);
INSERT INTO `room` VALUES (2, '102', '1', 50);
INSERT INTO `room` VALUES (3, '201', '1', 60);
INSERT INTO `room` VALUES (4, '202', '1', 60);
INSERT INTO `room` VALUES (5, '101a', '2', 50);
INSERT INTO `room` VALUES (6, '102a', '2', 50);
INSERT INTO `room` VALUES (7, '201a', '2', 60);
INSERT INTO `room` VALUES (8, '202a', '2', 60);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `sex` int NOT NULL COMMENT '0：男\r\n1：女',
  `room_id` int NOT NULL,
  `role` int NOT NULL DEFAULT 0 COMMENT '0：未审核\r\n1：家庭成员\r\n2：业主\r\n\r\n',
  `isDel` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '0：未删\r\n1：已删\r\n',
  `tel` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 't1', '王富贵', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 1, 3, 2, 0, '15444444445');
INSERT INTO `user` VALUES (2, 't2', '张百万', '4693fbb215b8ca15a6900f0cfa164cdc', 1, 3, 1, 0, '15555555555');
INSERT INTO `user` VALUES (3, 't3', '萌新', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 1, 2, 0, '13258787777');
INSERT INTO `user` VALUES (13, 't4', '铁锤妹妹', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 1, 2, 1, 0, '13555555555');
INSERT INTO `user` VALUES (16, 't6666', '测试', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 1, 1, 0, '13333333333');
INSERT INTO `user` VALUES (20, 'carMan', 'Loki', 'e10adc3949ba59abbe56e057f20f883e', 0, 4, 1, 0, '18280594837');
INSERT INTO `user` VALUES (21, 'test1226', 'Loki', 'e86fdc2283aff4717103f2d44d0610f7', 0, 8, 0, 0, '13711008046');

-- ----------------------------
-- Table structure for user_token
-- ----------------------------
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE `user_token`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `deadline` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 152 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_token
-- ----------------------------
INSERT INTO `user_token` VALUES (112, '1538883201281tokent1', '1539488001281', 1);
INSERT INTO `user_token` VALUES (113, '1538883258070tokent1', '1539488058070', 1);
INSERT INTO `user_token` VALUES (114, '1538883399688tokent1', '1539488199688', 1);
INSERT INTO `user_token` VALUES (115, '1538883401154tokent1', '1539488201154', 1);
INSERT INTO `user_token` VALUES (116, '1538883428355tokent1', '1539488228355', 1);
INSERT INTO `user_token` VALUES (117, '1538883526046tokent1', '1539488326046', 1);
INSERT INTO `user_token` VALUES (118, '1538884558670tokent1', '1539489358670', 1);
INSERT INTO `user_token` VALUES (119, '1538885192336tokent1', '1539489992336', 1);
INSERT INTO `user_token` VALUES (120, '1538886113931tokent1', '1539490913931', 1);
INSERT INTO `user_token` VALUES (121, '1538886336066tokent1', '1539491136066', 1);
INSERT INTO `user_token` VALUES (122, '1538886339871tokent1', '1539491139871', 1);
INSERT INTO `user_token` VALUES (123, '1538886349684tokent1', '1539491149684', 1);
INSERT INTO `user_token` VALUES (124, '1538886385442tokent1', '1539491185442', 1);
INSERT INTO `user_token` VALUES (125, '1538886393897tokent1', '1539491193897', 1);
INSERT INTO `user_token` VALUES (126, '1538886396169tokent1', '1539491196169', 1);
INSERT INTO `user_token` VALUES (127, '1538886624235tokent1', '1539491424235', 1);
INSERT INTO `user_token` VALUES (128, '1538887431918tokent1', '1539492231918', 1);
INSERT INTO `user_token` VALUES (129, '1538887524435tokent1', '1539492324435', 1);
INSERT INTO `user_token` VALUES (130, '1538887613813tokent1', '1539492413813', 1);
INSERT INTO `user_token` VALUES (131, '1538888636248tokent1', '1539493436248', 1);
INSERT INTO `user_token` VALUES (132, '1538890825270tokent1', '1539495625270', 1);
INSERT INTO `user_token` VALUES (133, '1538891192223tokent6666', '1539495992223', 16);
INSERT INTO `user_token` VALUES (134, '1538891224945tokent6666', '1539496024945', 16);
INSERT INTO `user_token` VALUES (135, '1538891301430tokent6666', '1539496101430', 16);
INSERT INTO `user_token` VALUES (136, '1538891310184tokent1', '1539496110184', 1);
INSERT INTO `user_token` VALUES (137, '1538891321427tokent6666', '1539496121427', 16);
INSERT INTO `user_token` VALUES (138, '1539501785236tokent1', '1540106585236', 1);
INSERT INTO `user_token` VALUES (139, '1540374109855tokent1', '1540978909855', 1);
INSERT INTO `user_token` VALUES (140, '1701235569918tokent1', '1701840369918', 1);
INSERT INTO `user_token` VALUES (141, '1702879881348tokent1', '1703484681348', 1);
INSERT INTO `user_token` VALUES (142, '1703060546417tokencarMan', '1703665346417', 20);
INSERT INTO `user_token` VALUES (143, '1703061180338tokent1', '1703665980338', 1);
INSERT INTO `user_token` VALUES (144, '1703560454511tokent1', '1704165254511', 1);
INSERT INTO `user_token` VALUES (145, '1703567980816tokent1', '1704172780816', 1);
INSERT INTO `user_token` VALUES (146, '1703569191936tokent1', '1704173991936', 1);
INSERT INTO `user_token` VALUES (147, '1703569313745tokentest1226', '1704174113745', 21);
INSERT INTO `user_token` VALUES (148, '1703569385639tokent1', '1704174185639', 1);
INSERT INTO `user_token` VALUES (149, '1703570011550tokent1', '1704174811550', 1);
INSERT INTO `user_token` VALUES (150, '1703570525861tokent1', '1704175325861', 1);
INSERT INTO `user_token` VALUES (151, '1703818853566tokent1', '1704423653566', 1);

-- ----------------------------
-- Table structure for vehicle
-- ----------------------------
DROP TABLE IF EXISTS `vehicle`;
CREATE TABLE `vehicle`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `license_number` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `brand` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `photos` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL,
  `color` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL,
  `parking` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `user_id` int NULL DEFAULT NULL,
  `create_time` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf32 COLLATE = utf32_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vehicle
-- ----------------------------
INSERT INTO `vehicle` VALUES (1, '津C 342423', 'CarMan', '[]', 'black', 'Pki 999', 1, '1702967199731');
INSERT INTO `vehicle` VALUES (2, '津D 123123', 'Tesla', '[\"/img/vehicle170381890645515528.png\",\"/img/vehicle170381890645510032.png\"]', 'blue', 'PK 12312', 1, '1703818911159');

SET FOREIGN_KEY_CHECKS = 1;

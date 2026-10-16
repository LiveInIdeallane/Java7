/*
 Navicat Premium Data Transfer

 Source Server         : java
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : db_service

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 16/10/2026 11:21:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `is_deleted` int NOT NULL DEFAULT 0 COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `customer_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户姓名',
  `customer_age` int NOT NULL COMMENT '年龄',
  `customer_sex` int NOT NULL COMMENT '性别 0：男 1：女',
  `idcard` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '身份证号',
  `room_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '房间号',
  `building_no` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属楼房',
  `checkin_date` date NOT NULL COMMENT '入住时间',
  `expiration_date` date NOT NULL COMMENT '合同到期时间',
  `contact_tel` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `bed_id` int NOT NULL COMMENT '床号',
  `psychosomatic_state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身心状况',
  `attention` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注意事项',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `height` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身高',
  `weight` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '体重',
  `blood_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '血型',
  `filepath` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像路径',
  `user_id` int NULL DEFAULT NULL COMMENT '关联健康管家(护工)，无管家设置-1',
  `level_id` int NULL DEFAULT NULL COMMENT '护理等级',
  `family_member` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '家属',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '客户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, 0, '张伟', 72, 1, '110101195203051234', '101', '1号楼', '2024-03-01', '2026-03-01', '13800001234', 1, '良好', '高血压，需按时服药', '1952-03-05', '172', '68', 'A', '', NULL, NULL, '张建国');
INSERT INTO `customer` VALUES (2, 0, '张丽', 68, 0, '110101195607125678', '102', '1号楼', '2024-05-15', '2026-05-15', '13800005678', 2, '良好', NULL, '1956-07-12', '158', '55', 'B', '', NULL, NULL, '张晓明');
INSERT INTO `customer` VALUES (3, 0, '张敏', 75, 0, '320101194911234321', '103', '1号楼', '2024-01-10', '2026-01-10', '13900001122', 3, '一般', '糖尿病', '1949-11-23', '155', '58', 'O', '', NULL, NULL, '张红星');
INSERT INTO `customer` VALUES (4, 0, '王芳', 70, 0, '320101195409186789', '104', '1号楼', '2024-06-01', '2026-06-01', '13900003344', 4, '良好', NULL, '1954-09-18', '160', '57', 'A', '', NULL, NULL, '王大军');
INSERT INTO `customer` VALUES (5, 0, '王强', 78, 1, '320101194612053217', '105', '1号楼', '2024-02-20', '2026-02-20', '15500008899', 5, '一般', '腿脚不便，需轮椅', '1946-12-05', '175', '72', 'AB', '', NULL, NULL, '王丽娟');
INSERT INTO `customer` VALUES (6, 0, '李明', 66, 1, '330101195805061129', '201', '2号楼', '2024-04-12', '2026-04-12', '15500006677', 6, '良好', NULL, '1958-05-06', '170', '65', 'O', '', NULL, NULL, '李国强');
INSERT INTO `customer` VALUES (7, 0, '李娜', 71, 0, '330101195307194456', '202', '2号楼', '2024-07-08', '2026-07-08', '18600001234', 7, '良好', '轻度听力障碍', '1953-07-19', '159', '54', 'B', '', NULL, NULL, '李伟');
INSERT INTO `customer` VALUES (8, 0, '陈静', 69, 0, '440101195505247788', '203', '2号楼', '2024-08-16', '2026-08-16', '18600005566', 8, '良好', NULL, '1955-05-24', '161', '56', 'A', '', NULL, NULL, '陈志强');
INSERT INTO `customer` VALUES (9, 0, '陈晓', 63, 1, '440101196112301357', '204', '2号楼', '2024-09-01', '2026-09-01', '18600009900', 9, '良好', NULL, '1961-12-30', '174', '70', 'O', '', NULL, NULL, '陈小花');
INSERT INTO `customer` VALUES (10, 0, '刘洋', 74, 1, '110101195004082468', '205', '2号楼', '2024-03-25', '2026-03-25', '17700001111', 10, '一般', '冠心病，随身带药', '1950-04-08', '171', '69', 'A', '', NULL, NULL, '刘海涛');
INSERT INTO `customer` VALUES (11, 0, '杨光', 77, 1, '110101194708163579', '301', '3号楼', '2024-05-05', '2026-05-05', '17700002222', 11, '良好', NULL, '1947-08-16', '176', '73', 'B', '', NULL, NULL, '杨建华');
INSERT INTO `customer` VALUES (12, 0, '赵磊', 65, 1, '320101195909014680', '302', '3号楼', '2024-06-18', '2026-06-18', '17700003333', 12, '良好', NULL, '1959-09-01', '173', '67', 'O', '', NULL, NULL, '赵春燕');
INSERT INTO `customer` VALUES (13, 0, '黄敏', 73, 0, '330101195107131234', '303', '3号楼', '2024-07-22', '2026-07-22', '13800004444', 13, '一般', '失眠，睡前需巡视', '1951-07-13', '157', '53', 'AB', '', NULL, NULL, '黄志明');
INSERT INTO `customer` VALUES (14, 0, '周涛', 79, 1, '440101194503067890', '304', '3号楼', '2024-08-30', '2026-08-30', '13800005555', 14, '良好', NULL, '1945-03-06', '177', '75', 'A', '', NULL, NULL, '周雪梅');
INSERT INTO `customer` VALUES (15, 0, '吴霞', 67, 0, '110101195706142345', '305', '3号楼', '2024-09-14', '2026-09-14', '13900006666', 15, '良好', NULL, '1957-06-14', '156', '52', 'B', '', NULL, NULL, '吴建军');
INSERT INTO `customer` VALUES (16, 0, '徐军', 76, 1, '320101194808197766', '401', '4号楼', '2024-04-02', '2026-04-02', '13900007777', 16, '一般', '帕金森前期，手抖', '1948-08-19', '174', '71', 'O', '', NULL, NULL, '徐婷');
INSERT INTO `customer` VALUES (17, 0, '孙倩', 64, 0, '330101196009203456', '402', '4号楼', '2024-05-28', '2026-05-28', '15500008888', 17, '良好', NULL, '1960-09-20', '162', '59', 'A', '', NULL, NULL, '孙立');
INSERT INTO `customer` VALUES (18, 0, '马超', 71, 1, '440101195301158899', '403', '4号楼', '2024-06-26', '2026-06-26', '15500009999', 18, '良好', NULL, '1953-01-15', '175', '68', 'AB', '', NULL, NULL, '马丽丽');
INSERT INTO `customer` VALUES (19, 0, '朱婷', 62, 0, '110101196208041122', '404', '4号楼', '2024-07-15', '2026-07-15', '18600001111', 19, '良好', '低盐饮食', '1962-08-04', '158', '56', 'B', '', NULL, NULL, '朱建华');
INSERT INTO `customer` VALUES (20, 0, '胡兵', 70, 1, '320101195407173344', '405', '4号楼', '2024-08-09', '2026-08-09', '18600002222', 20, '一般', '高血脂', '1954-07-17', '172', '74', 'O', '', NULL, NULL, '胡晓东');

SET FOREIGN_KEY_CHECKS = 1;

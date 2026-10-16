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

 Date: 16/10/2026 11:25:36
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL COMMENT '主键',
  `create_time` date NOT NULL COMMENT '创建时间',
  `create_by` int NOT NULL COMMENT '创建者',
  `update_time` date NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` int NULL DEFAULT NULL COMMENT '更新者',
  `is_deleted` int NOT NULL COMMENT '逻辑删除标记（0：显示；1：隐藏）',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '系统账号',
  `password` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `sex` int NOT NULL COMMENT '性别（0：女，1：男）',
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone_number` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电话号码',
  `role_id` int NOT NULL COMMENT '系统角色编号（1-管理员，2-健康管家）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '2025-01-10', 1, '2025-02-15', 1, 0, '张大明', 'admin01', '123456', 1, 'admin@health.com', '13500112233', 1);
INSERT INTO `user` VALUES (2, '2025-01-12', 1, NULL, NULL, 0, '李小红', 'health01', '123456', 0, 'li@health.com', '13500112244', 2);
INSERT INTO `user` VALUES (3, '2025-01-15', 1, '2025-03-01', 2, 0, '王海涛', 'health02', '654321', 1, 'wang@health.com', '13500112255', 2);
INSERT INTO `user` VALUES (4, '2025-01-18', 1, NULL, NULL, 0, '赵美玲', 'health03', '111111', 0, NULL, '13500112266', 2);
INSERT INTO `user` VALUES (5, '2025-01-20', 1, '2025-04-10', 1, 1, '陈志强', 'health04', '222222', 1, 'chen@health.com', '13500112277', 2);
INSERT INTO `user` VALUES (6, '2025-02-01', 1, NULL, NULL, 0, '刘雅静', 'health05', '333333', 0, 'liu@health.com', '13500112288', 2);
INSERT INTO `user` VALUES (7, '2025-02-05', 1, NULL, NULL, 0, '周建峰', 'health06', '444444', 1, NULL, '13500112299', 2);
INSERT INTO `user` VALUES (8, '2025-02-08', 1, '2025-05-06', 2, 0, '吴佳琪', 'health07', '555555', 0, 'wu@health.com', '13500112300', 2);

SET FOREIGN_KEY_CHECKS = 1;

/*
  东软颐养中心管理系统 - 缺失表与测试数据
  数据库：db_service
  说明：
  1. 补齐 controller/dao 中使用但数据库中不存在的表。
  2. 为原有空表补充多条测试数据。
  3. 修正 beddetails 主键自增，使入住登记可以正常写入床位详情。
*/

SET NAMES utf8mb4;

-- ============================================================
-- 1. 角色 / 菜单 / 角色菜单
-- ============================================================
DROP TABLE IF EXISTS `rolemenu`;
DROP TABLE IF EXISTS `role`;
DROP TABLE IF EXISTS `menu`;

CREATE TABLE `role` (
  `id` int NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `update_by` int NULL DEFAULT NULL,
  `is_deleted` int NOT NULL DEFAULT 0,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `menu` (
  `id` int NOT NULL,
  `menus_index` varchar(20) NULL DEFAULT NULL,
  `title` varchar(50) NOT NULL,
  `icon` varchar(50) NULL DEFAULT NULL,
  `path` varchar(100) NULL DEFAULT NULL,
  `parent_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `rolemenu` (
  `id` int NOT NULL,
  `role_id` int NOT NULL,
  `menu` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `role` VALUES
(1, '2026-01-01 09:00:00', NULL, 1, 0, '系统管理员'),
(2, '2026-01-01 09:10:00', NULL, 1, 0, '健康管家'),
(3, '2026-01-02 10:00:00', '2026-02-01 10:00:00', 1, 0, '护理员'),
(4, '2026-01-03 11:00:00', NULL, 1, 0, '数据维护员');

INSERT INTO `menu` VALUES
(1, '1', '客户管理', 'user', '/customer', 0),
(2, '2', '用户管理', 'setting', '/user', 0),
(3, '3', '床位管理', 'bed', '/bed', 0),
(4, '4', '护理管理', 'nurse', '/nurse', 0),
(5, '5', '健康管家', 'manager', '/manager', 0),
(6, '1-1', '入住登记', '', '/customer/checkin', 1),
(7, '1-2', '退住登记', '', '/customer/backdown', 1),
(8, '1-3', '外出登记', '', '/customer/outward', 1),
(9, '4-1', '护理级别', '', '/nurse/level', 4),
(10, '4-2', '护理项目', '', '/nurse/item', 4);

INSERT INTO `rolemenu` VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 3), (4, 1, 4), (5, 1, 5),
(6, 1, 6), (7, 1, 7), (8, 1, 8), (9, 1, 9), (10, 1, 10),
(11, 2, 1), (12, 2, 5), (13, 2, 6), (14, 2, 7), (15, 2, 8),
(16, 3, 1), (17, 3, 4), (18, 3, 9), (19, 3, 10);

-- ============================================================
-- 2. 护理级别 / 护理项目 / 级别项目关联
-- ============================================================
DROP TABLE IF EXISTS `nurselevelitem`;
DROP TABLE IF EXISTS `nursecontent`;
DROP TABLE IF EXISTS `nurselevel`;

CREATE TABLE `nurselevel` (
  `id` int NOT NULL AUTO_INCREMENT,
  `level_name` varchar(50) NOT NULL,
  `level_status` int NOT NULL DEFAULT 1,
  `is_deleted` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `nursecontent` (
  `id` int NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(50) NOT NULL,
  `nursing_name` varchar(100) NOT NULL,
  `service_price` varchar(20) NOT NULL,
  `message` varchar(255) NULL DEFAULT NULL,
  `status` int NOT NULL DEFAULT 1,
  `execution_cycle` varchar(50) NULL DEFAULT NULL,
  `execution_times` varchar(50) NULL DEFAULT NULL,
  `is_deleted` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `nurselevelitem` (
  `id` int NOT NULL AUTO_INCREMENT,
  `level_id` int NOT NULL,
  `item_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `nurselevel` VALUES
(1, '一级护理', 1, 0),
(2, '二级护理', 1, 0),
(3, '三级护理', 1, 0),
(4, '特级护理', 2, 0),
(5, '专护', 1, 0);

INSERT INTO `nursecontent` VALUES
(1, 'HL001', '助浴服务', '80.00', '协助老人完成洗浴', 1, '每周', '2', 0),
(2, 'HL002', '测量血压', '20.00', '每日测量并记录血压', 1, '每日', '1', 0),
(3, 'HL003', '协助进食', '30.00', '帮助行动不便老人进餐', 1, '每日', '3', 0),
(4, 'HL004', '翻身拍背', '40.00', '预防褥疮，定时翻身', 1, '每日', '4', 0),
(5, 'HL005', '口腔护理', '25.00', '早晚口腔清洁', 1, '每日', '2', 0),
(6, 'HL006', '康复训练', '100.00', '肢体功能康复训练', 1, '每周', '3', 0),
(7, 'HL007', '心理疏导', '60.00', '陪伴聊天、情绪疏导', 1, '每周', '1', 0),
(8, 'HL008', '晚间巡视', '15.00', '夜间定时巡视', 2, '每日', '2', 0);

INSERT INTO `nurselevelitem` VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 3),
(4, 2, 2), (5, 2, 3),
(6, 3, 2),
(7, 4, 1), (8, 4, 2), (9, 4, 3), (10, 4, 4), (11, 4, 5),
(12, 5, 1), (13, 5, 2), (14, 5, 3), (15, 5, 4), (16, 5, 5), (17, 5, 6), (18, 5, 7);

-- ============================================================
-- 3. 客户护理项目 / 护理记录
-- ============================================================
DROP TABLE IF EXISTS `customernurseitem`;
DROP TABLE IF EXISTS `nurserecord`;

CREATE TABLE `customernurseitem` (
  `id` int NOT NULL,
  `item_id` int NOT NULL,
  `customer_id` int NOT NULL,
  `level_id` int NULL DEFAULT NULL,
  `nurse_number` int NOT NULL DEFAULT 1,
  `is_deleted` int NOT NULL DEFAULT 0,
  `buy_time` date NULL DEFAULT NULL,
  `maturity_time` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `nurserecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `is_deleted` int NOT NULL DEFAULT 0,
  `customer_id` int NOT NULL,
  `item_id` int NOT NULL,
  `nursing_time` datetime NULL DEFAULT NULL,
  `nursing_content` varchar(255) NULL DEFAULT NULL,
  `nursing_count` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `customernurseitem` VALUES
(1, 1, 3, 1, 4, 0, '2026-07-01', '2027-01-01'),
(2, 2, 3, 1, 30, 0, '2026-07-01', '2027-01-01'),
(3, 2, 5, 2, 20, 0, '2026-08-01', '2026-12-31'),
(4, 3, 5, 2, 15, 0, '2026-08-01', '2026-12-31'),
(5, 4, 8, 1, 10, 0, '2026-06-15', '2026-12-15'),
(6, 2, 10, 3, 25, 0, '2026-09-01', '2027-03-01'),
(7, 5, 13, 2, 12, 0, '2026-05-20', '2026-11-20'),
(8, 6, 16, 4, 8, 0, '2026-04-01', '2027-04-01'),
(9, 7, 19, 1, 6, 0, '2026-09-10', '2026-12-10'),
(10, 2, 2, 1, 18, 0, '2026-08-18', '2026-11-18'),
(11, 1, 20, 5, 5, 0, '2026-03-01', '2027-03-01');

INSERT INTO `nurserecord` VALUES
(1, 0, 3, 1, '2026-10-15 09:20:00', '协助完成洗浴，状态良好', 1, 2),
(2, 0, 3, 2, '2026-10-16 08:10:00', '血压 135/85，记录正常', 1, 2),
(3, 0, 5, 2, '2026-10-16 08:30:00', '血压 142/90，已提醒按时服药', 1, 3),
(4, 0, 5, 3, '2026-10-16 11:40:00', '午餐进食正常', 1, 3),
(5, 0, 8, 4, '2026-10-15 15:00:00', '完成翻身拍背，皮肤无异常', 2, 6),
(6, 0, 10, 2, '2026-10-17 08:05:00', '血压 128/80', 1, 6),
(7, 0, 13, 5, '2026-10-17 20:30:00', '晚间口腔护理完成', 1, 3),
(8, 0, 16, 6, '2026-10-14 10:00:00', '康复训练 30 分钟', 1, 6),
(9, 0, 19, 7, '2026-10-13 16:20:00', '心理疏导 20 分钟', 1, 2),
(10, 0, 20, 1, '2026-10-12 09:00:00', '助浴服务完成', 1, 3);

-- ============================================================
-- 4. 膳食（食品 / 周食谱）
-- ============================================================
DROP TABLE IF EXISTS `meal`;
DROP TABLE IF EXISTS `food`;

CREATE TABLE `food` (
  `id` int NOT NULL AUTO_INCREMENT,
  `food_name` varchar(100) NOT NULL,
  `price` decimal(10,2) NULL DEFAULT NULL,
  `food_type` varchar(50) NULL DEFAULT NULL,
  `is_halal` int NULL DEFAULT 0,
  `food_img` varchar(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `meal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `week_day` varchar(20) NOT NULL,
  `food_id` int NOT NULL,
  `meal_type` int NOT NULL,
  `taste` varchar(50) NULL DEFAULT NULL,
  `is_deleted` int NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `food` (`food_name`, `price`, `food_type`, `is_halal`, `food_img`) VALUES
('小米粥', 3.00, '主食', 1, ''),
('软米饭', 2.00, '主食', 1, ''),
('清蒸鲈鱼', 18.00, '荤菜', 1, ''),
('西红柿炒蛋', 10.00, '素菜', 1, ''),
('青菜豆腐', 8.00, '素菜', 1, ''),
('红烧鸡腿', 15.00, '荤菜', 1, ''),
('南瓜粥', 4.00, '主食', 1, ''),
('水果拼盘', 6.00, '加餐', 1, '');

INSERT INTO `meal` (`week_day`, `food_id`, `meal_type`, `taste`, `is_deleted`) VALUES
('星期一', 1, 1, '清淡', 0),
('星期一', 3, 2, '咸鲜', 0),
('星期一', 5, 3, '清淡', 0),
('星期二', 2, 1, '清淡', 0),
('星期二', 6, 2, '酱香', 0),
('星期三', 7, 1, '微甜', 0),
('星期三', 4, 2, '家常', 0),
('星期四', 8, 3, '甜', 0);

-- ============================================================
-- 5. 原有空表补充数据：外出、退住、偏好
-- ============================================================
DELETE FROM `outward`;
INSERT INTO `outward` (`id`, `remarks`, `is_deleted`, `customer_id`, `outgoingreason`, `outgoingtime`, `expectedreturntime`, `actualreturntime`, `escorted`, `relation`, `escortedtel`, `auditstatus`, `auditperson`, `audittime`) VALUES
(1, '家属接回', 0, 1, '回家探亲', '2026-10-15', '2026-10-18', NULL, '张建国', '儿子', '13800001234', 0, NULL, NULL),
(2, NULL, 0, 3, '医院复查', '2026-10-16', '2026-10-17', NULL, '张红星', '儿子', '13900001122', 0, NULL, NULL),
(3, '需按时返回', 0, 5, '参加家庭聚会', '2026-10-17', '2026-10-19', NULL, '王丽娟', '女儿', '15500008899', 0, NULL, NULL),
(4, NULL, 0, 7, '购买生活用品', '2026-10-10', '2026-10-10', '2026-10-10', '李伟', '儿子', '18600001234', 1, '张大明', '2026-10-09'),
(5, NULL, 0, 9, '朋友聚会', '2026-10-08', '2026-10-09', NULL, '陈小花', '女儿', '18600009900', 2, '张大明', '2026-10-08');

DELETE FROM `backdown`;
INSERT INTO `backdown` (`id`, `remarks`, `is_deleted`, `customer_id`, `retreattime`, `retreattype`, `retreatreason`, `auditstatus`, `auditperson`, `audittime`) VALUES
(1, NULL, 0, 2, '2026-10-20', 1, '合同到期，家属接回', 0, NULL, NULL),
(2, NULL, 0, 4, '2026-10-22', 3, '暂时保留床位', 0, NULL, NULL),
(3, NULL, 0, 6, '2026-10-25', 2, '因病离世', 0, NULL, NULL),
(4, NULL, 0, 8, '2026-09-30', 1, '转去其他养老机构', 1, '张大明', '2026-09-28'),
(5, NULL, 0, 11, '2026-09-20', 1, '家属要求退住', 2, '张大明', '2026-09-19');

DELETE FROM `preference`;
INSERT INTO `preference` (`id`, `customer_id`, `preferences`, `attention`, `remark`, `is_deleted`) VALUES
(1, 1, '清淡饮食，喜食鱼类', '低盐低油', '早餐喝小米粥', 0),
(2, 2, '喜食甜食', '糖尿病，少糖', '水果控制在少量', 0),
(3, 3, '爱吃面食', '忌辛辣', '晚餐少量', 0),
(4, 4, '喜食蔬菜', '无特殊忌口', '可增加粗粮', 0),
(5, 5, '偏爱软烂食物', '腿脚不便，需送餐', '午餐需人协助', 0);

-- ============================================================
-- 6. 房间 / 床位 / 床位详情：与现有 20 位客户配套
-- ============================================================
INSERT INTO `room` (`id`, `room_floor`, `room_no`) VALUES
(1, '1号楼', 101), (2, '1号楼', 102), (3, '1号楼', 103), (4, '1号楼', 104), (5, '1号楼', 105),
(6, '2号楼', 201), (7, '2号楼', 202), (8, '2号楼', 203), (9, '2号楼', 204), (10, '2号楼', 205),
(11, '3号楼', 301), (12, '3号楼', 302), (13, '3号楼', 303), (14, '3号楼', 304), (15, '3号楼', 305),
(16, '4号楼', 401), (17, '4号楼', 402), (18, '4号楼', 403), (19, '4号楼', 404), (20, '4号楼', 405)
ON DUPLICATE KEY UPDATE `room_floor` = VALUES(`room_floor`), `room_no` = VALUES(`room_no`);

INSERT INTO `bed` (`id`, `room_no`, `bed_status`, `remarks`, `bed_no`) VALUES
(1, 101, 2, '在住', '101-1'), (2, 102, 2, '在住', '102-1'), (3, 103, 2, '在住', '103-1'),
(4, 104, 2, '在住', '104-1'), (5, 105, 2, '在住', '105-1'), (6, 201, 2, '在住', '201-1'),
(7, 202, 2, '在住', '202-1'), (8, 203, 2, '在住', '203-1'), (9, 204, 2, '在住', '204-1'),
(10, 205, 2, '在住', '205-1'), (11, 301, 2, '在住', '301-1'), (12, 302, 2, '在住', '302-1'),
(13, 303, 2, '在住', '303-1'), (14, 304, 2, '在住', '304-1'), (15, 305, 2, '在住', '305-1'),
(16, 401, 2, '在住', '401-1'), (17, 402, 2, '在住', '402-1'), (18, 403, 2, '在住', '403-1'),
(19, 404, 2, '在住', '404-1'), (20, 405, 2, '在住', '405-1'),
(21, 101, 1, '空闲', '101-2'), (22, 102, 1, '空闲', '102-2'), (23, 103, 1, '空闲', '103-2'),
(24, 104, 1, '空闲', '104-2'), (25, 105, 1, '空闲', '105-2'), (26, 201, 1, '空闲', '201-2'),
(27, 202, 1, '空闲', '202-2'), (28, 203, 1, '空闲', '203-2'), (29, 204, 1, '空闲', '204-2'),
(30, 205, 1, '空闲', '205-2')
ON DUPLICATE KEY UPDATE `room_no` = VALUES(`room_no`), `bed_status` = VALUES(`bed_status`), `remarks` = VALUES(`remarks`), `bed_no` = VALUES(`bed_no`);

ALTER TABLE `user` MODIFY `id` int NOT NULL AUTO_INCREMENT;
ALTER TABLE `beddetails` MODIFY `id` int NOT NULL AUTO_INCREMENT;

DELETE FROM `beddetails`;
INSERT INTO `beddetails` (`start_date`, `end_date`, `bed_details`, `customer_id`, `bed_id`, `is_deleted`) VALUES
('2024-03-01', NULL, '入住使用', 1, 1, 0),
('2024-05-15', NULL, '入住使用', 2, 2, 0),
('2024-01-10', NULL, '入住使用', 3, 3, 0),
('2024-06-01', NULL, '入住使用', 4, 4, 0),
('2024-02-20', NULL, '入住使用', 5, 5, 0),
('2024-04-12', NULL, '入住使用', 6, 6, 0),
('2024-07-08', NULL, '入住使用', 7, 7, 0),
('2024-08-16', NULL, '入住使用', 8, 8, 0),
('2024-09-01', NULL, '入住使用', 9, 9, 0),
('2024-03-25', NULL, '入住使用', 10, 10, 0),
('2024-05-05', NULL, '入住使用', 11, 11, 0),
('2024-06-18', NULL, '入住使用', 12, 12, 0),
('2024-07-22', NULL, '入住使用', 13, 13, 0),
('2024-08-30', NULL, '入住使用', 14, 14, 0),
('2024-09-14', NULL, '入住使用', 15, 15, 0),
('2024-04-02', NULL, '入住使用', 16, 16, 0),
('2024-05-28', NULL, '入住使用', 17, 17, 0),
('2024-06-26', NULL, '入住使用', 18, 18, 0),
('2024-07-15', NULL, '入住使用', 19, 19, 0),
('2024-08-09', NULL, '入住使用', 20, 20, 0);

-- ============================================================
-- 7. 客户护理级别 / 健康管家分配
-- ============================================================
UPDATE `customer` SET `level_id` = 1, `user_id` = 2 WHERE `id` = 1;
UPDATE `customer` SET `level_id` = 1, `user_id` = 2 WHERE `id` = 2;
UPDATE `customer` SET `level_id` = 1, `user_id` = 3 WHERE `id` = 3;
UPDATE `customer` SET `level_id` = 2, `user_id` = 3 WHERE `id` = 4;
UPDATE `customer` SET `level_id` = 2, `user_id` = 6 WHERE `id` = 5;
UPDATE `customer` SET `level_id` = 3, `user_id` = 6 WHERE `id` = 6;
UPDATE `customer` SET `level_id` = 1, `user_id` = 7 WHERE `id` = 7;
UPDATE `customer` SET `level_id` = 1, `user_id` = 8 WHERE `id` = 8;
UPDATE `customer` SET `level_id` = 2, `user_id` = 7 WHERE `id` = 9;
UPDATE `customer` SET `level_id` = 3, `user_id` = 8 WHERE `id` = 10;
UPDATE `customer` SET `level_id` = 2, `user_id` = 2 WHERE `id` = 11;
UPDATE `customer` SET `level_id` = 1 WHERE `id` = 12;
UPDATE `customer` SET `level_id` = 2 WHERE `id` = 13;
UPDATE `customer` SET `level_id` = 3 WHERE `id` = 14;
UPDATE `customer` SET `level_id` = 1 WHERE `id` = 15;
UPDATE `customer` SET `level_id` = 4 WHERE `id` = 16;
UPDATE `customer` SET `level_id` = 2 WHERE `id` = 17;
UPDATE `customer` SET `level_id` = 3 WHERE `id` = 18;
UPDATE `customer` SET `level_id` = 1 WHERE `id` = 19;
UPDATE `customer` SET `level_id` = 5 WHERE `id` = 20;

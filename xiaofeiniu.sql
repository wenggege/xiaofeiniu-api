SET NAMES UTF8;
#删除(丢弃)数据库,如果存在的话
DROP DATABASE IF EXISTS xiaofeiniu;
# 创建数据库名称
CREATE DATABASE xiaofeiniu CHARSET=UTF8;
#进入数据库
USE xiaofeiniu;

#创建管理员表
CREATE TABLE xfn_admin(
  aid INT PRIMARY KEY AUTO_INCREMENT,
  aname VARCHAR(32) UNIQUE, 
  apwd VARCHAR(64) #加密存储
);
INSERT INTO xfn_admin VALUES (NULL,'admin',PASSWORD('123456'));
INSERT INTO xfn_admin VALUES (NULL,'boss',PASSWORD('999999'));




#项目全局设置：xfn_settings
CREATE TABLE xfn_settings(
    sid INT PRIMARY KEY AUTO_INCREMENT,
    appName	VARCHAR(32),	      #应用/店家名称
    apiUrl	VARCHAR(64),	      #数据API子系统地址
    adminUrl VARCHAR(64),	      #管理后台子系统地址
    appUrl	VARCHAR(64),        #顾客App子系统地址
    icp	VARCHAR(64),	          #系统备案号
    copyright VARCHAR(128)	    #系统版权声明
);
INSERT INTO xfn_settings VALUES (NULL,'小肥牛','http://127.0.0.1:8090','http://127.0.0.1:8091','http://127.0.0.1:8092','京ICP备12003709号-3','Copyright © 2002-2019 北京达内金桥科技有限公司版权所有');

#桌台信息表：xfn_table
CREATE TABLE xfn_table(
    tid	INT PRIMARY KEY AUTO_INCREMENT,	    #桌台编号
    tname	VARCHAR(64),                      #允许空	桌台昵称
    type	VARCHAR(16),	                    #桌台类型，如3-4人桌
    status  INT                             #当前状态 1-空闲    2-预定 3-占用    0-其它
);
INSERT INTO xfn_table VALUES(NULL,'朝天门','6-8',1);
INSERT INTO xfn_table VALUES(NULL,'解放碑','4人桌',1);
INSERT INTO xfn_table VALUES(NULL,'观音桥','2人桌',1);
INSERT INTO xfn_table VALUES(NULL,'沙坪坝','10人桌',1);

#创建预定数据表xfn_reservation
CREATE TABLE xfn_reservation(
  rid INT PRIMARY KEY AUTO_INCREMENT,     #信息编号
  contactName VARCHAR(64),                #联系人姓名
  contactTime BIGINT,                     #联系时间
  dinnerTime BIGINT,                      #用餐时间
  phone VARCHAR(16)                       #联系人电话
);
INSERT INTO xfn_reservation VALUES(NULL,'kobe',1531756800000,1531830600000,'15340511871');
INSERT INTO xfn_reservation VALUES(NULL,'JJlin',1531756800000,1531830600000,'13667690542');
INSERT INTO xfn_reservation VALUES(NULL,'jay',1531756800000,1531830600000,'13666548894');

#创建菜品分类表xfn_category
CREATE TABLE xfn_category(
  cid INT PRIMARY KEY AUTO_INCREMENT,     #分类编号
  cname VARCHAR(32)                       #类别名称
);
INSERT INTO xfn_category VALUES(NULL,'肉类');
INSERT INTO xfn_category VALUES(NULL,'鱼类');
INSERT INTO xfn_category VALUES(NULL,'海鲜类');
INSERT INTO xfn_category VALUES(NULL,'蔬菜类');
INSERT INTO xfn_category VALUES(NULL,'蘑菇类');

#创建菜品信息表xfn_dish
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY AUTO_INCREMENT,                     #菜品编号(其起始值为100000)
  title VARCHAR(32),                                      #菜品名称
  imgUrl VARCHAR(128),                                    #图片地址
  price DECIMAL(6,2),                                     #菜品价格
  detail VARCHAR(128),                                    #菜品详情
  categoryld INT,
  FOREIGN KEY(categoryld) REFERENCES xfn_category(cid)    #所属菜品类别编号
);
INSERT INTO xfn_dish VALUES(100000,'草鱼片','CE7I9470.jpg',99,'选鲜活草鱼，切出鱼片冷鲜保存。锅开后再煮1分钟左右即可食用',2);
INSERT INTO xfn_dish VALUES(NULL,'冻虾','CE7I7004.jpg',199,'将活虾冷冻而成。肉质脆嫩，锅开后再煮4分钟左右即可食用。',3);

#创建订单表xfn_order
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY AUTO_INCREMENT,             #订单编号
    startTime BIGINT,                               #开始用餐时间
    endTime BIGINT,                                 #结束用餐时间
    customerCount INT,                              #用餐人数
    tableId INT,                
    FOREIGN KEY(tableId) REFERENCES xfn_table(tid)  #餐桌编号
);
INSERT INTO xfn_order VALUES(1,1531756800000,1531830600000,3,1);
INSERT INTO xfn_order VALUES(2,1531756800000,1531830600000,3,2);
INSERT INTO xfn_order VALUES(3,1531756800000,1531830600000,3,3);


#创建订单详情表xfn_order_detail
CREATE TABLE xfn_order_detail(
    did INT PRIMARY KEY AUTO_INCREMENT,                   #订单编号
    dishId INT,
    FOREIGN KEY(dishId) REFERENCES xfn_dish(did),         #菜品编号
    dishCount INT,                                        #菜品数量
    customerName   VARCHAR(64),                           #点餐用户的称呼
    orderId INT,
    FOREIGN KEY(orderId) REFERENCES xfn_order(oid)        #订单编号，指明所属订单
);
INSERT INTO xfn_order_detail VALUES(NULL,100000,1,'kobe',1);
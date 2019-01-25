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
    sid INT PRIMARY KEY,
    appName	VARCHAR(32),	    #应用/店家名称
    apiUrl	VARCHAR(64),	    #数据API子系统地址
    adminUrl VARCHAR(64),	    #管理后台子系统地址
    appUrl	VARCHAR(64),        #顾客App子系统地址
    icp	VARCHAR(64),	        #系统备案号
    copyright VARCHAR(128)	    #系统版权声明

);

#桌台信息表：xfn_table
CREATE TABLE xfn_table(
    tid	INT PRIMARY KEY,	 #桌台编号
    tname	VARCHAR(64),     #允许空	桌台昵称
    type	VARCHAR(16),	 #桌台类型，如3-4人桌
    status  INT              #当前状态 1-空闲    2-预定 3-占用    0-其它
);


#创建预定数据表xfn_reservation
CREATE TABLE xfn_reservation(
  rid INT PRIMARY KEY,     #信息编号
  contactName VARCHAR(64), #联系人姓名
  contactTime BIGINT,      #联系时间
  dinnerTime BIGINT,       #用餐时间
  phone VARCHAR(16)        #联系人电话
);

#创建菜品分类表xfn_category
CREATE TABLE xfn_category(
  cid INT PRIMARY KEY,     #分类编号
  cname VARCHAR(32)        #类别名称
);

#创建菜品信息表xfn_dish
CREATE TABLE xfn_dish(
  did INT PRIMARY KEY,     #菜品编号(其起始值为100000)
  title VARCHAR(32),       #菜品名称
  imgUrl VARCHAR(128),     #图片地址
  price DECIMAL(6,2),      #菜品价格
  detail VARCHAR(128),     #菜品详情
  categoryld INT,
  FOREIGN KEY(did) REFERENCES xfn_category(cid)    #所属菜品类别编号
);

#创建订单表xfn_order
CREATE TABLE xfn_order(
    oid INT PRIMARY KEY,        #订单编号
    startTime BIGINT,           #开始用餐时间
    endTime BIGINT,             #结束用餐时间
    customerCount INT,          #用餐人数
    tableId INT,                
    FOREIGN KEY(oid) REFERENCES xfn_table(tid)  #餐桌编号
);

#创建订单详情表xfn_order_detail
CREATE TABLE xfn_order_detail(
    did INT PRIMARY KEY,        #订单编号
    dishId INT,
    FOREIGN KEY(did) REFERENCES xfn_dish(did),  #菜品编号
    dishCount INT,    #菜品数量
    customerName   VARCHAR(64),  #点餐用户的称呼
    orderId INT,
    FOREIGN KEY(did) REFERENCES xfn_order(oid)  #订单编号，指明所属订单
);
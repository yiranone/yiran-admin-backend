# yiran-admin-backend
 后台管理

# 主要技术

- jdk1.8
- spring boot
- querdsl
- hibernate
- jpa

# 安装

创建数据

```
create DATABASE yiran_db character set utf8mb4 collate utf8mb4_general_ci;

create user 'yiran'@'%' identified by 'yiran_pass';
grant ALL PRIVILEGES on yiran_db.* to yiran;

DROP USER IF EXISTS 'yiran'@'%';
select Host, User FROM mysql.user WHERE User = 'yiran';

sql/init.sql
```
 






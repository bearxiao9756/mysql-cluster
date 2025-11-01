-- 创建 MGR 复制用户
CREATE USER 'repl_mgr'@'%' IDENTIFIED BY 'MGR_Password_123';
GRANT REPLICATION SLAVE ON *.* TO 'repl_mgr'@'%';
GRANT BACKUP_ADMIN ON *.* TO 'repl_mgr'@'%'; 
GRANT CONNECTION_ADMIN ON *.* TO 'repl_mgr'@'%';

-- 创建 ProxySQL 监控用户 (ProxySQL 需要该用户来检查 MGR 状态)
CREATE USER 'monitor'@'%' IDENTIFIED BY 'Monitor_Password_123';
GRANT SELECT ON performance_schema.* TO 'monitor'@'%'; 
GRANT REPLICATION CLIENT ON *.* TO 'monitor'@'%';

FLUSH PRIVILEGES;

CREATE DATABASE testdb;
USE testdb;
CREATE TABLE example (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data VARCHAR(255)
);
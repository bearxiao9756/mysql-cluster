-- 配置 ProxySQL 管理员
UPDATE global_variables SET admin-admin_credentials='admin:admin_password' WHERE variable_name='admin-admin_credentials';

-- 配置 MySQL 监控用户
UPDATE global_variables SET mysql-monitor_username='monitor', mysql-monitor_password='Monitor_Password_123' WHERE variable_name IN ('mysql-monitor_username', 'mysql-monitor_password');

-- 添加应用用户 (应用连接 ProxySQL 时使用的用户)
INSERT INTO mysql_users (username, password, default_hostgroup) VALUES ('app_user', 'App_Password_123', 10);

-- 配置 MGR 监控：使用 hostgroup 10 (Master) 和 hostgroup 20 (Replica)
INSERT INTO mysql_group_replication_hostgroups (writer_hostgroup, backup_writer_hostgroup, reader_hostgroup, offline_hostgroup, active) VALUES (10, 20, 20, 0, 1);

-- 添加 MGR 节点到 ProxySQL 监控
INSERT INTO mysql_servers (hostgroup_id, hostname, port) VALUES (0, 'mysql1', 3306);
INSERT INTO mysql_servers (hostgroup_id, hostname, port) VALUES (0, 'mysql2', 3306);
INSERT INTO mysql_servers (hostgroup_id, hostname, port) VALUES (0, 'mysql3', 3306);

-- 读写分离规则：所有 SELECT 路由到从库组 (20)，其他路由到主库组 (10)
INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply) VALUES (10, 1, '^SELECT.*FOR UPDATE$', 10, 1);
INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply) VALUES (11, 1, '^SELECT', 20, 1);
INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply) VALUES (12, 1, '.*', 10, 1);

-- 立即加载并持久化配置
LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS TO DISK;
LOAD MYSQL QUERY RULES TO RUNTIME;
SAVE MYSQL QUERY RULES TO DISK;
LOAD MYSQL GROUP REPLICATION HOSTGROUPS TO RUNTIME;
SAVE MYSQL GROUP REPLICATION HOSTGROUPS TO DISK;
#!/bin/bash
set -e

# ProxySQL Admin 连接信息
ADMIN_USER="admin"
ADMIN_PASS="admin_password"
ADMIN_HOST="127.0.0.1"
ADMIN_PORT="6032"
SQL_FILE="/etc/proxysql/init-proxysql.sql"

echo "等待 ProxySQL 管理接口启动..."

# 循环检查 ProxySQL 管理端口是否可用
until mysql -u"${ADMIN_USER}" -p"${ADMIN_PASS}" -h"${ADMIN_HOST}" -P"${ADMIN_PORT}" -e "SELECT 1;" > /dev/null 2>&1; do
  sleep 1
done

echo "ProxySQL 管理接口已就绪，开始导入配置文件：${SQL_FILE}"

# 执行 SQL 文件
mysql -u"${ADMIN_USER}" -p"${ADMIN_PASS}" -h"${ADMIN_HOST}" -P"${ADMIN_PORT}" < "${SQL_FILE}"

echo "ProxySQL 配置完成。"
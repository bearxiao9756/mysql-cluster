mysql cluster 



# Docker Compose + MGR (MySQL 强一致性集群) + ProxySQL (读写分离代理)

1.目录结构
```
.
├── docker-compose.yml       # 定义所有服务
├── my.cnf                   # MGR 共享配置
└── init.sql                 # 初始化脚本
```
2. MGR 共享配置文件 (my.cnf)

3. 初始化脚本 (init.sql)

4. Docker Compose 文件 (docker-compose.yml)
这个文件定义了三个 MySQL 节点和一个 ProxySQL 代理

5. 部署和初始化

启动
docker-compose up -d


进入 mysql1 容器
docker exec -it mysql1 mysql -uroot -pRoot_Password_123 -e "
  SET GLOBAL group_replication_bootstrap_group = ON; 
  START GROUP_REPLICATION; 
  SET GLOBAL group_replication_bootstrap_group = OFF;"

检查状态
docker exec -it mysql1 mysql -uroot -pRoot_Password_123 -e "SELECT * FROM performance_schema.replication_group_members;"

6. 应用连接



创建master mysql 
```
docker run --name mysql-master -p 3302:3306 -e MYSQL_ROOT_PASSWORD=aA123N456* -d mysql:8.0.33
```
创建slave mysql 1
```
docker run --name mysql-slave1 -p 3302:3306 -e MYSQL_ROOT_PASSWORD=aA123N456* -d mysql:8.0.33
```
创建slave mysql 2
```
docker run --name mysql-slave1 -p 3302:3306 -e MYSQL_ROOT_PASSWORD=aA123N456* -d mysql:8.0.33
```
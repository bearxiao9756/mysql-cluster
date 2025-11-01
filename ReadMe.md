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
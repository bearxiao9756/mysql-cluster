# MYSQL 主从复制 单机

直接在当前目录下运行
```
docker compose up -d
```
进入 master 配置 
```
docker exec -it mysql-master mysql -uroot -paf45d4daS*
```
```
SHOW MASTER STATUS\G
```
```
mysql> SHOW MASTER STATUS\G
*************************** 1. row ***************************
             File: binlog.000002
         Position: 157
     Binlog_Do_DB: 
 Binlog_Ignore_DB: 
Executed_Gtid_Set: 
1 row in set (0.00 sec)

```
进入slave1
```
docker exec -it mysql-slave1 mysql -uroot -paf45d4daS*
```
配置slave1
```
CHANGE MASTER TO
  MASTER_HOST='mysql-master',
  MASTER_USER='repl_user',
  MASTER_PASSWORD='repl_password',
  MASTER_LOG_FILE='binlog.000002',  -- 替换为您记录的 File
  MASTER_LOG_POS=157,               -- 替换为您记录的 Position
  MASTER_AUTO_POSITION=0;
```
启动 slave1
```
START SLAVE;
```
查看 slave1
```
 SHOW SLAVE STATUS\G
```
状态结果
```
*************************** 1. row ***************************
               Slave_IO_State: Connecting to source
                  Master_Host: mysql-master
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: binlog.000002
          Read_Master_Log_Pos: 157
               Relay_Log_File: 74c6c09119dd-relay-bin.000001
                Relay_Log_Pos: 4
        Relay_Master_Log_File: binlog.000002
             Slave_IO_Running: Connecting
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 157
              Relay_Log_Space: 157
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 2061
                Last_IO_Error: Error connecting to source 'repl_user@mysql-master:3306'. This was attempt 1/86400, with a delay of 60 seconds between attempts. Message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 0
                  Master_UUID: 
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Replica has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 251101 08:16:57
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
       Master_public_key_path: 
        Get_master_public_key: 0
            Network_Namespace: 
1 row in set, 1 warning (0.00 sec)
```
进入 slave2
```
docker exec -it mysql-slave2 mysql -uroot -paf45d4daS*
```
配置 slave2
```
CHANGE MASTER TO
  MASTER_HOST='mysql-master',
  MASTER_USER='repl_user',
  MASTER_PASSWORD='repl_password',
  MASTER_LOG_FILE='binlog.000002',  -- 替换为您记录的 File
  MASTER_LOG_POS=157,               -- 替换为您记录的 Position
  MASTER_AUTO_POSITION=0;
```
启动 slave2
```
START SLAVE;
```
查看 slave2
```
SHOW SLAVE STATUS\G
```
状态 slave2
```
*************************** 1. row ***************************
               Slave_IO_State: Connecting to source
                  Master_Host: mysql-master
                  Master_User: repl_user
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: binlog.000002
          Read_Master_Log_Pos: 157
               Relay_Log_File: e01a78e08724-relay-bin.000001
                Relay_Log_Pos: 4
        Relay_Master_Log_File: binlog.000002
             Slave_IO_Running: Connecting
            Slave_SQL_Running: Yes
              Replicate_Do_DB: 
          Replicate_Ignore_DB: 
           Replicate_Do_Table: 
       Replicate_Ignore_Table: 
      Replicate_Wild_Do_Table: 
  Replicate_Wild_Ignore_Table: 
                   Last_Errno: 0
                   Last_Error: 
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 157
              Relay_Log_Space: 157
              Until_Condition: None
               Until_Log_File: 
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File: 
           Master_SSL_CA_Path: 
              Master_SSL_Cert: 
            Master_SSL_Cipher: 
               Master_SSL_Key: 
        Seconds_Behind_Master: NULL
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 2061
                Last_IO_Error: Error connecting to source 'repl_user@mysql-master:3306'. This was attempt 1/86400, with a delay of 60 seconds between attempts. Message: Authentication plugin 'caching_sha2_password' reported error: Authentication requires secure connection.
               Last_SQL_Errno: 0
               Last_SQL_Error: 
  Replicate_Ignore_Server_Ids: 
             Master_Server_Id: 0
                  Master_UUID: 
             Master_Info_File: mysql.slave_master_info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Replica has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind: 
      Last_IO_Error_Timestamp: 251101 08:22:21
     Last_SQL_Error_Timestamp: 
               Master_SSL_Crl: 
           Master_SSL_Crlpath: 
           Retrieved_Gtid_Set: 
            Executed_Gtid_Set: 
                Auto_Position: 0
         Replicate_Rewrite_DB: 
                 Channel_Name: 
           Master_TLS_Version: 
       Master_public_key_path: 
        Get_master_public_key: 0
            Network_Namespace: 
1 row in set, 1 warning (0.00 sec)
``` 


# 问题
1. ssl 链接问题
## 创建证书

### 在主服务器上创建 CA 证书和密钥

1. 创建公钥
```
openssl genrsa 2048 > ca-key.pem
```
2. 创建证书
```
openssl req -new -x509 -nodes -days 3650 -key ca-key.pem -out ca.pem
```


### 为主服务器创建服务器证书和密钥
1. 创建服务器公钥
```
openssl genrsa 2048 > server-key.pem
```
2.创建证书签名请求 (CSR)：
```
openssl req -new -key server-key.pem -out server-req.pem
```
3.使用 CA 签署服务器证书 (server-cert.pem)：

```
openssl x509 -req -in server-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem
```
### 为从服务器（Replica）创建客户端证书和密钥
1. 创建客户端密钥：
```
openssl genrsa 2048 > replica-key.pem
```
2. 创建证书签名请求 (CSR)：
```
openssl req -new -key replica-key.pem -out replica-req.pem
```
3. 使用 CA 签署客户端证书 (replica-cert.pem)：
```
openssl x509 -req -in replica-req.pem -days 3650 -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out replica-cert.pem
```

 | 文件             |     部署位置         |      用于配置什么 | 
 | ca-key.pem       |  主服务器 和 从服务器 | CA 根证书（用于验证对方身份） |
 | ca.pem           | 
 | ca.srl 
 | replica-cert.pem | 从服务器  |
 | replica-key.pem  | 从服务器  |
 | replica-req.pem
 | server-cert.pem | 主服务器   |
 | server-key.pem |  主服务器   |
 | server-req.pem | 
文件	           部署位置	           用于配置什么
ca.pem	          主服务器 和 从服务器	CA 根证书（用于验证对方身份）
server-key.pem	  主服务器	主服务器私钥
server-cert.pem	  主服务器	主服务器证书
replica-key.pem	  从服务器	从服务器私钥 (MASTER_SSL_KEY)
replica-cert.pem  从服务器	从服务器证书 (MASTER_SSL_CERT)
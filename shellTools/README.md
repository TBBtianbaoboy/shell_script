# shell常用工具

---

## 日志打印函数

- 文件: log.sh
- 调用方法：
  - `log -e "error msg"`
  - `log -w "warning msg"`
  - `log "info msg"`
  
---

## 模块头部打印函数

- 文件: title.sh
- 调用方法
  - `title -T "模块标题"`
  - `title -t "段落标题"`

---

## 文件备份函数

- 文件: bak.sh
- 调用方法
  - `bak [file_name]`

---

## yum安装某个目录下的rpm文件

- 文件: yum.sh
- 调用方法
  - `yumLocalInstall [soft_name] [rpm_dir]`

---

## 通过sshpass控制远程服务器
- 文件: remote.sh
- 调用方法
    - RhostSet [hostname] [hostip] [username] [password] [port]
    - RexecCommand "<command>"
    - RexecScript "<script path>"
    - RcopyFile "<local path>" "<target path>"
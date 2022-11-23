## 前言
* 1、 基于shelf实现的http service
* 2、 实现基础rbac权限管理
* 3、 数据库使用mysql
* 4、 项目结构
```
.
├── app_parse
├── bin
├── db
├── lib
│   ├── config
│   ├── database
│   ├── entities
│   ├── exceptions
│   ├── helpers
│   ├── logger
│   ├── middlewares
│   ├── modules
│   └── routers
├── scripts
├── template
├── Dockerfile
├── pubspec.yaml
└── start-server
```
##
* 1、本地运行

```aidl
#生成相关文件
dart pub run build_runner build --delete-conflicting-outputs
```
```dart
#默认环境是prod，本地运行记得修改env
dart  bin/server.dart -p 8080 -env qa
```
* 2、服务器部署
  * 使用docker部署，相关命令
  ```aidl
  #同步代码
  git pull
  #构建
  docker build -t webapp .
  #运行
  docker run -d -p 8080:8080 --name webapp -v /Users/jenkins/zy_app_manager_server:/mnt webapp
  #停止
  docker stop webapp
  #删除
  docker rm webapp
  #查看日志
  docker logs -f webapp
  #进入容器
  docker exec -it webapp bash
  ```
* 3、环境变量配置,使用yaml文件配置
  * env.xx.yaml
  
* n、路由说明

|url|说明|权限|
|:----:|:----:|:----:|
|api/auth/login|登录|all|
|api/auth/register|注册|all|
|api/auth/refresh|更新token||
|api/user|用户信息||

## 参考

- [1] [docker 部署 dart web 项目](https://medium.com/google-cloud/build-slim-docker-images-for-dart-apps-ee98ea1d1cf7)


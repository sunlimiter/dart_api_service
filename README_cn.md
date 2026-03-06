# Dart API Service

基于 Dart 和 `shelf` 框架构建的轻量级、高性能 HTTP 服务端应用，支持 Docker 快速部署。

[English Documentation](README.md)

## 特性

- **HTTP 服务**: 基于强大的 `shelf` 以及 `shelf_router` 生态实现。
- **权限管理**: 实现了基础的 RBAC（基于角色的访问控制），便于扩展。
- **数据库**: 使用 MySQL 存储数据 (`mysql1`)。
- **身份验证**: 基于 JWT 的用户认证 (`jaguar_jwt`)。
- **依赖注入**: 使用 `get_it` 和 `injectable` 进行优雅的依赖管理。
- **容器化部署**: 内置 `Dockerfile`，支持快速容器化部署。

## 项目结构

```text
.
├── app_parse
├── bin               # 服务启动入口
├── db                # 数据库相关脚本/结构
├── lib
│   ├── config        # 配置文件
│   ├── database      # 数据库连接与操作
│   ├── entities      # 数据实体模型
│   ├── exceptions    # 自定义异常处理
│   ├── extensions    # 扩展方法
│   ├── helps         # 辅助工具类
│   ├── logger        # 日志统一记录
│   ├── middlewares   # 请求中间件 (鉴权, 日志等)
│   ├── modules       # 业务模块 (认证, 用户等)
│   └── routers       # 路由定义
├── scripts           # 工具脚本
├── template          # 代码模板
├── Dockerfile        # Docker 构建文件
├── pubspec.yaml      # 项目依赖配置
└── start-server      # 启动脚本
```

## 运行指南

### 本地运行

1. **安装依赖并生成代码**

由于项目使用了依赖注入和 JSON 序列化，运行前需要生成对应的代码：

```shell
dart pub get
dart run build_runner build --delete-conflicting-outputs
```

2. **启动服务**

默认环境是 `prod`，本地运行时可以通过 `-env` 参数指定环境（如 `qa`）：

```shell
dart bin/server.dart -p 8080 -env qa
```

*环境变量配置主要通过 YAML 文件管理（如 `env.qa.yaml`，`env.prod.yaml`）。*

### 服务器部署

推荐使用 Docker 进行部署，参考以下命令：

```shell
# 同步最新代码
git pull

# 构建 Docker 镜像
docker build -t webapp .

# 运行容器 (请将 /mnt/data 替换为实际需要挂载的宿主机路径)
docker run -d -p 8080:8080 --name webapp -v /mnt/data:/mnt webapp

# 其他常用命令
docker stop webapp          # 停止容器
docker rm webapp            # 删除容器
docker logs -f webapp       # 查看实时日志
docker exec -it webapp bash # 进入容器内部
```

## 路由说明

| 接口地址 | 说明 | 权限要求 |
| :--- | :--- | :--- |
| `api/auth/login` | 登录 | all |
| `api/auth/register` | 注册 | all |
| `api/auth/refresh` | 刷新 Token | - |
| `api/user` | 获取用户信息 | - |

## 参考

- [docker 部署 dart web 项目](https://medium.com/google-cloud/build-slim-docker-images-for-dart-apps-ee98ea1d1cf7)

## 开源协议

本项目基于 MIT 协议开源 - 详见 [LICENSE](LICENSE) 文件。

# Dart API Service

A powerful and lightweight HTTP server application built with Dart, utilizing the `shelf` package and Docker for deployment.

[中文文档](README_cn.md)

## Features

- **HTTP Service**: Built on top of the robust Dart `shelf` and `shelf_router` ecosystem.
- **RBAC**: Basic Role-Based Access Control implementation for robust permission management.
- **Database**: Integrated with MySQL (`mysql1`).
- **Auth**: JWT-based authentication (`jaguar_jwt`).
- **Dependency Injection**: Powered by `get_it` and `injectable`.
- **Deployment**: Ready for Docker deployment.

## Project Structure

```text
.
├── app_parse
├── bin               # Server entry point
├── db                # Database scripts/schema
├── lib
│   ├── config        # Configuration files
│   ├── database      # Database connection and queries
│   ├── entities      # Data models/entities
│   ├── exceptions    # Custom error handling
│   ├── extensions    # Dart extension methods
│   ├── helps         # Helper utilities
│   ├── logger        # Logging setup
│   ├── middlewares   # Shelf middlewares (Auth, Logger, etc.)
│   ├── modules       # Application modules (Auth, User, etc.)
│   └── routers       # API routing definitions
├── scripts           # Utility scripts
├── template          # Code templates
├── Dockerfile        # Docker configuration
├── pubspec.yaml      # Dart dependencies
└── start-server      # Start script
```

## Getting Started

### Local Development

1. **Install dependencies and generate files**

Before running the server, generate the required files (for `injectable` and JSON serialization):

```shell
dart pub get
dart run build_runner build --delete-conflicting-outputs
```

2. **Run the server**

The default environment is `prod`. Remember to switch the environment to `qa` or `dev` during local runs:

```shell
dart bin/server.dart -p 8080 -env qa
```

*Configuration is handled via YAML files (e.g., `env.qa.yaml`).*

### Server Deployment

You can quickly deploy the service using Docker.

```shell
# Pull the latest code
git pull

# Build the Docker image
docker build -t webapp .

# Run the container in detached mode
docker run -d -p 8080:8080 --name webapp -v /mnt/data:/mnt webapp

# Other useful Docker commands
docker stop webapp          # Stop the container
docker rm webapp            # Remove the container
docker logs -f webapp       # Follow container logs
docker exec -it webapp bash # Enter the container shell
```

## API Routes

| Path | Description | Required Permission |
| :--- | :--- | :--- |
| `api/auth/login` | Login | all |
| `api/auth/register` | Register | all |
| `api/auth/refresh` | Refresh Token | - |
| `api/user` | Get User Info | - |

## References

- [Build slim Docker images for Dart apps](https://medium.com/google-cloud/build-slim-docker-images-for-dart-apps-ee98ea1d1cf7)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

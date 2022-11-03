///author: lty
////Time: 2022/11/01
////Description:
///数据库连接信息实体
class DatabaseConnectionConfiguration {
  final String host;
  final String user;
  final int port;
  final String password;
  final String databaseName;

  DatabaseConnectionConfiguration({
    required this.host,
    required this.user,
    required this.port,
    required this.password,
    required this.databaseName,
  });
}

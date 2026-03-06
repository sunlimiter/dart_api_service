import 'package:dart_api_service/config/database_connection_configuration.dart';
import 'package:dart_api_service/database/i_database_connection.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';
import 'package:pool/pool.dart';

///author: lty
////Time: 2022/11/07
////Description:

///数据库连接
@LazySingleton(as: IDatabaseConnection)
class DatabaseConnection implements IDatabaseConnection {
  final DatabaseConnectionConfiguration _configuration;
  late final Pool _pool;

  DatabaseConnection(this._configuration) {
    // 限制最大并发数据库连接量
    _pool = Pool(10, timeout: const Duration(seconds: 30));
  }

  @override
  Future<T> withConnection<T>(Future<T> Function(MySqlConnection conn) action) async {
    return await _pool.withResource(() async {
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: _configuration.host,
          port: _configuration.port,
          user: _configuration.user,
          password: _configuration.password,
          db: _configuration.databaseName,
        ),
      );
      try {
        return await action(conn);
      } finally {
        await conn.close();
      }
    });
  }
}

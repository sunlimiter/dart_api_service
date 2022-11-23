import 'package:dart_api_service/config/database_connection_configuration.dart';
import 'package:dart_api_service/config/service_locator_config.dart';
import 'package:dart_api_service/helps/yaml_help.dart' show load, env;
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/logger/logger.dart';
import 'package:dart_api_service/routers/router_configure.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

///author: lty
////Time: 2022/11/01
////Description:

class ApplicationConfig {
  Future<void> loadConfigApplication(Router router, {required String env}) async {
    await _loadEnv(env: env);
    _loadDatabaseConfig();
    _configLogger();
    _loadDependecies();
    _loadRoutersConfigure(router);
  }

  Future<void> _loadEnv({env}) async {
    var filename = 'env.$env.yaml';
    load(filename);
  }

  ///数据库配置
  void _loadDatabaseConfig() {
    final databaseConfig = DatabaseConnectionConfiguration(
      host: env['DATABASE']?['HOST'] ?? env['database']['host']!,
      user: env['DATABASE']?['USER'] ?? env['database']['user']!,
      port: env['DATABASE']?['PORT'] ?? env['database']['port']!,
      password: env['DATABASE']?['PASSWORD'] ?? env['database']['password']!,
      databaseName: env['DATABASE']?['NAME'] ?? env['database']['name']!,
    );
    GetIt.I.registerSingleton(databaseConfig);
  }

  ///日志配置
  void _configLogger() => GetIt.I.registerLazySingleton<ILogger>(Logger.new);

  ///依赖注入
  void _loadDependecies() => configureDependencies();

  ///路由
  void _loadRoutersConfigure(Router router) => RouterConfigure(router).configure();
}

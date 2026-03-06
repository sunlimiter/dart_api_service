// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../database/database_connection.dart' as _i396;
import '../database/i_database_connection.dart' as _i77;
import '../logger/i_logger.dart' as _i742;
import '../modules/user/controller/auth_controller.dart' as _i285;
import '../modules/user/controller/user_controller.dart' as _i1058;
import '../modules/user/data/i_user_repository.dart' as _i1005;
import '../modules/user/data/user_repository.dart' as _i460;
import '../modules/user/service/i_user_service.dart' as _i232;
import '../modules/user/service/user_service.dart' as _i3;
import 'database_connection_configuration.dart' as _i32;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.lazySingleton<_i77.IDatabaseConnection>(
    () => _i396.DatabaseConnection(gh<_i32.DatabaseConnectionConfiguration>()),
  );
  gh.lazySingleton<_i1005.IUserRepository>(
    () => _i460.UserRepository(
      connection: gh<_i77.IDatabaseConnection>(),
      log: gh<_i742.ILogger>(),
    ),
  );
  gh.factory<_i1058.UserController>(
    () => _i1058.UserController(
      log: gh<_i742.ILogger>(),
      connection: gh<_i77.IDatabaseConnection>(),
    ),
  );
  gh.lazySingleton<_i232.IUserService>(
    () => _i3.UserService(
      repository: gh<_i1005.IUserRepository>(),
      log: gh<_i742.ILogger>(),
    ),
  );
  gh.factory<_i285.AuthController>(
    () => _i285.AuthController(
      userService: gh<_i232.IUserService>(),
      log: gh<_i742.ILogger>(),
    ),
  );
  return getIt;
}

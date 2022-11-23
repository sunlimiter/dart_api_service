// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../database/database_connection.dart' as _i4;
import '../database/i_database_connection.dart' as _i3;
import '../logger/i_logger.dart' as _i8;
import '../modules/user/controller/auth_controller.dart' as _i12;
import '../modules/user/controller/user_controller.dart' as _i11;
import '../modules/user/data/i_user_repository.dart' as _i6;
import '../modules/user/data/user_repository.dart' as _i7;
import '../modules/user/service/i_user_service.dart' as _i9;
import '../modules/user/service/user_service.dart' as _i10;
import 'database_connection_configuration.dart'
    as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.lazySingleton<_i3.IDatabaseConnection>(
      () => _i4.DatabaseConnection(get<_i5.DatabaseConnectionConfiguration>()));
  gh.lazySingleton<_i6.IUserRepository>(() => _i7.UserRepository(
        connection: get<_i3.IDatabaseConnection>(),
        log: get<_i8.ILogger>(),
      ));
  gh.lazySingleton<_i9.IUserService>(() => _i10.UserService(
        repository: get<_i6.IUserRepository>(),
        log: get<_i8.ILogger>(),
      ));
  gh.factory<_i11.UserController>(() => _i11.UserController(
        log: get<_i8.ILogger>(),
        connection: get<_i3.IDatabaseConnection>(),
      ));
  gh.factory<_i12.AuthController>(() => _i12.AuthController(
        userService: get<_i9.IUserService>(),
        log: get<_i8.ILogger>(),
      ));
  return get;
}

import 'package:dart_api_service/database/i_database_connection.dart';
import 'package:dart_api_service/entities/user.dart';
import 'package:dart_api_service/exceptions/database_error_exception.dart';
import 'package:dart_api_service/exceptions/user_notfound_exception.dart';
import 'package:dart_api_service/helps/cripty_helpers.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/modules/user/data/i_user_repository.dart';
import 'package:dart_api_service/modules/user/view_models/auth_login.dart';
import 'package:injectable/injectable.dart';
import 'package:mysql1/mysql1.dart';

///author: lty
////Time: 2022/11/23
////Description:

@LazySingleton(as: IUserRepository)
class UserRepository implements IUserRepository {
  final IDatabaseConnection connection;
  final ILogger log;

  UserRepository({required this.connection, required this.log});

  @override
  Future<User> getUserInfo(AuthLogin authLogin) async {
    final conn = await connection.openConnection();
    try {
      final result = await conn.query('''
        select * from userinfo where email = ? and password = ?
       ''', [authLogin.account, CriptyHelpers.generateSHA256Hash(authLogin.password)]);

      if (result.isEmpty) {
        throw UserNotfoundException();
      }

      final fields = result.first.fields;
      return User(
        id: fields['id'] as int,
        name: fields['name'] as String,
        email: fields['email'] as String,
        password: fields['password'] as String,
      );
    } on MySqlConnection catch (e) {
      log.debug(e);
      throw DatabaseErrorException(message: 'Error al loguear usuario');
    } finally {
      await conn.close();
    }
  }
}

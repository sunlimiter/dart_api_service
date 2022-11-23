import 'package:dart_api_service/entities/user.dart';
import 'package:dart_api_service/modules/user/view_models/auth_login.dart';

///author: lty
////Time: 2022/11/23
////Description:

abstract class IUserRepository {
  Future<User> getUserInfo(AuthLogin authLogin);
}

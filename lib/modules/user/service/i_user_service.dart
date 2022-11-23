import 'package:dart_api_service/modules/user/view_models/auth_login.dart';
import 'package:dart_api_service/modules/user/view_models/refresh_token.dart';

///author: lty
////Time: 2022/11/23
////Description:

abstract class IUserService {
  Future<Map<String, String>> login(AuthLogin authLogin);

  Future<Map<String, String>> refreshToken(RefreshToken refreshToken);
}

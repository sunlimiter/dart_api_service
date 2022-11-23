import 'package:dart_api_service/exceptions/base_exception.dart';
import 'package:dart_api_service/helps/jwt_helper.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/modules/user/data/i_user_repository.dart';
import 'package:dart_api_service/modules/user/service/i_user_service.dart';
import 'package:dart_api_service/modules/user/view_models/auth_login.dart';
import 'package:dart_api_service/modules/user/view_models/refresh_token.dart';
import 'package:injectable/injectable.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

///author: lty
////Time: 2022/11/23
////Description:

@LazySingleton(as: IUserService)
class UserService implements IUserService {
  IUserRepository repository;
  ILogger log;

  UserService({
    required this.repository,
    required this.log,
  });

  @override
  Future<Map<String, String>> login(AuthLogin authLogin) async {
    var user = await repository.getUserInfo(authLogin);
    final accessToken = JwtHelper.generateJWT(user.id);
    final refreshToken = JwtHelper.refreshToken(accessToken.replaceAll('Bearer ', ''));
    return {'accessToken': accessToken, 'refreshToken': refreshToken};
  }

  @override
  Future<Map<String, String>> refreshToken(RefreshToken model) async {
    _validateRefreshToken(model);
    final newAccessToken = JwtHelper.generateJWT(model.userId);
    final newRefreshToken = JwtHelper.refreshToken(newAccessToken.replaceAll('Bearer ', ''));
    return {'accessToken': newAccessToken, 'refreshToken': newRefreshToken};
  }

  void _validateRefreshToken(RefreshToken model) {
    try {
      final refreshToken = model.refreshToken.split(' ');
      if (refreshToken.length != 2 || refreshToken.first != 'Bearer') {
        log.error('刷新token无效');
        throw BaseException('刷新token无效');
      }
      final refreshTokenClaims = JwtHelper.getClaims(refreshToken.last);
      refreshTokenClaims.validate(issuer: model.accessToken);
    } on JwtException catch (e) {
      log.error('刷新token无效', e);
      throw BaseException('刷新token无效');
    } catch (e) {
      throw BaseException('刷新token错误');
    }
  }
}

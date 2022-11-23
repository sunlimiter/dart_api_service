import 'dart:convert';

import 'package:dart_api_service/extensions/responseify.dart';
import 'package:dart_api_service/helps/jwt_helper.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/modules/user/service/i_user_service.dart';
import 'package:dart_api_service/modules/user/view_models/auth_login.dart';
import 'package:dart_api_service/modules/user/view_models/refresh_token.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

///author: lty
////Time: 2022/11/23
////Description:

part 'auth_controller.g.dart';

@Injectable()
class AuthController {
  IUserService userService;
  ILogger log;

  AuthController({
    required this.userService,
    required this.log,
  });

  @Route.post('/login')
  Future<Response> login(Request request) async {
    final model = AuthLogin(await request.readAsString());
    final refreshToken = await userService.login(model);
    return refreshToken.ok();
  }

  @Route.post('/refresh')
  Future<Response> refreshToken(Request request) async {
    final userId = int.parse(request.headers['userId']!);
    final accessToken = request.headers['access_token']!;

    final model = RefreshToken(
      userId: userId,
      accessToken: accessToken,
      dataRequest: await request.readAsString(),
    );
    final userRefreshToken = await userService.refreshToken(model);
    return userRefreshToken.ok();
  }

  Router get router => _$AuthControllerRouter(this);
}

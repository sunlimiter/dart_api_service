import 'dart:convert';

import 'package:dart_api_service/entities/result_data.dart';
import 'package:dart_api_service/helps/jwt_helper.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/middlewares/middlewares.dart';
import 'package:dart_api_service/middlewares/security/security_skip_url.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shelf/shelf.dart';

///author: lty
////Time: 2022/11/23
////Description:

class SecurityMiddleware extends Middlewares {
  final ILogger log;

  SecurityMiddleware(this.log);

  final skipUrl = <SecuritySkipUrl>[
    SecuritySkipUrl(url: '/favicon.ico', method: 'GET'),
  ];

  @override
  Future<Response> execute(Request request) async {
    try {
      log.debug(request.url.toString());

      ///过滤url不鉴权
      if (skipUrl.contains(SecuritySkipUrl(url: '/${request.url.path}', method: request.method))) {
        return innerHandler(request);
      }

      ///token 鉴权
      final authHeader = request.headers['token'];

      if (authHeader == null || authHeader.isEmpty) {
        throw JwtException.invalidToken;
      }

      final authHeaderContent = authHeader.split(' ');

      if (authHeaderContent[0] != 'Bearer') {
        throw JwtException.invalidToken;
      }

      final authorizationToken = authHeaderContent[1];
      final claims = JwtHelper.getClaims(authorizationToken);

      if (request.url.path != 'auth/refresh') {
        claims.validate();
      }

      final claimsMap = claims.toJson();

      final userId = claimsMap['sub'];

      if (userId == null) {
        throw JwtException.invalidToken;
      }
      final securityHeaders = {
        'userId': userId,
        'access_token': authorizationToken,
      };

      return innerHandler(request.change(headers: securityHeaders));
    } on JwtException catch (e, s) {
      log.error('验证JWT令牌时出错', e, s);
      var result = ResultData(ok: false, error: Error(message: '登录失效', code: '403'), msg: '登录失效');

      return Response.forbidden(jsonEncode(result.toJson()));
    } catch (e, s) {
      log.error('内部服务器错误', e, s);
      var result = ResultData(ok: false, error: Error(message: '内部服务器错误', code: '500'), msg: '内部服务器错误');
      return Response.internalServerError(body: jsonEncode(result.toJson()));
    }
  }
}

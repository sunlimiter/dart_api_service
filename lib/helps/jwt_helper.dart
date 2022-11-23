import 'package:dart_api_service/helps/yaml_help.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

///author: lty
////Time: 2022/11/23
////Description:

class JwtHelper {
  static final String _jwtSecret = env['JWT_SECRET'] ?? env['jwtSecret']!;

  static final String _issuer = env['server']['host'];

  JwtHelper._();

  static String generateJWT(int userId) {
    final claimSet = JwtClaim(
      issuer: _issuer, //签发人
      subject: userId.toString(), //创建人
      expiry: DateTime.now().add(const Duration(days: 1)), //令牌到期时间
      notBefore: DateTime.now(), //JWT Token 在这个时间之前是无效的
      issuedAt: DateTime.now(), //发行的时间
      otherClaims: <String, dynamic>{},
      maxAge: const Duration(days: 1),
    );
    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }

  static JwtClaim getClaims(String token) {
    return verifyJwtHS256Signature(token, _jwtSecret);
  }

  static String refreshToken(String accessToken) {
    final claimSet = JwtClaim(
      issuer: accessToken,
      subject: 'RefreshToken',
      expiry: DateTime.now().add(const Duration(days: 20)),
      notBefore: DateTime.now().add(Duration(hours: 12)),
      issuedAt: DateTime.now(),
      otherClaims: <String, dynamic>{},
    );
    return 'Bearer ${issueJwtHS256(claimSet, _jwtSecret)}';
  }
}

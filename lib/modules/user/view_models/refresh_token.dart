import 'package:dart_api_service/helps/request_mapping.dart';

///author: lty
////Time: 2022/11/23
////Description:

class RefreshToken extends RequestMapping {
  int userId;
  String accessToken;
  late String refreshToken;

  RefreshToken({
    required this.userId,
    required this.accessToken,
    required String dataRequest,
  }) : super(dataRequest);

  @override
  void map() {
    refreshToken = data['refresh_token'];
  }
}

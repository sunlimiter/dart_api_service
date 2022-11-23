import 'package:dart_api_service/helps/request_mapping.dart';

///author: lty
////Time: 2022/11/23
////Description:

class AuthLogin extends RequestMapping {
  late String account;
  late String password;

  AuthLogin(String dataRequest) : super(dataRequest);

  @override
  void map() {
    account = data['account'];
    password = data['password'];
  }
}

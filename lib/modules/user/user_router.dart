import 'package:dart_api_service/modules/user/controller/user_controller.dart';
import 'package:dart_api_service/routers/i_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

///author: lty
////Time: 2022/11/01
////Description:

class UserRouter implements IRouter {
  @override
  void configure(Router router) {
    final userController = GetIt.I.get<UserController>();

    router.get('/api/user', userController.router);
  }
}

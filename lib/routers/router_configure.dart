import 'package:dart_api_service/modules/user/user_router.dart';
import 'package:dart_api_service/modules/websocket/ws_router.dart';
import 'package:dart_api_service/routers/i_router.dart';
import 'package:shelf_router/shelf_router.dart';

///author: lty
////Time: 2022/11/01
////Description:

class RouterConfigure {
  final Router _router;

  RouterConfigure(this._router);

  final List<IRouter> _routers = [
    UserRouter(),
    WSRouter(),
  ];

  void configure() {
    for (var r in _routers) {
      r.configure(_router);
    }
  }
}

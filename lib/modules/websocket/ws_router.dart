import 'dart:async';

import 'package:dart_api_service/helps/web_socket/web_socket_session.dart';
import 'package:dart_api_service/modules/websocket/controller/ws_controller.dart';
import 'package:dart_api_service/routers/i_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart' as shelf_web_socket;
import 'package:web_socket_channel/web_socket_channel.dart';

///author: lty
////Time: 2022/11/01
////Description:

class WSRouter implements IRouter {
  @override
  void configure(Router router) {
    final wsController = GetIt.I.get<WSController>();

    // Track connected clients
    var users = <WebSocketSession>[];

    router.get(
      '/ws',
      _RouterPlusHandler(
        () => WebSocketSession(
          onOpen: (ws) {
            print('onOpen');
            users.add(ws);
            users
                .where((user) => user != ws)
                .forEach((user) => user.send('A new user joined the chat.'));
          },
          onClose: (ws) {
            print('onClose');
            users.remove(ws);
            for (var user in users) {
              user.send('A user has left.');
            }
          },
          onMessage: (ws, dynamic data) {
            print('onMessage=>$data');
            for (var user in users) {
              user.send(data);
            }
          },
        ),
      ),
    );
  }
}

class _RouterPlusHandler {
  final Function handler;

  _RouterPlusHandler(this.handler);

  /// Match the signature of any shelf_router handler.
  FutureOr<Response> call(Request request) async {
    return _handler.call(request);
  }

  Future<Response> _handler(Request request) async {
    dynamic result;

    try {
      result = handler();
    } on NoSuchMethodError catch (__) {
      result = handler(request);
    }

    return await resolveResponse(request, result);
  }

  Future<Response> resolveResponse(Request request, dynamic result) async {
    Response? handlerResult = await shelf_web_socket
        .webSocketHandler((WebSocketChannel webSocketChannel) {
      result.init(webSocketChannel);
    })(request);
    return handlerResult;
  }
}

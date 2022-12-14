// ignore_for_file: unawaited_futures

import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_api_service/config/application_config.dart';
import 'package:dart_api_service/config/service_locator_config.dart';
import 'package:dart_api_service/helps/web_socket/websocket_chat.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:dart_api_service/middlewares/cors/cors_middlewares.dart';
import 'package:dart_api_service/middlewares/default/default_content_type.dart';
import 'package:dart_api_service/middlewares/exception/shelf_exception_handler.dart';
import 'package:dart_api_service/middlewares/security/security_middleware.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  var parser = ArgParser()
    ..addOption('port', abbr: 'p')
    ..addOption('env', abbr: 'e');
  var result = parser.parse(args);

  // For Google Cloud Run, we respect the PORT environment variable
  var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
  var port = int.tryParse(portStr);

  if (port == null) {
    stdout.writeln('Could not parse port value "$portStr" into a number.');
    // 64: command line usage error
    exitCode = 64;
    return;
  }

  var env = result['env'] ?? 'prod';

  //Application Config
  final router = Router();
  final appConfig = ApplicationConfig();
  await appConfig.loadConfigApplication(router, env: env);
  final chatWebSocket = WebSocketChat.create();

  final handler = const shelf.Pipeline()
      .addMiddleware(CorsMiddlewares().handler)
      .addMiddleware(DefaultContentType('application/json;charset=utf-8').handler)
      .addMiddleware(SecurityMiddleware(getIt.get()).handler)
      .addMiddleware(shelf.logRequests())
      .addMiddleware(chatWebSocket.middleware)
      .addMiddleware(exceptionHandler(getIt.get()))
      .addHandler(router);

  io.serve(handler, ip, port).then(
    (server) {
      getIt.get<ILogger>().debug('Serving at \nwss://${server.address.host}:${server.port}/ws \nhttp://${server.address.host}:${server.port}');
    },
  ).whenComplete(() async => chatWebSocket.dispose());
  // var server = await io.serve(handler, ip, port);
  // print('Serving at http://${server.address.host}:${server.port}');
}

import 'package:dart_api_service/logger/i_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'ws_controller.g.dart';

///author: lty
////Time: 2022/11/01
////Description:

@Injectable()
class WSController {
  ILogger log;

  WSController({
    required this.log,
  });

  @Route.get('/')
  Future<Response> index(Request request) async {
    log.info('id=>');
    return Response.ok('hello world');
  }

  Router get router => _$WSControllerRouter(this);
}

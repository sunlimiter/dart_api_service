import 'package:dart_api_service/logger/i_logger.dart';
import 'package:injectable/injectable.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'user_controller.g.dart';

///author: lty
////Time: 2022/11/01
////Description:

@Injectable()
class UserController {
  ILogger log;

  UserController({
    required this.log,
  });

  @Route.get('/')
  Future<Response> index(Request request) async {
    // log.info('id=>$id');
    return Response.ok('hello world');
  }

  Router get router => _$UserControllerRouter(this);
}

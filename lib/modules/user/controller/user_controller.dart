import 'package:dart_api_service/database/i_database_connection.dart';
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
  final IDatabaseConnection connection;

  UserController({
    required this.log,
    required this.connection,
  });

  @Route.get('/')
  Future<Response> index(Request request) async {
    return Response.ok('list');
  }

  Router get router => _$UserControllerRouter(this);
}

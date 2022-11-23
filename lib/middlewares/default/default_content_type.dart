import 'package:dart_api_service/middlewares/middlewares.dart';
import 'package:shelf/shelf.dart';

///author: lty
////Time: 2022/11/23
////Description:

class DefaultContentType extends Middlewares {
  final String contentType;

  DefaultContentType(this.contentType);

  @override
  Future<Response> execute(Request request) async {
    final response = await innerHandler(request);
    return response.change(headers: {'content-type': contentType});
  }
}

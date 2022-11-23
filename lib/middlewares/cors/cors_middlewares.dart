import 'dart:io';

import 'package:dart_api_service/middlewares/middlewares.dart';
import 'package:shelf/shelf.dart';

///author: lty
////Time: 2022/11/23
////Description: 跨域资源共享，中间件

class CorsMiddlewares extends Middlewares {
  final Map<String, String> headers = {
    'Vary': 'Origin',
    'Access-Control-Allow-Methods': 'GET, POST, PATCH, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers': '${HttpHeaders.contentTypeHeader}, ${HttpHeaders.authorizationHeader}',
    'Access-Control-Allow-Credentials': 'true'
  };

  @override
  Future<Response> execute(Request request) async {
    headers['Access-Control-Allow-Origin'] = request.headers['Origin'] ?? '*';
    if (request.method == 'OPTIONS') {
      return Response(HttpStatus.ok, headers: headers);
    }

    final response = await innerHandler(request);
    return response.change(headers: headers);
  }
}

import 'dart:convert';

import 'package:dart_api_service/entities/result_data.dart';
import 'package:dart_api_service/exceptions/base_exception.dart';
import 'package:dart_api_service/logger/i_logger.dart';
import 'package:shelf/shelf.dart';

///author: lty
////Time: 2022/11/23
////Description:
Middleware exceptionHandler(ILogger log) =>
    (Handler handler) => (Request request) => Future.sync(() => handler(request)).then((response) => response).catchError((Object error, StackTrace stackTrace) {
          var message = '请求出错了';
          var code = '10000';
          if (error is BaseException) {
            message = error.message ?? '请求出错了';
            code = '${error.code ?? 10000}';
          }
          log.debug(error);
          log.debug(stackTrace);
          log.error('全局异常拦截', error);
          var result = ResultData(ok: false, error: Error(message: message, code: code), msg: message);
          return Response.ok(jsonEncode(result.toJson()));
        });

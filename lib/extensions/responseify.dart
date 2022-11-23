import 'dart:convert';

import 'package:shelf/shelf.dart';

extension Responseify on String? {
  Response internalServerError() {
    if (this == null || this!.isEmpty) {
      return Response.internalServerError(body: jsonEncode({'ok': false}));
    }
    return Response.internalServerError(body: jsonEncode({'ok': false, 'message': this}));
  }

  Response exitError() {
    if (this == null || this!.isEmpty) {
      return Response(204, body: jsonEncode({'ok': false}));
    }
    return Response(204, body: jsonEncode({'ok': false, 'message': this}));
  }
}

extension Stringify on dynamic {
  Response ok({String? message}) {
    var map = <String, dynamic>{
      'ok': true,
    };
    if (this != null) {
      map['result'] = {'data': this};
    }
    if (message == null || message.isEmpty == true) {
      return Response.ok(jsonEncode(map));
    }
    map['message'] = message;

    return Response.ok(jsonEncode(map));
  }
}

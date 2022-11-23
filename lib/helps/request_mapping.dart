import 'dart:convert';

///author: lty
////Time: 2022/11/23
////Description:

abstract class RequestMapping {
  final Map<String, dynamic> data;

  RequestMapping.empty() : data = {};

  RequestMapping(String dataRequest) : data = jsonDecode(dataRequest) {
    map();
  }

  void map();
}

abstract class RequestQueryMapping {
  final Map<String, String> data;

  RequestQueryMapping.empty() : data = {};

  RequestQueryMapping(Map<String, String> dataRequest) : data = dataRequest {
    map();
  }

  void map();
}

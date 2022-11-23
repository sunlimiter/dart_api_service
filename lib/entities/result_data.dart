///author: lty
////Time: 2022/11/23
////Description:
class ResultData {
  bool ok = false;
  Error? error;
  String? msg;
  Result? result;

  ResultData({this.result, required this.ok, this.error, this.msg});

  ResultData.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    msg = json['message'];
    ok = json['ok'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['ok'] = ok;
    data['message'] = msg;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    if (result != null) {
      data['result'] = result;
    }
    return data;
  }
}

class Error {
  String? message;
  String? code;

  Error({this.message, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class Result {
  dynamic data;

  Result({this.data});

  Result.fromJson(Map<String, dynamic> json) {
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['data'] = this.data;
    return data;
  }
}

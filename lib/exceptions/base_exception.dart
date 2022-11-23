///author: lty
////Time: 2022/11/23
////Description:

class BaseException implements Exception {
  final String? message;

  final int? code;

  BaseException(this.message, {this.code});
}

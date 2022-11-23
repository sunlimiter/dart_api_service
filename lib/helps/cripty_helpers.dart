import 'dart:convert';

import 'package:crypto/crypto.dart';

///author: lty
////Time: 2022/11/23
////Description:

class CriptyHelpers {
  static String generateSHA256Hash(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }
}

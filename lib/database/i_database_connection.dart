import 'package:mysql1/mysql1.dart';

///author: lty
////Time: 2022/11/07
////Description:

abstract class IDatabaseConnection {
  Future<T> withConnection<T>(Future<T> Function(MySqlConnection conn) action);
}

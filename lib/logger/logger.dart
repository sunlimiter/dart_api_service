import 'package:dart_api_service/logger/i_logger.dart';
import 'package:logger/logger.dart' as log;

///author: lty
////Time: 2022/11/01
////Description:
class MyFilter extends log.LogFilter {
  @override
  bool shouldLog(log.LogEvent event) {
    return true;
  }
}

class Logger implements ILogger {
  final _logger = log.Logger(filter: MyFilter());

  @override
  void debug(message, [error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  @override
  void error(message, [error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  @override
  void info(message, [error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  @override
  void warning(message, [error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);
}

import 'dart:io';

import 'package:yaml/yaml.dart';

///author: lty
////Time: 2022/11/01
///Description:yaml辅助类，替换dotenv，yaml更方便查看

var _env = <dynamic, dynamic>{};

YamlMap get env => _env as YamlMap;

/// Read environment variables from [filename] and add them to [env].
/// Logs to [stderr] if [filename] does not exist.
void load([String filename = 'env.yaml']) {
  stderr.writeln('config/$filename');
  try {
    var f = File.fromUri(Uri.file('config/$filename'));
    var lines = _verify(f);
    _env = loadYaml(lines);
  } catch (ex) {
    _env = {};
  }
}

String _verify(File f) {
  if (f.existsSync()) return f.readAsStringSync();
  stderr.writeln('[dotenv] Load failed: file not found: $f');
  return '';
}

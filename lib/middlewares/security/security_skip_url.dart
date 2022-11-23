///author: lty
////Time: 2022/11/23
////Description:
// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

class SecuritySkipUrl {
  String url;
  String method;

  SecuritySkipUrl({
    required this.url,
    required this.method,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SecuritySkipUrl && other.url == url && other.method == method;
  }

  @override
  int get hashCode => url.hashCode ^ method.hashCode;
}

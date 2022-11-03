import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator_config.config.dart';

///author: lty
////Time: 2022/11/01
////Description:

///依赖注入配置
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(getIt);

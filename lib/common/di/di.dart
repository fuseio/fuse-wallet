import 'package:fusecash/common/di/di.config.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.registerFactory<API>(() => API(base: UrlConstants.API_BASE_URL));
  getIt.registerFactory<Graph>(
      () => Graph(baseUrl: UrlConstants.GRAPH_BASE_URL));
  $initGetIt(getIt);
}

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({
  String environment,
}) {
  getIt.registerFactory<API>(() => API(base: DotEnv().env['API_BASE_URL']));
  getIt.registerFactory<Graph>(
      () => Graph(baseUrl: DotEnv().env['GRAPH_BASE_URL']));
  $initGetIt(getIt, environment: environment);
}

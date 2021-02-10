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
  getIt.registerLazySingleton<API>(
      () => API(base: 'https://studio.fuse.io/api'));
  getIt.registerLazySingleton<Graph>(
      () => Graph(baseUrl: 'https://graph.fuse.io/subgraphs/name/fuseio'));
  $initGetIt(getIt, environment: environment);
}

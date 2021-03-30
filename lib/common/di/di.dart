import 'package:fusecash/common/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({
  String environment,
}) {
  $initGetIt(getIt, environment: environment);
}

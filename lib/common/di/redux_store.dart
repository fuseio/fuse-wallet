import 'package:fusecash/redux/store.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ReduxServiceDi {
  @preResolve
  Future<ReduxService> get reduxService => ReduxService.initStore();
}

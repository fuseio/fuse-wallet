import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RouterDi {
  @lazySingleton
  RootRouter get logger => RootRouter(authGuard: AuthGuard());
}

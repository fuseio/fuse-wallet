import 'package:auto_route/auto_route_annotations.dart';
import 'package:farmly_ledger/screens/pro_mode/pro_mode.dart';

@MaterialAutoRouter()
class $ProRouter {
  @initial
  ProModeScaffold proModeHomeScreen;
}

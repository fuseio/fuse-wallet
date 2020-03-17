import 'package:auto_route/auto_route_annotations.dart';
import 'package:fusecash/screens/pro_mode/pro_mode_main.dart';

@MaterialAutoRouter()
class $ProRouter {
  @initial
  ProModeScaffold proModeHomeScreen;
}

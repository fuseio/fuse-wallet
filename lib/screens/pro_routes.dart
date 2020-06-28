import 'package:auto_route/auto_route_annotations.dart';
import 'package:paywise/screens/pro_mode/pro_mode.dart';
import 'package:paywise/screens/pro_mode/token_transfers.dart';

@MaterialAutoRouter()
class $ProRouter {
  @initial
  ProModeScaffold proModeHomeScreen;
  TokenTransfersScreen tokenTransfersScreen;
}

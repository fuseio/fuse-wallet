import 'plugin_base.dart';

abstract class DepositPlugin extends Plugin {
  String widgetUrl;

  final String type = 'deposit';

  DepositPlugin(
    name,
    isActive,
    this.widgetUrl,
  ) : super(name: name, isActive: isActive);

  String generateUrl({String email, String walletAddress}) {
    return this.widgetUrl;
  }

  dynamic toJson() => {
        'name': name,
        'isActive': isActive,
        'type': type,
        'widgetUrl': widgetUrl
      };
}

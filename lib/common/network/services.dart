import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart' show API, Graph;

@module
abstract class ServicesModule {
  @lazySingleton
  Graph get graph => Graph(
        baseUrl: env['GRAPH_BASE_URL'],
      );

  @lazySingleton
  API get api => API(
        base: env['API_BASE_URL'],
      );
}

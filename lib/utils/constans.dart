import 'package:flutter_dotenv/flutter_dotenv.dart';

final int intervalSeconds = int.parse(DotEnv().env['INTERVAL_SECONDS']);

final bool createWalletOnForeign = (DotEnv().env['CREATE_WALLET_ON_FOREIGN'] as bool) ?? false;
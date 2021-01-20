import 'package:flutter_dotenv/flutter_dotenv.dart';

final String foreignNetwork =
    int.parse(DotEnv().env['FOREIGN_PROVIDER_URL']) == 1
        ? 'mainnet'
        : 'ropsten';

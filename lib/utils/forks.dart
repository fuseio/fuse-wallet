import 'package:flutter_dotenv/flutter_dotenv.dart';

final String localDolarMXCommuntiyAddress =
    '0xe8f18ebe449a8f63435c2f3889afaee4625b3da3';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

bool isLocalDolarMX(String communityAddress) {
  return communityAddress != null && communityAddress == localDolarMXCommuntiyAddress;
}

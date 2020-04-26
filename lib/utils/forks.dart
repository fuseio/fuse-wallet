import 'package:flutter_dotenv/flutter_dotenv.dart';

bool isFork() {
  return DotEnv().env['FORK'] != null && DotEnv().env['FORK'] == 'true';
}

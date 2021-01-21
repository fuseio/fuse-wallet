import 'package:flutter_dotenv/flutter_dotenv.dart';

final int intervalSeconds = int.parse(DotEnv().env['INTERVAL_SECONDS']);

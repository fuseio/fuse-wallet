import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/utils/onboard/Istrategy.dart';
import 'package:injectable/injectable.dart';

@module
abstract class OnBoardStrategy {
  @lazySingleton
  IOnBoardStrategy get onBoardStrategy => OnBoardStrategyFactory.create(
        DotEnv().env['ON_BOARDING_STRATEGY'],
      );
}

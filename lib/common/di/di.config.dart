// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package_info.dart';
import 'package:phone_number/phone_number.dart';

import 'dio.dart';
import '../../services/apis/exchange.dart';
import 'firebase.dart';
import 'storage.dart';
import '../../services/apis/funder.dart';
import '../../utils/onboard/Istrategy.dart';
import '../../utils/log/log_it.dart';
import 'logger_di.dart';
import '../../services/apis/market.dart';
import 'onboard.dart';
import 'phone.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final dioDi = _$DioDi();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final flutterSecureStorageDi = _$FlutterSecureStorageDi();
  final onBoardStrategy = _$OnBoardStrategy();
  final loggerDi = _$LoggerDi();
  final packageInfoDi = _$PackageInfoDi();
  final phone = _$Phone();
  gh.lazySingleton<Dio>(() => dioDi.dio);
  gh.lazySingleton<Exchange>(() => Exchange(get<Dio>()));
  final resolvedFirebaseApp = await firebaseInjectableModule.firebaseApp;
  gh.factory<FirebaseApp>(() => resolvedFirebaseApp);
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<FlutterSecureStorage>(
      () => flutterSecureStorageDi.flutterSecureStorage);
  gh.lazySingleton<Funder>(() => Funder(get<Dio>()));
  gh.lazySingleton<IOnBoardStrategy>(() => onBoardStrategy.onBoardStrategy);
  gh.lazySingleton<Logger>(() => loggerDi.logger);
  gh.lazySingleton<Market>(() => Market(get<Dio>()));
  final resolvedPackageInfo = await packageInfoDi.packageInfo;
  gh.factory<PackageInfo>(() => resolvedPackageInfo);
  gh.lazySingleton<PhoneNumberUtil>(() => phone.phoneNumberUtil);
  gh.lazySingleton<LogIt>(() => LogIt(get<Logger>()));
  return get;
}

class _$DioDi extends DioDi {}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}

class _$FlutterSecureStorageDi extends FlutterSecureStorageDi {}

class _$OnBoardStrategy extends OnBoardStrategy {}

class _$LoggerDi extends LoggerDi {}

class _$PackageInfoDi extends PackageInfoDi {}

class _$Phone extends Phone {}

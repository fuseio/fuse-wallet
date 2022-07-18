// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart' as _i4;
import 'package:dio/dio.dart' as _i5;
import 'package:firebase_analytics/firebase_analytics.dart' as _i6;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i8;
import 'package:firebase_messaging/firebase_messaging.dart' as _i9;
import 'package:firebase_performance/firebase_performance.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i14;
import 'package:logger/logger.dart' as _i15;
import 'package:package_info/package_info.dart' as _i17;
import 'package:phone_number/phone_number.dart' as _i18;
import 'package:shared_preferences/shared_preferences.dart' as _i22;

import '../../network/network_info.dart' as _i16;
import '../../redux/store.dart' as _i19;
import '../../utils/alerts/alerts.dart' as _i23;
import '../../utils/alerts/alerts_helper.dart' as _i3;
import '../../utils/log/log_it.dart' as _i24;
import '../../utils/onboard/base_strategy.dart' as _i13;
import '../../utils/remote_config.dart' as _i20;
import '../helpers/flash_helper.dart' as _i11;
import '../helpers/flushbar_helper.dart' as _i12;
import '../network/services.dart' as _i25;
import '../router/routes.dart' as _i21;
import 'dio.dart' as _i26;
import 'firebase.dart' as _i27;
import 'logger_di.dart' as _i30;
import 'network_info_di.dart' as _i29;
import 'onboard.dart' as _i28;
import 'package_info.dart' as _i31;
import 'phone.dart' as _i32;
import 'redux_store.dart' as _i33;
import 'shared_preferences_di.dart'
    as _i34; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final servicesModule = _$ServicesModule();
  final dioDi = _$DioDi();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final onBoardStrategy = _$OnBoardStrategy();
  final networkInfoDi = _$NetworkInfoDi();
  final loggerDi = _$LoggerDi();
  final packageInfoDi = _$PackageInfoDi();
  final phone = _$Phone();
  final reduxServiceDi = _$ReduxServiceDi();
  final sharedPreferencesDi = _$SharedPreferencesDi();
  gh.lazySingleton<_i3.AlertsHelper>(() => _i3.AlertsHelper());
  gh.lazySingleton<_i4.ChargeApi>(() => servicesModule.chargeApi);
  gh.factory<_i5.Dio>(() => dioDi.dio);
  gh.lazySingleton<_i6.FirebaseAnalytics>(
      () => firebaseInjectableModule.firebaseAnalytics);
  gh.lazySingleton<_i7.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i8.FirebaseCrashlytics>(
      () => firebaseInjectableModule.firebaseCrashlytics);
  gh.lazySingleton<_i9.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  gh.lazySingleton<_i10.FirebasePerformance>(
      () => firebaseInjectableModule.firebasePerformance);
  gh.lazySingleton<_i11.FlashHelper>(() => _i11.FlashHelper());
  gh.lazySingleton<_i12.FlushbarHelper>(() => _i12.FlushbarHelper());
  gh.lazySingleton<_i4.FuseExplorer>(() => servicesModule.fuseExplorerAPI);
  gh.lazySingleton<_i4.Graph>(() => servicesModule.graph);
  gh.lazySingleton<_i13.IOnBoardStrategy>(
      () => onBoardStrategy.onBoardStrategy);
  gh.lazySingleton<_i14.InternetConnectionChecker>(
      () => networkInfoDi.dataConnectionChecker);
  gh.lazySingleton<_i15.Logger>(() => loggerDi.logger);
  gh.lazySingleton<_i16.NetworkInfo>(
      () => _i16.NetworkInfo(get<_i14.InternetConnectionChecker>()));
  await gh.factoryAsync<_i17.PackageInfo>(() => packageInfoDi.packageInfo,
      preResolve: true);
  gh.lazySingleton<_i18.PhoneNumberUtil>(() => phone.phoneNumberUtil);
  await gh.factoryAsync<_i19.ReduxService>(() => reduxServiceDi.reduxService,
      preResolve: true);
  await gh.factoryAsync<_i20.RemoteConfigService>(
      () => firebaseInjectableModule.remoteConfigService,
      preResolve: true);
  gh.lazySingleton<_i21.RootRouter>(() => servicesModule.rootRouter);
  await gh.factoryAsync<_i22.SharedPreferences>(
      () => sharedPreferencesDi.sharedPreferences,
      preResolve: true);
  gh.lazySingleton<_i23.Alerts>(
      () => _i23.Alerts(get<_i3.AlertsHelper>(), get<_i12.FlushbarHelper>()));
  gh.lazySingleton<_i24.LogIt>(() => _i24.LogIt(get<_i15.Logger>()));
  return get;
}

class _$ServicesModule extends _i25.ServicesModule {}

class _$DioDi extends _i26.DioDi {}

class _$FirebaseInjectableModule extends _i27.FirebaseInjectableModule {}

class _$OnBoardStrategy extends _i28.OnBoardStrategy {}

class _$NetworkInfoDi extends _i29.NetworkInfoDi {}

class _$LoggerDi extends _i30.LoggerDi {}

class _$PackageInfoDi extends _i31.PackageInfoDi {}

class _$Phone extends _i32.Phone {}

class _$ReduxServiceDi extends _i33.ReduxServiceDi {}

class _$SharedPreferencesDi extends _i34.SharedPreferencesDi {}

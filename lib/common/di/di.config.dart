// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_core/firebase_core.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i10;
import 'package:package_info/package_info.dart' as _i11;
import 'package:phone_number/phone_number.dart' as _i12;
import 'package:wallet_core/wallet_core.dart' as _i3;

import '../../services/apis/explorer.dart' as _i5;
import '../../services/apis/fuseswap.dart' as _i8;
import '../../utils/log/log_it.dart' as _i14;
import '../../utils/onboard/Istrategy.dart' as _i9;
import '../network/services.dart' as _i15;
import '../router/routes.dart' as _i13;
import 'dio.dart' as _i16;
import 'firebase.dart' as _i17;
import 'logger_di.dart' as _i19;
import 'onboard.dart' as _i18;
import 'package_info.dart' as _i20;
import 'phone.dart' as _i21; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final servicesModule = _$ServicesModule();
  final dioDi = _$DioDi();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final onBoardStrategy = _$OnBoardStrategy();
  final loggerDi = _$LoggerDi();
  final packageInfoDi = _$PackageInfoDi();
  final phone = _$Phone();
  gh.lazySingleton<_i3.API>(() => servicesModule.api);
  gh.factory<_i4.Dio>(() => dioDi.dio);
  gh.factoryParam<_i5.Explorer, String?, String?>(
      (base, apiKey) => _i5.Explorer(get<_i4.Dio>(), base, apiKey));
  await gh.factoryAsync<_i6.FirebaseApp>(
      () => firebaseInjectableModule.firebaseApp,
      preResolve: true);
  gh.lazySingleton<_i7.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i8.FuseSwapService>(
      () => _i8.FuseSwapService(get<_i4.Dio>()));
  gh.lazySingleton<_i3.Graph>(() => servicesModule.graph);
  gh.lazySingleton<_i9.IOnBoardStrategy>(() => onBoardStrategy.onBoardStrategy);
  gh.lazySingleton<_i10.Logger>(() => loggerDi.logger);
  await gh.factoryAsync<_i11.PackageInfo>(() => packageInfoDi.packageInfo,
      preResolve: true);
  gh.lazySingleton<_i12.PhoneNumberUtil>(() => phone.phoneNumberUtil);
  gh.lazySingleton<_i13.RootRouter>(() => servicesModule.rootRouter);
  gh.lazySingleton<_i3.WalletApi>(() => servicesModule.walletApi);
  gh.lazySingleton<_i14.LogIt>(() => _i14.LogIt(get<_i10.Logger>()));
  return get;
}

class _$ServicesModule extends _i15.ServicesModule {}

class _$DioDi extends _i16.DioDi {}

class _$FirebaseInjectableModule extends _i17.FirebaseInjectableModule {}

class _$OnBoardStrategy extends _i18.OnBoardStrategy {}

class _$LoggerDi extends _i19.LoggerDi {}

class _$PackageInfoDi extends _i20.PackageInfoDi {}

class _$Phone extends _i21.Phone {}

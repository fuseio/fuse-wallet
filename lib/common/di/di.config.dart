// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i7;
import 'package:firebase_core/firebase_core.dart' as _i6;
import 'package:firebase_messaging/firebase_messaging.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i11;
import 'package:package_info/package_info.dart' as _i13;
import 'package:phone_number/phone_number.dart' as _i14;
import 'package:wallet_core/wallet_core.dart' as _i3;

import '../../services/apis/explorer.dart' as _i5;
import '../../services/apis/fuseswap.dart' as _i9;
import '../../services/apis/market.dart' as _i12;
import '../../utils/log/log_it.dart' as _i15;
import '../../utils/onboard/Istrategy.dart' as _i10;
import '../network/services.dart' as _i17;
import '../network/web3.dart' as _i24;
import '../router/routes.dart' as _i16;
import 'dio.dart' as _i18;
import 'firebase.dart' as _i19;
import 'logger_di.dart' as _i21;
import 'onboard.dart' as _i20;
import 'package_info.dart' as _i22;
import 'phone.dart' as _i23; // ignore_for_file: unnecessary_lambdas

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
  final web3Di = _$Web3Di();
  gh.lazySingleton<_i3.API>(() => servicesModule.api);
  gh.factory<_i4.Dio>(() => dioDi.dio);
  gh.factoryParam<_i5.Explorer, String?, String?>(
      (base, apiKey) => _i5.Explorer(get<_i4.Dio>(), base, apiKey));
  await gh.factoryAsync<_i6.FirebaseApp>(
      () => firebaseInjectableModule.firebaseApp,
      preResolve: true);
  gh.lazySingleton<_i7.FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<_i8.FirebaseMessaging>(
      () => firebaseInjectableModule.firebaseMessaging);
  gh.lazySingleton<_i9.FuseSwapService>(
      () => _i9.FuseSwapService(get<_i4.Dio>()));
  gh.lazySingleton<_i3.Graph>(() => servicesModule.graph);
  gh.lazySingleton<_i10.IOnBoardStrategy>(
      () => onBoardStrategy.onBoardStrategy);
  gh.lazySingleton<_i11.Logger>(() => loggerDi.logger);
  gh.lazySingleton<_i12.Market>(() => _i12.Market(get<_i4.Dio>()));
  await gh.factoryAsync<_i13.PackageInfo>(() => packageInfoDi.packageInfo,
      preResolve: true);
  gh.lazySingleton<_i14.PhoneNumberUtil>(() => phone.phoneNumberUtil);
  gh.factory<String>(() => web3Di.defaultCommunityAddress,
      instanceName: 'defaultCommunityAddress');
  gh.factoryParam<_i3.Web3, Map<dynamic, dynamic>?, dynamic>(
      (walletModules, _) => web3Di.fuseWeb3(
          get<String>(instanceName: 'defaultCommunityAddress'), walletModules),
      instanceName: 'fuseWeb3');
  gh.factoryParam<_i3.Web3, Map<dynamic, dynamic>?, dynamic>(
      (walletModules, _) => web3Di.ethereumWeb3(
          get<String>(instanceName: 'defaultCommunityAddress'), walletModules),
      instanceName: 'ethereumWeb3');
  gh.lazySingleton<_i15.LogIt>(() => _i15.LogIt(get<_i11.Logger>()));
  gh.singleton<_i16.RootRouter>(servicesModule.roovtRouter);
  return get;
}

class _$ServicesModule extends _i17.ServicesModule {}

class _$DioDi extends _i18.DioDi {}

class _$FirebaseInjectableModule extends _i19.FirebaseInjectableModule {}

class _$OnBoardStrategy extends _i20.OnBoardStrategy {}

class _$LoggerDi extends _i21.LoggerDi {}

class _$PackageInfoDi extends _i22.PackageInfoDi {}

class _$Phone extends _i23.Phone {}

class _$Web3Di extends _i24.Web3Di {}

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package_info.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

import 'dio.dart';
import '../../services/apis/exchange.dart';
import 'firebase.dart';
import '../../services/apis/funder.dart';
import '../../utils/onboard/Istrategy.dart';
import '../../utils/log/log_it.dart';
import 'logger_di.dart';
import '../../services/apis/market.dart';
import 'onboard.dart';
import 'phone.dart';
import '../network/services.dart';
import '../network/web3.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final servicesModule = _$ServicesModule();
  final dioDi = _$DioDi();
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  final onBoardStrategy = _$OnBoardStrategy();
  final loggerDi = _$LoggerDi();
  final packageInfoDi = _$PackageInfoDi();
  final phone = _$Phone();
  final web3Module = _$Web3Module();
  gh.lazySingleton<API>(() => servicesModule.api);
  gh.lazySingleton<Dio>(() => dioDi.dio);
  gh.lazySingleton<Exchange>(() => Exchange(get<Dio>()));
  final resolvedFirebaseApp = await firebaseInjectableModule.firebaseApp;
  gh.factory<FirebaseApp>(() => resolvedFirebaseApp);
  gh.lazySingleton<FirebaseAuth>(() => firebaseInjectableModule.firebaseAuth);
  gh.lazySingleton<Funder>(() => Funder(get<Dio>()));
  gh.lazySingleton<Graph>(() => servicesModule.graph);
  gh.lazySingleton<IOnBoardStrategy>(() => onBoardStrategy.onBoardStrategy);
  gh.lazySingleton<Logger>(() => loggerDi.logger);
  gh.lazySingleton<Market>(() => Market(get<Dio>()));
  final resolvedPackageInfo = await packageInfoDi.packageInfo;
  gh.factory<PackageInfo>(() => resolvedPackageInfo);
  gh.lazySingleton<PhoneNumberUtil>(() => phone.phoneNumberUtil);
  gh.factory<String>(() => web3Module.fuseRpcUrl, instanceName: 'fuseRpcUrl');
  gh.factory<String>(() => web3Module.ethereumRpcUrl,
      instanceName: 'ethereumRpcUrl');
  gh.factory<String>(() => web3Module.defaultCommunityAddress,
      instanceName: 'defaultCommunityAddress');
  gh.factory<String>(() => web3Module.communityManagerAddress,
      instanceName: 'communityManagerAddress');
  gh.factory<String>(() => web3Module.transferManagerAddress,
      instanceName: 'transferManagerAddress');
  gh.factory<String>(() => web3Module.daiPointsManagerAddress,
      instanceName: 'daiPointsManagerAddress');
  gh.factory<int>(() => web3Module.fuseNetworkId,
      instanceName: 'fuseNetworkId');
  gh.factory<int>(() => web3Module.ethereumNetworkId,
      instanceName: 'ethereumNetworkId');
  gh.lazySingleton<LogIt>(() => LogIt(get<Logger>()));
  gh.lazySingleton<Web3>(
      () => web3Module.homeWeb3(
            get<String>(instanceName: 'fuseRpcUrl'),
            get<int>(instanceName: 'fuseNetworkId'),
            get<String>(instanceName: 'defaultCommunityAddress'),
            get<String>(instanceName: 'communityManagerAddress'),
            get<String>(instanceName: 'transferManagerAddress'),
            get<String>(instanceName: 'daiPointsManagerAddress'),
          ),
      instanceName: 'homeWeb3');
  gh.lazySingleton<Web3>(
      () => web3Module.foreignWeb3(
            get<String>(instanceName: 'ethereumRpcUrl'),
            get<int>(instanceName: 'ethereumNetworkId'),
            get<String>(instanceName: 'defaultCommunityAddress'),
            get<String>(instanceName: 'communityManagerAddress'),
            get<String>(instanceName: 'transferManagerAddress'),
            get<String>(instanceName: 'daiPointsManagerAddress'),
          ),
      instanceName: 'foreignWeb3');
  return get;
}

class _$ServicesModule extends ServicesModule {}

class _$DioDi extends DioDi {}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}

class _$OnBoardStrategy extends OnBoardStrategy {}

class _$LoggerDi extends LoggerDi {}

class _$PackageInfoDi extends PackageInfoDi {}

class _$Phone extends Phone {}

class _$Web3Module extends Web3Module {}

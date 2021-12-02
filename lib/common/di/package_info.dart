import 'package:supervecina/common/di/di.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info/package_info.dart';

@module
abstract class PackageInfoDi {
  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}

final PackageInfo packageInfo = getIt<PackageInfo>();

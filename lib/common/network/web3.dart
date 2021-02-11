import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart' show Web3;

Future<bool> approvalCallback() async {
  return true;
}

@module
abstract class Web3Module {
  @Named('fuseNetworkId')
  int get fuseNetworkId => Variables.FUSE_CHAIN_ID;
  @Named('ethereumNetworkId')
  int get ethereumNetworkId => int.parse(DotEnv().env['FOREIGN_NETWORK_ID']);
  @Named('fuseRpcUrl')
  String get fuseRpcUrl => UrlConstants.FUSE_RPC_URL;
  @Named('ethereumRpcUrl')
  String get ethereumRpcUrl => DotEnv().env['FOREIGN_PROVIDER_URL'];
  @Named('defaultCommunityAddress')
  String get defaultCommunityAddress =>
      DotEnv().env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'];
  @Named('communityManagerAddress')
  String get communityManagerAddress =>
      DotEnv().env['COMMUNITY_MANAGER_CONTRACT_ADDRESS'];
  @Named('transferManagerAddress')
  String get transferManagerAddress =>
      DotEnv().env['TRANSFER_MANAGER_CONTRACT_ADDRESS'];
  @Named('daiPointsManagerAddress')
  String get daiPointsManagerAddress =>
      DotEnv().env['DAI_POINTS_MANAGER_CONTRACT_ADDRESS'];

  @Named('homeWeb3')
  @lazySingleton
  Web3 homeWeb3(
    @Named('fuseRpcUrl') String url,
    @Named('fuseNetworkId') int networkId,
    @Named('defaultCommunityAddress') String defaultCommunityAddress,
    @Named('communityManagerAddress') String communityManagerAddress,
    @Named('transferManagerAddress') String transferManagerAddress,
    @Named('daiPointsManagerAddress') String daiPointsManagerAddress,
  ) =>
      Web3(
        approvalCallback,
        url: url,
        networkId: networkId,
        defaultCommunityAddress: defaultCommunityAddress,
        communityManagerAddress: communityManagerAddress,
        transferManagerAddress: transferManagerAddress,
        daiPointsManagerAddress: daiPointsManagerAddress,
      );

  @Named('foreignWeb3')
  @lazySingleton
  Web3 foreignWeb3(
    @Named('ethereumRpcUrl') String url,
    @Named('ethereumNetworkId') int networkId,
    @Named('defaultCommunityAddress') String defaultCommunityAddress,
    @Named('communityManagerAddress') String communityManagerAddress,
    @Named('transferManagerAddress') String transferManagerAddress,
    @Named('daiPointsManagerAddress') String daiPointsManagerAddress,
  ) =>
      Web3(
        approvalCallback,
        url: url,
        networkId: networkId,
        defaultCommunityAddress: defaultCommunityAddress,
        communityManagerAddress: communityManagerAddress,
        transferManagerAddress: transferManagerAddress,
        daiPointsManagerAddress: daiPointsManagerAddress,
      );
}

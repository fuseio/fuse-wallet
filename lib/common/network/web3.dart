import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart' show Web3;

Future<bool> approvalCallback() async {
  return true;
}

@module
abstract class Web3Di {
  @Named('defaultCommunityAddress')
  String get defaultCommunityAddress =>
      dotenv.env['DEFAULT_COMMUNITY_CONTRACT_ADDRESS'] ??
      '0xEe289be8bE686ca6Ca334683306C6dA6CdAD379C';

  @Named('fuseWeb3')
  @injectable
  Web3 fuseWeb3(
    @Named('defaultCommunityAddress') String defaultCommunityAddress,
    @factoryParam Map? walletModules,
  ) =>
      Web3(
        approveCb: approvalCallback,
        url: UrlConstants.FUSE_RPC_URL,
        networkId: Variables.FUSE_CHAIN_ID,
        defaultCommunityAddress: defaultCommunityAddress,
        communityManagerAddress: walletModules?['communityManager'],
        transferManagerAddress: walletModules?['transferManager'],
        daiPointsManagerAddress: walletModules?['dAIPointsManager'],
      );

  @Named('ethereumWeb3')
  @injectable
  Web3 ethereumWeb3(
    @Named('defaultCommunityAddress') String defaultCommunityAddress,
    @factoryParam Map? walletModules,
  ) =>
      Web3(
        approveCb: approvalCallback,
        url: dotenv.env['FOREIGN_PROVIDER_URL']!,
        networkId: int.parse(dotenv.env['FOREIGN_NETWORK_ID']!),
        defaultCommunityAddress: defaultCommunityAddress,
        communityManagerAddress: walletModules?['communityManager'],
        transferManagerAddress: walletModules?['transferManager'],
        daiPointsManagerAddress: walletModules?['dAIPointsManager'],
      );
}

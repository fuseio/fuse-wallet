import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/common/router/route_guards.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet_core/wallet_core.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  Graph get graph => Graph(
        dotenv.env['GRAPH_BASE_URL']!,
        dotenv.env['NFT_SUB_GRAPH_URL'] ??
            'https://api.thegraph.com/subgraphs/name/fuseio/fuse-nft',
      );

  @lazySingleton
  API get api => API(
        dotenv.env['API_BASE_URL']!,
      );

  @lazySingleton
  WalletApi get walletApi => WalletApi(
        dotenv.env['WALLET_API_BASE_URL']!,
      );

  @lazySingleton
  RootRouter get rootRouter => RootRouter(authGuard: AuthGuard());
}

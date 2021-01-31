import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fusecash/services/swap_service.dart';
import 'package:http/http.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

final SwapService swapService = SwapService();

final Exchange exchangeApi = Exchange();

final Client client = Client();

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final API api = API(
    base: DotEnv().env['API_BASE_URL'],
    funderBase: DotEnv().env['FUNDER_BASE_URL']);

final Graph graph = Graph(
    url: DotEnv().env['GRAPH_BASE_URL'], subGraph: DotEnv().env['SUB_GRAPH']);

final ExplorerApi ethereumExplorerApi = ExplorerApi(
    base: DotEnv().env['ETHERSCAN_BASE_URL'],
    apiKey: DotEnv().env['ETHERSCAN_API_KEY']);

final ExplorerApi fuseExplorerApi =
    ExplorerApi(base: DotEnv().env['FUSE_RPC_URL']);

final MarketApi marketApi = MarketApi();

final PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil();

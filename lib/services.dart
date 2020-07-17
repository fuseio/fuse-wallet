import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:phone_number/phone_number.dart';
import 'package:wallet_core/wallet_core.dart';

final Exchange exchangeApi = new Exchange();

final Client client = new Client();

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

final API api = new API(
    base: DotEnv().env['API_BASE_URL'],
    funderBase: DotEnv().env['FUNDER_BASE_URL']);

final Graph graph = new Graph(
    url: DotEnv().env['GRAPH_BASE_URL'], subGraph: DotEnv().env['SUB_GRAPH']);

final TokensApi tokenAPI = new TokensApi(
    etherscanBase: DotEnv().env['ETHERSCAN_BASE_URL'],
    etherscanApiKey: DotEnv().env['ETHERSCAN_API_KEY']);

final MarketApi marketApi = new MarketApi();

final PhoneNumber phoneNumberUtil = new PhoneNumber();

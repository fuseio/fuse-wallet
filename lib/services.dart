import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:wallet_core/wallet_core.dart';

final API api = new API(base: DotEnv().env['API_BASE_URL'], funderBase: DotEnv().env['FUNDER_BASE_URL']);

final Client client = new Client();

final Graph graph = new Graph(url: DotEnv().env['GRAPH_BASE_URL'], subGraph: DotEnv().env['SUB_GRAPH']);

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
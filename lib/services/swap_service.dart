import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:wallet_core/models/api.dart';

class SwapService extends Api {
  String _base;
  Client _client;

  SwapService({String base = 'https://service.fuseswap.com/api/v1/swap'}) {
    _base = base;
    _client = new Client();
  }

  Future<Map<String, dynamic>> _get(String endpoint) async {
    print('SwapService - GET $_base/$endpoint');
    Response response = await _client.get('$_base/$endpoint');
    return responseHandler(response);
  }

  Future<Map<String, dynamic>> _post(String endpoint, {Map body}) async {
    print('SwapService - POST $_base/$endpoint');
    print(json.encode(body));
    Response response = await _client.post('$_base/$endpoint',
        headers: {"Content-Type": 'application/json'}, body: json.encode(body));
    return responseHandler(response);
  }

  Future<Map<String, dynamic>> swapCallParameters(String currIn, String currOut, String amountIn, String recipient) async {
    Map body = Map.from({
      'currencyIn': currIn,
      'currencyOut': currOut,
      'amountIn': amountIn,
      'recipient': recipient,
    });

    Map<String, dynamic> response = await _post('swapcallparameters', body: body);
    return response;
  }
}

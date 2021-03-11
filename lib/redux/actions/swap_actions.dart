import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/urls.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class FetchTokenList {
  final List<Token> fetchSwapList;
  FetchTokenList({this.fetchSwapList});
}

ThunkAction fetchSwapList() {
  return (Store store) async {
    try {
      final dio = getIt<Dio>();
      String address = store.state.userState.walletAddress;
      Response<String> response =
          await dio.get(UrlConstants.FUSESWAP_TOKEN_LIST);
      Map data = jsonDecode(response.data);
      List<Token> tokens = [];
      for (dynamic token in data['tokens']) {
        final BigInt balance = await fuseWeb3.getTokenBalance(
          token['address'],
          address: address,
        );
        tokens.add(
          Token.fromJson({
            "originNetwork": 'mainnet',
            "amount": balance.toString(),
            "address": token['address'].toLowerCase(),
            "decimals": token['decimals'],
            "name": formatTokenName(token["name"]),
            "symbol": token['symbol'],
            "imageUrl": token['logoURI'],
          }),
        );
      }
      store.dispatch(FetchTokenList(fetchSwapList: tokens));
    } catch (e) {
      log.error('ERROR - fetchTokenList $e');
    }
  };
}

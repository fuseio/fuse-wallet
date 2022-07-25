import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:charge_wallet_sdk/charge_wallet_sdk.dart';
import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_connect/wallet_connect.dart';

import 'package:fusecash/common/di/di.dart';
import 'package:fusecash/constants/analytics_events.dart';
import 'package:fusecash/constants/analytics_props.dart';
import 'package:fusecash/constants/variables.dart';
import 'package:fusecash/models/actions/actions.dart';
import 'package:fusecash/models/actions/wallet_action.dart';
import 'package:fusecash/models/cash_wallet_state.dart';
import 'package:fusecash/models/tokens/price.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/network/network_info.dart';
import 'package:fusecash/redux/actions/nft_actions.dart';
import 'package:fusecash/redux/actions/swap_actions.dart';
import 'package:fusecash/redux/actions/user_actions.dart';
import 'package:fusecash/services.dart';
import 'package:fusecash/utils/analytics/analytics.dart';
import 'package:fusecash/utils/constants.dart';
import 'package:fusecash/utils/crashlytics.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/utils/log/log.dart';

bool clearTokensWithZero(key, token) {
  if (token.timestamp == 0) return false;
  double formattedValue = token.amount / BigInt.from(pow(10, token.decimals));
  return num.parse(formattedValue.toString()).compareTo(0) != 1;
}

class AddSession {
  final WCSessionStore session;

  AddSession(this.session);
}

class RemoveSession {
  final WCSessionStore session;

  RemoveSession(this.session);
}

class AddCashTokens {
  final Map<String, Token> tokens;

  AddCashTokens({
    required this.tokens,
  });
}

class AddCashToken {
  final Token token;

  AddCashToken({
    required this.token,
  });
}

class UpdateTokenPrice {
  final Price price;
  final String tokenAddress;

  UpdateTokenPrice({
    required this.price,
    required this.tokenAddress,
  });
}

class GetWalletDataSuccess {
  final List<String> networks;
  final String walletAddress;
  final bool backup;
  final WalletModules walletModules;
  final String? contractVersion;

  GetWalletDataSuccess({
    required this.contractVersion,
    required this.backup,
    required this.networks,
    required this.walletAddress,
    required this.walletModules,
  });
}

class GetTokenBalanceSuccess {
  final String tokenAddress;
  final BigInt tokenBalance;

  GetTokenBalanceSuccess({
    required this.tokenBalance,
    required this.tokenAddress,
  });
}

class GetTokenIntervalStatsSuccess {
  final String tokenAddress;
  final List<IntervalStats> intervalStats;
  final TimeFrame timeFrame;
  final num priceChange;

  GetTokenIntervalStatsSuccess({
    required this.intervalStats,
    required this.tokenAddress,
    required this.timeFrame,
    required this.priceChange,
  });
}

class GetActionsSuccess {
  final List<WalletAction> walletActions;
  final int? nextPage;

  GetActionsSuccess({
    required this.walletActions,
    this.nextPage,
  });
}

class GetTokenWalletActionsSuccess {
  final Token token;
  final List<WalletAction> walletActions;
  final num updateAt;
  final int? nextPage;

  GetTokenWalletActionsSuccess({
    required this.updateAt,
    required this.walletActions,
    required this.token,
    this.nextPage,
  });
}

class StartBalanceFetchingSuccess {
  StartBalanceFetchingSuccess();
}

class SetIsTransfersFetching {
  final bool isFetching;

  SetIsTransfersFetching({
    required this.isFetching,
  });
}

class ResetTokenTxs {
  ResetTokenTxs();
}

class SetIsFetchingBalances {
  final bool isFetching;

  SetIsFetchingBalances({
    required this.isFetching,
  });
}

class FetchNewPage {
  final int page;
  FetchNewPage({required this.page});
}

ThunkAction enablePushNotifications(String walletAddress) {
  return (Store store) async {
    try {
      await getIt<FirebaseMessaging>().requestPermission(
        sound: true,
        badge: true,
        alert: true,
      );
      final String? token = await getIt<FirebaseMessaging>().getToken();
      if (token != null) {
        log.info("Firebase messaging token $token");
        await chargeApi.updateFirebaseToken(walletAddress, token);
      }
    } catch (e) {
      log.error('ERROR - Enable push notifications: $e');
    }
  };
}

ThunkAction startFetchTokensBalances() {
  return (Store store) async {
    final bool isFetchingBalances =
        store.state.cashWalletState.isFetchingBalances ?? false;
    final String walletAddress = store.state.userState.walletAddress;
    if (!isFetchingBalances) {
      log.info('Start Fetching token balances');
      Timer.periodic(const Duration(seconds: Variables.intervalSeconds),
          (Timer timer) async {
        String currentWalletAddress = store.state.userState.walletAddress;
        if (currentWalletAddress != walletAddress) {
          log.error('Timer stopped - startFetchTokensBalances');
          store.dispatch(SetIsFetchingBalances(isFetching: false));
          timer.cancel();
        } else {
          final NetworkInfo networkInfo = getIt<NetworkInfo>();
          if (await networkInfo.isConnected) {
            try {
              Map<String, Token> tokens = store.state.cashWalletState.tokens;
              store.dispatch(getFuseBalance());
              for (Token token in tokens.values) {
                await token.fetchBalance(
                  walletAddress,
                  onDone: (balance) {
                    if (balance.compareTo(token.amount) != 0) {
                      store.dispatch(
                        GetTokenBalanceSuccess(
                          tokenBalance: balance,
                          tokenAddress: token.address,
                        ),
                      );
                    }
                  },
                  onError: (
                    Object e,
                    StackTrace s,
                  ) {
                    log.error(
                      'Error - fetch token balance ${token.name}',
                      error: e,
                      stackTrace: s,
                    );
                  },
                );
              }
            } catch (e, s) {
              Crashlytics.recordError(
                Exception('Error fetch tokens balances - ${e.toString()}'),
                s,
                reason: 'Error fetch tokens balances',
              );
            }
          } else {
            log.error("Looks like you're offline");
          }
        }
      });
      store.dispatch(SetIsFetchingBalances(isFetching: true));
    }
  };
}

ThunkAction startFetchingCall() {
  return (Store store) async {
    bool isTransfersFetchingStarted =
        store.state.cashWalletState.isTransfersFetchingStarted ?? false;
    final String walletAddress = store.state.userState.walletAddress;
    if (!isTransfersFetchingStarted) {
      store.dispatch(fetchSwapList());
      store.dispatch(fetchCollectibles());
      store.dispatch(SetIsTransfersFetching(isFetching: true));
      Timer.periodic(
        const Duration(seconds: Variables.intervalSeconds),
        (Timer t) async {
          String currentWalletAddress = store.state.userState.walletAddress;
          if (currentWalletAddress != walletAddress) {
            log.error('Timer stopped - startFetchingCall');
            store.dispatch(SetIsTransfersFetching(isFetching: false));
            t.cancel();
            return;
          }
          final NetworkInfo networkInfo = getIt<NetworkInfo>();
          if (await networkInfo.isConnected) {
            store.dispatch(fetchTokenList());
            CashWalletState cashWalletState = store.state.cashWalletState;
            final List<WalletAction> walletActions = [
              ...cashWalletState.walletActions?.list ?? []
            ];
            if (walletActions.isNotEmpty) {
              try {
                Map<String, dynamic> res =
                    await chargeApi.getActionsByWalletAddress(
                  walletAddress,
                  updatedAt: walletActions.last.timestamp + 1,
                );
                Iterable<dynamic> docs = res['docs'] ?? [];
                if (docs.isNotEmpty) {
                  store.dispatch(getWalletActionsCall(pageIndex: 1));
                }
              } catch (e, s) {
                log.error(
                  'ERROR startFetchingCall',
                  error: e,
                  stackTrace: s,
                );
              }
            } else {
              store.dispatch(getWalletActionsCall(pageIndex: 1));
            }
          } else {
            log.error("Looks like you're offline");
          }
        },
      );
    }
  };
}

ThunkAction createAccountWalletCall() {
  return (Store store) async {
    try {
      final prefs = getIt<SharedPreferences>();
      Map<String, dynamic> response = await chargeApi.createWallet(
        referralAddress: prefs.getString('referral'),
      );
      if (!response.containsKey('job')) {
        log.info('Wallet already exists');
        final Map<String, dynamic> data = Map<String, dynamic>.from({
          ...response,
        });
        store.dispatch(generateWalletSuccessCall(data));
      } else {
        final Map jobData = response['job']['data'];
        Map<String, dynamic> walletData = Map<String, dynamic>.from({
          ...jobData,
          'networks': ['fuse'],
        });
        store.dispatch(generateWalletSuccessCall(walletData));
      }
    } catch (e, s) {
      log.error(
        'ERROR - createAccountWalletCal',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Error in Create Wallet: ${e.toString()}'),
        s,
        reason: 'Error in Create Wallet',
      );
    }
  };
}

ThunkAction generateWalletSuccessCall(Map<String, dynamic> walletData) {
  return (Store store) async {
    String? walletAddress = walletData["walletAddress"];
    log.info('walletAddress walletAddress $walletAddress');
    if (walletAddress != null && walletAddress.isNotEmpty) {
      store.dispatch(enablePushNotifications(walletAddress));
      store.dispatch(setupWalletCall(walletData));
      store.dispatch(saveUserProfile(walletAddress));
      store.dispatch(identifyCall(wallet: walletAddress));
    }
  };
}

ThunkAction inviteAndSendCall(
  Token token,
  String contactPhoneNumber,
  String tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String senderName = store.state.userState.displayName;
      final response = await chargeApi.invite(
        contactPhoneNumber,
        name: senderName,
        amount: tokensAmount.toString(),
        symbol: token.symbol,
      );
      final String receiverAddress = response['job']['data']["walletAddress"];
      store.dispatch(
        sendTokenCall(
          token,
          receiverAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ),
      );
      store.dispatch(loadContacts());
    } catch (e, s) {
      log.error(
        'ERROR - inviteAndSendCall',
        error: e,
        stackTrace: s,
      );
      Crashlytics.recordError(
        Exception('Invite user & send token: ${e.toString()}'),
        s,
        reason: 'ERROR while trying to invite user & send',
      );
    }
  };
}

ThunkAction fetchTokenList() {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      TokenList tokensList = await getIt<FuseExplorer>().getTokenList(
        walletAddress,
      );
      CashWalletState cashWalletState = store.state.cashWalletState;
      Map<String, Token> newTokens =
          tokensList.result.whereType<ERC20>().fold<Map<String, Token>>(
        {},
        (Map<String, Token> previousValue, ERC20 element) {
          final Token token = Token(
            address: element.address,
            name: element.name,
            symbol: element.symbol,
            amount: element.amount,
            decimals: element.decimals,
          );
          if (!cashWalletState.tokens.containsKey(element.address) &&
              num.parse(token.getBalance(true)).compareTo(0) == 1) {
            log.info('New token added ${element.name}');
            previousValue[element.address] = token;
          }
          return previousValue;
        },
      );
      if (newTokens.isNotEmpty) {
        store.dispatch(AddCashTokens(tokens: newTokens));
        Future.delayed(const Duration(seconds: Variables.intervalSeconds), () {
          store.dispatch(updateTokensPrices());
        });
      }
    } catch (e, s) {
      log.error(
        'ERROR - fetchTokenList',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction sendNativeTokenCall(
  String receiverAddress,
  String tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      final BigInt amount = Formatter.toBigInt(tokensAmount, 18);
      final Map transactionBody = Map.from({
        "status": 'pending',
        "from": walletAddress,
        "to": receiverAddress,
        "value": amount.toString(),
        'type': 'SEND',
        "asset": fuseToken.symbol,
        'tokenName': fuseToken.name,
        "tokenSymbol": fuseToken.symbol,
        'tokenDecimal': fuseToken.decimals,
        'tokenAddress': fuseToken.address,
      });
      dynamic response = await chargeApi.transfer(
        getIt<Web3>(),
        walletAddress,
        receiverAddress,
        amountInWei: amount,
        transactionBody: transactionBody,
      );

      dynamic jobId = response['job']['_id'];
      Analytics.identify({
        AnalyticsProps.fundSending: true,
      });
      store.dispatch(
        fetchJobCall(
          jobId,
          (Map jobData) {
            Analytics.track(
              eventName: AnalyticsEvents.send4Approve,
              properties: {"status": "success"},
            );
          },
          (dynamic failReason) {
            Analytics.track(
              eventName: AnalyticsEvents.send4Approve,
              properties: {
                "status": "failed",
                'failReason': failReason,
              },
            );
          },
        ),
      );
      log.info('sendNativeTokenCall');
      log.info('Job $jobId for sending native token sent to the relay service');

      sendSuccessCallback();
    } catch (e, s) {
      log.error(
        'ERROR - sendNativeTokenCall',
        error: e,
        stackTrace: s,
      );
      sendFailureCallback();
      Crashlytics.recordError(
        Exception('Send native (FUSE) token: ${e.toString()}'),
        s,
        reason: 'Send native (FUSE) token',
      );
    }
  };
}

ThunkAction sendTokenCall(
  Token token,
  String receiverAddress,
  String tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      String walletAddress = store.state.userState.walletAddress;
      if (token.isNative) {
        store.dispatch(sendNativeTokenCall(
          receiverAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      } else {
        log.info(
            'Sending ${token.name} $tokensAmount from $walletAddress to $receiverAddress');
        dynamic response = await chargeApi.tokenTransfer(
          getIt<Web3>(),
          walletAddress,
          token.address,
          receiverAddress,
          tokensAmount: tokensAmount,
        );
        Analytics.identify({
          AnalyticsProps.fundSending: true,
        });

        dynamic jobId = response['job']['_id'];
        log.info('Job $jobId for sending token sent to the relay service');
        store.dispatch(
          fetchJobCall(
            jobId,
            (Map jobData) {
              Analytics.track(
                eventName: AnalyticsEvents.send4Approve,
                properties: {"status": "success"},
              );
            },
            (dynamic failReason) {
              Analytics.track(
                eventName: AnalyticsEvents.send4Approve,
                properties: {
                  "status": "failed",
                  'failReason': failReason,
                },
              );
            },
          ),
        );
        sendSuccessCallback();
      }
    } catch (e, s) {
      log.error(
        'ERROR - sendTokenCall',
        error: e,
        stackTrace: s,
      );
      sendFailureCallback();
      Crashlytics.recordError(
        Exception('Send token: ${e.toString()}'),
        s,
        reason: 'Send token',
      );
    }
  };
}

ThunkAction getWalletActionsCall({
  int? pageIndex,
  VoidCallback? onSuccess,
}) {
  return (Store store) async {
    try {
      final String walletAddress = store.state.userState.walletAddress;
      final WalletActions walletActions =
          store.state.cashWalletState.walletActions;
      final Map<String, dynamic> response =
          await chargeApi.getPaginatedActionsByWalletAddress(
        walletAddress,
        pageIndex ?? walletActions.currentPage,
      );
      final Iterable<dynamic> docs = response['docs'] ?? [];
      final bool hasNextPage = response['hasNextPage'];
      final int nextPage = response['nextPage'] ?? 1;
      List<WalletAction> actions = WalletAction.actionsFromJson(docs);
      List<WalletAction> arr =
          walletActions.list.reversed.take(actions.length).toList();
      if (actions.isNotEmpty && !(const ListEquality().equals(actions, arr))) {
        final int next = hasNextPage && nextPage > walletActions.currentPage
            ? nextPage
            : walletActions.currentPage;
        store.dispatch(
          GetActionsSuccess(
            walletActions: actions,
            nextPage: next,
          ),
        );
        onSuccess?.call();
      }
    } catch (e, s) {
      log.error(
        'ERROR - getWalletActionsCall',
        error: e,
        stackTrace: s,
      );
    }
  };
}

ThunkAction updateTokensPrices() {
  return (Store store) async {
    Map<String, Token> tokens = store.state.cashWalletState.tokens;
    for (Token token in tokens.values) {
      store.dispatch(getTokenPriceCall(token));
      store.dispatch(getTokenIntervalStatsCall(
        token,
      ));
    }
  };
}

ThunkAction getTokenPriceCall(Token token) {
  return (Store store) async {
    try {
      void onDone(Price priceInfo) {
        store.dispatch(
          UpdateTokenPrice(
            price: priceInfo,
            tokenAddress: token.address,
          ),
        );
      }

      void onError(Object error, StackTrace stackTrace) {
        log.error('Fetch token price error for - ${token.name} - $error ');
      }

      await token.fetchLatestPrice(
        onDone: onDone,
        onError: onError,
      );
    } catch (e) {
      log.error('Error getTokenPriceCall for ${token.name}');
    }
  };
}

ThunkAction getTokenIntervalStatsCall(
  Token token, {
  TimeFrame timeFrame = TimeFrame.day,
}) {
  return (Store store) async {
    try {
      await token.fetchIntervalStats(
        timeFrame: timeFrame,
        onDone: (List<IntervalStats> data) {
          if (!(const ListEquality().equals(data, token.intervalStats))) {
            store.dispatch(
              GetTokenIntervalStatsSuccess(
                intervalStats: data,
                tokenAddress: token.address,
                timeFrame: timeFrame,
                priceChange: getPercentChange(
                  data.last.currentPrice,
                  data.first.currentPrice,
                ),
              ),
            );
          }
        },
        onError: (
          Object error,
          StackTrace stackTrace,
        ) {
          log.error(
              'Error getTokenIntervalStatsCall - ${token.name} - $error ');
        },
      );
    } catch (e) {
      log.error(
          'Error getTokenIntervalStatsCall - ${token.name} - ${e.toString()} ');
    }
  };
}

ThunkAction getTokenWalletActionsCall(Token token) {
  return (Store store) async {
    try {
      final String walletAddress = store.state.userState.walletAddress;
      final Map<String, dynamic> response =
          await chargeApi.getPaginatedActionsByWalletAddress(
        walletAddress,
        1,
        tokenAddress: token.address,
      );
      final Iterable<dynamic> docs = response['docs'] ?? [];
      // final bool hasNextPage = response['hasNextPage'];
      // final int nextPage = response['nextPage'] ?? 1;
      final List<WalletAction> actions = WalletAction.actionsFromJson(docs)
        ..sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
      List<WalletAction> arr = (token.walletActions?.list.reversed
              .take(actions.length)
              .toList() ??
          [])
        ..sort(((a, b) => a.timestamp.compareTo(b.timestamp)));
      if (actions.isNotEmpty) {
        if (!(const ListEquality().equals(actions, arr))) {
          store.dispatch(
            GetTokenWalletActionsSuccess(
              walletActions: actions,
              updateAt: actions.last.timestamp,
              token: token,
            ),
          );
        } else {
          log.info('GetTokenWalletActionsSuccess nothing new');
        }
      }
    } catch (e) {
      log.error('Error getTokenWalletActionsCall for ${token.name}');
    }
  };
}

ThunkAction sendTokenToContactCall(
  Token token,
  String contactPhoneNumber,
  String tokensAmount,
  VoidCallback sendSuccessCallback,
  VoidCallback sendFailureCallback,
) {
  return (Store store) async {
    try {
      Map? wallet = await chargeApi.getWalletByPhoneNumber(contactPhoneNumber);
      log.info('Trying to send $tokensAmount to phone $contactPhoneNumber');
      String? walletAddress = (wallet != null) ? wallet["walletAddress"] : null;
      if (walletAddress == null || walletAddress.isEmpty) {
        store.dispatch(inviteAndSendCall(
          token,
          contactPhoneNumber,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      } else {
        store.dispatch(sendTokenCall(
          token,
          walletAddress,
          tokensAmount,
          sendSuccessCallback,
          sendFailureCallback,
        ));
      }
    } catch (e) {
      log.error('ERROR - sendTokenToContactCall $e');
    }
  };
}

ThunkAction getFuseBalance() {
  return (Store store) async {
    try {
      BigInt fuseBalance =
          store.state.cashWalletState.tokens[fuseToken.address]?.amount ??
              BigInt.zero;
      String walletAddress = store.state.userState.walletAddress;
      EtherAmount balance = await getIt<Web3>().getBalance(
        address: walletAddress,
      );
      if (balance.getInWei.compareTo(fuseBalance) != 0) {
        store.dispatch(
          AddCashToken(
            token: fuseToken.copyWith(
              amount: balance.getInWei,
            ),
          ),
        );
        store.dispatch(getTokenPriceCall(fuseToken));
      }
    } catch (error) {
      log.error('Error in Get Fuse Balance ${error.toString()}');
    }
  };
}

ThunkAction refresh() {
  return (Store store) async {
    store.dispatch(getWalletActionsCall(pageIndex: 1));
    store.dispatch(ResetTokenTxs());
    store.dispatch(startFetchTokensBalances());
    store.dispatch(updateTokensPrices());
  };
}

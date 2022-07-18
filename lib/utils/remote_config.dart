import 'dart:async';
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService(FirebaseRemoteConfig remoteConfig)
      : _remoteConfig = remoteConfig;

  final defaults = <String, dynamic>{
    "unexchangeableTokens": {
      "0x94Ba7A27c7A95863d1bdC7645AC2951E0cca06bA": 0,
      "0xd8Bf72f3e163B9CF0C73dFdCC316417A5ac20670": 0,
      "0x025a4c577198D116Ea499193E6D735FDb2e6E841": 0,
      "0x0972F26e8943679b043de23df2fD3852177A7c48": 0,
      "0x43B17749B246fd2a96DE25d9e4184E27E09765b0": 0,
      "0x2f60a843302F1Be3FA87429CA9d684f9091b003c": 0,
      "0x7F59aE3a787C0d1D640F99883d0e48c22188C54f": 0
    }.toString(),
    "onrampOptions": {
      "onrampFUSD": ["*"],
      "onrampUSDC": ["China"],
      "withWireTransfer": [
        "United Kingdom",
        "Austria",
        "Belgium",
        "Bulgaria",
        "Croatia",
        "Cyprus",
        "Czechia",
        "Denmark",
        "Estonia",
        "Finland",
        "France",
        "Germany",
        "Greece",
        "Hungary",
        "Iceland",
        "Ireland",
        "Italy",
        "Latvia",
        "Liechtenstein",
        "Lithuania",
        "Luxembourg",
        "Malta",
        "Monaco",
        "Netherlands",
        "Norway",
        "Poland",
        "Portugal",
        "Romania",
        "Slovakia",
        "Slovenia",
        "Spain",
        "Sweden",
        "Switzerland"
      ],
      "xanpool": [
        "Australia",
        "Hong Kong",
        "India",
        "Indonesia",
        "Malaysia",
        "New Zealand",
        "Philippines",
        "Singapore",
        "South Korea",
        "Thailand",
        "Vietnam"
      ]
    }.toString(),
  };

  static RemoteConfigService? _instance;

  static Future<RemoteConfigService> getInstance() async {
    final inst = FirebaseRemoteConfig.instance;
    await inst.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: Duration.zero,
      ),
    );
    _instance = RemoteConfigService(inst);
    await _instance!.initialize();
    return _instance!;
  }

  Map<String, dynamic> get unexchangeableTokens =>
      json.decode(_remoteConfig.getValue('unexchangeableTokens').asString());

  List get withXanpool => json
      .decode(_remoteConfig.getValue('onrampOptions').asString())['xanpool'];

  List get withOnrampUSDC => json
      .decode(_remoteConfig.getValue('onrampOptions').asString())['onrampUSDC'];

  String get xanpoolTopupWidgetUrl => _remoteConfig.getString('onrampXanpool');

  List get getWithWireTransfer => json.decode(
      _remoteConfig.getValue('onrampOptions').asString())['withWireTransfer'];

  Future initialize() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (e) {
      if (kDebugMode) {
        print('Unable to fetch remote config. Default value will be used');
      }
    }
  }

  Future _fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }
}

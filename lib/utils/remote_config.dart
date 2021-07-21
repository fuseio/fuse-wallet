// import 'dart:async';
// import 'dart:convert';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:injectable/injectable.dart';

// @singleton
// class RemoteConfigService {
//   final RemoteConfig _remoteConfig;

//   RemoteConfigService(RemoteConfig remoteConfig) : _remoteConfig = remoteConfig;

//   final defaults = <String, dynamic>{
//     'onramp': {
//       "withTransak": ["Vietnam", "Indonesia", "China", "United States"],
//       "withWireTransfer": [
//         "United Kingdom",
//         "Austria",
//         "Belgium",
//         "Bulgaria",
//         "Croatia",
//         "Cyprus",
//         "Czechia",
//         "Denmark",
//         "Estonia",
//         "Finland",
//         "France",
//         "Germany",
//         "Greece",
//         "Hungary",
//         "Iceland",
//         "Ireland",
//         "Italy",
//         "Latvia",
//         "Liechtenstein",
//         "Lithuania",
//         "Luxembourg",
//         "Malta",
//         "Monaco",
//         "Netherlands",
//         "Norway",
//         "Poland",
//         "Portugal",
//         "Romania",
//         "Slovakia",
//         "Slovenia",
//         "Spain",
//         "Sweden",
//         "Switzerland"
//       ]
//     }
//   };

//   static RemoteConfigService? _instance;

//   @factoryMethod
//   static Future<RemoteConfigService> getInstance() async {
//     final inst = RemoteConfig.instance;
//     inst.setConfigSettings(
//       RemoteConfigSettings(
//         fetchTimeout: Duration(seconds: 10),
//         minimumFetchInterval: Duration.zero,
//       ),
//     );
//     _instance = RemoteConfigService(inst);
//     await _instance!.initialize();
//     return _instance!;
//   }

//   List get getWithTransak =>
//       json.decode(_remoteConfig.getValue('onramp').asString())['withTransak'];

//   List get getWithWireTransfer => json
//       .decode(_remoteConfig.getValue('onramp').asString())['withWireTransfer'];

//   Future initialize() async {
//     try {
//       await _remoteConfig.setDefaults(defaults);
//       await _fetchAndActivate();
//     } catch (e) {
//       print('Unable to fetch remote config. Default value will be used');
//     }
//   }

//   Future _fetchAndActivate() async {
//     await _remoteConfig.fetchAndActivate();
//   }
// }

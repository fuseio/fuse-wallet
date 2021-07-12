import 'package:fusecash/utils/addresses.dart';

final List<String> countriesWithTransak = [
  'Vietnam',
  'Indonesia',
  'China',
  'United States',
];

final List<String> countriesWithWireTransfer = [
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
  "Switzerland",
];

String withWebhookUrl(String url, String walletAddress) {
  return url + '&webhookStatusUrl=https://studio.fuse.io/api/v1/deposits/ramp/$walletAddress/$defaultCommunityAddress';
}

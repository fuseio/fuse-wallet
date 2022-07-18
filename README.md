# Fuse Wallet

The Fuse Wallet is a cross platform Ethereum wallet written in Dart and built on [Flutter](https://flutter.dev/). It's running on the Fuse network, but can be plugged into any EVM compatible blockchain.

# Architecture

The Fuse Wallet built upon the [charge_wallet_Sdk](https://github.com/fuseio/charge_wallet_Sdk), which provides a set of API's for the Fuse platform and its auxiliary services. Those services include:

- The Fuse Network and the networks' smart contracts, via the [web3dart](https://github.com/simolus3/web3dart) package
- The [NFT graphql API](https://thegraph.com/hosted-service/subgraph/fuseio/fuse-nft) (provided by [theraph's node](https://thegraph.com/)) provides a convenient API for reading from the network. More subgraphs on fuse can be found [here](https://github.com/fuseio/fuse-graph)
- The relayer service for fee abstraction
- The [Charge Wallet API](https://docs.chargeweb3.com/docs/overview-2)
- Redux for state management (<https://pub.dev/packages/flutter_redux>)
- Dio for fetching APIs (<https://pub.dev/packages/dio>)
- GetIt/Injectable for Dependency Injection (DI) (<https://pub.dev/packages/get_It> and <https://pub.dev/packages/injectable>)
- auto_route for routing (<https://pub.dev/packages/auto_route>)
- Multi language support (i18n)(<https://docs.flutter.dev/development/accessibility-and-localization/internationalization>)
- Logging using [logger](https://pub.dev/packages/logger "logger") (lib/utils/log)

## Smart Contracts

We developed and deployed a set of smart contracts, which the wallet interacts with:

- To avoid developing our own best practices and try to adhere to the industry standards we used [Argent-contracts](https://github.com/fuseio/argent-contracts), that were taken from the popular [wallet](https://www.argent.xyz/). These contracts are the core of wallet's logic on the Network. Using them, our users are sending free transactions (fee abstraction), have rate limits, and can use wallet recovery. More interesting features will be developed on their basis.

## Download the App

You can download the beta version of our app from the [Google Play](https://play.google.com/store/apps/details?id=io.fuse.fusecash&hl=en) or the [App Store](https://apps.apple.com/us/app/fuse-wallet/id1491783654?ls=1)

## Getting Started

### Setup

#### Set up flutter environment

- Set up a Flutter environment on your machine ([You can get started here](https://flutter.dev/docs/get-started/install)).
- Make sure to also [create a keystore as described here](https://flutter.dev/docs/deployment/android).
- Connect a phone or run a simulator

#### Clone the project

Clone the project using git commands.

      git clone https://github.com/fuseio/fuse-wallet.git
      cd fuse-wallet

#### Set up the project environment & run the project

- Make a copy of `.env_example` named `.env` - `cd environment && cp .env_example .env`
- For Android development, create a file at `./android/key.properties`, [as described here](https://flutter.dev/docs/deployment/android), containing the keystore path and passwords, as set up earlier.
- Run the app using:

      flutter run

### Config

#### UI customization

1. themes:
open the theme.dart file. that file located in lib\constants.
you will be able to change the theme of the project (such as colors, font family etc).
2. splash screen:
open the splash_screen.dart file. that file located in lib\features\screens. this is the initial screen of the app.
    - the function onInit detect if the user is logged in or not and direct the user to the relevant screen
    - in the build function of the splash screen you can design the specific UI for your app
3. icon - we are using the [flutter_launcher_icons package](https://pub.dev/packages/flutter_launcher_icons)  to set the icon app. follow the guide to change the launcher icon.
4. onboarding screen - in lib\features\onboard you can find the onboarding feature.

#### wallet configuration [required]

1. Create your own private in [Charge](https://chargeweb3.com/). Then copy and paste the project API key and put it in the `.env` file, PUBLIC_API_KEY.

2. there are 2 option for sign up. sign up with firebase or with sms. right now 'sign up with SMS' is default.
if you would like to change the sign up option Setup your onboarding option in the env file. We have an option for firebase or AWS SMS. If you choose the AWS SMS option change the ON_BOARDING_STRATEGY=sms. If you choose the firebase option change the ON_BOARDING_STRATEGY=firebase and make all the steps to deploy to the app store (the instructions are at the end of the read me file).
For easy setup we highly recommand to use sms provider (we pay for SMS for now),

### Deploy to the app stores

1. replace the current bundle id (io.fuse.fusecash) with your unique bundle id (choose your own name). replace the bundle id where-ever it's appear excepts the google_services files.
2. Create a firebase account: <https://firebase.google.com/>
3. Create firebase mobile apps (android and ios) and save the google-services file for later:
Ios (steps 1-3): <https://firebase.google.com/docs/ios/setup>
Android (Option 1, steps 1-3): <https://firebase.google.com/docs/android/setup>
4. Add phone authentication to your firebase project:
Step 1 only: <https://firebase.google.com/docs/auth/android/phone-auth>

steps 5,6 are the same steps as the setup environment steps you all ready done before

5. Create production signing keys:
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
6. Add your keys to the project:
Create a key.properties file in the android directory with the following properties:
storePassword=PASSWORD
keyPassword=PASSWORD
keyAlias=alias_name
storeFile=my-release-key.keystore
7. Add firebase your debug and production keys sha1:
<https://stackoverflow.com/questions/39144629/how-to-add-sha-1-to-android-application>
8. Send us your bundle id and admin keys:
To generate a private key file for your service account:
In the Firebase console, open Settings > Service Accounts.
Click Generate New Private Key, then confirm by clicking Generate Key.
9. replace the google_services.json file with the new .json file you saved before.

## As an enterprenuer

Launch your project on the [Charge](https://chargeweb3.com/), then open the project dashboard. There you can find your API key. Visit our [docs](https://docs.chargeweb3.com/docs/overview-2) to learn about the Charge WALLET API.


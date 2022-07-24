# Fuse Wallet

The Fuse Wallet is a white-label wallet built on top of the Charge Wallet API as a demonstration.

The Fuse Wallet built upon the [charge_wallet_SDK](https://github.com/fuseio/charge_wallet_Sdk), which provides a gateway to the Wallet API.

## Features

- Creating a smart wallet contract for a given phone number and public key
- Sending & Receiving ERC-20 & ERC-721
- Trading - A gateway to [voltage.finance](https://app.voltage.finance/) DEX
- WalletConnect

## Architecture

- [Charge Wallet API](https://docs.chargeweb3.com/docs/overview-2)
- [Redux](<https://pub.dev/packages/flutter_redux>) for state management
- [Dio](<https://pub.dev/packages/dio>) for fetching APIs
- [GetIt](<https://pub.dev/packages/get_It>) & [Injectable](<https://pub.dev/packages/injectable>) for Dependency Injection (DI)
- [auto_route](<https://pub.dev/packages/auto_route>) for routing
- Multi language support [i18n](<https://docs.flutter.dev/development/accessibility-and-localization/internationalization>)
- Logging using [logger](https://pub.dev/packages/logger) (lib/utils/log)

## Getting Started

## Prerequisites

Before you can start coding your first wallet, there are a few things you need to do, if you haven't done them already.

- Create a project on the [Charge](https://chargeweb3.com/) platform.
- Set up a Flutter environment on your machine ([Click here to get started here](https://flutter.dev/docs/get-started/install)).

### Setup

Clone the project using git commands.

- For Android development, create a file at `./android/key.properties`, [as described here](https://flutter.dev/docs/deployment/android), containing the keystore path and passwords, as set up earlier.

      git clone https://github.com/fuseio/fuse-wallet.git
      cd fuse-wallet

Run the app using:

      flutter pub get && flutter run

- Make a copy of `.env.example` named `.env` - `cd environment && cp .env.example .env`

## 3rd party integrations

If you'd like your app to support the on-ramp feature, you'll need to create a API key and put it in the `.env` file.

- [ramp.network](https://ramp.network)
- [xanpool](https://xanpool.com/)

## Download the App

You can download the beta version of our app from the [Google Play](https://play.google.com/store/apps/details?id=io.fuse.fusecash&hl=en) or the [App Store](https://apps.apple.com/us/app/fuse-wallet/id1491783654?ls=1)

# Fuse Wallet

The Fuse Wallet is a cross platform Ethereum wallet written in Dart and built on [Flutter](https://flutter.dev/). It's runninng on the Fuse network, but can be plugged into any EVM compatible blockchain.

# Architecture

The Fuse Wallet built upon the [wallet-core SDK](https://github.com/fuseio/wallet_core), which provides a set of API's for the Fuse platform and its auxiliary services. Those services include:
- The Fuse Network and the networks' smart contracts, via the [web3dart](https://github.com/simolus3/web3dart) package
- The [graphql API](https://graph.fuse.io/subgraphs/name/fuseio/fuse/graphql) (provided by [theraph's node](https://thegraph.com/)) provides a convinient API for reading from the network. More info about the API can be found [here](https://github.com/fuseio/fuse-graph)
- The relayer service for fee abstraction
- The [fuse-studio](https://github.com/fuseio/fuse-studio) backend API for business logic and data
- [3box](https://3box.io/) to store user's private and public data in a decentralized manner.
- [IPFS](https://ipfs.io/) to store other public data, e.g. businesses data and images.

## Smart Contracts

We developed and deployed a set of smart contracts, which the wallet interacts with:
- To avoid developing our own best practices and try to adhere to the indusry standarts we used [Argent-contracts](https://github.com/fuseio/argent-contracts), that were taken from the popular [wallet](https://www.argent.xyz/). These contracts are the core of wallet's logic on the Network. Using them, our users are sending free transactions (fee abstraction), have rate limits, and can use wallet recovery. More interesting features will be developed on their basis.
- [Token contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/token-factory) complying to ERC20 standard
- [Community contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/entities) to create a tied in interaction between users, businesses and other entities.

## Download the App

You can download the beta version of our app from the [Google Play](https://play.google.com/store/apps/details?id=io.fuse.fusecash&hl=en) or the [App Store](https://apps.apple.com/us/app/fuse-wallet/id1491783654?ls=1)

## Getting Started

## As a developer
- Set up a Flutter environment on your machine.
   - [You can get started here](https://flutter.dev/docs/get-started/install).
   - Make sure to also [create a keystore as described here](https://flutter.dev/docs/deployment/android).
- Connect a phone or run a simulator.
- Clone the project.

      git clone https://github.com/fuseio/fuse-wallet.git
      cd fuse-wallet

- For Android development, create a file at `./android/key.properties`, [as described here](https://flutter.dev/docs/deployment/android), containing the keystore path and passwords, as set up earlier.
- Run the app.

      flutter run

## As an enterprenuer or a community manager
Launch your community on the [Fuse Studio](https://studio.fuse.io/), then open the community dashboard. There you can configure it and *customize your wallet* app. When you done go to "White label wallet" and send an app invite link to yourself. Visit our [docs](https://docs.fuse.io/the-fuse-studio/overview) to learn about the Fuse Studio.

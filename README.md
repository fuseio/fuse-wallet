# Fuse Wallet

The Fuse Wallet is a cross platform Ethereum wallet written in Dart and built on Flutter. It's runninng on the Fuse network, but can be plugged into any EVM compatible blockchain.

# Architecture

The Fuse Wallet built upon the [wallet-core SDK](https://github.com/fuseio/wallet_core), which provides a set of API's for the Fuse platform and its auxiliary services. Those services include:
- The Fuse Network and the networks' smart contracts, via the [web3dart](https://github.com/simolus3/web3dart) package
- The [graphql API](https://graph.fuse.io/subgraphs/name/fuseio/fuse/graphql) (provided by [theraph's node](https://thegraph.com/)) provides a convinient API for readiing from the network. More info about the API can be found [here](https://github.com/fuseio/fuse-graph)
- The relayer service for fee abstraction
- The [fuse-studio](https://github.com/fuseio/fuse-studio) backend API for business logic and data
- [3box](https://3box.io/) to store user's private and public data in a decentralized manner.
- [IPFS](https://ipfs.io/) to store other public data, e.g. businesses data and images.

## Smart Contracts

We developed and deployed a set of smart contracts, which the wallet is interacts with
- [Argent-contracts](https://github.com/fuseio/argent-contracts) which is the core of wallet's logic on the network
- [Token contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/token-factory) complying to ERC20 standard
- [Community contracts](https://github.com/fuseio/fuse-studio/tree/master/contracts/entities) to create a tied in interaction between users, businesses and other entities.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

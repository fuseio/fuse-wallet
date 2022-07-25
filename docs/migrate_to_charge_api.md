# Migration guide - wallet_core TO charge_wallet_SDK

This guide is for users who forked the fuse-wallet at the time, it used wallet_core, this guide is for you.
The wallet_core exposed two different modules for interacting with the Fuse ecosystem (API, WalletApi), and the new Charge API is a consolidation of the two. The studio will be deprecated soon. Thus communities-related APIs (join community, entities, community cover photo, logo, etc.) will be removed.

## Prerequisites

- Create a project on the [Charge](https://chargeweb3.com/) platform.

### A few notes prior to installing the new SDK

Some of the data types (located under lib/models), were moved to the SDK or removed. Here’s a list of them.

**Removed:**

- libs/models/community folder
- libs/models/plugins folder

**Moved to the new SDK:**

- `WalletModules`
- `WalletUpgrade`
- `Collectible`
- `IntervalStats`
- `TradeInfo`. Renamed to `Trade`
- `SwapCallParameters`. Renamed to `TradeCallParameters`.
- `SwapRequestBody`. Renamed to `TradeRequestBody`.

Remove old SDK and Install the new SDK

```bash
flutter pub remove wallet_core && flutter pub add charge_wallet_sdk
```

Initialize ChargeApi

```bash
final ChargeApi chargeApi = ChargeApi(
 dotenv.env['PROJECT_API_KEY']!,
);
```

Next you'll need to search and replace all the references of 

`api.` OR `walletApi.` TO `chargeApi.`

It’ll show an error that some of the function references don’t exist, it because they were removed. 

### Here’s a list of them

- `fetchMetadata`
- `getCommunityData`
- `getEntityMetadata`

## Graph module

all the functions, except `getCollectiblesByOwner`, are deprecated.

## FuseSwap Service (lib/services/fuseswap): (Renamed to [Trade API](https://docs.chargeweb3.com/docs/overview-3))

If you used the FuseSwapService in the fuse-wallet, we moved the functionality also to the SDK and changed the terminology to Trade, instead of Swap. Basically, all his functions and data types move to the SDK.

## Explorer Service (lib/services/explorer)

This logic also moved to the SDK. you can remove the current explorer.dart and instead use the FuseExplorer from the new SDK. here’s an example

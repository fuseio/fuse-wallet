import 'package:fusecash/redux/actions/error_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:wallet_core/wallet_core.dart';
import 'package:fusecash/services.dart';
import 'dart:async';

class InitWeb3Success {
  final Web3 web3;
  InitWeb3Success(this.web3);
}

class GetPublicKeySuccess {
  final String publicKey;
  GetPublicKeySuccess(this.publicKey);
}

class OnboardUserSuccess {
  final String accountAddress;
  OnboardUserSuccess(this.accountAddress);
}

class GetWalletAddressSuccess {
  final String walletAddress;
  GetWalletAddressSuccess(this.walletAddress);
}

class CreateAccountWalletRequest {
  final String accountAddress;
  CreateAccountWalletRequest(this.accountAddress);
}

class CreateAccountWalletSuccess {
  final String accountAddress;
  CreateAccountWalletSuccess(this.accountAddress);
}

class GetTokenBalanceSuccess {
   final BigInt tokenBalance;
   GetTokenBalanceSuccess(this.tokenBalance);
}

class SendTokenSuccess {
  final String txHash;
  SendTokenSuccess(this.txHash);
}

class JoinCommunitySuccess {
  final String txHash;
  final String communityAddress;
  final String communityName;
  final String tokenAddress;
  final String tokenName;
  final String tokenSymbol;
  final int tokenDecimals;
  JoinCommunitySuccess(this.txHash, this.communityAddress, this.communityName, this.tokenAddress, this.tokenName, this.tokenSymbol, this.tokenDecimals);
}

class AlreadyJoinedCommunity {
  final String communityAddress;
  final String communityName;
  final String tokenAddress;
  final String tokenName;
  final String tokenSymbol;
  final int tokenDecimals;
  AlreadyJoinedCommunity(this.communityAddress, this.communityName, this.tokenAddress, this.tokenName, this.tokenSymbol, this.tokenDecimals);
}

class SwitchCommunitySuccess {
  // TODO
  SwitchCommunitySuccess();
}

class GetJoinBonusSuccess {
  // TODO
  GetJoinBonusSuccess();
}

class GetBusinessListSuccess {
  // TODO
  GetBusinessListSuccess();
}

class GetTokenTransfersListSuccess {
  List tokenTransfersList;
  GetTokenTransfersListSuccess(this.tokenTransfersList);
}

Future<bool> approvalCallback() async {
  return true;
}


ThunkAction initWeb3Call(String privateKey) {
  return (Store store) async {
    try {
      Web3 web3 = new Web3(approvalCallback);
      web3.setCredentials(privateKey);
      store.dispatch(new InitWeb3Success(web3));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not init web3'));
    }
  };
}

ThunkAction getPublicKeyCall() {
  return (Store store) async {
    try {
      Web3 web3 = store.state.cashWalletState.web3;
      String publicKey = await web3.getAddress();
      store.dispatch(new GetPublicKeySuccess(publicKey));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get public key'));
    }
  };
}

ThunkAction createAccountWalletCall(String accountAddress) {
  return (Store store) async {
    try {
      store.dispatch(new CreateAccountWalletRequest(accountAddress));
      await api.createWallet();
      store.dispatch(new CreateAccountWalletSuccess(accountAddress));
      new Timer.periodic(Duration(seconds:5), (Timer t) async {
        dynamic wallet = await api.getWallet();
        String walletAddress = wallet["walletAddress"];
        if (walletAddress != null && walletAddress.isNotEmpty) {
            store.dispatch(new GetWalletAddressSuccess(walletAddress));
            t.cancel();
        }
      });
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not create wallet'));
    }
  };
}

ThunkAction getWalletAddressCall() {
  return (Store store) async {
    try {
      dynamic wallet = await api.getWallet();
      String walletAddress = wallet["walletAddress"];
      store.dispatch(new GetWalletAddressSuccess(walletAddress));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get wallet address'));
    }
  };
}

ThunkAction getTokenBalanceCall() {
  return (Store store) async {
    try {
      String walletAddress = store.state.cashWalletState.walletAddress;
      String tokenAddress = store.state.cashWalletState.tokenAddress;
      BigInt tokenBalance = await graph.getTokenBalance(walletAddress, tokenAddress);
      store.dispatch(new GetTokenBalanceSuccess(tokenBalance));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get token balance'));
    }
  };
}

ThunkAction sendTokenCall(String receiverAddress, num tokensAmount ) {
  return (Store store) async {
    try {
      Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      String tokenAddress = store.state.cashWalletState.tokenAddress;
      String txHash = await web3.cashTokenTransfer(walletAddress, tokenAddress, receiverAddress, tokensAmount);
      store.dispatch(new SendTokenSuccess(txHash));
      store.dispatch(getTokenBalanceCall());
      store.dispatch(getTokenTransfersListCall());
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not send token'));
    }
  };
}

ThunkAction joinCommunityCall({String communityAddress}) {
  return (Store store) async {
    try {
      Web3 web3 = store.state.cashWalletState.web3;
      String walletAddress = store.state.cashWalletState.walletAddress;
      communityAddress = communityAddress ?? Web3.getDefaultCommunity();
      dynamic community = await graph.getCommunityByAddress(communityAddress: communityAddress);
      dynamic token = await graph.getTokenOfCommunity(communityAddress: communityAddress);
      bool isMember = await graph.isCommunityMember(walletAddress, community["entitiesList"]["address"]);
      if (isMember) {
        return store.dispatch(new AlreadyJoinedCommunity(communityAddress, community["name"], token["address"], token["name"], token["symbol"], token["decimals"]));
      }
      String txHash = await web3.joinCommunity(walletAddress, communityAddress: communityAddress);
      return store.dispatch(new JoinCommunitySuccess(txHash, communityAddress, community["name"], token["address"], token["name"], token["symbol"], token["decimals"]));
      
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not join community'));
    }
  };
}

ThunkAction switchCommunityCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not switch community'));
    }
  };
}

ThunkAction getJoinBonusCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get join bonus'));
    }
  };
}

ThunkAction getBusinessListCall() {
  return (Store store) async {
    try {
      // TODO
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get business list'));
    }
  };
}

ThunkAction getTokenTransfersListCall() {
  return (Store store) async {
    try {
      String walletAddress = store.state.cashWalletState.walletAddress;
      String tokenAddress = store.state.cashWalletState.tokenAddress;
      Map<String, dynamic> transfers = await graph.getTransfers(walletAddress, tokenAddress);
      store.dispatch(new GetTokenTransfersListSuccess(transfers["data"]));
    } catch (e) {
      print(e);
      store.dispatch(new ErrorAction('Could not get token transfers'));
    }
  };
}
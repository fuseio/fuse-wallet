import 'package:digitalrand/widgets/activate_pro_mode2.dart';
import 'package:digitalrand/widgets/primary_button.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:digitalrand/models/community/community.dart';
import 'package:digitalrand/models/plugins/fee_base.dart';
import 'package:digitalrand/utils/addresses.dart';
import 'package:redux/redux.dart';
import 'package:digitalrand/models/app_state.dart';
import 'dart:core';

class ActivateProModeDialog extends StatefulWidget {
  @override
  createState() => new ActivateProModeDialogState();
}

class ActivateProModeDialogState extends State<ActivateProModeDialog>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityAnimation;
  Animation<double> scaleAnimatoin;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.4).animate(
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    scaleAnimatoin =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _context) {
    return ScaleTransition(
        scale: scaleAnimatoin,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          content: Stack(
            children: <Widget>[
              new StoreConnector<AppState, ActivateProModeViewModel>(
                  distinct: true,
                  converter: ActivateProModeViewModel.fromStore,
                  builder: (_, viewModel) {
                    return Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                              "In order to withdraw DAI to Ethereum we first need to transfer it from Fuse to Ethereum mainnet.",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 20.0),
                          Text(
                              "Click on Activate pro mode to enable Ethereum support in your wallet:",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(height: 20.0),
                          Center(
                              child: PrimaryButton(
                            fontSize: 16,
                            width: 260.0,
                            label: 'Activate pro mode',
                            labelFontWeight: FontWeight.normal,
                            onPressed: () async {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ActivateProMode2Dialog();
                                  });
                            },
                          ))
                        ],
                      ),
                    );
                  })
            ],
          ),
        ));
  }
}

class ActivateProModeViewModel extends Equatable {
  final String homeBridgeAddress;
  final FeePlugin feePlugin;
  ActivateProModeViewModel({this.feePlugin, this.homeBridgeAddress});

  @override
  List<Object> get props => [feePlugin, homeBridgeAddress];

  static ActivateProModeViewModel fromStore(Store<AppState> store) {
    Community community =
        store.state.cashWalletState.communities[defaultCommunityAddress];
    return ActivateProModeViewModel(
      feePlugin: community.plugins.bridgeToForeign,
      homeBridgeAddress: community.homeBridgeAddress,
    );
  }
}

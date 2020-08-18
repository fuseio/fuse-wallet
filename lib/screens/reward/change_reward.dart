import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:seedbed/redux/actions/cash_wallet_actions.dart';
import 'package:seedbed/utils/format.dart';
import 'package:seedbed/widgets/my_app_bar.dart';
import 'package:seedbed/widgets/primary_button.dart';
import 'package:span_builder/span_builder.dart';
import 'package:equatable/equatable.dart';
import 'package:redux/redux.dart';
import 'package:seedbed/models/app_state.dart';

class ChangeRewardScreen extends StatefulWidget {
  @override
  _ChangeRewardScreenState createState() => _ChangeRewardScreenState();
}

class _ChangeRewardScreenState extends State<ChangeRewardScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isPrimaryPreloading = false;
  num amount;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ChangeRewardViewModel>(
        converter: _ChangeRewardViewModel.fromStore,
        builder: (_, viewModel) {
          DateTime date = DateTime.now().add(Duration(
              days: (DateTime.sunday - DateTime.now().weekday) %
                  DateTime.daysPerWeek));
          String nextSunday = '${date.year}-${date.month}-${date.day}';
          String currentReward = formatValue(viewModel.currentReward, 18) + '%';
          String next = formatValue(viewModel.nextReward, 18) + '%';
          final List<InlineSpan> spans =
              SpanBuilder('''The reward rate will be changed per
your request in the beginning of the
upcoming week on the $nextSunday
to reward rate of $next''')
                  .apply(TextSpan(
                      text: nextSunday,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline)))
                  .apply(TextSpan(
                      text: next,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline)))
                  .build();

          final List<InlineSpan> current =
              SpanBuilder('''Current reward rate: $currentReward''')
                  .apply(TextSpan(
                      text: currentReward,
                      style: TextStyle(fontWeight: FontWeight.bold)))
                  .build();

          return Scaffold(
              appBar: MyAppBar(
                height: 230.0,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(
                          top: 20.0, left: 20.0, right: 20.0, bottom: 40),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Theme.of(context).primaryColor.withAlpha(20),
                              blurRadius: 30.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                0.0,
                                3.0,
                              ),
                            )
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).primaryColorLight,
                              Theme.of(context).primaryColorDark,
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 30.0),
                            child: new RichText(
                              text: TextSpan(
                                  children: current,
                                  style: TextStyle(
                                    fontSize: 25,
                                    letterSpacing: .5,
                                  )),
                            ),
                          ),
                          RichText(
                              text: TextSpan(
                                  children: spans,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFFC6C6C6))))
                        ],
                      ),
                    ),
                    Positioned(
                        top: 45,
                        left: 20,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            PlatformIcons(context).back,
                            color: Theme.of(context).splashColor,
                          ),
                        ))
                  ],
                ),
              ),
              body: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Change reward rate',
                          style: TextStyle(
                              color: Color(0xFF979797),
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal)),
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              TextFormField(
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                                  validator: (String value) {
                                    try {
                                      if (num.parse(value).compareTo(0) != 1) {
                                        return 'Must be number bigger then 0';
                                      }
                                      return null;
                                    } catch (e) {
                                      return 'Must be number';
                                    }
                                  },
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(0.0),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFE0E0E0),
                                              width: 3)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFF292929)),
                                      ),
                                      labelText: 'Enter amount',
                                      hintStyle: TextStyle(
                                        fontSize: 13.0,
                                      ),
                                      labelStyle: TextStyle(
                                        fontSize: 13.0,
                                      )),
                                  onSaved: (String value) {
                                    try {
                                      this.amount = num.parse(value);
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  PrimaryButton(
                                    fontSize: 15,
                                    label: 'Change',
                                    preload: isPrimaryPreloading,
                                    labelFontWeight: FontWeight.normal,
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        setState(() {
                                          isPrimaryPreloading = true;
                                        });
                                        viewModel.setReward(
                                            toBigInt(this.amount, 27),
                                            toBigInt(100, 27), () {
                                          ExtendedNavigator.named('homeRouter')
                                              .popUntilRoot();
                                        }, () {
                                          setState(() {
                                            isPrimaryPreloading = false;
                                          });
                                        });
                                      }
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )));
        });
  }
}

class _ChangeRewardViewModel extends Equatable {
  final BigInt nextReward;
  final BigInt currentReward;
  final Function(
    BigInt nom,
    BigInt dnom,
    VoidCallback sendSuccessCallback,
    VoidCallback sendFailureCallback,
  ) setReward;

  _ChangeRewardViewModel({this.nextReward, this.currentReward, this.setReward});
  static _ChangeRewardViewModel fromStore(Store<AppState> store) {
    return _ChangeRewardViewModel(
        currentReward:
            store.state.cashWalletState?.currentReward ?? BigInt.zero,
        nextReward: store.state.cashWalletState?.nextReward ?? BigInt.zero,
        setReward: (
          BigInt nom,
          BigInt dnom,
          VoidCallback sendSuccessCallback,
          VoidCallback sendFailureCallback,
        ) {
          store.dispatch(setMintedReward(
              nom, dnom, sendSuccessCallback, sendFailureCallback));
        });
  }

  @override
  List<Object> get props => [currentReward, nextReward];
}

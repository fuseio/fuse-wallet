import 'package:auto_route/auto_route.dart';
import 'package:flutter_segment/flutter_segment.dart';
import 'package:fusecash/constants/enums.dart';
import 'package:fusecash/common/router/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/features/screens/set_up_pincode.dart';
import 'package:fusecash/redux/viewsmodels/security.dart';
import 'package:fusecash/utils/biometric_local_auth.dart';
import 'package:fusecash/features/shared/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';

class ChooseSecurityOption extends StatefulWidget {
  @override
  _ChooseSecurityOptionState createState() => _ChooseSecurityOptionState();
}

class _ChooseSecurityOptionState extends State<ChooseSecurityOption> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BiometricAuth>(
      future: BiometricUtils.getAvailableBiometrics(),
      builder: (context, AsyncSnapshot<BiometricAuth> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return MyScaffold(
            title: I10n.of(context).protect_wallet,
            body: Container(
              height: MediaQuery.of(context).size.height * .9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      SvgPicture.asset('assets/images/lock.svg'),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          I10n.of(context).choose_lock_method,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF888888),
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      StoreConnector<AppState, SecurityViewModel>(
                        distinct: true,
                        converter: SecurityViewModel.fromStore,
                        builder: (_, viewModel) {
                          return Container(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    InkWell(
                                      focusColor: Theme.of(context).canvasColor,
                                      highlightColor:
                                          Theme.of(context).canvasColor,
                                      child: Container(
                                          height: 60,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .8,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primaryVariant,
                                                Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ],
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11.0)),
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                      'assets/images/${BiometricAuth.faceID == {
                                                            snapshot.requireData
                                                          } ? 'face_id' : 'fingerprint'}.svg'),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    BiometricUtils
                                                        .getBiometricString(
                                                      context,
                                                      snapshot.requireData,
                                                    ),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  SvgPicture.asset(
                                                    'assets/images/info_black.svg',
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    I10n.of(context)
                                                        .recommended,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSurface),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                      onTap: () async {
                                        final String biometric =
                                            BiometricUtils.getBiometricString(
                                          context,
                                          snapshot.requireData,
                                        );

                                        await BiometricUtils
                                            .showDefaultPopupCheckBiometricAuth(
                                          message:
                                              '${I10n.of(context).please_use} $biometric ${I10n.of(context).to_unlock}',
                                          callback: (bool result) {
                                            if (result) {
                                              Segment.track(
                                                eventName:
                                                    'Sign up: Choose Protection Type',
                                                properties: Map.from(
                                                  {
                                                    "protectionType": biometric,
                                                  },
                                                ),
                                              );
                                              viewModel.setSecurityType(
                                                snapshot.requireData,
                                              );
                                              Segment.track(
                                                eventName:
                                                    'Sign up: Protection Done',
                                              );
                                              context.router
                                                  .replace(MainScreen());
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InkWell(
                                      focusColor: Theme.of(context).canvasColor,
                                      highlightColor:
                                          Theme.of(context).canvasColor,
                                      child: Container(
                                        height: 60,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .8,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(11.0)),
                                          color: Color(0xFFF7F7F7),
                                          shape: BoxShape.rectangle,
                                        ),
                                        child: Row(children: [
                                          SvgPicture.asset(
                                              'assets/images/pincode.svg',
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(I10n.of(context).pincode,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface))
                                        ]),
                                      ),
                                      onTap: () {
                                        Segment.track(
                                            eventName:
                                                'Sign up: Choose Protection Type',
                                            properties: Map.from(
                                                {"protectionType": 'PinCode'}));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SetUpPinCodeScreen(
                                              onSuccess: () {
                                                Segment.track(
                                                  eventName:
                                                      'Sign up: Protection Done',
                                                );
                                                context.router
                                                    .push(MainScreen());
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                ),
                width: 10,
                height: 10,
                // margin: EdgeInsets.only(left: 28, right: 28),
              ),
            ],
          );
        }
      },
    );
  }
}

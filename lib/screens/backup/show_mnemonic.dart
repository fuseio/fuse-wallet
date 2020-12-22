import 'dart:core';
import 'package:flutter/material.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/models/views/backup.dart';
import 'package:esol/widgets/main_scaffold.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:esol/models/app_state.dart';
import 'package:esol/widgets/preloader.dart';
import 'package:esol/widgets/primary_button.dart';

class ShowMnemonic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MainScaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          drawerIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).splashColor,
                borderRadius: new BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ),
          expandedHeight: MediaQuery.of(context).size.height * 0.1,
          newHeaderAppBar: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          withPadding: true,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // SizedBox(
              //   width: 40,
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Respaldar con frases',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '           mneomónicas',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          children: <Widget>[
            //
            StoreConnector<AppState, BackupViewModel>(
                distinct: true,
                converter: BackupViewModel.fromStore,
                builder: (_, viewModel) {
                  return (viewModel.user != null &&
                          viewModel.user.mnemonic.length > 0)
                      ? Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7F7F7),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[0], 1),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[1], 2),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[2], 3)
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[3], 4),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[4], 5),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[5], 6)
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[6], 7),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[7], 8),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[8], 9)
                                    ],
                                  ),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      wordWidget(context,
                                          viewModel.user.mnemonic[9], 10),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[10], 11),
                                      wordWidget(context,
                                          viewModel.user.mnemonic[11], 12)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.only(top: 30, bottom: 25),
                            //   child: Container(
                            //     child: Row(
                            //       // mainAxisAlignment:
                            //       //     // MainAxisAlignment.spaceEvenly,
                            //       children: <Widget>[
                            //         CopyToClipboard(
                            //           context: context,
                            //           content:
                            //               viewModel.user.mnemonic.join(" "),
                            //         ),
                            //         const SizedBox(width: 4.0),
                            //         Icon(
                            //           Icons.content_copy,
                            //           color: const Color(0xFF546c7c),
                            //           size: 16,
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 20.0,
                                  right: 20.0,
                                  bottom: 20.0,
                                  top: 0.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: RichText(
                                      // textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16),
                                        children: [
                                          TextSpan(
                                            text: I18n.of(context).important +
                                                ' ',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: I18n.of(context).write_words +
                                                '\n\n',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text:
                                                'Por favor guarda de forma segura estas 12 palabras en papel (el orden es importante). Estas palabras en este orden también llamado semilla permitirá recuperar los fondos en caso de haya una perdida, robo o fallo en tu teléfono celular.' +
                                                    '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text:
                                                'Nunca compartas ni reveles tu semilla' +
                                                    '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text: 'No la escribas en una web' +
                                                '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text:
                                                'No la almacenes digitalmente' +
                                                    '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text:
                                                'Si pierdes o expones a otras personas estas palabras alguien' +
                                                    '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                          TextSpan(
                                            text:
                                                'podría manipular tus fondos y hacerte perder tu dinero.' +
                                                    '\n',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // const SizedBox(height: 30.0),
                            PrimaryButton(
                              fontSize: 15,
                              width: 160,
                              label: 'Respaldar',
                              labelFontWeight: FontWeight.normal,
                              onPressed: () async {},
                            ),
                            // PrimaryButton(
                            //   // buttonContentColor: Colors.white,
                            //   icon: Text(''),
                            //   fontSize: 15,
                            //   width: 160,
                            //   label: I18n.of(context).next_button,
                            //   labelFontWeight: FontWeight.normal,
                            //   onPressed: () async {
                            //     ExtendedNavigator.named('homeRouter')
                            //         .replace(HomeRoutes.verifyMnemonic);
                            //   },
                            // ),
                          ],
                        )
                      : Padding(
                          child: Preloader(),
                          padding: EdgeInsets.only(top: 70),
                        );
                })
          ]),
    );
  }

  Widget wordWidget(context, word, int index) {
    return Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 48,
            width: 111,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Card(
              elevation: 0.0,
              child: Row(
                children: [
                  FittedBox(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                      child: new Center(
                        child: new Text(
                          '$index',
                          style: TextStyle(fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  FittedBox(
                    child: Container(
                        width: 50,
                        height: 36,
                        child: Center(child: Text(word))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

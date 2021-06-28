import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fusecash/features/home/widgets/token_tile.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/tokens/token.dart';
import 'package:fusecash/redux/viewsmodels/send_amount.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Dialogs {
  // static Future<void> showMessage({
  //   required String message,
  //   bool isSuccess = true,
  // }) async {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: isSuccess ? Colors.green : Colors.red,
  //     gravity: ToastGravity.TOP,
  //   );
  // }

  // static Future<String?> showPasswordConfirmationDialog(
  //   BuildContext context, {
  //   required String hintText,
  // }) async {
  //   String? password = await showDialog(
  //     context: context,
  //     builder: (context) {
  //       String? password;
  //       return AlertDialog(
  //         title: Text('Verify'),
  //         content: TextFormField(
  //           autofocus: true,
  //           onChanged: (input) => password = input,
  //           obscureText: true,
  //           decoration: InputDecoration(hintText: hintText),
  //         ),
  //         actions: [
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () => Navigator.pop(context),
  //           ),
  //           TextButton(
  //             child: Text('Confirm'),
  //             onPressed: () => Navigator.pop(context, password),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   return password;
  // }

  static Future<void> showSecretKeyBottomSheet(
    BuildContext context,
    Widget Function(BuildContext) builder, {
    bool isDismissible = false,
    bool enableDrag = false,
  }) async {
    showBarModalBottomSheet(
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      context: context,
      builder: builder,
    );
  }

  // static Future<String?> showEditEntryBottomSheet(
  //   BuildContext context, {
  //   required String title,
  //   String? description,
  //   required String hintText,
  //   required String? entry,
  //   required String buttonText,
  //   required TextCapitalization textCapitalization,
  //   required bool validateWithPrimaryPassword,
  //   required bool validateWithSecondaryPassword,
  //   required bool validateWithBiometric,
  // }) async {
  //   String? newEntry = await showBarModalBottomSheet<String?>(
  //     context: context,
  //     builder: (context) {
  //       return EditEntryPage(
  //         title: title,
  //         description: description ?? '',
  //         hintText: hintText,
  //         entry: entry ?? '',
  //         buttonText: buttonText,
  //         textCapitalization: textCapitalization,
  //         validateWithPrimaryPassword: validateWithPrimaryPassword,
  //         validateWithSecondaryPassword: validateWithSecondaryPassword,
  //         validateWithBiometric: validateWithBiometric,
  //       );
  //     },
  //   );
  //   return newEntry;
  // }

  static void showTokenList(
    BuildContext context,
    String title,
    void Function(Token token)? onTap,
  ) {
    showBarModalBottomSheet(
      useRootNavigator: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (_) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: Text(
                          title, //I10n.of(context).token,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Europa',
                            fontSize: 22,
                          ),
                          softWrap: true,
                        ),
                      ),
                      new StoreConnector<AppState, SendAmountViewModel>(
                        converter: SendAmountViewModel.fromStore,
                        onInitialBuild: (viewModel) {},
                        builder: (_, viewModel) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 20, bottom: 30),
                              separatorBuilder: (_, int index) => Divider(
                                height: 0,
                              ),
                              itemCount: viewModel.tokens.length,
                              itemBuilder: (context, index) => TokenTile(
                                token: viewModel.tokens[index],
                                onTap: () {
                                  onTap?.call(viewModel.tokens[index]);
                                },
                                // onTap: () {
                                //   Navigator.of(context).pop();
                                //   setState(() {
                                //     textEditingController.text = "0";
                                //     selectedToken = viewModel.tokens[index];
                                //   });
                                // },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showInformationBottomSheet(
    BuildContext context, {
    required String title,
    required String content,
    required String buttonText,
    required void Function() onPressed,
  }) {
    showBarModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 8,
            top: 0,
            right: 8,
            // Use bottom padding to detect if keyboard is shown, so it'd not hide our rendered elements
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Divider(height: 1),
              SizedBox(height: 8),
              Text(content),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(buttonText),
                        onPressed: onPressed,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

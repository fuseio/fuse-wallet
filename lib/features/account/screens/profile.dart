import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fusecash/generated/l10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/profile.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widgets/my_scaffold.dart';
import 'package:fusecash/widgets/snackbars.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String displayName;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      onDispose: (store) {
        if (store.state.userState.displayName != displayName) {
          final viewModel = ProfileViewModel.fromStore(store);
          viewModel.updateDisplayName(displayName);
        }
      },
      builder: (_, viewModel) {
        return MyScaffold(
          title: I10n.of(context).account,
          body: InkWell(
            focusColor: Theme.of(context).canvasColor,
            highlightColor: Theme.of(context).canvasColor,
            onTap: () {
              WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus();
            },
            child: Material(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showSourceImagePicker(context,
                                  (source) => viewModel.editAvatar(source)),
                              child: SizedBox(
                                height: 70,
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: Colors.grey[400],
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                          child: CachedNetworkImage(
                                            width: 60,
                                            height: 60,
                                            imageUrl: viewModel.avatarUrl,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/anom.png'),
                                              radius: 30,
                                            ),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Image(
                                              image: imageProvider,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned.directional(
                                            textDirection: TextDirection.ltr,
                                            bottom: 0,
                                            start: 0,
                                            end: 0,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 3),
                                              alignment: Alignment.center,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                              child: Text(
                                                I10n.of(context).edit,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .canvasColor,
                                                    fontSize: 9),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(viewModel.displayName,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                    fontSize: 18))
                          ],
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(I10n.of(context).name,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey))),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          autofocus: false,
                          style: TextStyle(
                              fontSize: 20,
                              color: Theme.of(context).colorScheme.onSurface),
                          initialValue: viewModel.displayName,
                          keyboardType: TextInputType.text,
                          cursorColor: Color(0xFFC6C6C6),
                          onChanged: (value) => displayName = value,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            fillColor: Theme.of(context).canvasColor,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            suffixIcon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      _buildGroup(
                        I10n.of(context).wallet_address,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              formatAddress(viewModel.walletAddress),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              focusColor: Theme.of(context).canvasColor,
                              highlightColor: Theme.of(context).canvasColor,
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: viewModel.walletAddress,
                                  ),
                                );
                                showCopiedFlushbar(context);
                              },
                              child: Icon(
                                FaIcon(FontAwesomeIcons.copy).icon,
                                size: 14,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider(),
                      _buildGroup(
                        I10n.of(context).phoneNumber,
                        Text(
                          viewModel.phone,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroup(String title, Widget rightWidget) => Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              rightWidget,
            ],
          ),
        ),
      );

  void _showSourceImagePicker(
    BuildContext context,
    void Function(ImageSource source) callback,
  ) =>
      showBarModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (context) => BottomSheet(
          onClosing: () {},
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    title: Text(I10n.of(context).camera),
                    onTap: () {
                      callback(ImageSource.camera);
                      Navigator.pop(context);
                    }),
                ListTile(
                  title: Text(I10n.of(context).gallery),
                  onTap: () {
                    callback(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}

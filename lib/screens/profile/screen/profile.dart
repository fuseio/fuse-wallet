import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fc_knudde/generated/i18n.dart';
import 'package:fc_knudde/models/app_state.dart';
import 'package:fc_knudde/models/views/profile.dart';
import 'package:fc_knudde/widgets/main_scaffold.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String displayName;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        converter: ProfileViewModel.fromStore,
        onDispose: (store) {
          if (displayName != null &&
              store.state.userState.displayName != displayName) {
            final viewModel = ProfileViewModel.fromStore(store);
            viewModel.updateDisplaName(displayName);
          }
        },
        builder: (_, viewModel) {
          return MainScaffold(
            backgroundColor: Colors.grey[200],
            title: I18n.of(context).account,
            children: [
              Material(
                color: Colors.white,
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
                                              child: ![
                                            null,
                                            ''
                                          ].contains(viewModel.avatarUrl)
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          viewModel.avatarUrl,
                                                      placeholder: (context,
                                                              url) =>
                                                          CircularProgressIndicator(),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                              'assets/images/anom.png',
                                                              width: 40,
                                                              height: 40),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Image(
                                                        image: imageProvider,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage:
                                                          new AssetImage(
                                                              'assets/images/anom.png'),
                                                      radius: 30,
                                                    )),
                                          Positioned.directional(
                                              textDirection: TextDirection.ltr,
                                              bottom: 0,
                                              start: 0,
                                              end: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 3),
                                                alignment: Alignment.center,
                                                color: Colors.black,
                                                child: Text(
                                                  I18n.of(context).edit,
                                                  style: TextStyle(
                                                      color: Colors.white,
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
                              Text(viewModel?.displayName ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          ),
                        ),
                        Container(height: 1, color: Colors.grey[200]),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(I18n.of(context).name,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            initialValue: viewModel.displayName,
                            keyboardType: TextInputType.text,
                            cursorColor: Color(0xFFC6C6C6),
                            onChanged: (value) => displayName = value,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(
                                  Icons.edit,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                        Container(height: 1, color: Colors.grey[200]),
                        _buildGroup(I18n.of(context).wallet_address,
                            viewModel?.walletAddress ?? ''),
                        Container(height: 1, color: Colors.grey[200]),
                        _buildGroup(I18n.of(context).phoneNumber,
                            viewModel?.phone ?? ''),
                        Container(height: 1, color: Colors.grey[200]),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _buildGroup(String title, String value) => Container(
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
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      );

  void _showSourceImagePicker(
          BuildContext context, void Function(ImageSource source) callback) =>
      showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
          onClosing: () {},
          builder: (context) => Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                )),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    title: Text('Camera'),
                    onTap: () {
                      callback(ImageSource.camera);
                      Navigator.pop(context);
                    }),
                ListTile(
                    title: Text('Gallery'),
                    onTap: () {
                      callback(ImageSource.gallery);
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
      );
}

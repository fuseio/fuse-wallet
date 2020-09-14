import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/models/views/profile.dart';
import 'package:fusecash/widgets/main_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
        distinct: true,
        converter: ProfileViewModel.fromStore,
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
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: Colors.grey[400],
                                    child: Stack(
                                      children: [
                                        Positioned.fill(
                                            child: Icon(Icons.person,
                                                size: 40,
                                                color: Colors.grey[300])),
                                        Positioned.directional(
                                            textDirection: TextDirection.ltr,
                                            bottom: 0,
                                            start: 0,
                                            end: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
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
                              SizedBox(height: 5),
                              Text(viewModel?.firstName() ?? '',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18))
                            ],
                          ),
                        ),
                        Container(height: 1, color: Colors.grey[200]),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(I18n.of(context).name,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey))),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                viewModel.firstName() ?? '',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                              IconButton(
                                icon: Icon(Icons.edit),
                                color: Colors.grey,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Container(height: 1, color: Colors.grey[200]),
                        _buildGroup(I18n.of(context).private_key,
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
}

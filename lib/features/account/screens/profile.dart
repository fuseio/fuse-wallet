import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:fusecash/features/shared/widgets/inner_page.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/viewsmodels/profile.dart';
import 'package:fusecash/utils/alerts/alerts_model.dart';
import 'package:fusecash/utils/format.dart';
import 'package:fusecash/widget_extends/sf_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends SfWidget<ProfilePage> {
  String? displayName;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      distinct: true,
      converter: ProfileViewModel.fromStore,
      onDispose: (store) {
        if (displayName != null) {
          if (store.state.userState.displayName != displayName) {
            final viewModel = ProfileViewModel.fromStore(store);
            viewModel.updateDisplayName(displayName!);
          }
        }
      },
      builder: (_, viewModel) {
        return InnerScaffold(
          hasScrollBody: false,
          title: I10n.of(context).account,
          body: InkWell(
            hoverColor: Theme.of(context).canvasColor,
            splashColor: Theme.of(context).canvasColor,
            focusColor: Theme.of(context).canvasColor,
            highlightColor: Theme.of(context).canvasColor,
            onTap: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
            },
            child: Material(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => _showSourceImagePicker(context,
                                  (source) => viewModel.editAvatar(source)),
                              child: SizedBox(
                                width: 90,
                                height: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: CachedNetworkImage(
                                          width: 60,
                                          height: 60,
                                          imageUrl: viewModel.avatarUrl,
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/images/anom.png'),
                                            radius: 30,
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) => Image(
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
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                          ),
                                          alignment: Alignment.center,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          child: Text(
                                            I10n.of(context).edit,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: 9,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              viewModel.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            I10n.of(context).name,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                    ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0),
                        child: TextFormField(
                          autofocus: false,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                          initialValue: viewModel.displayName,
                          keyboardType: TextInputType.text,
                          cursorColor: const Color(0xFFC6C6C6),
                          onChanged: (value) => displayName = value,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            border: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            fillColor: Theme.of(context).canvasColor,
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 2,
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      _buildGroup(
                        I10n.of(context).wallet_address,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Formatter.formatEthAddress(
                                viewModel.walletAddress,
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
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
                                super.throwAlert(
                                  context,
                                  I10n.of(context).copied_to_clipboard,
                                  type: AlertsTypeEnum.INFO,
                                );
                              },
                              child: Icon(
                                const FaIcon(FontAwesomeIcons.copy).icon,
                                size: 14,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      _buildGroup(
                        I10n.of(context).phoneNumber,
                        Text(
                          viewModel.phone,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                        ),
                      ),
                      const Divider(),
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                    ),
              ),
              const SizedBox(height: 8),
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
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(I10n.of(context).camera),
                  onTap: () {
                    callback(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
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

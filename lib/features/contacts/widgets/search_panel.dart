import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fusecash/generated/l10n.dart';
// import 'package:fusecash/utils/send.dart';
import 'package:fusecash/widgets/silver_app_bar.dart';

class SearchPanel extends StatelessWidget {
  SearchPanel({
    Key? key,
    required this.searchController,
  }) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 100.0,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE8E8E8),
              ),
            ),
          ),
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    autofocus: false,
                    controller: searchController,
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      fillColor: Theme.of(context).canvasColor,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                      ),
                      labelText: I10n.of(context).search,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFAAAAAA),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                child: GestureDetector(
                  child: SvgPicture.asset(
                    'assets/images/scan_black.svg',
                    width: 25.0,
                  ),
                  onTap: () {
                    // barcodeScannerHandler(
                    //   ExtendedNavigator.named('contactsRouter').context,
                    // );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

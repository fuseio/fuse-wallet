import 'package:flutter/material.dart';
import 'package:peepl/generated/i18n.dart';
import 'package:peepl/utils/send.dart';
import 'package:peepl/widgets/silver_app_bar.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({Key key, this.searchController}) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 100.0,
        child: Container(
          decoration: new BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(bottom: BorderSide(color: Color(0xFFE8E8E8)))),
          padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    controller: searchController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFE0E0E0), width: 3)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: const Color(0xFF292929)),
                      ),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xFFACACAC),
                      ),
                      labelText: I18n.of(context).search,
                    ),
                  ),
                ),
              ),
              Container(
                width: 45,
                height: 45,
                child: new FloatingActionButton(
                    heroTag: 'contacts_list',
                    backgroundColor: const Color(0xFF292929),
                    elevation: 0,
                    child: Image.asset(
                      'assets/images/scan.png',
                      width: 25.0,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    onPressed: bracodeScannerHandler),
              )
            ],
          ),
        ),
      ),
    );
  }
}

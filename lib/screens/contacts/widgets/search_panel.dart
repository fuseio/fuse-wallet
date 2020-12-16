import 'package:esol/widgets/custom_rectangle.dart';
import 'package:flutter/material.dart';
import 'package:esol/generated/i18n.dart';
import 'package:esol/widgets/silver_app_bar.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({Key key, this.searchController}) : super(key: key);
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 100.0,
        child: CustomRectangle(
          borderSize: 20,
          borderColor: Colors.white,
          height: 50.0,
          borderRadius: 40.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 18, top: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: TextFormField(
                      controller: searchController,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        suffixIcon: Icon(Icons.search, color: Colors.black),
                        labelText: I18n.of(context).search,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

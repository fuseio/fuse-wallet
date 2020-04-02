import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supervenica/generated/i18n.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => new _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int _key;

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context);
  }

  List<Widget> _languageItems() {
    return I18n.delegate.supportedLocales.map((lang) {
      bool isSelected = Localizations.localeOf(context).languageCode == lang.languageCode;
      return new ListTile(
          contentPadding:
              EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 15),
          title: new Text(
            lang.languageCode,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          trailing:
              Localizations.localeOf(context).languageCode == lang.languageCode
                  ? new Icon(Icons.check, color: Colors.green)
                  : null,
          selected: isSelected,
          onTap: () {
            I18n.onLocaleChanged(
                new Locale(lang.languageCode, lang.countryCode));
            setState(() {
              _collapse();
            });
          });
    }).toList();
  }

  Widget _buildTiles(BuildContext context) {
    return new ExpansionTile(
      key: new Key(_key.toString()),
      initiallyExpanded: false,
      title: new Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
            child: new Text(I18n.of(context).language,
                style: TextStyle(
                    fontSize: 16, color: Theme.of(context).primaryColor)),
          )
        ],
      ),
      children: _languageItems(),
    );
  }

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }
}

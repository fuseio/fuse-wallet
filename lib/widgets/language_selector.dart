import 'dart:math';
import 'package:flutter/material.dart';
import 'package:esol/generated/i18n.dart';
import 'package:country_code_picker/country_codes.dart';

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

  List<Widget> _languageItems(context) {
    Locale currentLocal = Localizations.localeOf(context);
    return I18n.delegate.supportedLocales.map((local) {
      bool isSelected = currentLocal == local;
      Map code = codes.firstWhere((code) => code['code'] == local.countryCode,
          orElse: () => null);
      String name = code['name'] ?? local.countryCode;
      return new ListTile(
          contentPadding:
              EdgeInsets.only(top: 5, bottom: 5, left: 30, right: 15),
          title: new Text(
            name,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          trailing:
              isSelected ? new Icon(Icons.check, color: Colors.green) : null,
          selected: isSelected,
          onTap: () {
            I18n.onLocaleChanged(local);
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
      children: _languageItems(context),
    );
  }

  _collapse() {
    int newKey;
    do {
      _key = new Random().nextInt(10000);
    } while (newKey == _key);
  }
}

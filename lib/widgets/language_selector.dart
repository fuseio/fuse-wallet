import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fusecash/generated/i18n.dart';
import 'package:country_code_picker/country_codes.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
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
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      title: Row(
        children: <Widget>[
          Flexible(
            child: SvgPicture.asset(
              'assets/images/language.svg',
              width: 13,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            I18n.of(context).language,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
      children: _languageItems(context),
    );
  }

  List<Widget> _languageItems(context) {
    Locale currentLocal = Localizations.localeOf(context);
    return I18n.delegate.supportedLocales.map((local) {
      bool isSelected = currentLocal == local;
      Map code = codes.firstWhere((code) => code['code'] == local.countryCode,
          orElse: () => null);
      String name = code['name'] ?? local.countryCode;
      return ListTile(
        contentPadding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        title: Text(
          name,
        ),
        trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
        selected: isSelected,
        onTap: () {
          I18n.onLocaleChanged(local);
          setState(() {
            _collapse();
          });
        },
      );
    }).toList();
  }

  _collapse() {
    int newKey;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }
}

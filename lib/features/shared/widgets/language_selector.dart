import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supervecina/app.dart';
import 'package:supervecina/generated/l10n.dart';
import 'package:supervecina/models/app_state.dart';
import 'package:supervecina/redux/viewsmodels/language_selector.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int? _key;

  void _changeLanguage(Locale _locale) async {
    MyApp.setLocale(context, _locale);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LanguageSelectorViewModel>(
      distinct: true,
      converter: LanguageSelectorViewModel.fromStore,
      builder: (_, viewModel) {
        return ExpansionTile(
          textColor: Theme.of(context).colorScheme.onSurface,
          collapsedIconColor: Theme.of(context).colorScheme.onSurface,
          collapsedTextColor: Theme.of(context).colorScheme.onSurface,
          iconColor: Theme.of(context).colorScheme.onSurface,
          tilePadding: EdgeInsets.zero,
          title: Row(
            children: <Widget>[
              Flexible(
                child: SvgPicture.asset(
                  'assets/images/language.svg',
                  width: 16,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                I10n.of(context).language,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          children: _languageItems(
            viewModel.updateLocale,
          ),
        );
      },
    );
  }

  List<Widget> _languageItems(dynamic Function(Locale) updateLocale) {
    Locale currentLocal = Localizations.localeOf(context);
    return I10n.delegate.supportedLocales.map((locale) {
      bool isSelected = currentLocal == locale;
      return ListTile(
        contentPadding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        title: Text(
          LocaleNames.of(context)!.nameOf(locale.toString())!,
        ),
        trailing: isSelected ? Icon(Icons.check, color: Colors.green) : null,
        selected: isSelected,
        onTap: () {
          _changeLanguage(locale);
          updateLocale(locale);
          setState(() {
            _collapse();
          });
        },
      );
    }).toList();
  }

  _collapse() {
    int? newKey;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }
}

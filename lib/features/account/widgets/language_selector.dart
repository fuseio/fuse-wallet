import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:fusecash/app.dart';
import 'package:flutter_gen/gen_l10n/I10n.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  int? _key;

  void _changeLanguage(Locale locale) async {
    MyApp.setLocale(context, locale);
  }

  @override
  void initState() {
    super.initState();
    _collapse();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      textColor: Theme.of(context).colorScheme.onSurface,
      collapsedIconColor: Theme.of(context).colorScheme.onSurface,
      collapsedTextColor: Theme.of(context).colorScheme.onSurface,
      iconColor: Theme.of(context).colorScheme.onSurface,
      tilePadding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      title: Row(
        children: [
          Flexible(
            child: SvgPicture.asset(
              'assets/images/language.svg',
              width: 16,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            I10n.of(context).language,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 18,
                ),
          ),
        ],
      ),
      children: _languageItems(),
    );
  }

  List<Widget> _languageItems() {
    Locale currentLocal = Localizations.localeOf(context);
    return I10n.supportedLocales.map((locale) {
      final bool isSelected = currentLocal == locale;
      return ListTile(
        contentPadding: const EdgeInsets.only(
          top: 5,
          bottom: 5,
          left: 20,
          right: 20,
        ),
        title: Text(
          LocaleNames.of(context)!.nameOf(locale.toString())!,
        ),
        trailing: isSelected
            ? Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        selected: isSelected,
        onTap: () {
          _changeLanguage(locale);
          final store = StoreProvider.of<AppState>(context);
          store.dispatch(UpdateLocale(locale: locale));
          setState(() {
            _collapse();
          });
        },
      );
    }).toList();
  }

  void _collapse() {
    int? newKey;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }
}

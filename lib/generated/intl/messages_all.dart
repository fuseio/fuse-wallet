// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that looks up messages for specific locales by
// delegating to the appropriate library.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:implementation_imports, file_names, unnecessary_new
// ignore_for_file:unnecessary_brace_in_string_interps, directives_ordering
// ignore_for_file:argument_type_not_assignable, invalid_assignment
// ignore_for_file:prefer_single_quotes, prefer_generic_function_type_aliases
// ignore_for_file:comment_references

import 'dart:async';

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_de-DE.dart' as messages_de_de;
import 'messages_en-PH.dart' as messages_en_ph;
import 'messages_en-US.dart' as messages_en_us;
import 'messages_es-ES.dart' as messages_es_es;
import 'messages_es-MX.dart' as messages_es_mx;
import 'messages_fr-FR.dart' as messages_fr_fr;
import 'messages_id-ID.dart' as messages_id_id;
import 'messages_it-IT.dart' as messages_it_it;
import 'messages_ko.dart' as messages_ko;
import 'messages_my.dart' as messages_my;
import 'messages_nl-NL.dart' as messages_nl_nl;
import 'messages_pt-BR.dart' as messages_pt_br;
import 'messages_ru-RU.dart' as messages_ru_ru;
import 'messages_sr-RS.dart' as messages_sr_rs;
import 'messages_th-TH.dart' as messages_th_th;
import 'messages_tl.dart' as messages_tl;
import 'messages_zh-CN.dart' as messages_zh_cn;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> _deferredLibraries = {
  'de_DE': () => new Future.value(null),
  'en_PH': () => new Future.value(null),
  'en_US': () => new Future.value(null),
  'es_ES': () => new Future.value(null),
  'es_MX': () => new Future.value(null),
  'fr_FR': () => new Future.value(null),
  'id_ID': () => new Future.value(null),
  'it_IT': () => new Future.value(null),
  'ko': () => new Future.value(null),
  'my': () => new Future.value(null),
  'nl_NL': () => new Future.value(null),
  'pt_BR': () => new Future.value(null),
  'ru_RU': () => new Future.value(null),
  'sr_RS': () => new Future.value(null),
  'th_TH': () => new Future.value(null),
  'tl': () => new Future.value(null),
  'zh_CN': () => new Future.value(null),
};

MessageLookupByLibrary? _findExact(String localeName) {
  switch (localeName) {
    case 'de_DE':
      return messages_de_de.messages;
    case 'en_PH':
      return messages_en_ph.messages;
    case 'en_US':
      return messages_en_us.messages;
    case 'es_ES':
      return messages_es_es.messages;
    case 'es_MX':
      return messages_es_mx.messages;
    case 'fr_FR':
      return messages_fr_fr.messages;
    case 'id_ID':
      return messages_id_id.messages;
    case 'it_IT':
      return messages_it_it.messages;
    case 'ko':
      return messages_ko.messages;
    case 'my':
      return messages_my.messages;
    case 'nl_NL':
      return messages_nl_nl.messages;
    case 'pt_BR':
      return messages_pt_br.messages;
    case 'ru_RU':
      return messages_ru_ru.messages;
    case 'sr_RS':
      return messages_sr_rs.messages;
    case 'th_TH':
      return messages_th_th.messages;
    case 'tl':
      return messages_tl.messages;
    case 'zh_CN':
      return messages_zh_cn.messages;
    default:
      return null;
  }
}

/// User programs should call this before using [localeName] for messages.
Future<bool> initializeMessages(String localeName) async {
  var availableLocale = Intl.verifiedLocale(
      localeName, (locale) => _deferredLibraries[locale] != null,
      onFailure: (_) => null);
  if (availableLocale == null) {
    return new Future.value(false);
  }
  var lib = _deferredLibraries[availableLocale];
  await (lib == null ? new Future.value(false) : lib());
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, _findGeneratedMessagesFor);
  return new Future.value(true);
}

bool _messagesExistFor(String locale) {
  try {
    return _findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? _findGeneratedMessagesFor(String locale) {
  var actualLocale =
      Intl.verifiedLocale(locale, _messagesExistFor, onFailure: (_) => null);
  if (actualLocale == null) return null;
  return _findExact(actualLocale);
}

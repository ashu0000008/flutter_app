import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/l10n/messages_all.dart';

class AppLocalizations{
  AppLocalizations();
//  Locale _locale;

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message(
      '各种链',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }

//  static Map<String, Map<String, String>> _localizedValues = {
//    'en': {
//      'title': 'global title',
//      'setting': 'setting',
//      'block_height': 'height',
//      'account_number': 'account.',
//      'contract_number': 'contract.',
//      'peer_number': 'peer.',
//      'tps': 'tps',
//      'token_number': 'token.',
//    },
//    'zh': {
//      'title': '国际化标题',
//      'setting': '设置',
//      'block_height': '最新块高',
//      'account_number': '账户数',
//      'contract_number': '合约数',
//      'peer_number': '节点数',
//      'tps': '性能峰值',
//      'token_number': '代币数',
//    },
//  };

//  String get title {
//    return _localizedValues[_locale.languageCode]['title'];
//  }
//
//  String get setting {
//    return _localizedValues[_locale.languageCode]['setting'];
//  }
//
//  String getString(String name){
//    return _localizedValues[_locale.languageCode][name];
//  }
}
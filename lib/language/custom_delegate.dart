import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app_localizations.dart';

class CustomDelegate extends LocalizationsDelegate<AppLocalizations>{
  const CustomDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  bool shouldReload(CustomDelegate old) {
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations());
  }

  static CustomDelegate delegate = const CustomDelegate();
}
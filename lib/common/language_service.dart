import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/resources/languages.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LanguageService {
  late LocalizationDelegate _delegate;
  late LocaleStorageService _localeStorageService;

  Future<LocalizationDelegate> initDelegate(LocaleStorageService localeStorageService) async {
    _delegate = await LocalizationDelegate.create(
      fallbackLocale: LanguageCode.byDefault,
      supportedLocales: languageCodes,
      basePath: 'locale',
    );
    _localeStorageService = localeStorageService;
    return _delegate;
  }

  List<String> get languageCodes {
    return [
      LanguageCode.english,
    ];
  }

  List<Locale> get supportedLocales {
    return _delegate.supportedLocales;
  }

  LocalizationDelegate get delegate {
    return _delegate;
  }

  String get currentLanguageCode {
    return _delegate.currentLocale.languageCode;
  }

  Locale get currentLocale {
    return _delegate.currentLocale;
  }

  String get defaultLocaleCode => LanguageCode.byDefault;

  Future<void> changeCurrentLocale(String languageCode) async {
    if (_delegate.currentLocale.languageCode != languageCode) {
      await _delegate.changeLocale(Locale(languageCode, ''));
    }
  }
}

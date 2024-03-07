import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/resources/storage_keys.dart';

enum ThemePreference { light, dark }

class ThemeService {
  final LocaleStorageService _localeStorageService;
  final Map<String, Color> _colorType = {
    'bug': const Color(0xff94BC4A),
    'dark': const Color(0xff736C75),
    'dragon': const Color(0xff6A7BAF),
    'electric': const Color(0xffE5C531),
    'fairy': const Color(0xffE397D1),
    'fighting': const Color(0xffCB5F48),
    'fire': const Color(0xffEA7A3C),
    'flying': const Color(0xff7DA6DE),
    'ghost': const Color(0xff846AB6),
    'grass': const Color(0xff71C558),
    'ground': const Color(0xffCC9F4F),
    'ice': const Color(0xff70CBD4),
    'normal': const Color(0xffAAB09F),
    'poison': const Color(0xffB468B7),
    'psychic': const Color(0xffE5709B),
    'rock': const Color(0xffB2A061),
    'steel': const Color(0xff89A1B0),
    'water': const Color(0xff539AE2),
  };

  ThemeService(this._localeStorageService);

  static const String _keyTheme = 'themePreferenceInsideOut';

  late ThemePreference _theme;

  void init() {
    int? themeValue = _localeStorageService.getInt(_keyTheme);
    if (themeValue == null) {
      final Brightness brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _theme = brightness.name == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
      _saveCurrentTheme();
    } else {
      _theme = ThemePreference.values[themeValue];
    }
  }

  ThemePreference get themePreference => _theme;

  PaletteColors get paletteColors => _theme == ThemePreference.light ? PaletteColorsLight() : PaletteColorsDark();

  Color get primary {
    List<String> captured = _localeStorageService.getStringList(StorageKeys.keyCaptured);
    if (captured.isNotEmpty) {
      Map<String, int> typeCount = {};
      for (var element in captured) {
        Pokemon.fromJson(json.decode(element)).types?.forEach((element) {
          typeCount[element] = typeCount.containsKey(element) ? (typeCount[element]! + 1) : 1;
        });
      }
      List<MapEntry<String, int>> entries = typeCount.entries.toList();
      entries.sort((a, b) => a.value.compareTo(b.value));
      int maxValue = entries.last.value;
      bool isMaxValueRepeated = entries.where((entry) => entry.value == maxValue).length > 1;
      if (!isMaxValueRepeated) {
        return _colorType[entries.last.key] ?? paletteColors.primary;
      }
    }
    return paletteColors.primary;
  }

  void setTheme(ThemePreference themePreference) {
    _theme = themePreference;
    _saveCurrentTheme();
  }

  void _saveCurrentTheme() => _localeStorageService.saveInt(_keyTheme, _theme.index);
}

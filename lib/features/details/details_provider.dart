import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/data/poke_api.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';
import 'package:flutter_pokedex/resources/storage_keys.dart';

class DetailsProvider extends ChangeNotifier {
  final LocaleStorageService localeStorageService;
  final String name;
  final PokeApi _pokeApi = PokeApi();
  late final Pokemon _pokemon;
  late bool _isCaptured;
  bool _isLoading = true;
  bool _capturing = false;

  DetailsProvider(this.name, {required this.localeStorageService}) {
    _getPokemon(name);
  }

  bool get isLoading => _isLoading;
  Pokemon get pokemon => _pokemon;
  bool get isCaptured => _isCaptured;
  bool get capturing => _capturing;

  Future<void> _getPokemon(String name) async {
    try {
      _pokemon = await _pokeApi.getPokemon(name);
      _isCaptured =
          localeStorageService.stringListContainValue(StorageKeys.keyCaptured, json.encode(_pokemon.toJson()));
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> release() async {
    _capturing = true;
    notifyListeners();
    await localeStorageService.removeValueToStringList(StorageKeys.keyCaptured, json.encode(_pokemon.toJson()));
    _isCaptured = false;
    _capturing = false;
    notifyListeners();
  }

  Future<void> capture() async {
    _capturing = true;
    notifyListeners();
    await localeStorageService.addValueToStringList(StorageKeys.keyCaptured, json.encode(_pokemon.toJson()));
    _isCaptured = true;
    _capturing = false;
    notifyListeners();
  }
}

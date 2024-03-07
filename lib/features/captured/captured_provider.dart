import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';
import 'package:flutter_pokedex/resources/storage_keys.dart';

class CapturedProvider extends ChangeNotifier {
  final LocaleStorageService localeStorageService;
  final List<Pokemon> _pokemons = [];
  late final StreamSubscription<bool> subscription;
  bool _isLoading = true;

  CapturedProvider({required this.localeStorageService}) {
    subscription = localeStorageService.stringListNeedRefresh.stream.listen((bool needRefresh) {
      if (needRefresh) {
        _isLoading = true;
        notifyListeners();
        _pokemons.clear();
        _getCapturedPokemons();
      }
    });
    _getCapturedPokemons();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool get isLoading => _isLoading;
  List<Pokemon> get pokemons => _pokemons;

  void _getCapturedPokemons() {
    List<String> captured = localeStorageService.getStringList(StorageKeys.keyCaptured);
    for (var element in captured) {
      _pokemons.add(Pokemon.fromJson(json.decode(element)));
    }
    _pokemons.sort((a, b) => a.id.compareTo(b.id));
    _isLoading = false;
    notifyListeners();
  }

  void sortByName() {
    _isLoading = true;
    notifyListeners();
    _pokemons.sort((a, b) => a.name.compareTo(b.name));
    _isLoading = false;
    notifyListeners();
  }

  void sortByType() {
    _isLoading = true;
    notifyListeners();
    _pokemons.sort((a, b) => a.types!.join().compareTo(b.types!.join()));
    _isLoading = false;
    notifyListeners();
  }
}

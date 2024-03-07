import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/data/poke_api.dart';
import 'package:flutter_pokedex/domain/pokedex.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';

class PokedexProvider extends ChangeNotifier {
  final LocaleStorageService localeStorageService;
  late final StreamSubscription<bool> subscription;
  late final List<Pokemon> _pokemonsFromApi;
  final PokeApi _pokeApi = PokeApi();
  List<Pokemon> _pokemons = [];
  bool _isLoading = true;
  bool _isSearching = false;

  PokedexProvider({required this.localeStorageService}) {
    subscription = localeStorageService.stringListNeedRefresh.stream.listen((bool needRefresh) {
      if (needRefresh) {
        notifyListeners();
      }
    });
    _getPokemons();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  List<Pokemon> get pokemons => _pokemons;

  Future<void> _getPokemons() async {
    try {
      Pokedex pokedex = await _pokeApi.getPokedex('kanto');
      _pokemonsFromApi = pokedex.pokemons;
      _pokemons = _pokemonsFromApi;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void filterByName(String name) {
    _isSearching = true;
    notifyListeners();
    if (name.trim().isEmpty) {
      _pokemons = _pokemonsFromApi;
    } else {
      _pokemons = pokemons.where((element) => element.name.startsWith(name.trim())).toList();
    }
    _isSearching = false;
    notifyListeners();
  }
}

import 'dart:convert' as convert;

import 'package:flutter/cupertino.dart';
import 'package:flutter_pokedex/domain/pokedex.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';
import 'package:http/http.dart' as http;

class PokeApi {
  final String _urlBase = "https://pokeapi.co/api/";
  final String _version = "v2";

  Future<Pokedex> getPokedex(String name) async {
    try {
      Uri url = Uri.parse('$_urlBase$_version/pokedex/$name/');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Pokedex.fromApi(jsonResponse);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }

  Future<Pokemon> getPokemon(String name) async {
    try {
      Uri url = Uri.parse('$_urlBase$_version/pokemon/$name/');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Pokemon.fromApi(jsonResponse);
      } else {
        throw Exception('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw FlutterError(e.toString());
    }
  }
}

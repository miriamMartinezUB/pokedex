import 'package:flutter_pokedex/domain/pokemon.dart';

class Pokedex {
  final int id;
  final String name;
  final List<Pokemon> pokemons;

  Pokedex({
    required this.id,
    required this.name,
    required this.pokemons,
  });

  factory Pokedex.fromApi(Map<String, dynamic> json) {
    List<Pokemon> pokemons = [];
    for (var element in json["pokemon_entries"]) {
      pokemons.add(Pokemon.fromPokemonEntry(element));
    }
    return Pokedex(
      id: json['id'],
      name: json['name'],
      pokemons: pokemons,
    );
  }
}

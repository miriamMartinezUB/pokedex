import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/domain/pokemon.dart';
import 'package:flutter_pokedex/utils/string.dart';
import 'package:flutter_pokedex/views/app_divider.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  final List<Pokemon> pokemons;
  final Function(String pokemonName) onTap;
  const PokemonList({
    Key? key,
    required this.pokemons,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        String pokemonName = pokemons[index].name;
        return Column(
          children: [
            ListTile(
              title: AppText(pokemonName.capitalize()),
              splashColor: themeService.primary,
              onTap: () => onTap(pokemonName),
            ),
            const AppDivider(),
          ],
        );
      },
    );
  }
}

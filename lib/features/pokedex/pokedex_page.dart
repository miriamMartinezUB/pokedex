import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/features/pokedex/pokedex_provider.dart';
import 'package:flutter_pokedex/features/pokedex/views/free_text_question_view.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:flutter_pokedex/views/circular_progress.dart';
import 'package:flutter_pokedex/views/page_wrapper.dart';
import 'package:flutter_pokedex/views/pokemon_list.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final PokedexProvider pokedexProvider = PokedexProvider(localeStorageService: localeStorageService);
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    return ChangeNotifierProvider<PokedexProvider>(
      create: (BuildContext context) => pokedexProvider,
      child: Consumer<PokedexProvider>(
        builder: (context, pokedexProvider, child) {
          return PageWrapper(
            appBarName: translate('pokedex'),
            body: pokedexProvider.isLoading
                ? const CircularProgress()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.paddingLarge),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FreeTextQuestionView(
                            onChanged: (String search) {
                              pokedexProvider.filterByName(search);
                            },
                            hint: translate('search_pokemon'),
                            suffixIcon: Icon(
                              Icons.search,
                              color: paletteColors.icons,
                            ),
                          ),
                          if (pokedexProvider.pokemons.isEmpty) ...[
                            const SizedBox(
                              height: Dimens.paddingLarge,
                            ),
                            AppText(translate('404')),
                          ] else if (pokedexProvider.isSearching) ...[
                            const SizedBox(height: Dimens.paddingLarge),
                            const CircularProgress()
                          ] else ...[
                            const SizedBox(
                              height: Dimens.paddingS,
                            ),
                            PokemonList(
                              pokemons: pokedexProvider.pokemons,
                              onTap: (pokemonName) => navigationService.navigateTo(
                                '${Routes.pokedex}/${Routes.details}/$pokemonName',
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

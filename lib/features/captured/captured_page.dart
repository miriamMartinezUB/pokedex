import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/features/captured/captured_provider.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:flutter_pokedex/views/app_text_button.dart';
import 'package:flutter_pokedex/views/circular_progress.dart';
import 'package:flutter_pokedex/views/page_wrapper.dart';
import 'package:flutter_pokedex/views/pokemon_list.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class CapturedPage extends StatelessWidget {
  const CapturedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    final CapturedProvider capturedProvider = CapturedProvider(localeStorageService: localeStorageService);
    return ChangeNotifierProvider<CapturedProvider>(
      create: (BuildContext context) => capturedProvider,
      child: Consumer<CapturedProvider>(builder: (context, capturedProvider, child) {
        return PageWrapper(
          appBarName: translate('captured'),
          body: capturedProvider.isLoading
              ? const CircularProgress()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.paddingLarge),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (capturedProvider.pokemons.isEmpty)
                          AppText(translate('not_captured'))
                        else ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppTextButton(
                                text: 'sort_by_name',
                                icon: Icons.sort_by_alpha,
                                color: paletteColors.active,
                                onTap: () => capturedProvider.sortByName(),
                              ),
                              AppTextButton(
                                text: 'sort_by_types',
                                icon: Icons.sort_outlined,
                                color: paletteColors.active,
                                onTap: () => capturedProvider.sortByType(),
                              )
                            ],
                          ),
                          const SizedBox(height: Dimens.paddingXS),
                          PokemonList(
                            pokemons: capturedProvider.pokemons,
                            onTap: (pokemonName) => navigationService.navigateTo(
                              '${Routes.captured}/${Routes.details}/$pokemonName',
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
        );
      }),
    );
  }
}

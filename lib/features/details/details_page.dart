import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/common/locale_storage_service.dart';
import 'package:flutter_pokedex/features/details/details_provider.dart';
import 'package:flutter_pokedex/features/details/views/pokemon_image.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/utils/list.dart';
import 'package:flutter_pokedex/utils/string.dart';
import 'package:flutter_pokedex/views/app_button.dart';
import 'package:flutter_pokedex/views/circular_progress.dart';
import 'package:flutter_pokedex/views/page_wrapper.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  const DetailsPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final DetailsProvider detailsProvider = DetailsProvider(title, localeStorageService: localeStorageService);

    return ChangeNotifierProvider<DetailsProvider>(
      create: (BuildContext context) => detailsProvider,
      child: Consumer<DetailsProvider>(builder: (context, detailsProvider, child) {
        return PageWrapper(
          appBarName: '$title ${translate('details')}',
          isMainPage: false,
          body: detailsProvider.isLoading
              ? const CircularProgress()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge, horizontal: Dimens.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PokemonImage(
                        urlImageFront: detailsProvider.pokemon.urlImageFront!,
                        urlImageBack: detailsProvider.pokemon.urlImageBack!,
                      ),
                      const SizedBox(height: Dimens.paddingXLarge),
                      AppText('[${translate('id')}:](B) ${detailsProvider.pokemon.id}'),
                      const SizedBox(height: Dimens.paddingLarge),
                      AppText('[${translate('name')}:](B) ${detailsProvider.pokemon.name.capitalize()}'),
                      const SizedBox(height: Dimens.paddingLarge),
                      AppText('[${translate('height')}:](B) ${detailsProvider.pokemon.height}'),
                      const SizedBox(height: Dimens.paddingLarge),
                      AppText('[${translate('weight')}:](B) ${detailsProvider.pokemon.weight}'),
                      const SizedBox(height: Dimens.paddingLarge),
                      AppText('[${translate('types')}:](B) ${detailsProvider.pokemon.types!.getAllElements()}'),
                      const SizedBox(height: Dimens.paddingXLarge),
                      AppButton(
                        text: detailsProvider.isCaptured ? 'release' : 'capture',
                        onTap: detailsProvider.capturing
                            ? null
                            : () {
                                if (detailsProvider.isCaptured) {
                                  detailsProvider.release();
                                } else {
                                  detailsProvider.capture();
                                }
                              },
                      ),
                    ],
                  ),
                ),
        );
      }),
    );
  }
}

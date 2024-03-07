import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:provider/provider.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Icon(Icons.home, color: paletteColors.appBar),
      ),
      onTap: () {
        navigationService.replace(Routes.home);
      },
    );
  }
}

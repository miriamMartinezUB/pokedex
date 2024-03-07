import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:flutter_pokedex/views/app_divider.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    return SafeArea(
      child: Drawer(
          backgroundColor: paletteColors.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
                  child: Column(
                    children: [
                      DrawerItem(
                        text: translate('home'),
                        iconData: Icons.home_outlined,
                        color: paletteColors.text,
                        splashColor: themeService.primary,
                        onTap: () => navigationService.currentRoute == Routes.home
                            ? navigationService.close()
                            : navigationService.replace(Routes.home),
                      ),
                      DrawerItem(
                        text: translate('pokedex'),
                        iconData: Icons.summarize_outlined,
                        color: paletteColors.text,
                        splashColor: themeService.primary,
                        onTap: () => navigationService.currentRoute == Routes.pokedex
                            ? navigationService.close()
                            : navigationService.navigateTo(Routes.pokedex),
                      ),
                      DrawerItem(
                        text: translate('captured'),
                        iconData: Icons.catching_pokemon_outlined,
                        color: paletteColors.text,
                        splashColor: themeService.primary,
                        onTap: () => navigationService.currentRoute == Routes.captured
                            ? navigationService.close()
                            : navigationService.navigateTo(Routes.captured),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color splashColor;
  final Function() onTap;
  final Color? color;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
    required this.splashColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: splashColor,
      child: Column(
        children: [
          ListTile(
            title: AppText(
              translate(text),
              type: TextTypes.body,
              color: color,
            ),
            leading: Icon(
              iconData,
              color: color,
            ),
          ),
          const AppDivider(),
        ],
      ),
    );
  }
}

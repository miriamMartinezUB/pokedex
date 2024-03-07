import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/utils/string.dart';
import 'package:flutter_pokedex/views/app_drawer.dart';
import 'package:flutter_pokedex/views/home_button.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:provider/provider.dart';

class PageWrapper extends StatelessWidget {
  final Widget body;
  final bool isMainPage;
  final bool canGoBack;
  final String? appBarName;
  final Function? onPop;
  final Color? backgroundColor;

  const PageWrapper({
    Key? key,
    required this.body,
    this.appBarName,
    this.isMainPage = true,
    this.canGoBack = true,
    this.onPop,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);

    return PopScope(
      canPop: canGoBack,
      onPopInvoked: (didPop) {
        onPop?.call();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: isMainPage ? const AppDrawer() : null,
        appBar: appBarName == null
            ? null
            : AppBar(
                backgroundColor: themeService.primary,
                centerTitle: true,
                iconTheme: IconThemeData(color: paletteColors.appBar),
                leading: isMainPage
                    ? null
                    : InkWell(
                        child: Icon(Icons.arrow_back_ios, color: paletteColors.appBar),
                        onTap: () {
                          if (onPop == null) {
                            navigationService.goBack();
                          }
                          onPop?.call();
                        },
                      ),
                actions: isMainPage ? null : [const HomeButton()],
                title: AppText(
                  appBarName!.capitalize(),
                  type: TextTypes.appBar,
                  align: TextAlign.center,
                ),
              ),
        body: body,
      ),
    );
  }
}

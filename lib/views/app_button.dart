import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final GestureTapCallback? onTap;

  const AppButton({
    Key? key,
    required this.text,
    this.shouldTranslate = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: themeService.primary,
          borderRadius: BorderRadius.circular(Dimens.radiusMedium),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingLarge),
          child: AppText(
            shouldTranslate ? translate(text) : text,
            align: TextAlign.center,
            color: paletteColors.textButton,
          ),
        ),
      ),
    );
  }
}

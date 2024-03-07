import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

BorderRadius _borderRadius = BorderRadius.circular(Dimens.radiusLarge);

class FreeTextQuestionView extends StatelessWidget {
  final String? hint;
  final Function(String) onChanged;
  final Icon? suffixIcon;

  const FreeTextQuestionView({
    Key? key,
    required this.onChanged,
    required this.hint,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final TextStyle style = getTextStyle(type: TextTypes.smallBodyLight, paletteColors: paletteColors);
    return TextField(
      style: style,
      scrollPhysics: const BouncingScrollPhysics(),
      maxLines: 1,
      cursorColor: themeService.primary,
      decoration: InputDecoration(
        hintText: translate(hint ?? ''),
        hintStyle: style,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            width: Dimens.borderThickness,
            color: paletteColors.secondary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            width: Dimens.borderThickness,
            color: themeService.primary,
          ),
        ),
        suffixIcon: suffixIcon,
      ),
      onChanged: onChanged,
    );
  }
}

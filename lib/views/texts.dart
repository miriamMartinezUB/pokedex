import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:flutter_stylized_text/flutter_stylized_text.dart';
import 'package:provider/provider.dart';

enum TextTypes {
  appBar,
  title,
  titleBold,
  subtitleLight,
  subtitle,
  subtitleBold,
  bodyLight,
  body,
  bodyMedium,
  bodyBold,
  smallBodyLight,
  smallBody,
  smallBodyMedium,
  tinyBodyLight,
  tinyBody,
}

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextTypes type;
  final TextAlign align;

  const AppText(
    this.text, {
    this.type = TextTypes.body,
    this.align = TextAlign.start,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    return FlutterStylizedText(
      text: text,
      fontSize: _getFontSize(type: type),
      fontWeight: _getFontWeight(type: type),
      textAlign: align,
      stylizedTextColor: themeService.primary,
      color: color ?? _getColor(paletteColors, type: type),
      fontFamily: 'Montserrat',
    );
  }
}

TextStyle getTextStyle({
  required PaletteColors paletteColors,
  TextTypes type = TextTypes.body,
  Color? color,
}) {
  return TextStyle(
    color: color ?? _getColor(paletteColors, type: type),
    fontWeight: _getFontWeight(type: type),
    fontSize: _getFontSize(type: type),
  );
}

Color _getColor(PaletteColors paletteColors, {TextTypes type = TextTypes.body}) {
  if (type.name.toLowerCase().contains('subtitle')) {
    return paletteColors.textSubtitle;
  } else if (type.name == 'appBar') {
    return paletteColors.appBar;
  }
  return paletteColors.text;
}

double _getFontSize({TextTypes type = TextTypes.body}) {
  if (type.name.toLowerCase().contains('subtitle')) {
    return Dimens.textSizeSubtitle;
  } else if (type.name.toLowerCase().contains('title')) {
    return Dimens.textSizeTitle;
  } else if (type.name.toLowerCase().contains('small')) {
    return Dimens.textSizeBodySmall;
  } else if (type.name.toLowerCase().contains('tiny')) {
    return Dimens.textSizeBodyTiny;
  }
  return Dimens.textSizeBody;
}

FontWeight _getFontWeight({TextTypes type = TextTypes.body}) {
  if (type.name.toLowerCase().contains('light')) {
    return Dimens.fontWeightLight;
  } else if (type.name.toLowerCase().contains('medium')) {
    return Dimens.fontWeightMedium;
  } else if (type.name.toLowerCase().contains('bold')) {
    return Dimens.fontWeightBold;
  }
  return Dimens.fontWeightRegular;
}

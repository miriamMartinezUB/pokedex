import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xffCC0000);
  Color secondary = const Color(0xffFF0000);
  Color active = const Color(0xff3B4CCA);
  late Color shadow;
  late Color textButton;
  late Color icons;
  late Color appBar;
  late Color background;
  late Color text;
  late Color textSubtitle;
}

class PaletteColorsLight extends PaletteColors {
  PaletteColorsLight() {
    textButton = const Color(0xffffffff);
    icons = const Color(0xff242e37);
    appBar = const Color(0xffffffff);
    background = const Color(0xfffbf7ee);
    text = const Color(0xff242e37);
    textSubtitle = const Color(0xff3f484f);
    shadow = Colors.grey.shade400;
  }
}

class PaletteColorsDark extends PaletteColors {
  PaletteColorsDark() {
    textButton = const Color(0xffffffff);
    icons = const Color(0xff242e37);
    appBar = const Color(0xffffffff);
    background = const Color(0xfffbf7ee);
    text = const Color(0xff242e37);
    textSubtitle = const Color(0xff3f484f);
    shadow = Colors.grey.shade400;
  }
}

class PaletteMaterialColors {
  static const MaterialColor primary = MaterialColor(0xffCC0000, {
    50: Color.fromRGBO(204, 0, 0, .1),
    100: Color.fromRGBO(204, 0, 0, .2),
    200: Color.fromRGBO(204, 0, 0, .3),
    300: Color.fromRGBO(204, 0, 0, .4),
    400: Color.fromRGBO(204, 0, 0, .5),
    500: Color.fromRGBO(204, 0, 0, .6),
    600: Color.fromRGBO(204, 0, 0, .7),
    700: Color.fromRGBO(204, 0, 0, .8),
  });
}

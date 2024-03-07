import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final Color? color;
  final GestureTapCallback? onTap;
  final IconData? icon;

  const AppTextButton({Key? key, required this.text, this.shouldTranslate = true, this.color, this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Provider.of<ThemeService>(context).paletteColors.active.withOpacity(0.5),
        ),
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
      ),
      onPressed: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(width: Dimens.paddingS)
          ],
          Flexible(
            child: AppText(
              shouldTranslate ? translate(text) : text,
              type: TextTypes.bodyLight,
              color: color,
              align: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}

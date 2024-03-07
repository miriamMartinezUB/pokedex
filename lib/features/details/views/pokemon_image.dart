import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/theme_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/palette_colors.dart';
import 'package:provider/provider.dart';

class PokemonImage extends StatefulWidget {
  final String urlImageFront;
  final String urlImageBack;
  const PokemonImage({
    Key? key,
    required this.urlImageFront,
    required this.urlImageBack,
  }) : super(key: key);

  @override
  State<PokemonImage> createState() => _PokemonImageState();
}

class _PokemonImageState extends State<PokemonImage> {
  late final PaletteColors _paletteColors;
  bool showFront = true;

  @override
  void didChangeDependencies() {
    _paletteColors = Provider.of<ThemeService>(context).paletteColors;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          showFront = !showFront;
        });
      },
      child: Container(
        height: Dimens.iconSizeBig,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _paletteColors.shadow,
            width: 2,
          ),
          image: DecorationImage(
            image: NetworkImage(showFront ? widget.urlImageFront : widget.urlImageBack),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}

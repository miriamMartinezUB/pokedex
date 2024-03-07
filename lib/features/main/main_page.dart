import 'package:flutter/material.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/views/page_wrapper.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      appBarName: translate('app_title'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingXLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/oak.png',
                  height: Dimens.iconSizeBig,
                ),
              ),
              const SizedBox(height: Dimens.paddingLarge),
              AppText(
                translate('welcome'),
                type: TextTypes.bodyLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

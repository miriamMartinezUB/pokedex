import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/navigation/navigation_service.dart';
import 'package:flutter_pokedex/resources/dimens.dart';
import 'package:flutter_pokedex/resources/routes.dart';
import 'package:flutter_pokedex/views/page_wrapper.dart';
import 'package:flutter_pokedex/views/texts.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final StreamSubscription<InternetConnectionStatus> listener;
  late final NavigationService navigationService;

  @override
  void initState() {
    navigationService = Provider.of<NavigationService>(context, listen: false);
    InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        if (status == InternetConnectionStatus.connected) {
          Future.delayed(const Duration(seconds: 2), () {
            navigationService.replace(Routes.home);
          });
        } else {
          navigationService.replace(Routes.connectionError);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      isMainPage: false,
      canGoBack: false,
      body: Center(
        child: Image.asset(
          'assets/images/oak.png',
          height: Dimens.iconSizeBig,
        ),
      ),
    );
  }
}

class NotConnectionPage extends StatelessWidget {
  const NotConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      isMainPage: false,
      canGoBack: false,
      body: Padding(
        padding: const EdgeInsets.all(Dimens.paddingXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.warning_amber_outlined,
              size: Dimens.iconSizeMedium,
              color: Colors.amber,
            ),
            const SizedBox(height: Dimens.paddingLarge),
            AppText(
              translate('connection_error_title'),
              type: TextTypes.title,
              align: TextAlign.center,
            ),
            const SizedBox(height: Dimens.paddingLarge),
            AppText(
              translate('connection_error_body'),
              type: TextTypes.bodyLight,
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
